


interface LC3_io(input bit clock);
  	
	logic reset, instrmem_rd, complete_instr, complete_data, Data_rd; 
	logic [15:0] pc, Instr_dout, Data_addr,  Data_dout, Data_din;
  	

  	clocking cb @(posedge clock);
 	default input #1 output #0;

		// instruction memory side
		input	pc; 
   		input	instrmem_rd;  
   		output Instr_dout;

		// data memory side
		input Data_din;
		input Data_rd;
		input Data_addr;		
		output Data_dout;
		
		//output reset;
		
		
  	endclocking

  	modport TB(clocking cb, output complete_data, output complete_instr,input clock,output reset);   //modify to include reset

	property lc3_rst_if;
		@(posedge clock)
		reset |-> ##1 (pc == 16'h3000);
	endproperty
	
	assert property (lc3_rst_if);
	cover property (lc3_rst_if);

endinterface


interface dut_Probe_controller(
			input logic clock,
			input logic reset,
			input logic [15:0] IR, 
			input logic bypass_alu_1, 
			input logic bypass_alu_2, 
			input logic bypass_mem_1, 
			input logic bypass_mem_2, 
			input logic complete_data,
			input logic complete_instr,
			input logic [15:0] Instr_dout, 
			input logic [2:0] NZP, 
			input logic [2:0] psr, 
			input logic [15:0] IR_Exec,
			input logic enable_fetch, 
			input logic enable_decode, 
			input logic enable_execute, 
			input logic enable_writeback, 
			input logic enable_updatePC, 
			input logic br_taken, 
			input logic [1:0] mem_state
			);

		//------------------------------------CONTROLLER RESET -----------------------------------------------//
		
		property lc3_rst_ctrl;
			@(posedge clock)
			reset |-> ##1 (!((enable_decode)||(enable_execute)||(enable_writeback)))&&(!(enable_updatePC)&&(enable_fetch)&&(mem_state==2'b11));
		
		endproperty
		
		assert property (lc3_rst_ctrl); 
		cover property (lc3_rst_ctrl);
		
		//------------------------------------BR_TAKEN-----------------------------------------------//
		property CTRL_br_taken_jmp;
			@(posedge clock)
			|(NZP & psr) |-> br_taken;
		
		endproperty
		
		assert property (CTRL_br_taken_jmp); 
		cover property (CTRL_br_taken_jmp);
		//----------------------------------------FETCH-----------------------------------------------//
		property CTRL_enable_fetch_fall;
			@(posedge clock)
			(IR[15:12] == 4'b0011 || IR[15:12] == 4'b0111 || IR[15:12] == 4'b0010 || IR[15:12] == 4'b0110 || IR[15:12] == 4'b1010 || IR[15:12] == 4'b1011 || Instr_dout[15:12] == 4'b0000 || Instr_dout[15:12] == 4'b1100) |=>  !enable_fetch;
		
		endproperty
		
		cover property (CTRL_enable_fetch_fall);
		
		property CTRL_enable_fetch_rise1;
			@(posedge clock)
			(IR[15:12] == 4'b0011 || IR[15:12] == 4'b0111 || IR[15:12] == 4'b0010 || IR[15:12] == 4'b0110 ) |=>  ##1 enable_fetch;
		endproperty
		property CTRL_enable_fetch_rise2;
			@(posedge clock)
			(IR[15:12] == 4'b1010 || IR[15:12] == 4'b1011) |=>  ##2 enable_fetch;
		endproperty
		property CTRL_enable_fetch_rise3;
			@(posedge clock)
			(Instr_dout[15:12] == 4'b0000) || (Instr_dout[15:12] == 4'b1100) |=>  ##3 enable_fetch;
		endproperty
		
		assert property (CTRL_enable_fetch_rise1); 
		cover property (CTRL_enable_fetch_rise1);
		assert property (CTRL_enable_fetch_rise2); 
		cover property (CTRL_enable_fetch_rise2);
		assert property (CTRL_enable_fetch_rise3); 
		cover property (CTRL_enable_fetch_rise3);

		//-------------------------------------------WRITEBACK------------------------------------------------//

		property CTRL_enable_mem_state_LDI;
			@(posedge clock)
			(IR[15:12] == 4'b1010) |=>  mem_state == 2'b01 ##1 mem_state == 2'b00 ##1 mem_state == 2'b11;
		endproperty
		assert property (CTRL_enable_mem_state_LDI); 
		cover property  (CTRL_enable_mem_state_LDI);

		property CTRL_enable_mem_state_STI;
			@(posedge clock)
			(IR[15:12] == 4'b1011) |=>  mem_state == 2'b01 ##1 mem_state == 2'b10 ##1 mem_state == 2'b11;
		endproperty
		assert property (CTRL_enable_mem_state_STI); 
		cover property  (CTRL_enable_mem_state_STI);

		property CTRL_enable_mem_state_STI_LDI;
			@(posedge clock)
			(IR[15:12] == 4'b1010 || IR[15:12] == 4'b1011 ) |=>  mem_state == 2'b01 ##2 mem_state == 2'b11;
		endproperty
		assert property (CTRL_enable_mem_state_STI_LDI); 
		cover property  (CTRL_enable_mem_state_STI_LDI);
	
		property CTRL_enable_mem_state_ST_STR;
			@(posedge clock)
			(IR[15:12] == 4'b0011 || IR[15:12] == 4'b0111 ) |=>  mem_state == 2'b10 ##1 mem_state == 2'b11;
		endproperty
		assert property (CTRL_enable_mem_state_ST_STR); 
		cover property  (CTRL_enable_mem_state_ST_STR);
		property CTRL_enable_mem_state_LD_LDR;
			@(posedge clock)
			(IR[15:12] == 4'b0010 || IR[15:12] == 4'b0110 ) |=>  mem_state == 2'b00 ##1 mem_state == 2'b11;
		endproperty
		assert property (CTRL_enable_mem_state_LD_LDR); 
		cover property  (CTRL_enable_mem_state_LD_LDR);
		
		property CTRL_bypass_alu_1_AA;
			@(posedge clock)
		((IR[15:12] == 4'b0001) || (IR[15:12] == 4'b0101) || (IR[15:12] == 4'b1001)) && ((IR_Exec[15:12] == 4'b0001) || (IR_Exec[15:12] == 4'b0101) || (IR_Exec[15:12] == 4'b1001) || (IR_Exec[15:12] == 4'b1110)) && (IR_Exec[11:9] == IR[8:6]) |-> bypass_alu_1 == 1'b1;
		endproperty
		assert property (CTRL_bypass_alu_1_AA); 
		cover property  (CTRL_bypass_alu_1_AA);

		property CTRL_bypass_alu_2_AA;
			@(posedge clock)
		((IR[15:12] == 4'b0001) || (IR[15:12] == 4'b0101) || (IR[15:12] == 4'b1001)) && ((IR_Exec[15:12] == 4'b0001) || (IR_Exec[15:12] == 4'b0101) || (IR_Exec[15:12] == 4'b1001) || (IR_Exec[15:12] == 4'b1110)) && ((IR_Exec[11:9] == IR[2:0]) && (IR[5] == 1'b0)) |-> bypass_alu_2 == 1'b1;
		endproperty
		assert property (CTRL_bypass_alu_2_AA); 
		cover property  (CTRL_bypass_alu_2_AA);
		
		property CTRL_bypass_alu_1_AL;
			@(posedge clock)
		((IR_Exec[15:12] == 4'b0001) || (IR_Exec[15:12] == 4'b0101) || (IR_Exec[15:12] == 4'b1001)) && (IR[15:12] == 4'b0110) && (IR_Exec[11:9] == IR[8:6]) |-> bypass_alu_1 == 1'b1;
		endproperty
		assert property (CTRL_bypass_alu_1_AL); 
		cover property  (CTRL_bypass_alu_1_AL);
		
		property CTRL_bypass_alu_1_AS;
			@(posedge clock)
		((IR_Exec[15:12] == 4'b0001) || (IR_Exec[15:12] == 4'b0101) || (IR_Exec[15:12] == 4'b1001)) && (IR[15:12] == 4'b0111) && (IR_Exec[11:9] == IR[8:6]) |-> bypass_alu_1 == 1'b1;
		endproperty
		assert property (CTRL_bypass_alu_1_AS); 
		cover property  (CTRL_bypass_alu_1_AS);

		property CTRL_bypass_mem_1_LA;
			@(posedge clock)
		((IR_Exec[15:12] == 4'b0010) || (IR_Exec[15:12] == 4'b0110) || (IR_Exec[15:12] == 4'b1010)) && ((IR[15:12] == 4'b0001) || (IR[15:12] == 4'b0101) || (IR[15:12] == 4'b1001)) && (IR_Exec[11:9] == IR[8:6]) |-> bypass_mem_1 == 1'b1;
		endproperty
		assert property (CTRL_bypass_mem_1_LA); 
		cover property  (CTRL_bypass_mem_1_LA);

		property CTRL_bypass_mem_2_LA;
			@(posedge clock)
		((IR_Exec[15:12] == 4'b0010) || (IR_Exec[15:12] == 4'b0110) || (IR_Exec[15:12] == 4'b1010)) && ((IR[15:12] == 4'b0001) || (IR[15:12] == 4'b0101) || (IR[15:12] == 4'b1001)) && ((IR_Exec[11:9] == IR[2:0]) && (IR[5] == 1'b0)) |-> bypass_mem_2 == 1'b1;
		endproperty
		assert property (CTRL_bypass_mem_2_LA); 
		cover property  (CTRL_bypass_mem_2_LA);

		property CTRL_enable_wb_ST;
			@(posedge clock)
			(Instr_dout[15:12] == 4'b0111 || Instr_dout[15:12] == 4'b0011) |=> ##2 !enable_writeback ##2 enable_writeback;
		endproperty
		assert property (CTRL_enable_wb_ST);
		cover property  (CTRL_enable_wb_ST);


		property CTRL_mem_state_3_1;
			@(posedge clock)
			(mem_state == 2'b11) && ((IR[15:12] == 4'b1010) || (IR[15:12] == 4'b1010)) |=>  mem_state == 2'b01;
		endproperty
		assert property (CTRL_mem_state_3_1); 
		cover property  (CTRL_mem_state_3_1);

		property CTRL_mem_state_3_0;
			@(posedge clock)
			(mem_state == 2'b11) && (IR[15:12] == 4'b1010) |=>  mem_state == 2'b01 ##1 mem_state == 2'b00;
		endproperty
		assert property (CTRL_mem_state_3_0); 
		cover property  (CTRL_mem_state_3_0);

		property CTRL_mem_state_3_2;
			@(posedge clock)
			(mem_state == 2'b11) && (IR[15:12] == 4'b1011) |=>  mem_state == 2'b01 ##1 mem_state == 2'b10;
		endproperty
		assert property (CTRL_mem_state_3_2); 
		cover property  (CTRL_mem_state_3_2);

		property CTRL_mem_state_2_3;
			@(posedge clock)
			(mem_state == 2'b10) && (complete_data == 1) |=>  mem_state == 2'b11;
		endproperty
		assert property (CTRL_mem_state_2_3); 
		cover property  (CTRL_mem_state_2_3);

		property CTRL_mem_state_0_3;
			@(posedge clock)
			(mem_state == 2'b00) && (complete_data == 1) |=>  mem_state == 2'b11;
		endproperty
		assert property (CTRL_mem_state_0_3); 
		cover property  (CTRL_mem_state_0_3);

		property CTRL_mem_state_1_2;
			@(posedge clock)
			(mem_state == 2'b01) && (IR_Exec[15:12] == 4'b1011) |=>  mem_state == 2'b10;
		endproperty
		assert property (CTRL_mem_state_1_2); 
		cover property  (CTRL_mem_state_1_2);

		property CTRL_mem_state_1_0;
			@(posedge clock)
			(mem_state == 2'b01) && (IR_Exec[15:12] == 4'b1010) |=>  mem_state == 2'b00;
		endproperty
		assert property (CTRL_mem_state_1_0); 
		cover property  (CTRL_mem_state_1_0);

		property CTRL_enable_writeback_fall1;
			@(posedge clock)
			(IR[15:12] == 4'b0011 || IR[15:12] == 4'b0111 || IR[15:12] == 4'b0010 || IR[15:12] == 4'b0110 || IR[15:12] == 4'b1010 || IR[15:12] == 4'b1011 ) |=>  !enable_writeback;
		
		endproperty
		property CTRL_enable_writeback_fall2;
			@(posedge clock)
			(Instr_dout[15:12] == 4'b0000 || Instr_dout[15:12] == 4'b1100) |=>  ##2 !enable_writeback;
		
		endproperty
		
		cover property (CTRL_enable_writeback_fall1);
		cover property (CTRL_enable_writeback_fall2);
		
		property CTRL_enable_writeback_rise1;
			@(posedge clock)
			(IR[15:12] == 4'b0010 || IR[15:12] == 4'b0110 ) |=>  ##1 enable_writeback;
		endproperty
		property CTRL_enable_writeback_rise2;
			@(posedge clock)
			(IR[15:12] == 4'b0011 || IR[15:12] == 4'b0111 || IR[15:12] == 4'b1010) |=>  ##2 enable_writeback;
		endproperty
		
		property CTRL_enable_writeback_rise3;
			@(posedge clock)
			(IR[15:12] == 4'b1011) |=>  ##3 enable_writeback;
		endproperty
		property CTRL_enable_writeback_rise4;
			@(posedge clock)
			(Instr_dout[15:12] == 4'b0000) || (Instr_dout[15:12] == 4'b1100) |=>  ##6 enable_writeback;
		endproperty
		
		assert property (CTRL_enable_writeback_rise1); 
		cover property  (CTRL_enable_writeback_rise1);
		assert property (CTRL_enable_writeback_rise2); 
		cover property  (CTRL_enable_writeback_rise2);
		assert property (CTRL_enable_writeback_rise3); 
		cover property  (CTRL_enable_writeback_rise3);
		assert property (CTRL_enable_writeback_rise4); 
		cover property  (CTRL_enable_writeback_rise4);

		//------------------------------------------EXECUTE------------------------------------------//
		property CTRL_enable_execute_fall1;
			@(posedge clock)
			(IR[15:12] == 4'b0011 || IR[15:12] == 4'b0111 || IR[15:12] == 4'b0010 || IR[15:12] == 4'b0110 || IR[15:12] == 4'b1010 || IR[15:12] == 4'b1011 ) |=>  !enable_execute;
		
		endproperty
		property CTRL_enable_execute_fall2;
			@(posedge clock)
			(Instr_dout[15:12] == 4'b0000 || Instr_dout[15:12] == 4'b1100) |=>  ##2 !enable_execute;
		
		endproperty
		
		cover property (CTRL_enable_execute_fall1);
		cover property (CTRL_enable_execute_fall2);
		
		property CTRL_enable_execute_rise1;
			@(posedge clock)
			(IR[15:12] == 4'b0011 || IR[15:12] == 4'b0111 || IR[15:12] == 4'b0010 || IR[15:12] == 4'b0110 ) |=>  ##1 enable_execute;
		endproperty
		property CTRL_enable_execute_rise2;
			@(posedge clock)
			(IR[15:12] == 4'b1010 || IR[15:12] == 4'b1011) |=>  ##2 enable_execute;
		endproperty
		property CTRL_enable_execute_rise3;
			@(posedge clock)
			(Instr_dout[15:12] == 4'b0000) || (Instr_dout[15:12] == 4'b1100) |=>  ##5 enable_execute;
		endproperty
		
		assert property (CTRL_enable_execute_rise1); 
		cover property  (CTRL_enable_execute_rise1);
		assert property (CTRL_enable_execute_rise2); 
		cover property  (CTRL_enable_execute_rise2);
		assert property (CTRL_enable_execute_rise3); 
		cover property  (CTRL_enable_execute_rise3);

		//----------------------------------------DECODE-----------------------------------------------//
		property CTRL_enable_decode_fall1;
			@(posedge clock)
			(IR[15:12] == 4'b0011 || IR[15:12] == 4'b0111 || IR[15:12] == 4'b0010 || IR[15:12] == 4'b0110 || IR[15:12] == 4'b1010 || IR[15:12] == 4'b1011 ) |=>  !enable_decode;
		
		endproperty
		property CTRL_enable_decode_fall2;
			@(posedge clock)
			(Instr_dout[15:12] == 4'b0000 || Instr_dout[15:12] == 4'b1100) |=>  ##1 !enable_decode;
		
		endproperty
		
		cover property (CTRL_enable_decode_fall1);
		cover property (CTRL_enable_decode_fall2);
		
		property CTRL_enable_decode_rise1;
			@(posedge clock)
			(IR[15:12] == 4'b0011 || IR[15:12] == 4'b0111 || IR[15:12] == 4'b0010 || IR[15:12] == 4'b0110 ) |=>  ##1 enable_decode;
		endproperty
		property CTRL_enable_decode_rise2;
			@(posedge clock)
			(IR[15:12] == 4'b1010 || IR[15:12] == 4'b1011) |=>  ##2 enable_decode;
		endproperty
		property CTRL_enable_decode_rise3;
			@(posedge clock)
			(Instr_dout[15:12] == 4'b0000) || (Instr_dout[15:12] == 4'b1100) |=>  ##4 enable_decode;
		endproperty
		
		assert property (CTRL_enable_decode_rise1); 
		cover property  (CTRL_enable_decode_rise1);
		assert property (CTRL_enable_decode_rise2); 
		cover property  (CTRL_enable_decode_rise2);
		assert property (CTRL_enable_decode_rise3); 
		cover property  (CTRL_enable_decode_rise3);

endinterface


interface dut_Probe_fetch(
					input 	logic 				clock,
					input 	logic 				reset,	
					input   logic 				fetch_enable_updatePC,
					input	logic				fetch_enable_fetch,
					input	logic				fetch_br_taken, 
					input   logic 		[15:0] 	fetch_taddr,
					input   logic 				fetch_instrmem_rd,
					input   logic		[15:0]	fetch_pc,
					input	logic		[15:0]	fetch_npc_out
					);
endinterface
interface dut_Probe_decode(
			input logic clock,
			input logic reset,
			input logic enable_decode, 
			input logic [15:0]dout, 
			input logic [5:0]E_Control, //.F_Control(F_Control), 
			input logic [15:0]npc_in, //.psr(psr), 
			input logic Mem_Control, 
			input logic [1:0]W_Control, 
			input logic [15:0]IR, 
			input logic [15:0]npc_out
	      		);							

property lc3_rst_dc;
	@(posedge clock)
	reset |-> ##1 (!((Mem_Control)||(W_Control)||(E_Control)||(IR)||(npc_out)));

endproperty

assert property (lc3_rst_dc);
cover property (lc3_rst_dc);


endinterface
interface dut_Probe_execute(
			input logic clock,
			input logic reset,
	        input logic [5:0]E_Control, 
			input logic bypass_alu_1, 
            input logic bypass_alu_2, 
			input logic [15:0]IR, 
			input logic [15:0]npc, 
			input logic [1:0]W_Control_in, 
            input logic Mem_Control_in, 
			input logic [15:0]VSR1, 
			input logic [15:0]VSR2, 
            input logic bypass_mem_1, 
			input logic bypass_mem_2, 
			input logic [15:0]Mem_Bypass_Val,
            input logic enable_execute, 
			input logic [1:0]W_Control_out, 
           	input logic Mem_Control_out, 
			input logic [15:0]aluout, 
			input logic [15:0]pcout, 
            input logic [2:0]sr1, 
			input logic [2:0]sr2, 
			input logic [2:0]dr, 
			input logic [15:0]M_Data, 
			input logic [2:0]NZP, 
			input logic [15:0]IR_Exec
			);
	
		property lc3_rst_ex;
			@(posedge clock)
			reset |-> ##1 (!((Mem_Control_out)||(W_Control_out)||(dr)||(NZP)||(IR_Exec)||(aluout)||(pcout)||(M_Data)));
		endproperty
		assert property (lc3_rst_ex); 
		cover property (lc3_rst_ex);
		

endinterface
interface dut_Probe_writeback(	
			input logic clock,
			input logic reset,
			input logic enable_writeback,
			input logic [1:0] W_Control, 
			input logic [15:0] aluout, 
			input logic [15:0] memout,
			input logic [15:0 ]pcout,
			input logic [15:0] npc,
			input logic [2:0] sr1,
			input logic [2:0] sr2,
			input logic [2:0] dr,
			input logic [15:0] d1,
			input logic [15:0] d2,
			input logic [2:0] psr
			);

property lc3_rst_wb;
	@(posedge clock)
	reset |-> ##1 (!psr);
endproperty
assert property (lc3_rst_wb);
cover property (lc3_rst_wb);

endinterface
	
interface dut_Probe_mem_access (
			input logic clock,
			input logic reset,	
			input logic [1:0] mem_state,
			input logic M_Control,
 			input logic [15:0]M_Data, 
			input logic [15:0] M_Addr, 
			input logic [15:0] memout, 
			input logic [15:0] Data_addr, 
			input logic [15:0] Data_din, 
			input logic [15:0] Data_dout, 
			input logic Data_rd
			);
endinterface

