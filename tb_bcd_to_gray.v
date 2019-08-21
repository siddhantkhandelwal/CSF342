`include "bcd_to_gray.v"
module testbench;
	reg [3:0]b;
	wire [3:0]g;
	BCDtoGrayDF BCD_test_df (b, g);
	initial
		begin
			$monitor(,$time," b=%4b, g=%4b", g, b);
			#0 b=4'b0000;
			#2 b=4'b0001;
			#4 b=4'b0010;
			#6 b=4'b0011;
			#100 $finish;
		end
endmodule