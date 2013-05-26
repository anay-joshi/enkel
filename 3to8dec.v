module decoder_plus(sel,res);
  input [2:0] sel;  
  output [7:0] res;  
  reg [7:0] res;  
 
  always @(sel)  
  begin
	
    case (sel)  
       3'b000 : res = 8'b00000001;  
       3'b001 : res = 8'b00000010;
       3'b010 : res = 8'b00000100;  
       3'b011 : res = 8'b00001000;  
       3'b100 : res = 8'b00010000;
       3'b101 : res = 8'b00100000;
       3'b110 : res = 8'b01000000;
       3'b111 : res = 8'b10000000;
       
       default : res = 8'b10000000;  
       
    endcase  
	
  end  
endmodule 
