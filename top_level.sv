// File Name   : top_module.sv
// Function    : Top-level module that incorporates seven hexment display to the arbiter_puf module
// Author:  Venkata Banda

module top_level (input logic clk, reset,
					input logic [7:0] challenge,
					output logic [6:0] segment [5:0]);

logic [23:0] response;

//fastclk fc (.fastclk(fastclk), .clk(clk));

arbiter_puf #(.challenge_size(8), .response_width(24)) puf
			(.clk(clk), .reset(reset), .challenge(challenge), .response(response));

logic [3:0] hex [5:0];

assign hex[0] = response[3:0];
assign hex[1] = response[7:4];
assign hex[2] = response[11:8];
assign hex[3] = response[15:12];
assign hex[4] = response[19:16];
assign hex[5] = response[23:20];
//assign hex[6] = response[27:24];
//assign hex[7] = response[31:28];
//assign hex[8] = response[35:32];
//assign hex[9] = response[39:36];
//assign hex[10] = response[43:40];
//assign hex[11] = response[47:44];
//assign hex[12] = response[51:48];
//assign hex[13] = response[55:52];
//assign hex[14] = response[59:56];
//assign hex[15] = response[63:60];

sevensegdisp disp1(.hex(hex[0]), .segments(segment[0]));
sevensegdisp disp2(.hex(hex[1]), .segments(segment[1]));
sevensegdisp disp3(.hex(hex[2]), .segments(segment[2]));
sevensegdisp disp4(.hex(hex[3]), .segments(segment[3]));
sevensegdisp disp5(.hex(hex[4]), .segments(segment[4]));
sevensegdisp disp6(.hex(hex[5]), .segments(segment[5]));

endmodule
