module tri_state_buffer(c,in,out);

input c;
input [7:0]in;
output [7:0]out;

assign out = c ? in : 'bz;

endmodule
