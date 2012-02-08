`timescale 1ns/1ps
`include "or1200_soc_top_defines.v"

module or1200_soc_tb();

// -----------------------------------
// Local Wires
reg     rst;

// PLL
reg     clk;
reg     boot_flash;

wire    uart_srx;
wire    uart_stx;

reg [31:0] gpio_in;
wire [31:0] gpio_out;

wire    [21:0] 	flash_addr;
wire    [15:0] 	flash_dq;

wire    flash_we_n;
wire    flash_oe_n;
wire    flash_ce_n;
wire    flash_reset_n;
wire    flash_wp_n;
wire    flash_RY;
wire    flash_byte_n;

//sdram0 signals
wire    [15:0]  sdram0_dq;
wire    [12:0]  sdram0_addr;
wire    [1:0]   sdram0_ba;
wire    sdram0_cas_n;
wire    sdram0_ras_n;
wire    sdram0_cke;
wire    sdram0_we_n;
wire    [1:0]   sdram0_dqm;
wire    sdram0_clk;
wire    sdram0_cs_n;

// -----------------------------------
// Instance of Module: or1200_soc_top
// -----------------------------------
or1200_soc_top i_or1200_soc_top(
	.clk    	(	clk ),
	.rst		(	rst		),
//uart
        .uart_srx      (        uart_srx        ),
        .uart_stx      (        uart_stx        ),

	.boot_flash    (	boot_flash	),

	//
	//flash signals
	//
	.flash_addr(	flash_addr	),
	.flash_dq  (	flash_dq	),
	.flash_we_n(	flash_we_n	),
	.flash_oe_n(	flash_oe_n	),
	.flash_reset_n (	flash_reset_n	),
	.flash_ce_n    (	flash_ce_n	),
	.flash_wp_n    (	flash_wp_n	),
	.flash_RY      (	flash_RY	),
	.flash_byte_n  (	flash_byte_n	),

	// sdram0_signals
	.sdram0_dq     (	sdram0_dq	),
	.sdram0_addr   (	sdram0_addr	),
	.sdram0_ba     (	sdram0_ba	),
	.sdram0_cas_n  (	sdram0_cas_n	),
	.sdram0_ras_n  (	sdram0_ras_n	),
	.sdram0_cke    (	sdram0_cke	),
	.sdram0_we_n   (	sdram0_we_n	),
	.sdram0_dqm    (	sdram0_dqm	),
	.sdram0_clk    (	sdram0_clk	),
	.sdram0_cs_n   (	sdram0_cs_n	),

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

reg     baudclk;
//add by dxzhang 20081122,uart_monitor
//baudclk   : 1000000000/(16*baud_rate), when baud_rate=9600, is 6510
//`define BAUDCLK_HALF_PERIOD 3255
// baud_rate =115200, 271
`define BAUDCLK_HALF_PERIOD 271

initial begin
        baudclk    =  0;
        forever # `BAUDCLK_HALF_PERIOD baudclk =  ~baudclk;
end

uart_rx uart_rx (
        .reset (                rst     ),
        .rxclk (                baudclk ),
        .rx_in (                uart_stx)
);

initial begin
	`ifdef	BOOT_FLASH
	boot_flash   =  1'b1;
	`else
	boot_flash   =  1'b0;
	`endif
end
//add by dxzhang,for 16 bit flash
defparam or1200_soc_tb.s29gl064a_r3_r4_flash.mem_file_name =  "flash.ver";

s29gl064a_r3_r4 s29gl064a_r3_r4_flash(
	
	.A21   (	flash_addr[21]	),
	.A20   (	flash_addr[20]	),
	.A19   (	flash_addr[19]	),
	.A18   (	flash_addr[18]	),
	.A17   (	flash_addr[17]	),
	.A16   (	flash_addr[16]	),
	.A15   (	flash_addr[15]	),
	.A14   (	flash_addr[14]	),
	.A13   (	flash_addr[13]	),
	.A12   (	flash_addr[12]	),
	.A11   (	flash_addr[11]	),
	.A10   (	flash_addr[10]	),
	.A9    (	flash_addr[9]	),
	.A8    (	flash_addr[8]	),
	.A7    (	flash_addr[7]	),
	.A6    (	flash_addr[6]	),
	.A5    (	flash_addr[5]	),
	.A4    (	flash_addr[4]	),
	.A3    (	flash_addr[3]	),
	.A2    (	flash_addr[2]	),
	.A1    (	flash_addr[1]	),
	.A0    (	flash_addr[0]	),
	
	.DQ15  (	flash_dq[15]	),
	.DQ14  (	flash_dq[14]	),
	.DQ13  (	flash_dq[13]	),
	.DQ12  (	flash_dq[12]	),
	.DQ11  (	flash_dq[11]	),
	.DQ10  (	flash_dq[10]	),
	.DQ9   (	flash_dq[9]	),
	.DQ8   (	flash_dq[8]	),
	.DQ7   (	flash_dq[7]	),
	.DQ6   (	flash_dq[6]	),
	.DQ5   (	flash_dq[5]	),
	.DQ4   (	flash_dq[4]	),
	.DQ3   (	flash_dq[3]	),
	.DQ2   (	flash_dq[2]	),
	.DQ1   (	flash_dq[1]	),
	.DQ0   (	flash_dq[0]	),
	
	.OENeg (	flash_oe_n	),
	
	.WENeg (	flash_we_n	),
	.CENeg (	flash_ce_n	),
	.RESETNeg  (	flash_reset_n	),

	.WPNeg     (	flash_wp_n	),
	//dxzhang: should be 1'b1 when 16bit flash
	//.BYTENeg(1'b1)  ,
	.BYTENeg   (	flash_byte_n	),
	.RY(	flash_RY	)
);

//sdram model
mt48lc16m16a2
sdram0_module(
	.Dq        (	sdram0_dq	),
	.Addr      (	sdram0_addr[12:0]	),
	.Ba         (	sdram0_ba[1:0]	),
	.Clk   (	sdram0_clk	),
	.Cke   (	sdram0_cke	),
	.Cs_n  (	sdram0_cs_n	),
	.Ras_n (	sdram0_ras_n	),
	.Cas_n (	sdram0_cas_n	),
	.We_n  (	sdram0_we_n	),
	.Dqm   (	sdram0_dqm[1:0]	)
);


or1200_monitor or1200_monitor();

endmodule

