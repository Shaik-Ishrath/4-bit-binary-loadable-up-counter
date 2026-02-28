module binary_up_counter_tb();
  reg [3:0] data_in;
  reg load,clk,reset;
  wire [3:0] count;
  parameter CYCLE = 10;
  binary_up_counter DUT(data_in,
                        load,
                        clk,
                        reset,
                        count);
  always
    begin
      #(CYCLE/2);
      clk = 1'b0;
      #(CYCLE/2);
      clk = 1'b1;
    end

  task reset_t;
    begin
      @(negedge clk);
      reset = 1'b0;
      @(negedge clk);
      reset = 1'b1;
    end
  endtask

  task load_t(input 1, input [3:0]d);
    begin
      @(negedge clk);
      load = 1;
      data_in = d;
    end
  endtask

  initial 
    begin
      reset_t;
      #100;
      load_t(1'b1,4'd13);
      load_t(1'b0,4'd13);
      #200;
      $finish;
    end
endmodule
