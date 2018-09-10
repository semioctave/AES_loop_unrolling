/*	|a1|  |2 3 1 1|   |b1|
	|a2|  |1 2 3 1|   |b2|
	|a3| .|1 1 2 3| = |b3|  
	|a4|  |3 1 1 2|   |b4|

Mixcolumn implemented using above matrix operation in GF(2^8)
*/ 


module Mixcolumn(data_in , out1);
	input [127:0]data_in;
	output [127:0]out1;

	function [31:0]galois_mix;
	
		input [31:0]in;
		reg [7:0]w1,w2,w3,w4,w5,w6,w7,w8;
	begin
		
		begin
			assign w1[7:0] = in[7:0];
 			assign w2[7:0] = in[15:8];
 			assign w3[7:0] = in[23:16];
 			assign w4[7:0] = in[31:24];
 		end
		 begin
 			 w5 = gmultiply2(w1)^gmultiply3(w2)^w3^w4;
 			 w6 = w1^gmultiply2(w2)^gmultiply3(w3)^w4;
 			 w7 = w1^w2^gmultiply2(w3)^gmultiply3(w4);
 			 w8 = gmultiply3(w1)^w2^w3^gmultiply2(w4);
 			 galois_mix = {w8,w7,w6,w5};
		end
	 end
	endfunction
	
	function [7:0]gmultiply2; // Galois Multiplication with 2
	  input [7:0] i1;
	 begin
	  if(!i1[7]) gmultiply2 = i1<<1;
	  else  gmultiply2 = (i1<<1)^8'h1b; // if MSB is 1 then left shift by 1 and XOR with 8'b00011011
	 end
	 endfunction
 
	 function [7:0]gmultiply3;
	  input [7:0] inp1;
	 begin
	   gmultiply3 = inp1^gmultiply2(inp1); // 3.inp = (2+1).inp = (2.inp)^inp 
	 end
	 endfunction

	assign out1[127:96] = galois_mix(data_in[127:96]);
  	assign out1[95:64] = galois_mix(data_in[95:64]);
  	assign out1[63:32] = galois_mix(data_in[63:32]);
  	assign out1[31:0] = galois_mix(data_in[31:0]);

endmodule  
