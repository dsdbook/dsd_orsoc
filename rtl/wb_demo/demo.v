`include "timescale.v"
`define AND 3'h0
`define OR  3'h1
`define NOT 3'h2
`define XOR 3'h3
`define NOR 4'h4

module demo(clk,rst,start,done,A,B,op,Y);
input   clk;
input   rst;
input   start;
input   [31:0] A;
input   [31:0] B;
input   [2:0] op;
output  reg     done;
output  reg     [31:0] Y;


always@(posedge clk or posedge rst)
begin
	if(rst) begin
		Y<=32'h0;
		done<=1'b0;
	end
	else begin
		if(start) begin
			done <= 1'b1;
			case(op)
			`AND:   begin Y<=A&B;end
			`OR:    begin Y<=A|B;end
			`NOT:   begin Y<=~A;end
			`XOR:   begin Y<=A^B;end
			`NOR:   begin Y<=A~^B;end
			endcase
		end
		else begin
			done<=1'b0;
		end
	end        
end

endmodule
