module register2 (load, d, value,reset);
input load;
input [7:0] d;
input reset;
output reg [7:0] value;

always @ (d or load or reset)
begin
if(reset)
value = 8'b00000000;
else
if(load) value = d;
end

endmodule
