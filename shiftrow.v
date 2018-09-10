module shiftrow(in , out );
	input [127:0]in;
	output [127:0]out;


/*	A00 A01 A02 A03			A00 A01 A02 A03
	A10 A11 A12 A13	    shiftrow	A13 A10 A12 A13
	A20 A21 A22 A23   ------------> A22 A23 A20 A21
	A30 A31 A32 A33 		A33 A30 A31 A32
futher assign the column of second matrix to out wire of the module */


assign out = {in[127:120],in[87:80],in[47:40],in[7:0],in[95:88],
	      in[55:48],in[15:8],in[103:96],in[63:56],in[23:16],
	      in[111:104],in[71:64],in[31:24],in[119:112],in[79:72],
	      in[39:32]};   
endmodule 