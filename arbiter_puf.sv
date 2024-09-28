// File Name   : arbiter_puf.sv
// Function    : Top-level module for Arbiter PUF that integrates all the blocks and generates a 64-bit response
// Author:  Venkata Banda

`timescale 1ns/1ps


module arbiter_puf #(parameter challenge_size = 8, response_width = 24)
					(input logic [challenge_size-1 : 0] challenge,
					input logic clk, reset,
					output logic [response_width-1 : 0] response);

logic [challenge_size-1 : 0] out_lfsr;
//logic [31:0] out_muxchain;
logic [31:0] out_muxchain;
logic temp_out_mux1, temp_out_mux2;
logic out_mux1, out_mux2, en;
logic [7:0] count;
//wire [7:0] temp_out_cntr1, temp_out_cntr2;
//wire [7:0] out_cntr1, out_cntr2;
//wire [7:0] temp_out_cntr1[response_width-1 : 0], temp_out_cntr2[response_width-1 : 0];
//wire [7:0] out_cntr1[response_width-1 : 0], out_cntr2[response_width-1 : 0];
//wire [response_width-1 : 0] ab;
logic temp_comp;
//wire [response_width-1 : 0] out_cmp;
//wire out_cmp;
logic [response_width-1 : 0] temp_response;
//logic [response_width-1 : 0] next_resp;
//wire [response_width-1 : 0] temp_response [response_width-1 : 0];

lfsr #(challenge_size) lfsr1(.clk(clk), .en_lfsr(en), .reset(reset), .in_lfsr(challenge), .out_lfsr(out_lfsr));

chain c0 (.in(en), .clk(clk), .reset(reset), .challenge(out_lfsr), .out_chain(out_muxchain[7:0]));

chain c1 (.in(en), .clk(clk), .reset(reset), .challenge(out_lfsr), .out_chain(out_muxchain[15:8]));

//mux8_1 m3(.in1(out_muxchain[0]), .in2(out_muxchain[1]), .in3(out_muxchain[2]), .in4(out_muxchain[3]), .in5(out_muxchain[4]), .in6(out_muxchain[5]), .in7(out_muxchain[6]), .in8(out_muxchain[7]), 
mux16_1 m3(.in0(out_muxchain[0]), .in1(out_muxchain[1]), .in2(out_muxchain[2]), .in3(out_muxchain[3]), .in4(out_muxchain[4]), .in5(out_muxchain[5]), .in6(out_muxchain[6]), .in7(out_muxchain[7]), .in8(out_muxchain[8]), .in9(out_muxchain[9]), .in10(out_muxchain[10]), .in11(out_muxchain[11]), .in12(out_muxchain[12]), .in13(out_muxchain[13]), .in14(out_muxchain[14]), .in15(out_muxchain[15]), .se(out_lfsr[3:0]), .out(temp_out_mux1)); 
//mux16_1 m4(.in0(out_muxchain[0]), .in1(out_muxchain[1]), .in2(out_muxchain[2]), .in3(out_muxchain[3]), .in4(out_muxchain[4]), .in5(out_muxchain[5]), .in6(out_muxchain[6]), .in7(out_muxchain[7]), .in8(out_muxchain[8]), .in9(out_muxchain[9]), .in10(out_muxchain[10]), .in11(out_muxchain[11]), .in12(out_muxchain[12]), .in13(out_muxchain[13]), .in14(out_muxchain[14]), .in15(out_muxchain[15]), .se(out_lfsr[7:4]), .out(temp_out_mux2)); 

mux16_1 m4(.in0(out_muxchain[16]), .in1(out_muxchain[17]), .in2(out_muxchain[18]), .in3(out_muxchain[19]), .in4(out_muxchain[20]), .in5(out_muxchain[21]), .in6(out_muxchain[22]), .in7(out_muxchain[23]), .in8(out_muxchain[24]), .in9(out_muxchain[25]), .in10(out_muxchain[26]), .in11(out_muxchain[27]), .in12(out_muxchain[28]), .in13(out_muxchain[29]), .in14(out_muxchain[30]), .in15(out_muxchain[31]), .se(out_lfsr[7:4]), .out(temp_out_mux2));

assign  out_mux1 = temp_out_mux1;
assign  out_mux2 = temp_out_mux2;

always_ff@(posedge clk, negedge reset)
begin:SEQ
	if(~reset)
	begin
		count <= '0;
		temp_response <= '0;
		temp_comp <= '0;
		response <= '0;
		en <= 0;
	end
	else
	begin
		if(count < response_width)
		begin
			if(out_mux1 > out_mux2)
			begin
				temp_comp <= 1;
			end
			else
			begin
				temp_comp <= 0;
			end
			temp_response <= {temp_comp, temp_response[response_width-1 : 1]};
			//temp_response <= next_resp;
			
			count <= count + 1;
			en <= 1;
		end
		else if (count == response_width)
		begin
			en <= 0;
			//response <= temp_response[response_width-1];
			response <= temp_response;
			count <= '0;
		end
	end
end

endmodule


/*
genvar i;
generate
	for(i = 0; i<response_width; i = i+1)
	begin:GEN
		counter cntr0(.clk(clk), .reset(reset), .en(en), .inc(out_mux1), .out_counter(out_cntr1[i]));
		counter cntr1(.clk(clk), .reset(reset), .en(en), .inc(out_mux2), .out_counter(out_cntr2[i]));
		
		//assign #5ns out_cntr1 = temp_out_cntr1;
		//assign #20ns out_cntr2 = temp_out_cntr2;
		/*for(genvar k = 0; k < 1; k = k+1)
		begin:CMP
			comparator cmp(.in1(out_cntr1), .in2(out_cntr2), .en_comp(en), .out_comp(temp_comp[i]));
		end
		
		comparator cmp(.in1(out_cntr1[i]), .in2(out_cntr2[i]), .en_comp(en), .out_comp(ab[i]));
		assign temp_comp[i] = ab[i];
		shiftreg sr(.clk(clk), .reset(reset), .in(temp_comp[i]), .out_shift(temp_response));
	end
endgenerate*/

/*
always_ff@(posedge clk, negedge reset)
begin
	if(~reset)
	begin
		temp_response <= '0;
	end
	else
	begin
		for(int j = 0; j < response_width; j = j+1)
		begin:Resp_GEN
			//temp_comp[j] <= ab[j][0];
			temp_response[j] <= temp_comp[j];
		end
	end
end*/

//shiftreg sr(.clk(clk), .reset(reset), .in(temp_comp[j]), .out_shift(temp_response));

//comparator cmp(.in1(out_cntr1), .in2(out_cntr2), .en_comp(en), .out_comp(temp_comp));
//shiftreg sr(.clk(clk), .reset(reset), .in(out_cmp), .out_shift(temp_response));
//assign #5ns out_cntr1 = temp_out_cntr1;
//assign #20ns out_cntr2 = temp_out_cntr2;
//comparator cmp(.in1(out_cntr1), .in2(out_cntr2), .en_comp(en), .out_comp(out_cmp));