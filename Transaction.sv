
class transaction;

	rand bit [3:0] opcode;
	rand bit [2:0] dr;
	rand bit [2:0] sr1;
	rand bit imm_sr_mode;
	rand bit [2:0] sr2;
	rand bit [4:0] imm5;
	rand bit [8:0] PCoffset9;
	rand bit [2:0] BaseR;
	rand bit [5:0] PCoffset6;
	rand bit [2:0] nzp;
	rand bit [2:0] PSR;
	rand bit complete_instr;
	rand bit complete_data;
	rand bit [15:0] Data_dout;

	bit  [15:0] IR;
	bit  [2:0] NZP;
	bit  [2:0] psr;
	bit  [15:0] IR_Exec;
	bit  [15:0] Instr_dout;
	bit [15:0] prev_IR;
	bit [15:0] prev_Instr_dout;

	static int cnt=5;
	int fs;

	constraint instruction{ if((cnt <= 0) && (fs)) opcode inside {4'b0001,4'b0101,4'b1001,4'b0010,4'b0110,4'b1010,4'b1110,4'b0011,4'b0111,4'b1011,4'b0000,4'b1100};
				else opcode inside {4'b0001,4'b0101,4'b1001};}//4'b1110};}
	constraint data_instr {complete_data == 1;complete_instr == 1;}
	constraint nz {nzp inside {3'b001,3'b010,3'b011,3'b100,3'b101,3'b110};}


	
	
	function void post_randomize();
	fs = 1;
	if((opcode != 4'b0001) && (opcode != 4'b0101) && (opcode != 4'b1001)) //&& (opcode != 4'b1110))
		cnt = 5;
	else
		cnt--;
		case(opcode)
			4'b0001: 								// ADD
				begin
					if(imm_sr_mode)
						Instr_dout = {opcode,dr,sr1,1'b1,imm5};
					else
						Instr_dout = {opcode,dr,sr1,1'b0,1'b0,1'b0,sr2};
				end
			4'b0101:								// AND
				begin
					if(imm_sr_mode)
						Instr_dout = {opcode,dr,sr1,1'b1,imm5};
					else
						Instr_dout = {opcode,dr,sr1,1'b0,1'b0,1'b0,sr2};
				end
			4'b1001:  Instr_dout = {opcode,dr,sr1,1'b1,1'b1,1'b1,1'b1,1'b1,1'b1};			// NOT
			4'b0010:  Instr_dout = {opcode,dr,PCoffset9};						// LD
			4'b0110:  Instr_dout = {opcode,dr,BaseR,PCoffset6};					// LDR
			4'b1010:  Instr_dout = {opcode,dr,PCoffset9};						// LDI
			4'b1110:  Instr_dout = {opcode,dr,PCoffset9};						// LEA
			4'b0011:  Instr_dout = {opcode,sr1,PCoffset9};						// ST
			4'b0111:  Instr_dout = {opcode,sr1,BaseR,PCoffset6};					// STR
			4'b1011:  Instr_dout = {opcode,sr1,PCoffset9};						// STI
			4'b0000:  Instr_dout = {opcode,nzp,PCoffset9};						// BR
			4'b1100:  Instr_dout = {opcode,1'b1,1'b1,1'b1,BaseR,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0};	// JMP
		endcase

		NZP = nzp;
		psr = PSR;
		IR = prev_Instr_dout;
		IR_Exec = prev_IR;

		this.prev_Instr_dout = this.Instr_dout;
		this.prev_IR = this.IR;
	endfunction

endclass
