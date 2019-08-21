module BCDtoGrayGate (b,g);
	output [3:0]g;
	input [3:0]b;
	
	assign g[3] = b[3];
	or o1(g[2], b[3], b[2]);
	xor o2(g[1], b[2], b[1]);
	xor o3(g[0], b[1], b[0]);
endmodule

module BCDtoGrayDF (b,g);
	output [3:0]g;
	input [3:0]b;
	
	assign g[3] = b[3];
	assign g[2] = b[3] + b[2];
	assign g[1] = b[2] ^b[1];
	assign g[0] = b[1] ^b[0];
endmodule