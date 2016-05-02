`timescale 1ns/1ps
`include "TopLevelLC3.v"
`include "interface.sv"
`include "Environment.sv"

module top_testbench();

	parameter num_sims = 300000;
	parameter bit [3:0] ADD = 4'b0001;  
	parameter bit [3:0] AND = 4'b0101;  
	parameter bit [3:0] NOT = 4'b1001;  
	parameter bit [3:0] LD  = 4'b0010;  
	parameter bit [3:0] LDR = 4'b0110;  
	parameter bit [3:0] LDI = 4'b1010;  
	parameter bit [3:0] LEA = 4'b1110;  
	parameter bit [3:0] ST  = 4'b0011;  
	parameter bit [3:0] STR = 4'b0111;  
	parameter bit [3:0] STI = 4'b1011;  
	parameter bit [3:0] BR  = 4'b0000;  
	parameter bit [3:0] JMP = 4'b1100;  

	logic clock;

	LC3_io  intf(clock);

	always
		#5ns clock = ~clock;
	
	environment ev;
	
	`include "coverage.sv"        
	MEM_OPR_cg  cvg_mem = new();  
	ALU_OPR_cg  cvg_alu = new();  
	CTRL_OPR_cg cvg_ctrl= new();  
	OPR_SEQ_cg  cvg_opr = new();  
	
	initial
           clock = 1'b0;
	
	LC3 dut(.clock(clock),
		.reset(intf.reset),
		.pc(intf.pc),
		.instrmem_rd(intf.instrmem_rd),
		.Instr_dout(intf.Instr_dout),
		.Data_addr(intf.Data_addr),
		.complete_instr(intf.complete_instr),
		.complete_data(intf.complete_data),
		.Data_din(intf.Data_din),
		.Data_dout(intf.Data_dout),
		.Data_rd(intf.Data_rd));

	
	 dut_Probe_fetch prob_ft(.reset(intf.reset),                                  
			    .clock(clock),
			    .fetch_enable_updatePC(dut.Fetch.enable_updatePC),
                            .fetch_enable_fetch(dut.Fetch.enable_fetch),
			    .fetch_pc(dut.Fetch.pc), 
			    .fetch_npc_out(dut.Fetch.npc_out),
			    .fetch_instrmem_rd(dut.Fetch.instrmem_rd),
			    .fetch_taddr(dut.Fetch.taddr),
			    .fetch_br_taken(dut.Fetch.br_taken));
	


	 dut_Probe_decode prob_de(
			.clock(clock),
			.reset(intf.reset),                                  
			.enable_decode(dut.Dec.enable_decode), 
			.dout(dut.Dec.dout), 
			.E_Control(dut.Dec.E_Control), //.F_Control(F_Control), 
			.npc_in(dut.Dec.npc_in), //.psr(psr), 
			.Mem_Control(dut.Dec.Mem_Control), 
			.W_Control(dut.Dec.W_Control), 
			.IR(dut.Dec.IR), 
			.npc_out(dut.Dec.npc_out)
	      		);							

 	dut_Probe_execute prob_ex(
			.clock(clock),
			.reset(intf.reset),                                 
	        .E_Control(dut.Ex.E_Control), 
			.bypass_alu_1(dut.Ex.bypass_alu_1), 
            .bypass_alu_2(dut.Ex.bypass_alu_2), 
			.IR(dut.Ex.IR), 
			.npc(dut.Ex.npc), 
			.W_Control_in(dut.Ex.W_Control_in), 
            .Mem_Control_in(dut.Ex.Mem_Control_in), 
			.VSR1(dut.Ex.VSR1), 
			.VSR2(dut.Ex.VSR2), 
            .bypass_mem_1(dut.Ex.bypass_mem_1), 
			.bypass_mem_2(dut.Ex.bypass_mem_2), 
			.Mem_Bypass_Val(dut.Ex.Mem_Bypass_Val),
            .enable_execute(dut.Ex.enable_execute), 
			.W_Control_out(dut.Ex.W_Control_out), 
            .Mem_Control_out(dut.Ex.Mem_Control_out), 
			.aluout(dut.Ex.aluout), 
			.pcout(dut.Ex.pcout), 
            .sr1(dut.Ex.sr1), 
			.sr2(dut.Ex.sr2), 
			.dr(dut.Ex.dr), 
			.M_Data(dut.Ex.M_Data), 
			.NZP(dut.Ex.NZP), 
			.IR_Exec(dut.Ex.IR_Exec)
			);






	 dut_Probe_controller prob_cnt(
			.clock(clock),
			.reset(intf.reset),                                  
			.IR(dut.Ctrl.IR), 
			.bypass_alu_1(dut.Ctrl.bypass_alu_1), 
			.bypass_alu_2(dut.Ctrl.bypass_alu_2), 
			.bypass_mem_1(dut.Ctrl.bypass_mem_1), 
			.bypass_mem_2(dut.Ctrl.bypass_mem_2), 
			.complete_data(dut.Ctrl.complete_data),
			.complete_instr(dut.Ctrl.complete_instr),
			.Instr_dout(dut.Ctrl.Instr_dout), 
			.NZP(dut.Ctrl.NZP), 
			.psr(dut.Ctrl.psr), 
			.IR_Exec(dut.Ctrl.IR_Exec),
			.enable_fetch(dut.Ctrl.enable_fetch), 
			.enable_decode(dut.Ctrl.enable_decode), 
			.enable_execute(dut.Ctrl.enable_execute), 
			.enable_writeback(dut.Ctrl.enable_writeback), 
			.enable_updatePC(dut.Ctrl.enable_updatePC), 
			.br_taken(dut.Ctrl.br_taken), 
			.mem_state(dut.Ctrl.mem_state)
			);
	dut_Probe_writeback prob_wb(	
			.clock(clock),
			.reset(intf.reset),                                 
			.enable_writeback(dut.WB.enable_writeback), 
			.W_Control(dut.WB.W_Control), 
			.aluout(dut.WB.aluout), 
			.memout(dut.WB.memout), 
			.pcout(dut.WB.pcout),
			.npc(dut.WB.npc),
			.sr1(dut.WB.sr1),
			.sr2(dut.WB.sr2),
			.dr(dut.WB.dr),
			.d1(dut.WB.d1),
			.d2(dut.WB.d2),
			.psr(dut.WB.psr)
			);
	dut_Probe_mem_access prob_ma(	
			.clock(clock),
			.reset(intf.reset),                                
			.mem_state(dut.MemAccess.mem_state),
			.M_Control(dut.MemAccess.M_Control),
 			.M_Data(dut.MemAccess.M_Data), 
			.M_Addr(dut.MemAccess.M_Addr), 
			.memout(dut.MemAccess.memout), 
			.Data_addr(dut.MemAccess.Data_addr), 
			.Data_din(dut.MemAccess.Data_din), 
			.Data_dout(dut.MemAccess.Data_dout), 
			.Data_rd(dut.MemAccess.Data_rd)
			);

	initial
	begin

		ev  = new(intf.TB,prob_cnt,prob_ft,prob_de,prob_ex,prob_wb,prob_ma);

	    	intf.reset = 1'b1;
		
		ev.build();
		foreach(dut.WB.RF.ram[i])
		begin
			dut.WB.RF.ram[i] = i;	
			ev.wb_gr.RegFile[i] = i;
		end

		/////// Flags to print each module signals /////////////
		ev.ft_gr.fetch_print_flag = 0;
		ev.de_gr.decode_print_flag = 0;
		ev.ex_gr.execute_print_flag = 0;
		ev.wb_gr.prob_wbprintflag = 0;
		ev.wb_gr.prob_wbprintRF_flag = 0;
		ev.ma_gr.mem_access_print_flag = 0;
		ev.cnt_gr.controller_print_flag = 0;

		fork
			ev.run();
			begin
				forever@(prob_ex.sr1,prob_ex.sr2,prob_cnt.enable_fetch,prob_wb.d1,prob_wb.d2,prob_ma.memout,prob_cnt.mem_state,prob_ex.pcout,prob_ex.M_Data,prob_ex.Mem_Control_out,prob_cnt.enable_updatePC,prob_ex.NZP,prob_wb.psr)
					ev.async();
			end
			begin
				forever@(ev.tr.Data_dout)
					ev.async_data();
			end
		join_none
		#17 intf.reset = 1'b0;
		fork
		forever
		begin
			#1;
			`include "assert_dut_signals"
		end
		join_none
		
		for(int i = 0;i < num_sims;i++)
			begin
					
				@(posedge clock);
				if(ev.ft_gr.instrmem_rd)
				begin
					ev.transaction_rand();
					intf.complete_instr = ev.tr.complete_instr;
					intf.complete_data = ev.tr.complete_data;
					intf.Data_dout = ev.tr.Data_dout;
					intf.Instr_dout = ev.tr.Instr_dout;
				end
					#0.001;
					ev.send();
					ev.send_enables();
			end
			$display("finally done");

		   //none or just join
	end

//	initial
					
//	begin
//		#50000000 $finish;
//	end
	
	
endmodule

