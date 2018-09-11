module Loop_unrolling_aes (a,cipher);
	input [127:0]a; // input data to be encrypted
	output [127:0]cipher; // Encrypted data produced by the Block 
	parameter key = 128'h0123456789abcdef0123456789abcdef; // initial key used 	
	wire [127:0]w1[1:11],w2[1:10],w3[1:10],w4[1:10],w5[0:10];
	genvar i;
	begin
		assign w5[0] = key;
		assign w1[1] = a^w5[1]; // key addition
		keyexpansion	ke(w5[0],1,w5[1]);// generation of key for 1st round
			
		for ( i=1 ; i < 10 ; i=i+1 )
		begin	
			sub_Byte	sb(w1[i],w2[i]);
			shiftrow	sr(w2[i],w3[i]);
			Mixcolumn	mc(w3[i],w4[i]);
			keyexpansion	ke(w5[i],i,w5[i+1]);
			Addroundkey	ar(w4[i],w5[i],w1[i+1]);	
		end
	
		begin
			sub_Byte	sb(w1[10],w2[10]);
			shiftrow	sr(w2[10],w3[10]);
			Addroundkey	ar(w3[10],w5[10],w1[11]);	
		end
	end 

	assign cipher = w1[11];
	
endmodule 

