`include "controller.sv"
`include "decode.sv"
`include "execute.sv"
`include "fetch.sv"
`include "Transaction.sv"
`include "writeback.sv"
`include "memory_access.sv"

class environment ;

   	fetch_gr ft_gr;
	decode_gr de_gr;
	execute_gr ex_gr;
	writeback_gr wb_gr;
	mem_access_gr ma_gr;
	
	controller_gr cnt_gr;
	
	transaction tr;
	
	//virtual top_intf intf;
	virtual LC3_io.TB intf;
	virtual dut_Probe_controller prob_cnt;
	virtual dut_Probe_fetch prob_ft;
	virtual dut_Probe_decode prob_de;
	virtual dut_Probe_execute prob_ex;
	virtual dut_Probe_writeback prob_wb;
	virtual dut_Probe_mem_access prob_ma;	
	

	function new(virtual LC3_io.TB intf, virtual dut_Probe_controller prob_cnt,virtual dut_Probe_fetch prob_ft,virtual dut_Probe_decode prob_de,virtual dut_Probe_execute prob_ex,virtual dut_Probe_writeback prob_wb,virtual dut_Probe_mem_access prob_ma);
		this.intf  = intf;
		this.prob_cnt = prob_cnt;
		this.prob_ft = prob_ft;
		this.prob_de = prob_de;
		this.prob_ex = prob_ex;
		this.prob_wb  = prob_wb;
		this.prob_ma  = prob_ma;
	endfunction

	function void build();
		ft_gr  = new(intf,prob_ft);
		de_gr  = new(intf,prob_de);
		ex_gr  = new(intf,prob_ex);
		wb_gr   = new(intf,prob_wb);
		ma_gr  = new(intf,prob_ma);
		cnt_gr = new(intf,prob_cnt);
		tr = new();


	endfunction

	task run();
		

		fork
			ft_gr.golden_ref();
			de_gr.golden_ref();
			ex_gr.golden_ref();
			wb_gr.golden_ref();
			ma_gr.golden_ref();
			cnt_gr.golden_ref();
		join

	endtask

	task send_enables();

		cnt_gr.IR = prob_de.IR;
		cnt_gr.IR_Exec = prob_ex.IR_Exec;
		cnt_gr.Instr_dout = tr.Instr_dout;
		cnt_gr.complete_data = tr.complete_data;
		cnt_gr.complete_instr = tr.complete_instr;
		wb_gr.enable_writeback = prob_cnt.enable_writeback;
		de_gr.enable_decode    =  prob_cnt.enable_decode;
		ex_gr.enable_execute = prob_cnt.enable_execute;

	endtask

	task transaction_rand();
			assert(tr.randomize());
	endtask

	task async_data();
	        ma_gr.Data_dout = tr.Data_dout;
	endtask

	task async();
		
		ex_gr.VSR1 = prob_wb.d1;			//asynch
		ex_gr.VSR2 = prob_wb.d2;
		wb_gr.sr1 = prob_ex.sr1;				//asynch
		wb_gr.sr2 = prob_ex.sr2;
		ft_gr.enable_Fetch  = prob_cnt.enable_fetch;                     
		ft_gr.enable_updatePC =  prob_cnt.enable_updatePC;
		ex_gr.Mem_Bypass_Val = prob_ma.memout;
		wb_gr.memout = prob_ma.memout;
		ma_gr.mem_state = prob_cnt.mem_state;
		ma_gr.M_addr    = prob_ex.pcout;
		ma_gr.M_Data    = prob_ex.M_Data;
		ma_gr.M_Control = prob_ex.Mem_Control_out;
		cnt_gr.NZP = prob_ex.NZP;
		cnt_gr.psr = prob_wb.psr;

	endtask

	task send();
	

		ft_gr.br_taken = prob_cnt.br_taken;
		ft_gr.taddr =  prob_ex.pcout;

		wb_gr.npc = prob_de.npc_out;		
		wb_gr.pcout = prob_ex.pcout;
		wb_gr.aluout = prob_ex.aluout;
		wb_gr.dr = prob_ex.dr;
		wb_gr.W_Control_in = prob_ex.W_Control_out;

		de_gr.Instr_dout  = tr.Instr_dout;
		de_gr.npc_in = prob_ft.fetch_npc_out;				//coming from fetch

		ex_gr.W_Control_in = prob_de.W_Control;
		ex_gr.Mem_Control_in = prob_de.Mem_Control;
		ex_gr.E_Control = prob_de.E_Control;
		ex_gr.IR = prob_de.IR;
		ex_gr.npc = prob_de.npc_out;
		ex_gr.bypass_alu_1 = prob_cnt.bypass_alu_1;
		ex_gr.bypass_alu_2 = prob_cnt.bypass_alu_2;
		ex_gr.bypass_mem_1 = prob_cnt.bypass_mem_1;
		ex_gr.bypass_mem_2 = prob_cnt.bypass_mem_2;

	endtask




endclass


