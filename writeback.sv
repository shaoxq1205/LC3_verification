
`define psr_chk \
		if(psr !== prob_wb.psr)\
			$display($time,"BUG IN WRITEBACK DUT psr_DUT = %b | psr = %b \n\t\t enable_writeback%b | npc=%x | aluout=%x | pcout=%x | memout=%x | sr1=%b | sr2=%b | dr=%b | W_Control_in=%b",prob_wb.psr,psr, enable_writeback, npc, aluout, pcout, memout, sr1, sr2, dr, W_Control_in);

class writeback_gr;

   //inputs
   logic enable_writeback;
   logic [15:0]npc;  // npc is not present in the block diagram.. check this signal
   logic [15:0]aluout;
   logic [15:0]pcout;
   logic [15:0]memout;
   logic [2:0]sr1, sr2, dr;
   logic [1:0]W_Control_in ;

   //outputs
   logic [2:0]psr;
   logic [15:0]VSR1, VSR2;

   //Register File   
   logic [15:0]RegFile[0:7];
   
   //print flag
   bit prob_wbprintflag;
   bit prob_wbprintRF_flag;

   virtual LC3_io.TB intf;
   virtual dut_Probe_writeback prob_wb;
   

	function new(virtual LC3_io.TB intf,virtual dut_Probe_writeback prob_wb);
	   this.intf = intf;
	   this.prob_wb = prob_wb;
	endfunction

	task golden_ref();

	fork
		forever
		begin
			@(posedge intf.clock)
			begin
				`psr_chk
				if(intf.reset)
				begin
					psr = 3'b000;
					VSR1 = 0;
					VSR2 = 0;
				end
				else
				begin
					if(enable_writeback)
					begin
						case(W_Control_in)
						2'b00: begin
							RegFile[dr]=  aluout;
						    end
						2'b01: begin
							RegFile[dr]=  memout;
						    end
						2'b10: begin
							RegFile[dr]= pcout;
						    end
						default: begin
								RegFile[dr]=  aluout;	 // default value of W_Control_in is 0 so aluout is selected
							 end
						endcase

						if(RegFile[dr][15])
							psr = 3'b100;
						else if(RegFile[dr] > 0) 
							psr = 3'b001;
						else 
							psr = 3'b010;

					end
				end
			end
		end
		forever
		begin
			#0.001;
			if(!intf.reset)
			begin
				VSR1= RegFile[sr1];
				VSR2= RegFile[sr2];
			end
		end
		forever
		begin
			@(posedge intf.clock);
				check_async();
		end
		begin
			forever@(posedge intf.clock)
			begin
				if(prob_wbprintflag == 1)
					print_writeback();
			end
		end
		begin
			forever@(posedge intf.clock)
			begin
				if(prob_wbprintRF_flag == 1)
					print_writeback_RF();
			end
		end
	join
	endtask

	task check_async();
		if(VSR1 !== prob_wb.d1)
			$display($time,"BUG IN WRITEBACK DUT VSR1_DUT = %h | VSR1 = %h \n\t\t enable_writeback%b | npc=%x | aluout=%x | pcout=%x | memout=%x | sr1=%b | sr2=%b | dr=%b | W_Control_in=%b ",prob_wb.d1,VSR1, enable_writeback, npc, aluout, pcout, memout, sr1, sr2, dr, W_Control_in);

	        if(VSR2 !== prob_wb.d2)
			$display($time,"BUG IN WRITEBACK DUT VSR2_DUT = %h | VSR2 = %h \n\t\t enable_writeback%b | npc=%x | aluout=%x | pcout=%x | memout=%x | sr1=%b | sr2=%b | dr=%b | W_Control_in=%b",prob_wb.d2,VSR2, enable_writeback, npc, aluout, pcout, memout, sr1, sr2, dr, W_Control_in);
	endtask
	task  print_writeback();
			$display($time,"=====================WRITEBACK=======================");
			$display($time,"=======================Inputs========================");
			$display($time,"  enable_writeback = %b",enable_writeback);
			$display($time,"  npc = %h",npc);
			$display($time,"  aluout = %h",aluout);
			$display($time,"  pcout = %h",pcout);
			$display($time,"  memout = %h",memout);
			$display($time,"  sr1 = %b",sr1);
			$display($time,"  sr2 = %b",sr2);
			$display($time,"  dr = %b",dr);
			$display($time,"  W_Control_in = %b",W_Control_in);
			$display($time,"=======================Outputs=======================");
			$display($time,"  psr = %b",psr);
			$display($time,"  VSR1 = %h",VSR1);
			$display($time,"  VSR2 = %h",VSR2);
			$display($time,"=====================================================");
	endtask

	task  print_writeback_RF();
			$display($time,"================WriteBack RegFile====================");
			$display($time,"  RegFile[0] = %h",RegFile[0]);
			$display($time,"  RegFile[1] = %h",RegFile[1]);
			$display($time,"  RegFile[2] = %h",RegFile[2]);
			$display($time,"  RegFile[3] = %h",RegFile[3]);
			$display($time,"  RegFile[4] = %h",RegFile[4]);
			$display($time,"  RegFile[5] = %h",RegFile[5]);
			$display($time,"  RegFile[6] = %h",RegFile[6]);
			$display($time,"  RegFile[7] = %h",RegFile[7]);
	endtask


endclass

