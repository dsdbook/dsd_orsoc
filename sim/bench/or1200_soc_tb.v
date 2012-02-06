`timescale 1ns/1ps
`include "or1200_soc_top_defines.v"

module or1200_soc_tb();

// -----------------------------------
// Local Wires
reg     rst;

// PLL
reg     clk;

reg [31:0] gpio_in;
wire [31:0] gpio_out;
// -----------------------------------
// Instance of Module: or1200_soc_top
// -----------------------------------
or1200_soc_top i_or1200_soc_top(
	.clk    	(	clk ),
	.rst		(	rst		),
	
	.gpio_in	(	gpio_in		),
	.gpio_out	(	gpio_out	)
);

/**********************************************************************/

initial begin
	gpio_in = 32'hA5A5A5A5;
end

always@(gpio_out)
begin
	$display($time,"  gpio_out = %x",gpio_out);
	if(gpio_out == 32'hffffffff) begin
		$display("stop simulation duo to gpio_out==32'hffffffff");
		$finish();
	end
end

// ******************************  Clock section  ******************************
initial begin
	clk	 =  1'b0;
end
// clk		:	50MHz
always begin
	#10 clk 	<= 	1'b0;
	#10 clk 	<= 	1'b1;
end

initial begin
	//rst <= 1'b0;
	repeat(10)       @(posedge clk);
	rst <= 1'b1;
	repeat(10)       @(posedge clk);
	rst <= 1'b0;
end


`ifdef	DUMP_VCD
initial begin
	$dumpfile("or1200_soc_tb.vcd");
	$dumpvars(0,or1200_soc_tb);
	$dumpflush;
end
`endif

`ifdef	DUMP_FSDB
initial begin
	$fsdbDumpfile("or1200_soc_tb.fsdb");
	$fsdbDumpvars;
end
`endif

or1200_monitor or1200_monitor();

endmodule

