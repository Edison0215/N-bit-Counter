// Code your design here
//combinational logic
module counter
  #(parameter COUNTER_WIDTH = 4) //can further change for n-bit counter
  (clk, rst, act, updown, count, overflow);
  
  //define states
  localparam IDLE = 4'b0001;
  localparam COUNT_UP = 4'b0010;
  localparam COUNT_DOWN = 4'b0100;
  localparam OVERFLOW = 4'b1000;
  
  //define input and output
  input clk;
  input rst;
  input act;
  input updown;
  
  output reg [COUNTER_WIDTH-1:0] count;
  output reg overflow;
  
  reg [3:0] state;
  reg [3:0] next_state;
  reg count_en;
  reg [COUNTER_WIDTH-1:0]next_count;
  
  //Sequential logic of state
  always @(posedge clk or negedge rst)
    if(!rst)
      state <= IDLE;
  	else
      state <= next_state;
  
  //Combinational logic of state
  always @(*)
    case(state)
      IDLE: begin
        if(act)
          if(updown)
            next_state = COUNT_UP;
          else
            next_state = COUNT_DOWN;
        else
          next_state = IDLE;
      end
      
      COUNT_UP: begin
        if(act)
          if (updown)
            if(count == (1<<COUNTER_WIDTH)-1)
              next_state = OVERFLOW;
        	else
              next_state = COUNT_UP;
          else
            if(count == 'b0)
              next_state = OVERFLOW;
        	else
              next_state = COUNT_DOWN;
        else
          next_state = IDLE;
      end

      COUNT_DOWN: begin
        if(act)
          if (updown)
            if(count == (1<<COUNTER_WIDTH)-1)
              next_state = OVERFLOW;
        	else
              next_state = COUNT_UP;
          else
            if(count == 'b0)
              next_state = OVERFLOW;
        	else
              next_state = COUNT_DOWN;
        else
          next_state = IDLE;
      end
      
      OVERFLOW: begin
        next_state = OVERFLOW;
      end
      
      default: begin
        next_state = 'bx;
      end
      
    endcase
  
  //Sequential logic of counter
  always @(posedge clk or negedge rst)
    if(!rst)
      count <= 'b0;
  	else if (count_en)
	  count <= next_count;
  
  //Combinational logic of counter
  always @(*)
    begin
      next_count = count;
      if (state == COUNT_UP)
        next_count = count + 1'b1;
      else if (state == COUNT_DOWN)
        next_count = count - 1'b1;
    end
  
  assign overflow = (state == OVERFLOW) ? 1'b1 : 1'b0;
  assign count_en = (state == COUNT_UP) | (state == COUNT_DOWN);
endmodule
    
    

  
  
