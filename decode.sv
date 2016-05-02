class decode_gr;

   //inputs
   logic enable_decode;
   logic [15:0]Instr_dout;
   logic [15:0]npc_in;

   //outputs
   logic [5:0]E_Control;
   logic [1:0]W_Control;
   logic [15:0]npc_out;
   logic Mem_Control;
   logic [15:0]IR;

   //print flag
   bit decode_print_flag;

   virtual LC3_io.TB intf; 
   virtual dut_Probe_decode prob_de; 

	function new(virtual LC3_io.TB intf,virtual dut_Probe_decode prob_de);
		this.intf  = intf;
		this.prob_de = prob_de;
	endfunction


	task golden_ref();
	   fork
	      begin
			forever
			begin
				@(posedge intf.clock);

				check_decode();
				if(intf.reset)
				begin

					npc_out = 16'h0000;
					IR = 16'h0000;
					E_Control = 6'd0;
					W_Control = 2'd0;
					Mem_Control = 1'd0;
				end
				else
				begin
					if(enable_decode)
					begin
						
						IR = Instr_dout;
						npc_out = npc_in;
						//Mem_Control
						if((Instr_dout[15:12]==4'h1)||(Instr_dout[15:12]==4'h5)||(Instr_dout[15:12]==4'h9)||(Instr_dout[15:12]==4'h2)||(Instr_dout[15:12]==4'h6)||(Instr_dout[15:12]==4'h3)||(Instr_dout[15:12]==4'h7)||(Instr_dout[15:12]==4'hE)||(Instr_dout[15:12]==4'h0)||(Instr_dout[15:12]==4'hC))
								Mem_Control = 1'd0;
						else if((Instr_dout[15:12]==4'hA)||(Instr_dout[15:12]==4'hB))
								Mem_Control = 1'd1;
						else
								Mem_Control = 1'd0;


						//W_Control
						if((Instr_dout[15:12]==4'h1)||(Instr_dout[15:12]==4'h5)||(Instr_dout[15:12]==4'h9)||(Instr_dout[15:12]==4'hB)||(Instr_dout[15:12]==4'h3)||(Instr_dout[15:12]==4'h7)||(Instr_dout[15:12]==4'h0)||(Instr_dout[15:12]==4'hC))
								W_Control = 2'd0;
						else if((Instr_dout[15:12]==4'h2)||(Instr_dout[15:12]==4'h6)||(Instr_dout[15:12]==4'hA))
								W_Control = 2'd1;
						else if(Instr_dout[15:12]==4'hE)
								W_Control = 2'd2;
						else 
								W_Control = 2'd0;

						//E_Control
						if((Instr_dout[15:12]==4'h0)||(Instr_dout[15:12]==4'h2)||(Instr_dout[15:12]==4'h3)||(Instr_dout[15:12]==4'hA)||(Instr_dout[15:12]==4'hB)||(Instr_dout[15:12]==4'hE))
								E_Control = 6'd6;
						else if((Instr_dout[15:12]==4'h6)||(Instr_dout[15:12]==4'h7))
								E_Control = 6'd8;
						else if(Instr_dout[15:12]==4'hC)
								E_Control = 6'd12;
						else if(Instr_dout[15:12]==4'h9)
								E_Control = 6'd32;
						else if(Instr_dout[15:12]==4'h1)
							begin
									if(Instr_dout[5])
										E_Control= 6'd0;
									else
										E_Control= 6'd1;								
							end
						else if(Instr_dout[15:12]==4'h5)
							begin
									if(Instr_dout[5])
										E_Control= 6'd16;
									else
										E_Control= 6'd17;
							end
						else 
								E_Control = 6'd0;
					end
				end
			end
		end
		begin
			forever@(posedge intf.clock)
			begin
				if(decode_print_flag == 1)
					print_decode();
			end
		end

	   join
	endtask

	task check_decode();

	                if(W_Control !== prob_de.W_Control)
	                begin
	                        $display($time,"BUG IN DECODE DUT W_Control_DUT = %b | W_Control = %b \n\t\t | enable_decode=%b | Instr_dout=%h | npc_in=%X",prob_de.W_Control,W_Control,enable_decode, Instr_dout, npc_in);   
	                end
	                if(E_Control !== prob_de.E_Control)
	                begin
	                        $display($time,"BUG IN DECODE DUT E_Control_DUT = %b | E_Control = %b \n\t\t | enable_decode=%b | Instr_dout=%h | npc_in=%X",prob_de.E_Control,E_Control,enable_decode, Instr_dout, npc_in);   
	                end
	                if(Mem_Control !== prob_de.Mem_Control)
	                begin
	                        $display($time,"BUG IN DECODE DUT Mem_Control_DUT = %b | Mem_Control = %b \n\t\t | enable_decode=%b | Instr_dout=%h | npc_in=%X",prob_de.Mem_Control,Mem_Control,enable_decode, Instr_dout, npc_in);
	                end
	                if(npc_out !== prob_de.npc_out)
	                begin
	                        $display($time,"BUG IN DECODE DUT npc_out_DUT = %x | npc_out = %x \n\t\t | enable_decode=%b | Instr_dout=%h | npc_in=%X",prob_de.npc_out,npc_out,enable_decode, Instr_dout, npc_in);
	                end
	                if(IR !== prob_de.IR)
	                begin
	                        $display($time,"BUG IN DECODE DUT IR_DUT = %x | IR = %x \n\t\t | enable_decode=%b | Instr_dout=%h | npc_in=%X",prob_de.IR,IR,enable_decode, Instr_dout, npc_in); 
	                end

	endtask

	task print_decode();

			$display($time,"=======================DECODE=======================");
			$display($time,"=======================Inputs=======================");
			$display($time,"  enable_decode = %b",enable_decode);
			$display($time,"  Instr_dout = %x",Instr_dout);
			$display($time,"  npc_in = %x",npc_in);
			$display($time,"=======================Outputs=======================");
		      	$display($time,"  W_Control = %b",W_Control);
		      	$display($time,"  E_Control = %b",E_Control);
			$display($time,"  Mem_Control = %b",Mem_Control);
			$display($time,"  npc_out = %x",npc_out);
			$display($time,"  IR = %x",IR);
			$display($time,"=====================================================");

	endtask
 
endclass



