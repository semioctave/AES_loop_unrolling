module keyexpansion(oldkey,round,newkey);
input [127:0] oldkey;
input [4:0]round;
output [127:0] newkey;

genvar i;
wire [31:0]sbin,t1;
reg [31:0] t2;
wire [31:0]w4;
assign w4 = oldkey[31:0];

for(i=0;i<=3;i=i+1)begin 

   sbox sb(w4[((i*8)+7):(i*8)],sbin[((i*8)+7):(i*8)]);

 end
  assign t1 = {sbin[23:0],sbin[31:24]};
 always @ *
 begin
   case(round)
   4'd1 : assign t2 = t1 ^ (32'h01000000);
   4'd2 : assign t2 = t1 ^ (32'h02000000);
   4'd3 : assign t2 = t1 ^ (32'h04000000);
   4'd4 : assign t2 = t1 ^ (32'h08000000);
   4'd5 : assign t2 = t1 ^ (32'h10000000);
   4'd6 : assign t2 = t1 ^ (32'h20000000);
   4'd7 : assign t2 = t1 ^ (32'h40000000);
   4'd8 : assign t2 = t1 ^ (32'h80000000);
   4'd9 :  assign t2 = t1 ^ (32'h1b000000);
   4'd10 : assign t2 = t1 ^ (32'h36000000);
   endcase
end
    
assign newkey[127:96] = t2^oldkey[127:96];
assign newkey[95:64] = newkey[127:96] ^oldkey[95:64];
assign newkey[63:32] = newkey[95:64] ^ oldkey[63:32];
assign newkey[31:0] = newkey[63:32] ^ oldkey[31:0];


endmodule
