module sub_Byte( inps , outs );
	input [127:0]inps;
	output [127:0]outs;
	
	genvar i;

	for( i = 0 ; i< 16 ; i = i+1)
	begin 
		sbox sb(inps[((i*8)+7):(i*8)] , outs[((i*8)+7):(i*8)]); // data of 8 bit is sent to the S-box in iterations
	end 

endmodule
