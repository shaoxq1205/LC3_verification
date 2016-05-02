`define pc_chk\
		if(pc!== prob_ft.fetch_pc)\
			$display($time,"BUG IN FETCH DUT pc_DUT = %h |  pc = %h \n\t\t enable_Fetch=%x | enable_updatePC=%x | br_taken=%x | taddr =%x ",prob_ft.fetch_pc,pc, enable_Fetch, enable_updatePC, br_taken, taddr);
`define npc_chk\
		if(npc!== prob_ft.fetch_npc_out)\
			$display($time,"BUG IN FETCH DUT npc_DUT = %h | npc = %h\n\t\t enable_Fetch=%x | enable_updatePC=%x | br_taken=%x | taddr =%x ",prob_ft.fetch_npc_out,npc, enable_Fetch, enable_updatePC, br_taken, taddr);

class fetch_gr;

   //inputs
   logic br_taken;
   logic [15:0]taddr;
   logic enable_updatePC;
   logic enable_Fetch;

   //outputs
   logic instrmem_rd;
   logic [15:0]pc;
   logic [15:0]npc;

   //print flag
   bit fetch_print_flag;

   virtual LC3_io.TB intf; 
   virtual dut_Probe_fetch prob_ft;

  function new(virtual LC3_io.TB intf,virtual dut_Probe_fetch prob_ft);
    this.intf = intf;
    this.prob_ft = prob_ft;
  endfunction

  task golden_ref();

    fork
       begin
          forever
             begin
                @(posedge intf.clock);
          `pc_chk
          `npc_chk
                if(intf.reset)
                   begin
                      pc = 16'h3000;
                      npc = pc + 1;
                instrmem_rd = 1'b1;
                   end
                else
                   begin
                      if(enable_updatePC)
                         begin
                            if(br_taken)
          begin
                               pc = taddr;
          end
                            else
              begin
                               pc = npc;
          end
          npc = pc + 1;
                         end
                   end
             end
       end
       begin
          forever
             begin
      #0.001;
            case(enable_Fetch)
                   1'b0 : instrmem_rd = 1'b0;
                   1'b1 : instrmem_rd = 1'b1;
                  // default : instrmem_rd = 1'bz;
      endcase
             end
       end
       begin
    forever@(posedge intf.clock)
    begin
      check_fetch();    //For asynchronous signal instrmem_rd
    end
       end
       begin
    forever@(posedge intf.clock)
    begin
      if(fetch_print_flag == 1)
        print_fetch();    //For Displaying all signals
    end
       end 
    join
  endtask

  task check_fetch();
      @(posedge intf.clock)
      if(instrmem_rd !== prob_ft.fetch_instrmem_rd)
        $display($time,"BUG IN FETCH DUT instrmem_rd_DUT = %h | instrmem_rd = %h\n\t\t enable_Fetch=%x | enable_updatePC=%x | br_taken=%x | taddr =%x ",prob_ft.fetch_instrmem_rd,instrmem_rd, enable_Fetch, enable_updatePC, br_taken, taddr);
  endtask


  task print_fetch();
        $display($time,"=======================FETCH========================");
        $display($time,"=======================Inputs=======================");
        $display($time,"  enable_Fetch = %b",enable_Fetch);
        $display($time,"  enable_updatePC = %b",enable_updatePC);
        $display($time,"  br_taken = %b",br_taken);
        $display($time,"  taddr = %h",taddr);
        $display($time,"=======================Outputs======================");
        $display($time,"  pc = %h",pc);
        $display($time,"  npc = %h",npc);
        $display($time,"  instrmem_rd = %b",instrmem_rd);
        $display($time,"====================================================");
  endtask


endclass

