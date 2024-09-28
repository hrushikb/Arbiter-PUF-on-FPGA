// File Name   : mux2_1.sv
// Function    : 2x1 Multiplexer
// Author:  Venkata Banda

module mux2_1 (input logic in1, in2, se,
				output logic out);

always_comb
begin
	if(se)
	begin
		out = in2;
	end
	else
	begin
		out = in1;
	end
end
endmodule