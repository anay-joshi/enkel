module carry_register (load, d, value,reset);
input load;
input d;
input reset;
output reg value;

always @ (d or load or reset)
begin
if(reset)
value <= 1'b0;
else
if(load) value <= d;
end

endmodule
