// File Name   : lut_int.sv
// Function    : Integration of all luts to form a chain
// Author:  Venkata Banda

module lut_int (input logic in, reset, clk,
				input logic [7:0] challenge,
				output logic out);

logic [7:0] top_chain, bottom_chain;

logic [1023:0] mem;

rng rng1(.clk(clk), .reset(reset), .out(mem));

lut lut1(.in(mem[63:0]), .se1(in), .se2(challenge[0]), .se3(1'b0), .se4(1'b0), .se5(1'b0), .se6(1'b0), .out(top_chain[0]));
lut lut2(.in(mem[127:64]), .se1(in), .se2(challenge[1]), .se3(1'b0), .se4(1'b0), .se5(1'b0), .se6(1'b0), .out(top_chain[1]));
lut lut3(.in(mem[191:128]), .se1(in), .se2(challenge[2]), .se3(1'b0), .se4(1'b0), .se5(1'b0), .se6(1'b0), .out(top_chain[2]));
lut lut4(.in(mem[255:192]), .se1(in), .se2(challenge[3]), .se3(1'b0), .se4(1'b0), .se5(1'b0), .se6(1'b0), .out(top_chain[3]));
lut lut5(.in(mem[319:256]), .se1(in), .se2(challenge[4]), .se3(1'b0), .se4(1'b0), .se5(1'b0), .se6(1'b0), .out(top_chain[4]));
lut lut6(.in(mem[383:320]), .se1(in), .se2(challenge[5]), .se3(1'b0), .se4(1'b0), .se5(1'b0), .se6(1'b0), .out(top_chain[5]));
lut lut7(.in(mem[447:384]), .se1(in), .se2(challenge[6]), .se3(1'b0), .se4(1'b0), .se5(1'b0), .se6(1'b0), .out(top_chain[6]));
lut lut8(.in(mem[511:448]), .se1(in), .se2(challenge[7]), .se3(1'b0), .se4(1'b0), .se5(1'b0), .se6(1'b0), .out(top_chain[7]));

lut lut9(.in(mem[575:512]), .se1(in), .se2(challenge[0]), .se3(1'b0), .se4(1'b0), .se5(1'b0), .se6(1'b0), .out(bottom_chain[0]));
lut lut10(.in(mem[639:576]), .se1(in), .se2(challenge[1]), .se3(1'b0), .se4(1'b0), .se5(1'b0), .se6(1'b0), .out(bottom_chain[1]));
lut lut11(.in(mem[703:640]), .se1(in), .se2(challenge[2]), .se3(1'b0), .se4(1'b0), .se5(1'b0), .se6(1'b0), .out(bottom_chain[2]));
lut lut12(.in(mem[767:704]), .se1(in), .se2(challenge[3]), .se3(1'b0), .se4(1'b0), .se5(1'b0), .se6(1'b0), .out(bottom_chain[3]));
lut lut13(.in(mem[831:768]), .se1(in), .se2(challenge[4]), .se3(1'b0), .se4(1'b0), .se5(1'b0), .se6(1'b0), .out(bottom_chain[4]));
lut lut14(.in(mem[895:832]), .se1(in), .se2(challenge[5]), .se3(1'b0), .se4(1'b0), .se5(1'b0), .se6(1'b0), .out(bottom_chain[5]));
lut lut15(.in(mem[959:896]), .se1(in), .se2(challenge[6]), .se3(1'b0), .se4(1'b0), .se5(1'b0), .se6(1'b0), .out(bottom_chain[6]));
lut lut16(.in(mem[1023:960]), .se1(in), .se2(challenge[7]), .se3(1'b0), .se4(1'b0), .se5(1'b0), .se6(1'b0), .out(bottom_chain[7]));

/*
genvar i;
generate
	for(i = 0; i<8; i = i+1)
	begin:LUT
		lut top(.in(mem[i * 64 +: 64]), .se1(in), .se2(challenge[i]),.se3(1'b0), .se4(1'b0), .se5(1'b0), .se6(1'b0), .out(top_chain[i]));
		lut bottom(.in(mem[512 + i * 64 +: 64]), .se1(in), .se2(challenge[i]), .se3(1'b0), .se4(1'b0), .se5(1'b0), .se6(1'b0), .out(bottom_chain[i]));
	end
endgenerate*/

//lut #(.N(9)) lut1(.in_bits(top_bits), .se({challenge, in}), .out(out_lut));

d_ff d0(.d(top_chain[7]), .clk(bottom_chain[7]), .reset(reset), .q(out));
endmodule

/*
module lut_int (input logic in, reset,
				input logic [7:0] challenge,
				output logic out);

logic [511:0]top_bits = 512'hD9A5B3C7D9A5B3C7D9A5B3C7D9A5B3C7D9A5B3C7D9A5B3C7D9A5B3C7D9A5B3C7;
logic [511:0]bottom_bits = 512'h6A5936476A5936476A5936476A5936476A5936476A5936476A5936476A593647;
logic top_chain, bottom_chain;
wire out_lut;

always_comb
begin
	top_chain = top_bits[{challenge, in}];
	bottom_chain = bottom_bits[{challenge, in}];
end

//lut #(.N(9)) lut1(.in_bits(top_bits), .se({challenge, in}), .out(out_lut));

d_ff d0(.d(top_chain), .clk(bottom_chain), .reset(reset), .q(out));
endmodule
*/