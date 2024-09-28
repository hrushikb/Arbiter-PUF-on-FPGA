// File Name   : chain.sv
// Function    : Multiplexer chain network
// Author:  Venkata Banda

module chain(input logic [7:0] challenge,
			input logic in, reset, clk,
			output logic [15:0] out_chain);
wire [15:0] temp_chain;

lut_int c1(.in(in), .reset(reset), .clk(clk), .challenge(challenge), .out(temp_chain[0]));
lut_int c2(.in(in), .reset(reset), .clk(clk), .challenge(challenge), .out(temp_chain[1]));
lut_int c3(.in(in), .reset(reset), .clk(clk), .challenge(challenge), .out(temp_chain[2]));
lut_int c4(.in(in), .reset(reset), .clk(clk), .challenge(challenge), .out(temp_chain[3]));
lut_int c5(.in(in), .reset(reset), .clk(clk), .challenge(challenge), .out(temp_chain[4]));
lut_int c6(.in(in), .reset(reset), .clk(clk), .challenge(challenge), .out(temp_chain[5]));
lut_int c7(.in(in), .reset(reset), .clk(clk), .challenge(challenge), .out(temp_chain[6]));
lut_int c8(.in(in), .reset(reset), .clk(clk), .challenge(challenge), .out(temp_chain[7]));
lut_int c9(.in(in), .reset(reset), .clk(clk), .challenge(challenge), .out(temp_chain[8]));
lut_int c10(.in(in), .reset(reset), .clk(clk), .challenge(challenge), .out(temp_chain[9]));
lut_int c11(.in(in), .reset(reset), .clk(clk), .challenge(challenge), .out(temp_chain[10]));
lut_int c12(.in(in), .reset(reset), .clk(clk), .challenge(challenge), .out(temp_chain[11]));
lut_int c13(.in(in), .reset(reset), .clk(clk), .challenge(challenge), .out(temp_chain[12]));
lut_int c14(.in(in), .reset(reset), .clk(clk), .challenge(challenge), .out(temp_chain[13]));
lut_int c15(.in(in), .reset(reset), .clk(clk), .challenge(challenge), .out(temp_chain[14]));
lut_int c16(.in(in), .reset(reset), .clk(clk), .challenge(challenge), .out(temp_chain[15]));

/*
genvar i;
generate
	for(i=0; i < 8; i = i+1)
	begin:CHAIN
		lut_int lut6(.in(in), .reset(reset), .clk(clk), .challenge(challenge), .out(temp_chain[i]));
	end
endgenerate*/

assign out_chain = temp_chain;

endmodule