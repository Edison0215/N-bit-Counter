// Code your testbench here
// or browse Examples
module tb;
  parameter WIDTH = 4;
  
  //define input and output
  reg clk;
  reg rst;
  reg act;
  reg updown;
  
  wire [WIDTH-1:0]count;
  wire overflow;
  
  //instantiate DUT module
  counter #(WIDTH) DUT(.clk(clk), .rst(rst), .act(act), .updown(updown), .count(count), .overflow(overflow)); 

  initial begin
    $dumpfile("tb.vcd");  // Name of the VCD file to be generated
    $dumpvars(0, tb);     // Dump all variables starting at time 0
  end
  
  initial begin
    clk = 1'b0;
    rst = 1'b0; //turn on reset
    act = 1'b0;
    updown = 1'b0;
     
  end
  
  //define clock
  always
    #5 clk = ~clk;
  
  initial begin
    #50 act = 1'b1;
    rst = 1'b1;
    updown = 1'b1;
    #300 rst = 1'b0;
    #100 rst = 1'b1;
    updown = 1'b1;
    #100 updown = 1'b0;
    #300 $finish;
  end
  
endmodule
