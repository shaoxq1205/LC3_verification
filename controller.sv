`timescale 1ns/1ps


`define enable_wb_temp_chk \
				if(prob_cnt.enable_writeback !== enable_writeback_temp)\
						$display($time,"BUG in CONTROLLER DUT enable_writeback_DUT = %b | enable_writeback = %b\n \t \t Instr_dout=%H  IR=%H  IR_Exec=%H  NZP=%H  psr=%H",prob_cnt.enable_writeback,enable_writeback_temp,Instr_dout,IR, IR_Exec,NZP, psr);			

`define enable_exe_temp_chk \
				if(prob_cnt.enable_execute !== enable_execute_temp)\
					$display($time,"BUG in CONTROLLER DUT enable_execute_DUT = %b | enable_execute = %b\n \t \t Instr_dout=%H  IR=%H  IR_Exec=%H  NZP=%H  psr=%H",prob_cnt.enable_execute,enable_execute_temp,Instr_dout,IR, IR_Exec,NZP, psr);					
				
`define enable_dec_temp_chk \
				if(prob_cnt.enable_decode !== enable_decode_temp)\
					$display($time,"BUG in CONTROLLER DUT enable_decode_DUT = %b | enable_decode = %b\n \t \t Instr_dout=%H  IR=%H  IR_Exec=%H  NZP=%H  psr=%H", prob_cnt.enable_decode, enable_decode_temp,Instr_dout,IR, IR_Exec,NZP, psr);					
				
`define enable_fet_temp_chk \
				if(prob_cnt.enable_fetch !== enable_fetch_temp)\
					$display($time,"BUG in CONTROLLER DUT enable_fetch_DUT = %b | enable_fetch = %b\n \t \t Instr_dout=%H  IR=%H  IR_Exec=%H  NZP=%H  psr=%H", prob_cnt.enable_fetch, enable_fetch_temp,Instr_dout,IR, IR_Exec,NZP, psr);						
				
`define enable_uppc_temp_chk \
				if(prob_cnt.enable_updatePC !== enable_updatePC_temp)\
					$display($time,"BUG in CONTROLLER DUT enable_updatePC_DUT = %b | enable_updatePC = %b\n \t \t Instr_dout=%H  IR=%H  IR_Exec=%H  NZP=%H  psr=%H", prob_cnt.enable_updatePC, enable_updatePC_temp,Instr_dout,IR, IR_Exec,NZP, psr);					

`define enable_wb_chk \
				if(prob_cnt.enable_writeback !== enable_writeback)\
					$display($time,"BUG in CONTROLLER DUT enable_writeback_DUT = %b | enable_writeback = %b\n \t \t Instr_dout=%H  IR=%H  IR_Exec=%H  NZP=%H  psr=%H",prob_cnt.enable_writeback,enable_writeback,Instr_dout,IR, IR_Exec,NZP, psr);
					
`define enable_exe_chk \
				if(prob_cnt.enable_execute !== enable_execute)\
					$display($time,"BUG in CONTROLLER DUT enable_execute_DUT = %b | enable_execute = %b\n \t \t Instr_dout=%H  IR=%H  IR_Exec=%H  NZP=%H  psr=%H",prob_cnt.enable_execute,enable_execute,Instr_dout,IR, IR_Exec,NZP, psr);
					
`define enable_dec_chk \
				if(prob_cnt.enable_decode !== enable_decode)\
					$display($time,"BUG in CONTROLLER DUT enable_decode_DUT = %b | enable_decode = %b\n \t \t Instr_dout=%H  IR=%H  IR_Exec=%H  NZP=%H  psr=%H", prob_cnt.enable_decode, enable_decode,Instr_dout,IR, IR_Exec,NZP, psr);
				
`define enable_fet_chk \
				if(prob_cnt.enable_fetch !== enable_fetch)\
					$display($time,"BUG in CONTROLLER DUT enable_fetch_DUT = %b | enable_fetch = %b\n \t \t Instr_dout=%H  IR=%H  IR_Exec=%H  NZP=%H  psr=%H", prob_cnt.enable_fetch, enable_fetch,Instr_dout,IR, IR_Exec,NZP, psr);
				

`define enable_uppc_chk \
				if(prob_cnt.enable_updatePC !== enable_updatePC)\
					$display($time,"BUG in CONTROLLER DUT enable_updatePC_DUT = %b | enable_updatePC = %b\n \t \t Instr_dout=%H  IR=%H  IR_Exec=%H  NZP=%H  psr=%H", prob_cnt.enable_updatePC, enable_updatePC,Instr_dout,IR, IR_Exec,NZP, psr);

`define mem_state \
				if(prob_cnt.mem_state !== mem_state)\
					$display($time,"BUG in CONTROLLER DUT mem_state_DUT = %b | mem_state = %b\n \t \t Instr_dout=%H  IR=%H  IR_Exec=%H  NZP=%H  psr=%H",prob_cnt.mem_state,mem_state,Instr_dout,IR, IR_Exec,NZP, psr);


`define bypass_chk\
				if(prob_cnt.bypass_mem_1 !== bypass_mem_1)\
					$display($time,"BUG in CONTROLLER DUT bypass_mem_1_DUT = %b | bypass_mem_1 = %b\n \t \t Instr_dout=%H  IR=%H  IR_Exec=%H  NZP=%H  psr=%H",prob_cnt.bypass_mem_1,bypass_mem_1,Instr_dout,IR, IR_Exec,NZP, psr);\
				if(prob_cnt.bypass_mem_2 !== bypass_mem_2)\
					$display($time,"BUG in CONTROLLER DUT bypass_mem_2_DUT = %b | bypass_mem_2 = %b\n \t \t Instr_dout=%H  IR=%H  IR_Exec=%H  NZP=%H  psr=%H",prob_cnt.bypass_mem_2,bypass_mem_2,Instr_dout,IR, IR_Exec,NZP, psr);\
				if(prob_cnt.bypass_alu_1 !== bypass_alu_1)\
					$display($time,"BUG in CONTROLLER DUT bypass_alu_1_DUT = %b | bypass_alu_1 = %b\n \t \t Instr_dout=%H  IR=%H  IR_Exec=%H  NZP=%H  psr=%H",prob_cnt.bypass_alu_1,bypass_alu_1,Instr_dout,IR, IR_Exec,NZP, psr);\
				if(prob_cnt.bypass_alu_2 !== bypass_alu_2)\
					$display($time,"BUG in CONTROLLER DUT bypass_alu_2_DUT = %b | bypass_alu_2 = %b\n \t \t Instr_dout=%H  IR=%H  IR_Exec=%H  NZP=%H  psr=%H",prob_cnt.bypass_alu_2,bypass_alu_2,Instr_dout,IR, IR_Exec,NZP, psr);


`define enable_chk \
				if(prob_cnt.enable_writeback !== enable_writeback_temp)\
					$display($time,"BUG in CONTROLLER DUT enable_writeback_DUT = %b | enable_writeback = %b\n \t \t Instr_dout=%H  IR=%H  IR_Exec=%H  NZP=%H  psr=%H", prob_cnt.enable_writeback, enable_writeback_temp,Instr_dout,IR, IR_Exec,NZP, psr);\
				if(prob_cnt.enable_execute !== enable_execute_temp)\
					$display($time,"BUG in CONTROLLER DUT enable_execute_DUT = %b | enable_execute = %b\n \t \t Instr_dout=%H  IR=%H  IR_Exec=%H  NZP=%H  psr=%H",prob_cnt.enable_execute,enable_execute_temp,Instr_dout,IR, IR_Exec,NZP, psr);\
				if(prob_cnt.enable_decode !== enable_decode_temp)\
					$display($time,"BUG in CONTROLLER DUT enable_decode_DUT = %b | enable_decode = %b\n \t \t Instr_dout=%H  IR=%H  IR_Exec=%H  NZP=%H  psr=%H", prob_cnt.enable_decode, enable_decode_temp,Instr_dout,IR, IR_Exec,NZP, psr);\
				if(prob_cnt.enable_fetch !== enable_fetch_temp)\
					$display($time,"BUG in CONTROLLER DUT enable_fetch_DUT = %b | enable_fetch = %b\n \t \t Instr_dout=%H  IR=%H  IR_Exec=%H  NZP=%H  psr=%H", prob_cnt.enable_fetch, enable_fetch_temp,Instr_dout,IR, IR_Exec,NZP, psr);\
				if(prob_cnt.enable_updatePC !== enable_updatePC_temp)\
					$display($time,"BUG in CONTROLLER DUT enable_updatePC_DUT = %b | enable_updatePC = %b\n \t \t Instr_dout=%H  IR=%H  IR_Exec=%H  NZP=%H  psr=%H", prob_cnt.enable_updatePC, enable_updatePC_temp,Instr_dout,IR, IR_Exec,NZP, psr);

`define br_taken\
				if(prob_cnt.br_taken !== br_taken)\
					$display($time,"BUG in CONTROLLER DUT br_taken_DUT = %b | br_taken = %b\n \t \t Instr_dout=%H  IR=%H  IR_Exec=%H  NZP=%H  psr=%H",prob_cnt.br_taken,br_taken,Instr_dout,IR, IR_Exec,NZP, psr);
						


class controller_gr;

	//inputs
	logic complete_data;
	logic complete_instr;
	logic [15:0] IR;
	logic [2:0] NZP;
	logic [2:0] psr;
	logic [15:0] IR_Exec;
	logic [15:0] Instr_dout;     //	Instr_dout

	//outputs
	logic enable_updatePC;
	logic enable_fetch;
	logic enable_decode;
	logic enable_execute;
	logic enable_writeback;
	logic br_taken;
	logic bypass_alu_1;
	logic bypass_alu_2;
	logic bypass_mem_1;
	logic bypass_mem_2;
	logic [1:0] mem_state;

	//Temporary Variables
	logic [15:0] IR_temp;
	bit flag;
	logic enable_updatePC_temp;
	logic enable_fetch_temp;
	logic enable_decode_temp;
	logic enable_execute_temp;
	logic enable_writeback_temp;
	logic [2:0] temp;
	logic br;

	//print flag
	bit controller_print_flag;

	//Process for parallel execution
	process proc1,proc2;
	
	virtual interface LC3_io.TB intf;
	virtual dut_Probe_controller prob_cnt;

	function new(virtual LC3_io.TB intf,virtual dut_Probe_controller prob_cnt);
		this.intf = intf;
		this.prob_cnt = prob_cnt;
	endfunction

	task golden_ref();
		fork
			begin   //////////////RESET BLOCK
				forever
				begin
					proc1 = process::self();
					@(posedge intf.clock);
					if(intf.reset)
					begin
						enable_fetch = 1'b1;
						enable_updatePC = 1'b0;
						enable_decode = 1'b0;
						enable_execute = 1'b0;
						enable_writeback = 1'b0;
						
						enable_fetch_temp     = enable_fetch ;
						enable_updatePC_temp  = enable_updatePC;
						enable_decode_temp    = enable_decode;
						enable_execute_temp   = enable_execute;
						enable_writeback_temp = enable_writeback;
						`bypass_chk
						bypass_alu_1 = 1'b0;
						bypass_alu_2 = 1'b0;
						bypass_mem_1 = 1'b0;
						bypass_mem_2 = 1'b0;
						mem_state = 2'b11;
						br_taken = 1'b0;
						wait(!intf.reset);
						@(posedge intf.clock);
						enable_updatePC = 1'b1;
						`enable_chk
						`br_taken
						@(posedge intf.clock);
						enable_fetch_temp     = enable_fetch ;
						enable_updatePC_temp  = enable_updatePC;
						enable_decode_temp    = enable_decode;
						enable_execute_temp   = enable_execute;
						enable_writeback_temp = enable_writeback;
						
						enable_decode = 1'b1;
						`enable_chk
						`br_taken
						@(posedge intf.clock);
						enable_fetch_temp     = enable_fetch ;
						enable_updatePC_temp  = enable_updatePC;
						enable_decode_temp    = enable_decode;
						enable_execute_temp   = enable_execute;
						enable_writeback_temp = enable_writeback;
						
						enable_execute = 1'b1;
						`enable_chk
						`br_taken
						@(posedge intf.clock);
						enable_fetch_temp     = enable_fetch ;
						enable_updatePC_temp  = enable_updatePC;
						enable_decode_temp    = enable_decode;
						enable_execute_temp   = enable_execute;
						enable_writeback_temp = enable_writeback;
						
						enable_writeback = 1'b1;
						`enable_chk
						`br_taken
					end
				end
			end
			begin            //// For Complete_instr         Not sure
				forever@(posedge intf.clock)
				begin
					wait(!complete_instr);
					enable_updatePC = 1'b0;
					enable_decode = 1'b0;
						`enable_chk
						`br_taken
					@(posedge intf.clock);
						enable_fetch_temp     = enable_fetch ;
						enable_updatePC_temp  = enable_updatePC;
						enable_decode_temp    = enable_decode;
						enable_execute_temp   = enable_execute;
						enable_writeback_temp = enable_writeback;
						
					enable_execute = 1'b0;
					enable_writeback = 1'b0;
					wait(complete_instr);
					enable_updatePC = 1'b1;
						`enable_chk
						`br_taken
					@(posedge intf.clock);
						enable_fetch_temp     = enable_fetch ;
						enable_updatePC_temp  = enable_updatePC;
						enable_decode_temp    = enable_decode;
						enable_execute_temp   = enable_execute;
						enable_writeback_temp = enable_writeback;
						
					enable_decode = 1'b1;
						`enable_chk
						`br_taken
					@(posedge intf.clock);
						enable_fetch_temp     = enable_fetch ;
						enable_updatePC_temp  = enable_updatePC;
						enable_decode_temp    = enable_decode;
						enable_execute_temp   = enable_execute;
						enable_writeback_temp = enable_writeback;
						
					enable_execute = 1'b1;
						`enable_chk
						`br_taken
					@(posedge intf.clock);
						enable_fetch_temp     = enable_fetch ;
						enable_updatePC_temp  = enable_updatePC;
						enable_decode_temp    = enable_decode;
						enable_execute_temp   = enable_execute;
						enable_writeback_temp = enable_writeback;
						
					enable_writeback = 1'b1;
						`enable_chk
						`br_taken
				end
			end
			begin       ///// Manage Enables
				forever @(posedge intf.clock)
				begin
					proc2 = process::self();
					//#0.001;
					if(!intf.reset)
					begin
						if((IR[15:12] == 4'b0010) || (IR[15:12] == 4'b0110))    // For LD/LDR
						begin
							//$display("TIME =%t CON2 Controller IR =%b",$time,IR);
							enable_fetch_temp     = enable_fetch ;
							enable_updatePC_temp  = enable_updatePC;
							enable_decode_temp    = enable_decode;
							enable_execute_temp   = enable_execute;
							enable_writeback_temp = enable_writeback;
						
							proc1.kill();
							//SKM @(posedge intf.clock);
							enable_fetch = 1'b0;
							enable_updatePC = 1'b0;
							enable_decode = 1'b0;
							enable_execute = 1'b0;
							enable_writeback = 1'b0;
						`enable_chk
						`br_taken
							@(posedge intf.clock);
							proc1.kill();
							enable_fetch_temp     = enable_fetch ;
							enable_updatePC_temp  = enable_updatePC;
							enable_decode_temp    = enable_decode;
							enable_execute_temp   = enable_execute;
							enable_writeback_temp = enable_writeback;
						
							enable_fetch = 1'b1;
							wait(complete_instr);
							enable_updatePC = 1'b1;
							enable_decode = 1'b1;
							enable_execute = 1'b1;
							enable_writeback = 1'b1;
						`enable_chk
						`br_taken
						end
						else if((IR[15:12] == 4'b0011) || (IR[15:12] == 4'b0111))    // For ST/STR
						begin
							//$display($time,"Controller CON3 IR =%b",IR);
							enable_fetch_temp     = enable_fetch ;
							enable_updatePC_temp  = enable_updatePC;
							enable_decode_temp    = enable_decode;
							enable_execute_temp   = enable_execute;
							enable_writeback_temp = enable_writeback;
						
							proc1.kill();
							//SKM @(posedge intf.clock);
							enable_fetch = 1'b0;
							enable_updatePC = 1'b0;
							enable_decode = 1'b0;
							enable_execute = 1'b0;
							enable_writeback = 1'b0;
						`enable_chk
						`br_taken
							@(posedge intf.clock);
							proc1.kill();
							enable_fetch_temp     = enable_fetch ;
							enable_updatePC_temp  = enable_updatePC;
							enable_decode_temp    = enable_decode;
							enable_execute_temp   = enable_execute;
							enable_writeback_temp = enable_writeback;
						
							enable_fetch = 1'b1;
							wait(complete_instr);
							enable_updatePC = 1'b1;
							enable_decode = 1'b1;
							enable_execute = 1'b1;
						`enable_chk
						`br_taken
							@(posedge intf.clock);
							proc1.kill();
							enable_fetch_temp     = enable_fetch ;
							enable_updatePC_temp  = enable_updatePC;
							enable_decode_temp    = enable_decode;
							enable_execute_temp   = enable_execute;
							enable_writeback_temp = enable_writeback;
						
							enable_writeback = 1'b1;
						`enable_chk
						`br_taken
						end
						else if(IR[15:12] == 4'b1010) // For LDI
						begin
							proc1.kill();
							//$display($time,"Controller CON4 IR =%b",IR);
							enable_fetch_temp     = enable_fetch ;
							enable_updatePC_temp  = enable_updatePC;
							enable_decode_temp    = enable_decode;
							enable_execute_temp   = enable_execute;
							enable_writeback_temp = enable_writeback;
						
							//SKM @(posedge intf.clock);
							//$display("Controller Instr_dout =%b",Instr_dout)
							enable_fetch = 1'b0;
							enable_updatePC = 1'b0;
							enable_decode = 1'b0;
							enable_execute = 1'b0;
							enable_writeback = 1'b0;
						`enable_chk
						`br_taken
							@(posedge intf.clock);
							proc1.kill();
							enable_fetch_temp     = enable_fetch ;
							enable_updatePC_temp  = enable_updatePC;
							enable_decode_temp    = enable_decode;
							enable_execute_temp   = enable_execute;
							enable_writeback_temp = enable_writeback;
						
						`enable_chk
						`br_taken
							@(posedge intf.clock);
							proc1.kill();
							enable_fetch_temp     = enable_fetch ;
							enable_updatePC_temp  = enable_updatePC;
							enable_decode_temp    = enable_decode;
							enable_execute_temp   = enable_execute;
							enable_writeback_temp = enable_writeback;
						
							enable_fetch = 1'b1;
							wait(complete_instr);
							enable_updatePC = 1'b1;
							enable_decode = 1'b1;
							enable_execute = 1'b1;
							enable_writeback = 1'b1;
						`enable_chk
						`br_taken
						end
						else if(IR[15:12] == 4'b1011) // For STI
						begin
							//$display($time,"Controller CON5 IR =%b",IR);
							enable_fetch_temp     = enable_fetch ;
							enable_updatePC_temp  = enable_updatePC;
							enable_decode_temp    = enable_decode;
							enable_execute_temp   = enable_execute;
							enable_writeback_temp = enable_writeback;
						
							proc1.kill();
							//SKM @(posedge intf.clock);
							enable_fetch = 1'b0;
							enable_updatePC = 1'b0;
							enable_decode = 1'b0;
							enable_execute = 1'b0;
							enable_writeback = 1'b0;
						`enable_chk
						`br_taken
							@(posedge intf.clock);
							proc1.kill();
							enable_fetch_temp     = enable_fetch ;
							enable_updatePC_temp  = enable_updatePC;
							enable_decode_temp    = enable_decode;
							enable_execute_temp   = enable_execute;
							enable_writeback_temp = enable_writeback;
						
						`enable_chk
						`br_taken
							@(posedge intf.clock);
							proc1.kill();
							enable_fetch_temp     = enable_fetch ;
							enable_updatePC_temp  = enable_updatePC;
							enable_decode_temp    = enable_decode;
							enable_execute_temp   = enable_execute;
							enable_writeback_temp = enable_writeback;
						
							enable_fetch = 1'b1;
							wait(complete_instr);
							enable_updatePC = 1'b1;
							enable_decode = 1'b1;
							enable_execute = 1'b1;
						`enable_chk
						`br_taken
							@(posedge intf.clock);
							proc1.kill();
							enable_fetch_temp     = enable_fetch ;
							enable_updatePC_temp  = enable_updatePC;
							enable_decode_temp    = enable_decode;
							enable_execute_temp   = enable_execute;
							enable_writeback_temp = enable_writeback;
						
							enable_writeback = 1'b1;
						`enable_chk
						`br_taken
						end
						//$display($time,"Controller CON6 IR =%b",IR);

					end
				end
			end
			begin
				forever
				begin
				#0.001;
				if((Instr_dout[15:12] == 4'b0000) || (Instr_dout[15:12] == 4'b1100))   // For BR/JMP
				begin
					proc2.kill();
					proc1.kill();
					//$display($time,"Controller Instr_dout =%b",Instr_dout);
					enable_fetch_temp     = enable_fetch ;
					enable_updatePC_temp  = enable_updatePC;
					enable_decode_temp    = enable_decode;
					enable_execute_temp   = enable_execute;
					enable_writeback_temp = enable_writeback;
				
					enable_fetch = 1'b0;
					enable_updatePC = 1'b0;
					`enable_fet_chk
					`enable_uppc_chk
					`enable_wb_chk
					`enable_exe_chk
					`enable_dec_chk				//original
					@(posedge intf.clock);
					proc2.kill();
					enable_fetch_temp     = enable_fetch ;
					enable_updatePC_temp  = enable_updatePC;
					enable_decode_temp    = enable_decode;
					enable_execute_temp   = enable_execute;
					enable_writeback_temp = enable_writeback;
				
					enable_decode = 1'b0;
					`enable_chk
						`br_taken
					@(posedge intf.clock);
					proc2.kill();
					enable_fetch_temp     = enable_fetch ;
					enable_updatePC_temp  = enable_updatePC;
					enable_decode_temp    = enable_decode;
					enable_execute_temp   = enable_execute;
					enable_writeback_temp = enable_writeback;
				
					enable_execute = 1'b0;
					enable_writeback = 1'b0;
					`enable_wb_temp_chk
					`enable_exe_temp_chk
					
					///////// Chk exec and wb
					#0.001;
					temp = NZP & psr;
					br = temp[0] | temp[1] | temp[2];
					if(br)
					begin
						br_taken = 1'b1;
						wait(complete_instr);
						//if(Instr_dout[15:12] == 4'b1100)
						begin
							enable_updatePC = 1'b1;
							`enable_uppc_chk
						end
						
						@(posedge intf.clock);           //// To check from here about br_taken
						proc2.kill();
						`br_taken
						enable_fetch_temp     = enable_fetch ;
						enable_updatePC_temp  = enable_updatePC;
						enable_decode_temp    = enable_decode;
						enable_execute_temp   = enable_execute;
						enable_writeback_temp = enable_writeback;
				
						//if(Instr_dout[15:12] == 4'b0000)
						//	enable_updatePC = 1'b1;
						enable_fetch = 1'b1;
						br_taken = 1'b0;
					end
					else
					begin
						br_taken = 1'b0;
						//`enable_chk
						`enable_fet_temp_chk
						`enable_dec_temp_chk
						`enable_uppc_temp_chk
						@(posedge intf.clock);           //// To check from here about br_taken
						proc2.kill();
						`br_taken
						enable_fetch_temp     = enable_fetch ;
						enable_updatePC_temp  = enable_updatePC;
						enable_decode_temp    = enable_decode;
						enable_execute_temp   = enable_execute;
						enable_writeback_temp = enable_writeback;
				
						wait(complete_instr);
						enable_updatePC = 1'b1;
						enable_fetch = 1'b1;
					end

					//wait(complete_instr);
					//enable_updatePC = 1'b1;
					`enable_chk
					@(posedge intf.clock);
					proc2.kill();
					`br_taken
					enable_fetch_temp     = enable_fetch ;
					enable_updatePC_temp  = enable_updatePC;
					enable_decode_temp    = enable_decode;
					enable_execute_temp   = enable_execute;
					enable_writeback_temp = enable_writeback;
				
					enable_decode = 1'b1;
					`enable_chk
						`br_taken
					@(posedge intf.clock);
					proc2.kill();
					enable_fetch_temp     = enable_fetch ;
					enable_updatePC_temp  = enable_updatePC;
					enable_decode_temp    = enable_decode;
					enable_execute_temp   = enable_execute;
					enable_writeback_temp = enable_writeback;
				
					enable_execute = 1'b1;
					`enable_chk
						`br_taken
					@(posedge intf.clock);
					proc2.kill();
					enable_fetch_temp     = enable_fetch ;
					enable_updatePC_temp  = enable_updatePC;
					enable_decode_temp    = enable_decode;
					enable_execute_temp   = enable_execute;
					enable_writeback_temp = enable_writeback;
				
					enable_writeback = 1'b1;
					`enable_chk
						`br_taken
				end
				end
			end
			begin   
				//------------FSM of mem_state---------------//
			    forever//@(posedge intf.clock)
				begin
					if(!intf.reset)
					begin
						if(flag == 0)
						begin
							@(posedge intf.clock);
							`mem_state 
						end
						//case(mem_state)
							if(mem_state == 2'b00)
								begin
									wait(complete_data);
									@(posedge intf.clock);
									mem_state = 2'b11;
									`mem_state 
									flag = 0;
								end
							else if(mem_state == 2'b01)
								begin
									wait(complete_data);
									if((IR_temp[15:12] == 4'b0010) || (IR_temp[15:12] == 4'b0110) || (IR_temp[15:12] == 4'b1010))  // FOR LD,LDR,LDI
									begin
										@(posedge intf.clock);
										mem_state = 2'b00;
										`mem_state 
									end
									else if((IR_temp[15:12] == 4'b0011) || (IR_temp[15:12] == 4'b0111) || (IR_temp[15:12] == 4'b1011))  // FOR ST,STR,STI
									begin
										@(posedge intf.clock);
										mem_state = 2'b10;
										`mem_state 
									end
								end
							else if(mem_state == 2'b10)
								begin
									wait(complete_data);
									@(posedge intf.clock);
									mem_state = 2'b11;
									`mem_state 
									flag = 0;
								end
							else if(mem_state ==2'b11)
								begin
									wait(complete_data);
									case(IR[15:12])
										4'b0010,4'b0110:begin
												 IR_temp = IR;
												 @(posedge intf.clock);
												 mem_state = 2'b00;  // LD,LDR
												`mem_state 
												 flag = 1;
												end
										4'b0011,4'b0111:begin
												 IR_temp = IR;
												 @(posedge intf.clock);
												 mem_state = 2'b10;  // ST,STR
												`mem_state 
												 flag = 1;
												end
										4'b1011,4'b1010:begin
												 IR_temp = IR;
												 @(posedge intf.clock);
												 mem_state = 2'b01;  // STI,LDI
												`mem_state 
												 flag = 1;
												end
									endcase
								end
						//endcase
					end
					else
					begin
						@(posedge intf.clock);
						mem_state = 2'b11;
						#0.001;
						`mem_state 
					end
				end
			end
			begin    ///// Manage Bypass values
				forever @(posedge intf.clock)
				begin
					if(!intf.reset)
					begin
						if((IR[15:12] == 4'b0001) || (IR[15:12] == 4'b0101) || (IR[15:12] == 4'b1001))    // IR Arithmetic
						begin
							if((IR_Exec[15:12] == 4'b0001) || (IR_Exec[15:12] == 4'b0101) || (IR_Exec[15:12] == 4'b1001) || (IR_Exec[15:12] == 4'b1110)) //  IR_Exec Arithmetic or LEA
							begin
								if(IR_Exec[11:9] == IR[8:6])
									bypass_alu_1 = 1'b1;
								else
									bypass_alu_1 = 1'b0;
								
								if((IR_Exec[11:9] == IR[2:0]) && (IR[5] == 1'b0))
									bypass_alu_2 = 1'b1;
								else
									bypass_alu_2 = 1'b0;
								
								bypass_mem_1 = 1'b0;
								bypass_mem_2 = 1'b0;
							end
							else if((IR_Exec[15:12] == 4'b0010) || (IR_Exec[15:12] == 4'b0110) || (IR_Exec[15:12] == 4'b1010)) //IR_Exec is Load Operation
							begin
								if(IR_Exec[11:9] == IR[8:6])
									bypass_mem_1 = 1'b1;

								else 
									bypass_mem_1 = 1'b0;

								if((IR_Exec[11:9] == IR[2:0]) && (IR[5] == 1'b0))
									bypass_mem_2 = 1'b1;

								else 
									bypass_mem_2 = 1'b0;

								bypass_alu_1 = 1'b0;
								bypass_alu_2 = 1'b0;
							end
							else
							begin
								bypass_alu_1 = 1'b0;
								bypass_alu_2 = 1'b0;
								bypass_mem_1 = 1'b0;
								bypass_mem_2 = 1'b0;
							end
						end
						else if(IR[15:12] == 4'b0110) // IR LDR
						begin
							if((IR_Exec[15:12] == 4'b0001) || (IR_Exec[15:12] == 4'b0101) || (IR_Exec[15:12] == 4'b1001)) //  IR_Exec Arithmetic
							begin
								if(IR_Exec[11:9] == IR[8:6])
								begin
									bypass_alu_1 = 1'b1;
									bypass_alu_2 = 1'b0;
									bypass_mem_1 = 1'b0;
									bypass_mem_2 = 1'b0;
								end
								else
								begin
									bypass_alu_1 = 1'b0;
									bypass_alu_2 = 1'b0;
									bypass_mem_1 = 1'b0;
									bypass_mem_2 = 1'b0;
								end
							end
							else
							begin
								bypass_alu_1 = 1'b0;
								bypass_alu_2 = 1'b0;
								bypass_mem_1 = 1'b0;
								bypass_mem_2 = 1'b0;
							end
						end
						else if(IR[15:12] == 4'b0111) //IR STR
						begin
							if((IR_Exec[15:12] == 4'b0001) || (IR_Exec[15:12] == 4'b0101) || (IR_Exec[15:12] == 4'b1001)) //  IR_Exec Arithmetic
							begin
								if(IR_Exec[11:9] == IR[8:6])
									bypass_alu_1 = 1'b1;

								else
									bypass_alu_1 = 1'b0;
									
								if(IR_Exec[11:9] == IR[11:9])
									bypass_alu_2 = 1'b1;

								else
									bypass_alu_2 = 1'b0;

								bypass_mem_1 = 1'b0;
								bypass_mem_2 = 1'b0;
							end
							else
							begin
								bypass_alu_1 = 1'b0;
								bypass_alu_2 = 1'b0;
								bypass_mem_1 = 1'b0;
								bypass_mem_2 = 1'b0;
							end
						end
						else if((IR[15:12] == 4'b0011) || (IR[15:12] == 4'b1011)) // ST/STI
						begin
							if((IR_Exec[15:12] == 4'b0001) || (IR_Exec[15:12] == 4'b0101) || (IR_Exec[15:12] == 4'b1001)) //  IR_Exec Arithmetic
							begin
								if(IR_Exec[11:9] == IR[11:9])
								begin
									bypass_alu_2 = 1'b1;
									bypass_alu_1 = 1'b0;
									bypass_mem_1 = 1'b0;
									bypass_mem_2 = 1'b0;
								end
								else
								begin
									bypass_alu_1 = 1'b0;
									bypass_alu_2 = 1'b0;
									bypass_mem_1 = 1'b0;
									bypass_mem_2 = 1'b0;
								end
							end
							else
							begin
								bypass_alu_1 = 1'b0;
								bypass_alu_2 = 1'b0;
								bypass_mem_1 = 1'b0;
								bypass_mem_2 = 1'b0;
							end
						end
						else if(IR[15:12] == 4'b1100) //IR JMP
						begin
							if((IR_Exec[15:12] == 4'b0001) || (IR_Exec[15:12] == 4'b0101) || (IR_Exec[15:12] == 4'b1001)) //  IR_Exec Arithmetic
							begin
								if(IR_Exec[11:9] == IR[8:6])
								begin
									bypass_alu_1 = 1'b1;
									bypass_alu_2 = 1'b0;
									bypass_mem_1 = 1'b0;
									bypass_mem_2 = 1'b0;
								end
								else
								begin
									bypass_alu_1 = 1'b0;
									bypass_alu_2 = 1'b0;
									bypass_mem_1 = 1'b0;
									bypass_mem_2 = 1'b0;
								end
							end
							else
							begin
								bypass_alu_1 = 1'b0;
								bypass_alu_2 = 1'b0;
								bypass_mem_1 = 1'b0;
								bypass_mem_2 = 1'b0;
							end
						end
						else
						begin
							bypass_alu_1 = 1'b0;
							bypass_alu_2 = 1'b0;
							bypass_mem_1 = 1'b0;
							bypass_mem_2 = 1'b0;
						end
					   	`bypass_chk
					end
				end
			end
			begin
				forever@(posedge intf.clock)
				begin
					if(controller_print_flag == 1)
						print_controller();
				end
			end
		join
	endtask

	task print_controller();
			$display($time,"=====================CONTROLLER======================");
			$display($time,"======================Inputs=========================");
			$display($time,"  complete_data = %b",complete_data);
			$display($time,"  complete_instr = %b",complete_instr);
			$display($time,"  Instr_dout = %h",Instr_dout);
			$display($time,"  IR = %h",IR);
			$display($time,"  IR_Exec = %h",IR_Exec);
			$display($time,"  NZP = %b",NZP);
			$display($time,"  psr = %b",psr);
			$display($time,"=======================Outputs=======================");
			$display($time,"  enable_updatePC = %b",enable_updatePC);
			$display($time,"  enable_fetch = %b",enable_fetch);
			$display($time,"  enable_decode = %b",enable_decode);
			$display($time,"  enable_execute = %b",enable_execute);
			$display($time,"  enable_writeback = %b",enable_writeback);
			$display($time,"  br_taken = %b",br_taken);
			$display($time,"  bypass_alu_1 = %b",bypass_alu_1);
			$display($time,"  bypass_alu_2 = %b",bypass_alu_2);
			$display($time,"  bypass_mem_1 = %b",bypass_mem_1);
			$display($time,"  bypass_mem_2 = %b",bypass_mem_2);
			$display($time,"  mem_state = %b",mem_state);
			$display($time,"======================================================");

	endtask
   
endclass


