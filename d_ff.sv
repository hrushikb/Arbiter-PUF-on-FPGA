// File Name   : d_ff.sv
// Function    : D flipflop
// Author:  Venkata Banda

module d_ff (input logic d, clk, reset,
			output logic q);
always_ff@(posedge clk, negedge reset)
begin
	if(~reset)
	begin
		q <= 0;
	end
	else
	begin
		q <= d;
	end
end
endmodule