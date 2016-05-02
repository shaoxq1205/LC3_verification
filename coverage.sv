
covergroup MEM_OPR_cg @(posedge clock);
	Cov_mem_opcode : coverpoint ev.de_gr.Instr_dout[15:12]
	{
		bins LD_b  = {LD };
		bins LDR_b = {LDR};
		bins LDI_b = {LDI};
		bins LEA_b = {LEA};
		bins ST_b  = {ST };
		bins STR_b = {STR};
		bins STI_b = {STI};
	}
	Cov_BaseR_LDR : coverpoint ev.de_gr.Instr_dout[8:6] iff(ev.de_gr.Instr_dout[15:12] == LDR)
	{
		bins LDR_BaseR[] = {[3'b000:3'b111]};
	}
	Cov_BaseR_STR : coverpoint ev.de_gr.Instr_dout[8:6] iff(ev.de_gr.Instr_dout[15:12] == STR)
	{
		bins STR_BaseR[] = {[3'b000:3'b111]};
	}
	Cov_SR_ST : coverpoint ev.de_gr.Instr_dout[11:9] iff(ev.de_gr.Instr_dout[15:12] == ST)
	{
		bins ST_SR[] = {[3'b000:3'b111]};
	}
	Cov_SR_STI : coverpoint ev.de_gr.Instr_dout[11:9] iff(ev.de_gr.Instr_dout[15:12] == STI)
	{
		bins STI_SR[] = {[3'b000:3'b111]};
	}
	Cov_SR_STR : coverpoint ev.de_gr.Instr_dout[11:9] iff(ev.de_gr.Instr_dout[15:12] == STR)
	{
		bins STR_SR[] = {[3'b000:3'b111]};
	}
	Cov_DR_LD : coverpoint ev.de_gr.Instr_dout[11:9] iff(ev.de_gr.Instr_dout[15:12] == LD)
	{
		bins LD_DR[] = {[3'b000:3'b111]};
	}
	Cov_DR_LDR : coverpoint ev.de_gr.Instr_dout[11:9] iff(ev.de_gr.Instr_dout[15:12] == LDR)
	{
		bins LDR_DR[] = {[3'b000:3'b111]};
	}
	Cov_DR_LDI : coverpoint ev.de_gr.Instr_dout[11:9] iff(ev.de_gr.Instr_dout[15:12] == LDI)
	{
		bins LDI_DR[] = {[3'b000:3'b111]};
	}
	Cov_DR_LEA : coverpoint ev.de_gr.Instr_dout[11:9] iff(ev.de_gr.Instr_dout[15:12] == LEA)
	{
		bins LEA_DR[] = {[3'b000:3'b111]};
	}
	Cov_PCoffset9 : coverpoint ev.de_gr.Instr_dout[8:0] iff(ev.de_gr.Instr_dout[15:12] == LD || ev.de_gr.Instr_dout[15:12] == LDI || ev.de_gr.Instr_dout[15:12] == LEA || ev.de_gr.Instr_dout[15:12] == ST || ev.de_gr.Instr_dout[15:12] == STI || ev.de_gr.Instr_dout[15:12] == BR )
	{
		option.auto_bin_max = 8 ;
	}
	Cov_PCoffset6 : coverpoint ev.de_gr.Instr_dout[5:0] iff(ev.de_gr.Instr_dout[15:12] == LDR || ev.de_gr.Instr_dout[15:12] == STR)
	{
		option.auto_bin_max = 8 ;
	}
	Cov_PCoffset9_c : coverpoint ev.de_gr.Instr_dout[8:0] iff(ev.de_gr.Instr_dout[15:12] == LD || ev.de_gr.Instr_dout[15:12] == LDI || ev.de_gr.Instr_dout[15:12] == LEA || ev.de_gr.Instr_dout[15:12] == ST || ev.de_gr.Instr_dout[15:12] == STI || ev.de_gr.Instr_dout[15:12] == BR )
	{
		bins PCoffset9_c_high= {9'b111111111};
		bins PCoffset9_c_low= {9'b000000000};
	}
	Cov_PCoffset6_c : coverpoint ev.de_gr.Instr_dout[5:0] iff(ev.de_gr.Instr_dout[15:12] == LDR || ev.de_gr.Instr_dout[15:12] == STR)
	{
		bins PCoffset6_c_high= {6'b111111};
		bins PCoffset6_c_low= {6'b000000};
	}
	
	Xc_BaseR_DR_offset6 : cross Cov_PCoffset6,Cov_SR_STR,Cov_BaseR_STR,Cov_mem_opcode
    {
        ignore_bins others = binsof(Cov_mem_opcode) intersect {LDR, LD, LDI, STI, ST, LEA};
    }

    Xc_BaseR_SR_offset6 : cross Cov_PCoffset6,Cov_DR_LDR,Cov_BaseR_LDR,Cov_mem_opcode
    {
        ignore_bins others = binsof(Cov_mem_opcode) intersect {STR, LD, LDI, STI, ST, LEA};
    }

endgroup
covergroup ALU_OPR_cg @(posedge clock);

	Cov_alu_opcode : coverpoint ev.de_gr.Instr_dout[15:12]
	{
		bins ADD_b = {ADD};
		bins AND_b = {AND};
		bins NOT_b = {NOT};
	}
	Cov_alu_opcode_AND_ADD : coverpoint ev.de_gr.Instr_dout[15:12]
	{
		bins AND_p = {AND};
		bins ADD_p = {ADD};
	}	
	Cov_alu_opcode_NOT : coverpoint ev.de_gr.Instr_dout[15:12]
	{
		bins NOT_p = {NOT};
	}
	Cov_imm_en : coverpoint ev.de_gr.Instr_dout[5]
	{
		bins HIGH = {1'b1};
		bins LOW  = {1'b0};
	}
	Cov_SR1 : coverpoint ev.de_gr.Instr_dout[8:6]
	{
		bins ALU_SR1[] = {[0:7]};
	}
	Cov_SR2 : coverpoint ev.de_gr.Instr_dout[2:0]
	{
		bins ALU_SR2[] = {[0:7]};
	}
	Cov_DR  : coverpoint ev.de_gr.Instr_dout[11:9]
	{
		bins ALU_DR[] = {[0:7]};
	}
	Cov_imm5 : coverpoint ev.de_gr.Instr_dout[4:0] iff(ev.de_gr.Instr_dout[5] == 1'b1)
	{
		bins IMM[] = {[5'b00000:5'b11111]};
	}
	//Xc_opcode_not_imm_en : cross Cov_alu_opcode_NOT , Cov_imm_en iff(ev.de_gr.Instr_dout[5] == 1'b1); 
	Xc_opcode_imm_en : cross Cov_alu_opcode_AND_ADD,Cov_imm_en;
	Xc_opcode_dr_sr1_imm5 : cross Cov_alu_opcode_AND_ADD,Cov_SR1,Cov_DR,Cov_imm5 iff(ev.de_gr.Instr_dout[5] == 1'b1);			//CHANGED
	Xc_opcode_dr_sr1_sr2 : cross Cov_alu_opcode_AND_ADD,Cov_SR1,Cov_SR2,Cov_DR  iff(ev.de_gr.Instr_dout[5] == 1'b0);		//&&((ev.de_gr.Instr_dout[15:12]==1)||(ev.de_gr.Instr_dout[15:12]==5)));	Cov_imm5 		//CHNAGED
	Cov_aluin1 : coverpoint ev.ex_gr.aluin1_out
	{
		option.auto_bin_max = 8 ;
	}
	Cov_aluin1_corner : coverpoint ev.ex_gr.aluin1_out
	{
		bins aluin1_corner_high = {16'h0000} ;
		bins aluin1_corner_low  = {16'hFFFF} ;
	}
	Cov_aluin2 : coverpoint ev.ex_gr.aluin2_out
	{
		option.auto_bin_max = 8 ;
	}
	Cov_aluin2_corner : coverpoint ev.ex_gr.aluin2_out
	{
		bins aluin2_corner_high = {16'h0000} ;
		bins aluin2_corner_low  = {16'hFFFF} ;
	}
	Xc_opcode_aluin1 : cross Cov_alu_opcode,Cov_aluin1_corner;
	Xc_opcode_aluin2 : cross Cov_alu_opcode,Cov_aluin2_corner;
	Xc_Cov_opr_zero_ALL1 : cross Cov_alu_opcode_AND_ADD,Cov_aluin1_corner,Cov_aluin2_corner; 		//iff(ev.de_gr.Instr_dout[15:12] != NOT);
	Cov_aluin1_alt01 : coverpoint ev.ex_gr.aluin1_out
	{
		bins aluin1_alt01 = {16'b0101010101010101} ;
		bins aluin1_alt10 = {16'b1010101010101010} ;
		bins others = default;
	}
	Cov_aluin2_alt01 : coverpoint ev.ex_gr.aluin2_out
	{
		bins aluin2_alt01 = {16'b0101010101010101} ;
		bins aluin2_alt10 = {16'b1010101010101010} ;
		bins others = default;
	}
	Xc_Cov_opr_alt01_alt10 : cross Cov_alu_opcode,Cov_aluin1_alt01,Cov_aluin2_alt01 iff(ev.de_gr.Instr_dout[15:12] != NOT);
	Cov_aluin1_pos_neg : coverpoint ev.ex_gr.aluin1_out[15]
	{
		bins aluin1_pos = {1'b0} ;
		bins aluin1_neg = {1'b1} ;
	}
	Cov_aluin2_pos_neg : coverpoint ev.ex_gr.aluin2_out[15]
	{
		bins aluin2_pos = {1'b0} ;
		bins aluin2_neg = {1'b1} ;
	}
	Xc_Cov_opr_pos_neg : cross Cov_alu_opcode_AND_ADD,Cov_aluin1_pos_neg,Cov_aluin2_pos_neg;		 //iff(ev.de_gr.Instr_dout[15:12] != NOT);
endgroup

covergroup CTRL_OPR_cg @(posedge clock);

	Cov_ctrl_opcode : coverpoint ev.de_gr.Instr_dout[15:12]
	{
		bins BR_b  = {BR};
		bins JMP_b = {JMP};
	}
	Cov_BaseR : coverpoint ev.de_gr.Instr_dout[8:6] iff(ev.de_gr.Instr_dout[15:12] == JMP)
	{
		bins BaseR_JMP[] = {[0:7]};
	}
	Cov_NZP : coverpoint ev.ex_gr.NZP iff(ev.de_gr.Instr_dout[15:12] == JMP)
	{
		bins NZP_JMP = {7};
	}
	Cov_PSR : coverpoint ev.wb_gr.psr iff(ev.de_gr.Instr_dout[15:12] == JMP)
	{
		bins psr_JMP_1 = {1};
		bins psr_JMP_2 = {2};
		bins psr_JMP_4 = {4};
	}
	Cov_PCoffset9 : coverpoint ev.de_gr.Instr_dout[8:0] iff(ev.de_gr.Instr_dout[15:12] == BR)
	{
		option.auto_bin_max = 8 ;
	}
	Cov_PCoffset9_c : coverpoint ev.de_gr.Instr_dout[8:0] iff(ev.de_gr.Instr_dout[15:12] == BR)
	{
		bins pcoffset9_corner_low   = {9'h000} ;
		bins pcoffset9_corner_high  = {9'h1FF} ;
	}
	Xc_NZP_PSR : cross Cov_NZP,Cov_PSR;
endgroup

covergroup OPR_SEQ_cg @(posedge clock);
	Cov_opcode_order : coverpoint ev.de_gr.Instr_dout[15:12]
	{
		bins ALU_Memory = (AND, ADD, NOT => LD, LDR, LDI, LEA, ST, STR, STI);
		//bins Control_Memory = (BR, JMP => LD, LDR, LDI, LEA, ST, STR, STI);
		bins Memory_Control = (LD, LDR, LDI, LEA, ST, STR, STI => AND, ADD, NOT );
		bins Memory_ALU = (LD, LDR, LDI, LEA, ST, STR, STI => AND, ADD, NOT );
	}
	Cov_mem_opcode_temp : coverpoint ev.de_gr.Instr_dout[15:12]
	{
		bins LD_b  = {LD };
		bins LDR_b = {LDR};
		bins LDI_b = {LDI};
		bins LEA_b = {LEA};
		bins ST_b  = {ST };
		bins STR_b = {STR};
		bins STI_b = {STI};
	}
	Cov_alu_opcode_temp : coverpoint ev.de_gr.Instr_dout[15:12]
	{
		bins ADD_b = {ADD};
		bins AND_b = {AND};
		bins NOT_b = {NOT};
	}
	Cov_ctrl_opcode_temp : coverpoint ev.de_gr.Instr_dout[15:12]
	{
		bins BR_b  = {BR};
		bins JMP_b = {JMP};
	}
	//Xc_cov_inst : cross Cov_mem_opcode_temp,Cov_alu_opcode_temp,Cov_ctrl_opcode_temp;
endgroup
