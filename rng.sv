// File Name   : rng.sv
// Function    : Module for random bitstream generation to serve as input for LUTs
// Author:  Venkata Banda

module rng (input logic clk, reset,
				output logic [1023:0] out);

logic [1023:0] temp;

always_ff @(posedge clk, negedge reset)
begin
	if (~reset)
	begin
		temp <= '1;
	end
	else
	begin
		temp <= temp ^ (temp >> 10) ^ (temp >> 50) ^ (temp >> 180) ^ (temp >> 512) ^ (temp >> 895);
	end
end

assign out = temp;

endmodule