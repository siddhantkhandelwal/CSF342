`timescale 1ns/10ps

module tb_comparator_4bit(); 

	reg [3:0] A,B ;
	reg sign; 
	wire AeqB, AgtB, AltB ; 

	comparator_4bit uut (.AeqB(AeqB),.AgtB(AgtB),.AltB(AltB),.A(A),.B(B),.sign(sign));

	initial 
	begin 
		#00 A = 4'b0000 ; B = 4'b0000 ; sign = 1;
		#20 A = 4'b1111 ; B = 4'b1111 ; sign = 1;
		#20 A = 4'b1100 ; B = 4'b0000 ; sign = 1;
		#20 A = 4'b0011 ; B = 4'b0000 ; sign = 1;
		#20 $stop ; 
	end

	initial $monitor("t=%3d, A=%b,B=%b,sign=%b,AeqB=%b,AgtB=%b AltB=%b",$time,A,B,sign,AeqB, AgtB, AltB); 

	initial
	begin
		$dumpfile("comparator_8bit.vcd");
		$dumpvars;
	end
		
endmodule

module comparator_4bit(AeqB, AgtB, AltB, A, B, sign);

	output AeqB, AgtB, AltB ;
	input [3:0] A, B ;
	input sign ;

	//Using DF
	assign AeqB = (A==B)? 1 : 0 ; 
	assign AgtB = sign?(A[3]?(B[3]?(A<B):0):(B[3]?1:(A>B))):(A>B);
	assign AltB = sign?(A[3]?(B[3]?(A>B):1):(B[3]?0:(A<B))):(A<B);
endmodule

module comparator_4bit_beh(AeqB, AgtB, AltB, A, B, sign);
	output AeqB, AgtB, AltB ;
	reg AeqB, AgtB, AltB ;
	input [3:0] A, B ;
	input sign ;

	//Using DF
	always@(A, B)
	if (A==B) AeqB=1; else AeqB=0 ;
	if(sign && A[3] && B[3] && A<B) AgtB = 1;
	else if(sign && A[3] && B[3] && A>B) AgtB = 0;
	else if(sign && B[3]) AgtB = 1;
	else if(sign && A>B) AgtB = 1;
	else if(sign && A<B) AgtB = 0;
	else if(A>B) AgtB = 1;
	else AgtB = 0;
	
	if(sign && A[3] && B[3] && A>B) AltB = 1;
	else if(sign && A[3] && B[3] && A<B) AltB = 0;
	else if(sign && B[3]) AltB = 0;
	else if(sign && A<B) AltB = 1;
	else if(sign && A>B) AgtB = 0;
	else if(A<B) AltB = 1;
	else AltB = 0;
endmodule