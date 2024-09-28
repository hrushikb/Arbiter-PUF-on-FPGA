// File Name   : lfsr.sv
// Function    : LFSR to generate pseudo random input sequences to be passed onto the puf stages
// Author:  Venkata Banda

module lfsr #(parameter size = 8) (input logic clk, en_lfsr, reset,
									input logic [size-1 : 0] in_lfsr,
									output logic [size-1 : 0] out_lfsr);

logic shift;
always_ff@(posedge clk, negedge reset)
begin
	if(~reset)
	begin
		out_lfsr <= '0;
	end
	else
	begin
		if (en_lfsr)
		begin
			shift <= out_lfsr[7] ^ out_lfsr[6] ^ out_lfsr[5] ^ out_lfsr[0];
			out_lfsr <= {shift, out_lfsr[size-2:0]};
		end
		else
		begin
			out_lfsr <= in_lfsr;
		end
	end
end
endmodule