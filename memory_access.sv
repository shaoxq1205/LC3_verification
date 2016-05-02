class mem_access_gr;

   //inputs
   logic [1:0] 	mem_state;
   logic 	M_Control;
   logic [15:0] M_Data;
   logic [15:0] M_addr;
   logic [15:0] Data_dout;

   //outputs
   logic [15:0] Data_addr;
   logic [15:0] Data_din;
   logic 	Data_rd;
   logic [15:0] memout;

   //print flag
   bit mem_access_print_flag;

   virtual LC3_io.TB intf;
   virtual dut_Probe_mem_access prob_ma;

   function new(virtual LC3_io.TB intf,virtual dut_Probe_mem_access prob_ma);
      this.intf = intf;
      this.prob_ma = prob_ma;
   endfunction

   task golden_ref();
      fork
            forever
            begin
          #0.001;
              // case(mem_state[1:0])
                 if(mem_state[1:0] == 2'b00)
                     begin
                        Data_rd = 1'b1;
                        if(M_Control)
                           Data_addr = Data_dout;
                        else
                           Data_addr = M_addr;
                        Data_din = 16'b0;
                        memout = Data_dout;
                     end
                 else if(mem_state[1:0] == 2'b01)
                     begin
                        Data_rd = 1'b1;
                        Data_addr = M_addr;
                        Data_din = 16'b0;
                        memout = Data_dout;
                     end
                 else if(mem_state[1:0] == 2'b10)
                     begin
                        Data_rd = 1'b0;
                        if(M_Control)
                           Data_addr= Data_dout;
                        else
                           Data_addr = M_addr;
                        Data_din = M_Data;
                        memout = Data_dout; 
                     end
                 else if(mem_state[1:0] == 2'b11)
                     begin
                        Data_rd = 1'bz;
                        Data_addr = 16'hzzzz;
                        Data_din = 16'hzzzz;
                        memout = Data_dout; 
                     end
         //default:
                 else 
                     begin
                        Data_rd = 1'bz;
                        Data_addr = 16'hzzzz;
                        Data_din = 16'hzzzz;
                        memout = Data_dout;
                     end
             //   endcase
            end
      forever
      begin
         @(posedge intf.clock);
            check_mem_access();
      end
      forever@(posedge intf.clock)
      begin
         if(mem_access_print_flag == 1)
            print_mem_access();
      end
      join
   endtask

   task check_mem_access();
      #0.001;
      if(Data_addr !== prob_ma.Data_addr)
               $display($time,"BUG IN MEMORY ACCESS DUT Data_addr_DUT = %h | Data_addr = %h \n\t\t mem_state=%x | M_Control=%x  | M_Data=%x | M_addr=%x | Data_dout=%x ",prob_ma.Data_addr,Data_addr, mem_state, M_Control, M_Data, M_addr, Data_dout);
      if(Data_din !== prob_ma.Data_din)
               $display($time,"BUG IN MEMORY ACCESS DUT Data_din_DUT = %h | Data_din = %h\n\t\t mem_state=%x | M_Control=%x  | M_Data=%x | M_addr=%x | Data_dout=%x",prob_ma.Data_din,Data_din, mem_state, M_Control, M_Data, M_addr, Data_dout);
      if(Data_rd !== prob_ma.Data_rd)
               $display($time,"BUG IN MEMORY ACCESS DUT Data_rd_DUT = %h | Data_rd = %h\n\t\t mem_state=%x | M_Control=%x  | M_Data=%x | M_addr=%x | Data_dout=%x",prob_ma.Data_rd,Data_rd, mem_state, M_Control, M_Data, M_addr, Data_dout);
      if(memout !== prob_ma.memout)
               $display($time,"BUG IN MEMORY ACCESS DUT memout_DUT = %h | memout = %h\n\t\t mem_state=%x | M_Control=%x  | M_Data=%x | M_addr=%x | Data_dout=%x",prob_ma.memout,memout, mem_state, M_Control, M_Data, M_addr, Data_dout);
   endtask

   task print_mem_access();
         $display($time,"====================MEMORY ACCESS====================");
         $display($time,"=======================Inputs========================");
         $display($time,"  mem_state = %h",mem_state);
         $display($time,"  M_Control = %h",M_Control);
         $display($time,"  M_Data = %h",M_Data);
         $display($time,"  M_addr = %h",M_addr);
         $display($time,"  Data_dout = %h",Data_dout);
         $display($time,"=======================Outputs=======================");
         $display($time,"  Data_addr = %h",Data_addr);
         $display($time,"  Data_din = %h",Data_din);
         $display($time,"  Data_rd = %h",Data_rd);
         $display($time,"  memout = %h",memout);
         $display($time,"=====================================================");

   endtask
 
endclass



