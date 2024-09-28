// File Name   : lut.sv
// Function    : Lookuptable values calculation
// Author:  Venkata Banda

module lut(input logic [63:0] in,
			input logic se1, se2, se3, se4, se5, se6,
			output logic out);

logic out1stage, out2stage, out3stage, out4stage, out5stage;
logic out5_1, out5_2, out5_3, out5_4;
logic out5_5, out5_6, out5_7, out5_8;

// Stage 1: 2-to-1 MUX
mux2_1 m11(.in1(in[0]), .in2(in[1]), .se(se1), .out(out1stage));

// Stage 2: 4-to-1 MUX using 2-to-1 MUXes
logic out2_1;
mux2_1 m21(.in1(in[2]), .in2(in[3]), .se(se1), .out(out2_1));
mux2_1 m22(.in1(out1stage), .in2(out2_1), .se(se2), .out(out2stage));

// Stage 3: Use 2-to-1 MUXes to select from inputs
logic out3_1, out3_2, out3_3;
mux2_1 m31(.in1(in[4]), .in2(in[5]), .se(se1), .out(out3_1));
mux2_1 m32(.in1(in[6]), .in2(in[7]), .se(se1), .out(out3_2));
mux2_1 m33(.in1(out3_1), .in2(out3_2), .se(se2), .out(out3_3));
mux2_1 m34(.in1(out2stage), .in2(out3_3), .se(se3), .out(out3stage));

// Stage 4: 16-to-1 MUX for 8 inputs
mux16_1 m41(.in0(in[8]), .in1(in[9]), .in2(in[10]), .in3(in[11]), .in4(in[12]), .in5(in[13]), .in6(in[14]), .in7(in[15]), .in8(in[16]), .in9(in[17]), .in10(in[18]), .in11(in[19]), .in12(in[20]), .in13(in[21]), .in14(in[22]), .in15(in[23]), .se({se4, se3, se2, se1}), .out(out4stage));

//stage 5
logic out5_9, out5_10, out5_11, out5_12, out5_13, out5_14, out5_15;
mux2_1 m51(.in1(in[16]), .in2(in[17]), .se(se1), .out(out5_1));
mux2_1 m52(.in1(in[18]), .in2(in[19]), .se(se1), .out(out5_2));
mux2_1 m53(.in1(in[20]), .in2(in[21]), .se(se1), .out(out5_3));
mux2_1 m54(.in1(in[22]), .in2(in[23]), .se(se1), .out(out5_4));
mux2_1 m55(.in1(in[24]), .in2(in[25]), .se(se1), .out(out5_5));
mux2_1 m56(.in1(in[26]), .in2(in[27]), .se(se1), .out(out5_6));
mux2_1 m57(.in1(in[28]), .in2(in[29]), .se(se1), .out(out5_7));
mux2_1 m58(.in1(in[30]), .in2(in[31]), .se(se1), .out(out5_8));

mux2_1 m5d(.in1(out5_1), .in2(out5_2), .se(se2), .out(out5_9));
mux2_1 m5e(.in1(out5_3), .in2(out5_4), .se(se2), .out(out5_10));
mux2_1 m5f(.in1(out5_5), .in2(out5_6), .se(se2), .out(out5_11));
mux2_1 m5g(.in1(out5_7), .in2(out5_8), .se(se2), .out(out5_12));

mux2_1 m59(.in1(out5_9), .in2(out5_10), .se(se3), .out(out5_13));
mux2_1 m5a(.in1(out5_11), .in2(out5_12), .se(se3), .out(out5_14));

mux2_1 m5b(.in1(out5_13), .in2(out5_14), .se(se4), .out(out5_15));

mux2_1 m5c(.in1(out4stage), .in2(out5_15), .se(se5), .out(out5stage));

//stage 6
logic out6_1, out6_2, out6_3, out6_4, out6_5, out6_6, out6_7, out6_8, out6_30, out6_31;
logic out6_9, out6_10, out6_11, out6_12, out6_13, out6_14, out6_15, out6_16, out6_17, out6_18, out6_19, out6_20, out6_21, out6_22, out6_23, out6_24, out6_25, out6_26, out6_27, out6_28, out6_29;
mux2_1 m61(.in1(in[32]), .in2(in[33]), .se(se1), .out(out6_1));
mux2_1 m62(.in1(in[34]), .in2(in[35]), .se(se1), .out(out6_2));
mux2_1 m63(.in1(in[36]), .in2(in[37]), .se(se1), .out(out6_3));
mux2_1 m64(.in1(in[38]), .in2(in[39]), .se(se1), .out(out6_4));
mux2_1 m65(.in1(in[40]), .in2(in[41]), .se(se1), .out(out6_5));
mux2_1 m66(.in1(in[42]), .in2(in[43]), .se(se1), .out(out6_6));
mux2_1 m67(.in1(in[44]), .in2(in[45]), .se(se1), .out(out6_7));
mux2_1 m68(.in1(in[46]), .in2(in[47]), .se(se1), .out(out6_8));
mux2_1 m69(.in1(in[48]), .in2(in[49]), .se(se1), .out(out6_9));
mux2_1 m6a(.in1(in[50]), .in2(in[51]), .se(se1), .out(out6_10));
mux2_1 m6b(.in1(in[52]), .in2(in[53]), .se(se1), .out(out6_11));
mux2_1 m6c(.in1(in[54]), .in2(in[55]), .se(se1), .out(out6_12));
mux2_1 m6d(.in1(in[56]), .in2(in[57]), .se(se1), .out(out6_13));
mux2_1 m6e(.in1(in[58]), .in2(in[59]), .se(se1), .out(out6_14));
mux2_1 m6f(.in1(in[60]), .in2(in[61]), .se(se1), .out(out6_15));
mux2_1 m6g(.in1(in[62]), .in2(in[63]), .se(se1), .out(out6_16));

mux2_1 mux61(.in1(out6_1), .in2(out6_2), .se(se2), .out(out6_17));
mux2_1 mux62(.in1(out6_3), .in2(out6_4), .se(se2), .out(out6_18));
mux2_1 mux63(.in1(out6_5), .in2(out6_6), .se(se2), .out(out6_19));
mux2_1 mux64(.in1(out6_7), .in2(out6_8), .se(se2), .out(out6_20));
mux2_1 mux65(.in1(out6_9), .in2(out6_10), .se(se2), .out(out6_21));
mux2_1 mux66(.in1(out6_11), .in2(out6_12), .se(se2), .out(out6_22));
mux2_1 mux67(.in1(out6_13), .in2(out6_14), .se(se2), .out(out6_23));
mux2_1 mux68(.in1(out6_15), .in2(out6_16), .se(se2), .out(out6_24));

mux2_1 mux69(.in1(out6_17), .in2(out6_18), .se(se3), .out(out6_25));
mux2_1 mux6e(.in1(out6_19), .in2(out6_20), .se(se3), .out(out6_26));
mux2_1 mux6f(.in1(out6_21), .in2(out6_22), .se(se3), .out(out6_27));
mux2_1 mux6g(.in1(out6_23), .in2(out6_24), .se(se3), .out(out6_28));

mux2_1 mux6a(.in1(out6_25), .in2(out6_26), .se(se4), .out(out6_29));
mux2_1 mux6b(.in1(out6_27), .in2(out6_28), .se(se4), .out(out6_30));

mux2_1 mux6c(.in1(out6_29), .in2(out6_30), .se(se5), .out(out6_31));

mux2_1 mux6d(.in1(out5stage), .in2(out6_31), .se(se6), .out(out));

endmodule

/*
module lut #(parameter N = 1) (input logic [(2**N)-1 : 0] in_bits,
								input logic [N-1 : 0] se,
								output logic out);

logic [(2**(N-1))-1 : 0] temp;

genvar i;
generate
	if(N == 1)
	begin
		mux2_1 m0(.in1(in_bits[0]), .in2(in_bits[1]), .se(se), .out(out));
	end
	else
	begin
		for(i = 0; i < (2**(N-1)); i = i+1)
		begin:LUT
			lut #(.N(N-1)) lut0(in_bits[(2*i)+1 : 0], se[N-2:0], temp[i]);
		end
		lut #(.N(1)) lut1(temp, se[N-1], out);
	end
endgenerate
endmodule*/
