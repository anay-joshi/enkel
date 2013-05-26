module d_ff(d,clk,q,qbar,reset);
input d;
input clk;
input reset;
output reg q;
output qbar;
assign qbar = ~q;

always @ (negedge clk or posedge reset)
  if (reset)
    q <= 1'b0;
  else
    q <= d; 

endmodule
