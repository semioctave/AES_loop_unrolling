`timescale 1ns/1ns
module aes_tb();

	reg [127:0]in;
	wire [127:0]out;

	
	initial begin
		in = 128'h0123456789abcdef0123456789abcdef;
		#20 in = 128'hfedcba9876543210fedcba9876543210;	
	end 
	Loop_unrolling_aes MUT(in,out);
endmodule 	  
