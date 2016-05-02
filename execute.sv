class execute_gr;

   //inputs
   logic        enable_execute;
   logic [1:0]  W_Control_in;
   logic        Mem_Control_in;
   logic [5:0]  E_Control;
   bit   [15:0] IR;
   logic [15:0] npc;
   logic [15:0] VSR1, VSR2, Mem_Bypass_Val;
   logic	bypass_alu_1, bypass_alu_2, bypass_mem_1, bypass_mem_2;

   //outputs
   logic [15:0] aluout, pcout;
   logic [1:0]  W_Control_out;
   logic	Mem_Control_out;
   logic [2:0]  NZP;
   logic [15:0] IR_Exec;
   logic [2:0]  sr1, sr2;   //asynchronous
   logic [2:0]  dr;
   logic [15:0] M_Data;

   //Temporary Variables
   logic [15:0] aluin1_out, aluin2_out;

   //print flag
   bit execute_print_flag;

   virtual LC3_io.TB intf;
   virtual dut_Probe_execute prob_ex;

   extern function logic [15:0] aluin1(logic bypass_alu_1, bypass_mem_1, logic [15:0] VSR1, logic [15:0] Mem_Bypass_Val, logic [15:0] aluout);
   extern function logic [15:0] aluin2(logic bypass_alu_2, bypass_mem_2, logic mode, logic [4:0] imm5, logic [15:0] VSR2, logic [15:0] Mem_Bypass_Val, logic [15:0] aluout);

	function new(virtual LC3_io.TB intf,virtual dut_Probe_execute prob_ex);
		this.intf = intf;
		this.prob_ex = prob_ex;
	endfunction

	task golden_ref();
		int alu_pc_flag;
	   fork
	         forever
	         begin
	            @(posedge intf.clock);

		    check_execute();
	            if(intf.reset)
	            begin
					aluout = 16'b0;
					pcout = 16'b0;
					W_Control_out = 2'b0;
					Mem_Control_out = 0;
					NZP = 3'b0;
					IR_Exec = 16'b0;
					dr = 3'b0;
					M_Data = 16'b0;
				    sr1 = 0;
				    sr2 = 0;
	            end

		    else
		    begin
			    if(enable_execute === 0)
				NZP = 3'b0;
			    else if(enable_execute === 1)
			    begin
			       W_Control_out = W_Control_in;
			       Mem_Control_out = Mem_Control_in;
			       IR_Exec = IR;

			       if((IR[15:12]==4'd1)||(IR[15:12]==4'd5)||(IR[15:12]==4'd9)||(IR[15:12]==4'd2)||(IR[15:12]==4'd6)||(IR[15:12]==4'd10)||(IR[15:12]==4'd14))
			       		dr  <= IR[11:9];
			       else 
			       		dr = 3'b0;

			       if(IR[15:12] == 4'b0000)
			          NZP = IR[11:9];
			       else if(IR[15:12] == 4'b1100)
			          NZP = 3'b111;
			       else
			          NZP = 3'b0;
						
				if(IR[15:12] == 4'd1 || IR[15:12] == 4'd5 || IR[15:12] == 4'd9)
					alu_pc_flag = 1;
				else
					alu_pc_flag = 0;

				aluin1_out = aluin1(bypass_alu_1, bypass_mem_1, VSR1, Mem_Bypass_Val, aluout);
				aluin2_out = aluin2(bypass_alu_2, bypass_mem_2, IR[5], IR[4:0], VSR2, Mem_Bypass_Val, aluout);

				M_Data = VSR2;
				if(bypass_alu_2) 
						M_Data = aluin2(bypass_alu_2, bypass_mem_2, IR[5], IR[4:0], VSR2, Mem_Bypass_Val, aluout);
						
				if(alu_pc_flag == 1)
				begin
			       		if(E_Control[5:4] == 2'b00)
			       			aluout = aluin1(bypass_alu_1, bypass_mem_1, VSR1, Mem_Bypass_Val, aluout) + aluin2(bypass_alu_2, bypass_mem_2, IR[5], IR[4:0], VSR2, Mem_Bypass_Val, aluout);
			       		else if(E_Control[5:4] == 2'b01)
			       			aluout = aluin1(bypass_alu_1, bypass_mem_1, VSR1, Mem_Bypass_Val, aluout) & aluin2(bypass_alu_2, bypass_mem_2, IR[5], IR[4:0], VSR2, Mem_Bypass_Val, aluout);
			       		else if(E_Control[5:4] == 2'b10)
			       			aluout = ~(aluin1(bypass_alu_1, bypass_mem_1, VSR1, Mem_Bypass_Val, aluout));
			       		else
			       			aluout = 16'b0;

			       		pcout = aluout;
				end
				else
				begin
				          if(E_Control[3:2]==2'b00)
				          		begin
				                   if(E_Control[1])
				                   pcout = npc - 16'b1 + {{5{IR[10]}},IR[10:0]};
				                   else
				                   pcout = aluin1(bypass_alu_1, bypass_mem_1, VSR1, Mem_Bypass_Val, aluout) + {{5{IR[10]}},IR[10:0]};
				                end
				          else if(E_Control[3:2]==2'b01)
				          		begin
				                   if(E_Control[1])
				                   pcout = npc - 16'b1 + {{7{IR[8]}},IR[8:0]};
				                   else
				                   pcout = aluin1(bypass_alu_1, bypass_mem_1, VSR1, Mem_Bypass_Val, aluout) + {{7{IR[8]}},IR[8:0]};
				                end
				          else if(E_Control[3:2]==2'b10)
				          		begin
				                   if(E_Control[1])
				                   pcout = npc - 16'b1 + {{10{IR[5]}},IR[5:0]};
				                   else
				                   pcout = aluin1(bypass_alu_1, bypass_mem_1, VSR1, Mem_Bypass_Val, aluout) + {{10{IR[5]}},IR[5:0]};
				                end
				          else if(E_Control[3:2]==2'b11)
				          		begin
				                   if(E_Control[1])
				                   pcout = npc - 16'b1;
				                   else
				                   pcout = aluin1(bypass_alu_1, bypass_mem_1, VSR1, Mem_Bypass_Val, aluout);
				                end
				          else 
				          		pcout = 16'b0;
					aluout = pcout;
				end

			    end
		    end
	         end
	         forever
	         begin
		    #0.001;
		    if(!intf.reset)
		    begin
		       sr1 = IR[8:6];
		       case(IR[15:12])
		          4'd1, 4'd5, 4'd9: sr2 = IR[2:0];
		          4'd3, 4'd7, 4'd11: sr2 = IR[11:9];
		          default: sr2 = 3'b0;
	               endcase
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
				if(execute_print_flag == 1)
					print_execute();
			end
		end
	   join
	endtask

	task check_execute();
	        if(aluout !== prob_ex.aluout)
	            $display($time,"BUG IN EXECUTE DUT aluout_DUT = %h | aluout = %h\n\t\t enable_execute=%b | W_Control_in=%x | Mem_Control_in=%x | E_control=%x | IR=%x | npc=%x | VSR1=%x | VSR2=%x | Mem_Bypass_Val=%x  | bypass_alu_1 =%x  | bypass_alu_2 =%x  | bypass_mem_1 =%x  | bypass_mem_2 =%x \n\t\t IR=%x",prob_ex.aluout,aluout,enable_execute, W_Control_in, Mem_Control_in, E_Control, IR, npc, VSR1, VSR2, Mem_Bypass_Val, bypass_alu_1,bypass_alu_2,bypass_mem_1,bypass_mem_2, IR);

	        if(pcout !== prob_ex.pcout)
	            $display($time,"BUG IN EXECUTE DUT pcout_DUT = %h | pcout = %h\n\t\t enable_execute=%b | W_Control_in=%x | Mem_Control_in=%x | E_control=%x | IR=%x | npc=%x | VSR1=%x | VSR2=%x | Mem_Bypass_Val=%x  | bypass_alu_1 =%x  | bypass_alu_2 =%x  | bypass_mem_1 =%x  | bypass_mem_2 =%x \n\t\t IR=%x",prob_ex.pcout,pcout,enable_execute, W_Control_in, Mem_Control_in, E_Control, IR, npc, VSR1, VSR2, Mem_Bypass_Val, bypass_alu_1,bypass_alu_2,bypass_mem_1,bypass_mem_2, IR);

	        if(NZP !== prob_ex.NZP)
	            $display($time,"BUG IN EXECUTE DUT NZP_DUT = %b | NZP = %b\n\t\t enable_execute=%b | W_Control_in=%x | Mem_Control_in=%x | E_control=%x | IR=%x | npc=%x | VSR1=%x | VSR2=%x | Mem_Bypass_Val=%x  | bypass_alu_1 =%x  | bypass_alu_2 =%x  | bypass_mem_1 =%x  | bypass_mem_2 =%x \n\t\t IR=%x",prob_ex.NZP,NZP,enable_execute, W_Control_in, Mem_Control_in, E_Control, IR, npc, VSR1, VSR2, Mem_Bypass_Val, bypass_alu_1,bypass_alu_2,bypass_mem_1,bypass_mem_2, IR);

	        if(dr !== prob_ex.dr) 
	            $display($time,"BUG IN EXECUTE DUT dr_DUT = %b | dr = %b\n\t\t enable_execute=%b | W_Control_in=%x | Mem_Control_in=%x | E_control=%x | IR=%x | npc=%x | VSR1=%x | VSR2=%x | Mem_Bypass_Val=%x  | bypass_alu_1 =%x  | bypass_alu_2 =%x  | bypass_mem_1 =%x  | bypass_mem_2 =%x \n\t\t IR=%x",prob_ex.dr,dr,enable_execute, W_Control_in, Mem_Control_in, E_Control, IR, npc, VSR1, VSR2, Mem_Bypass_Val, bypass_alu_1,bypass_alu_2,bypass_mem_1,bypass_mem_2, IR);

	        if(M_Data !== prob_ex.M_Data)
	            $display($time,"BUG IN EXECUTE DUT M_Data_DUT = %h | M_Data = %h \n\t\t enable_execute=%b | W_Control_in=%x | Mem_Control_in=%x | E_control=%x | IR=%x | npc=%x | VSR1=%x | VSR2=%x | Mem_Bypass_Val=%x  | bypass_alu_1 =%x  | bypass_alu_2 =%x  | bypass_mem_1 =%x  | bypass_mem_2 =%x \n\t\t IR=%x",prob_ex.M_Data,M_Data, enable_execute, W_Control_in, Mem_Control_in, E_Control, IR, npc, VSR1, VSR2, Mem_Bypass_Val, bypass_alu_1,bypass_alu_2,bypass_mem_1,bypass_mem_2, IR);
	        
		if(W_Control_out !== prob_ex.W_Control_out)
	            $display($time,"BUG IN EXECUTE DUT W_Control_out_DUT = %h | W_Control_out = %h\n\t\t enable_execute=%b | W_Control_in=%x | Mem_Control_in=%x | E_control=%x | IR=%x | npc=%x | VSR1=%x | VSR2=%x | Mem_Bypass_Val=%x  | bypass_alu_1 =%x  | bypass_alu_2 =%x  | bypass_mem_1 =%x  | bypass_mem_2 =%x \n\t\t IR=%x",prob_ex.W_Control_out,W_Control_out,enable_execute, W_Control_in, Mem_Control_in, E_Control, IR, npc, VSR1, VSR2, Mem_Bypass_Val, bypass_alu_1,bypass_alu_2,bypass_mem_1,bypass_mem_2, IR);
	        
		if(Mem_Control_out !== prob_ex.Mem_Control_out)
	            $display($time,"BUG IN EXECUTE DUT Mem_Control_out_DUT = %h | Mem_Control_out = %h\n\t\t enable_execute=%b | W_Control_in=%x | Mem_Control_in=%x | E_control=%x | IR=%x | npc=%x | VSR1=%x | VSR2=%x | Mem_Bypass_Val=%x  | bypass_alu_1 =%x  | bypass_alu_2 =%x  | bypass_mem_1 =%x  | bypass_mem_2 =%x \n\t\t IR=%x",prob_ex.Mem_Control_out,Mem_Control_out, enable_execute, W_Control_in, Mem_Control_in, E_Control, IR, npc, VSR1, VSR2, Mem_Bypass_Val, bypass_alu_1,bypass_alu_2,bypass_mem_1,bypass_mem_2,IR);
	        
		if(IR_Exec !== prob_ex.IR_Exec)
	            $display($time,"BUG IN EXECUTE DUT IR_Exec_DUT = %h | IR_Exec = %h\n\t\t enable_execute=%b | W_Control_in=%x | Mem_Control_in=%x | E_control=%x | IR=%x | npc=%x | VSR1=%x | VSR2=%x | Mem_Bypass_Val=%x  | bypass_alu_1 =%x  | bypass_alu_2 =%x  | bypass_mem_1 =%x  | bypass_mem_2 =%x \n\t\t IR=%x",prob_ex.IR_Exec,IR_Exec,enable_execute, W_Control_in, Mem_Control_in, E_Control, IR, npc, VSR1, VSR2, Mem_Bypass_Val, bypass_alu_1,bypass_alu_2,bypass_mem_1,bypass_mem_2, IR);

	endtask


	task check_async();
	        if(sr1 !== prob_ex.sr1) 
	            $display($time,"BUG IN EXECUTE DUT sr1_DUT = %b | sr1 = %b\n\t\t enable_execute=%b | W_Control_in=%x | Mem_Control_in=%x | E_control=%x | IR=%x | npc=%x | VSR1=%x | VSR2=%x | Mem_Bypass_Val=%x  | bypass_alu_1 =%x  | bypass_alu_2 =%x  | bypass_mem_1 =%x  | bypass_mem_2 =%x \n\t\t IR=%x",prob_ex.sr1,sr1,enable_execute, W_Control_in, Mem_Control_in, E_Control, IR, npc, VSR1, VSR2, Mem_Bypass_Val, bypass_alu_1,bypass_alu_2,bypass_mem_1,bypass_mem_2, IR);

	        if(sr2 !== prob_ex.sr2)
	            $display($time,"BUG IN EXECUTE DUT sr2_DUT = %b | sr2 = %b\n\t\t enable_execute=%b | W_Control_in=%x | Mem_Control_in=%x | E_control=%x | IR=%x | npc=%x | VSR1=%x | VSR2=%x | Mem_Bypass_Val=%x  | bypass_alu_1 =%x  | bypass_alu_2 =%x  | bypass_mem_1 =%x  | bypass_mem_2 =%x \n\t\t IR=%x",prob_ex.sr2,sr2,enable_execute, W_Control_in, Mem_Control_in, E_Control, IR, npc, VSR1, VSR2, Mem_Bypass_Val, bypass_alu_1,bypass_alu_2,bypass_mem_1,bypass_mem_2, IR);
	endtask

	task print_execute();
			$display($time,"=======================EXECUTE=======================");
			$display($time,"=======================Inputs========================");
			$display($time,"  enable_execute = %h",enable_execute);
			$display($time,"  W_Control_in = %h",W_Control_in);
			$display($time,"  Mem_Control_in = %h",Mem_Control_in);
			$display($time,"  E_Control = %h",E_Control);
			$display($time,"  IR = %h",IR);
			$display($time,"  npc = %h",npc);
			$display($time,"  VSR1 = %h",VSR1);
			$display($time,"  VSR2 = %h",VSR2);
			$display($time,"  Mem_Bypass_Val = %h",Mem_Bypass_Val);
			$display($time,"  bypass_alu_1 = %h",bypass_alu_1);
			$display($time,"  bypass_alu_2 = %h",bypass_alu_2);
			$display($time,"  bypass_mem_1 = %h",bypass_mem_1);
			$display($time,"  bypass_mem_2 = %h",bypass_mem_2);
			$display($time,"=======================Outputs=======================");
			$display($time,"  aluout = %h",aluout);
			$display($time,"  pcout = %h",pcout);
			$display($time,"  W_Control_out = %h",W_Control_out);
			$display($time,"  Mem_Control_out = %h",Mem_Control_out);
			$display($time,"  NZP = %b",NZP);
			$display($time,"  IR_Exec = %b",IR_Exec);
			$display($time,"  sr1 = %b",sr1);
			$display($time,"  sr2 = %b",sr2);
			$display($time,"  dr = %b",dr);
			$display($time,"  M_Data = %h",M_Data);
			$display($time,"======================================================");
	endtask


endclass


function logic [15:0] execute_gr :: aluin1(logic bypass_alu_1, logic bypass_mem_1, logic [15:0] VSR1, logic [15:0] Mem_Bypass_Val, logic [15:0] aluout);
   case({bypass_mem_1,bypass_alu_1})
      2'b01: aluin1 = aluout;
      2'b10: aluin1 = Mem_Bypass_Val;
      default: aluin1 = VSR1;
   endcase
endfunction


function logic [15:0] execute_gr :: aluin2(logic bypass_alu_2, logic bypass_mem_2, logic mode, logic [4:0] imm5, logic [15:0] VSR2, logic [15:0] Mem_Bypass_Val, logic [15:0] aluout);
   case({bypass_mem_2,bypass_alu_2})
      2'b01: aluin2 = aluout;
      2'b10: aluin2 = Mem_Bypass_Val;
      default: begin
                  if(mode == 0)
                     aluin2 = VSR2;
                  else
                     aluin2 = {{11{imm5[4]}},imm5[4:0]};
               end
   endcase
endfunction



