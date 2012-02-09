// synopsys translate_off
`include "timescale.v"
// synopsys translate_on

`include "or1200_soc_top_defines.v"

module or1200_soc_top (
	//
	//Global signals
	// 
	clk,
	rst,
	//
	//gpio
	//
	gpio_in,
	gpio_out
);

//
// Global signals
//

input   clk;
input   rst;

//
// gpio
//
input   [31:0]	gpio_in;
output  [31:0]	gpio_out;
wire    [31:0]	gpio_oe;


`ifdef	FPGA_PLL_SIM
wire    cpu_clk;
reg     wb_clk;

always begin
	#20   wb_clk 	<= 	1'b0;
	#20   wb_clk 	<= 	1'b1;
end

assign  cpu_clk  =  wb_clk;

`else
//PLL inst
wire    wb_clk;
wire    cpu_clk;
pll	pll_inst (
	.inclk0    ( clk ),
	.c0        ( wb_clk ),
	.locked    (  )
);
assign  cpu_clk  =  wb_clk;
`endif

reg     rst_r;
reg     wb_rst;

// All the wishbone signals is high active	
always @(posedge wb_clk)
begin
	if (rst)
	begin
		rst_r <= 1'b1;
	end
	else
		rst_r <= #1 1'b0;
end

always @(posedge wb_clk)
begin
	wb_rst <= #1 rst_r;
end


//
// RISC instruction master i/f wires
//
wire    [31:0]		wb_rim_adr_o;
wire    wb_rim_cyc_o;
wire    [31:0]		wb_rim_dat_i;
wire    [31:0]		wb_rim_dat_o;
wire    [3:0]		wb_rim_sel_o;
wire    wb_rim_ack_i;
wire    wb_rim_err_i;
wire    wb_rim_we_o;
wire    wb_rim_stb_o;
wire    wb_rim_cab_o;
wire    wb_rim_rty_i;

//
// RISC data master i/f wires
//
wire    [31:0]		wb_rdm_adr_o;
wire    wb_rdm_cyc_o;
wire    [31:0]		wb_rdm_dat_i;
wire    [31:0]		wb_rdm_dat_o;
wire    [3:0]		wb_rdm_sel_o;
wire    wb_rdm_ack_i;
wire    wb_rdm_err_i;
wire    wb_rdm_we_o;
wire    wb_rdm_stb_o;
wire    wb_rdm_cab_o;
wire    wb_rdm_rty_i;

//
// RISC misc
//
wire    [30:0]		pic_ints;

//
// gpio
//
wire    [31:0]		wb_gpio_dat_i;
wire    [31:0]		wb_gpio_dat_o;
wire    [31:0]		wb_gpio_adr_i;
wire    [3:0]		wb_gpio_sel_i;
wire    wb_gpio_cyc_i;
wire    wb_gpio_we_i;
wire    wb_gpio_stb_i;
wire    wb_gpio_ack_o;
wire    wb_gpio_err_o;

//
// wb_demo
//
wire    [31:0]		wb_wbdemo_dat_i;
wire    [31:0]		wb_wbdemo_dat_o;
wire    [31:0]		wb_wbdemo_adr_i;
wire    [3:0]		wb_wbdemo_sel_i;
wire    wb_wbdemo_cyc_i;
wire    wb_wbdemo_we_i;
wire    wb_wbdemo_stb_i;
wire    wb_wbdemo_ack_o;

//
// on_chip memory
//
wire    [31:0]		wb_ocm_dat_i;
wire    [31:0]		wb_ocm_dat_o;
wire    [31:0]		wb_ocm_adr_i;
wire    [3:0]		wb_ocm_sel_i;
wire    wb_ocm_cyc_i;
wire    wb_ocm_we_i;
wire    wb_ocm_stb_i;
wire    wb_ocm_ack_o;
wire    wb_ocm_err_o;


//////////////////////////////////////////////////////////////////////////////////////////

//
// Unused interrupts
//
assign  pic_ints[`APP_INT_RES1]  =  'b0;
assign  pic_ints[`APP_INT_RES2]  =  'b0;


//add by dxzhang, orpsocv2
wire    wb_rdm_stb_o_tmp;
assign  wb_rdm_stb_o   =  (wb_rdm_cyc_o == 1'b1) ? wb_rdm_stb_o_tmp : 1'b0;


or1200_top or1200_top_inst (
	
	// Common
	.rst_i		   ( wb_rst ),
	.clk_i		   ( cpu_clk ),	
	
	.clmode_i	   ( 2'b00 ),
	
	// WISHBONE Instruction Master
	.iwb_clk_i	   ( wb_clk ),
	.iwb_rst_i	   ( wb_rst ),
	.iwb_cyc_o	   ( wb_rim_cyc_o ),
	.iwb_adr_o	   ( wb_rim_adr_o ),
	.iwb_dat_i	   ( wb_rim_dat_i ),
	.iwb_dat_o	   ( wb_rim_dat_o ),
	.iwb_sel_o	   ( wb_rim_sel_o ),
	.iwb_ack_i	   ( wb_rim_ack_i ),
	.iwb_err_i	   ( wb_rim_err_i ),
	.iwb_rty_i	   ( wb_rim_rty_i ),
	.iwb_we_o	   ( wb_rim_we_o  ),
	.iwb_stb_o	   ( wb_rim_stb_o ),
	`ifdef OR1200_WB_CAB
	.iwb_cab_o	   ( wb_rim_cab_o ),
	`endif
	
	// WISHBONE Data Master
	.dwb_clk_i	   ( wb_clk ),
	.dwb_rst_i	   ( wb_rst ),
	.dwb_cyc_o	   ( wb_rdm_cyc_o ),
	.dwb_adr_o	   ( wb_rdm_adr_o ),
	.dwb_dat_i	   ( wb_rdm_dat_i ),
	.dwb_dat_o	   ( wb_rdm_dat_o ),
	.dwb_sel_o	   ( wb_rdm_sel_o ),
	.dwb_ack_i	   ( wb_rdm_ack_i ),
	.dwb_err_i	   ( wb_rdm_err_i ),
	.dwb_rty_i	   ( wb_rdm_rty_i ),
	.dwb_we_o	   ( wb_rdm_we_o  ),
	.dwb_stb_o	   ( wb_rdm_stb_o_tmp ),
	`ifdef OR1200_WB_CAB
	.dwb_cab_o	   ( wb_rdm_cab_o ),
	`endif
	
	// External Debug Interface
	.dbg_stall_i   ( 1'b0  ),
	.dbg_ewt_i     ( 1'b0 ),
	.dbg_lss_o     (     ),
	.dbg_is_o      (     ),
	.dbg_wp_o      (     ),
	.dbg_bp_o      (     ),
	.dbg_stb_i     ( 1'b0   ),
	.dbg_we_i      ( 1'b0    ),
	.dbg_adr_i     ( 32'b0  ),
	.dbg_dat_o     (  ),
	.dbg_dat_i     ( 32'b0 ),
	.dbg_ack_o     (     ),
	
	// Power Management
	.pm_clksd_o	       ( ),
	.pm_cpustall_i	   ( 1'b0 ),
	.pm_dc_gate_o	   ( ),
	.pm_ic_gate_o	   ( ),
	.pm_dmmu_gate_o	   ( ),
	.pm_immu_gate_o	   ( ),
	.pm_tt_gate_o	   ( ),
	.pm_cpu_gate_o	   ( ),
	.pm_wakeup_o	   ( ),
	.pm_lvolt_o	       ( ),
	.sig_tick	       ( ),
	
	// Interrupts
	.pic_ints_i	       ( pic_ints )
);


//on_chip_ram:
on_chip_ram_top on_chip_ram_top_inst(
	.wb_clk_i              ( wb_clk ),
	.wb_rst_i              ( wb_rst ),
	
	// WISHBONE slave
	.wb_adr_i              ( wb_ocm_adr_i),
	.wb_dat_i              ( wb_ocm_dat_i ),
	.wb_dat_o              ( wb_ocm_dat_o ),
	.wb_we_i               ( wb_ocm_we_i  ),
	.wb_stb_i              ( wb_ocm_stb_i ),
	.wb_cyc_i              ( wb_ocm_cyc_i ),
	.wb_ack_o              ( wb_ocm_ack_o ),
	.wb_sel_i              ( wb_ocm_sel_i ),
	.wb_err_o              ( wb_ocm_err_o )
);

wb_demo wb_demo_inst(
	.wb_clk_i  (wb_clk),
	.wb_rst_i  (wb_rst),
	.wb_stb_i  (wb_wbdemo_stb_i),
	.wb_cyc_i  (wb_wbdemo_cyc_i),
	.wb_dat_i  (wb_wbdemo_dat_i),
	.wb_dat_o  (wb_wbdemo_dat_o),
	.wb_adr_i  (wb_wbdemo_adr_i[4:0]),
	.wb_we_i   (wb_wbdemo_we_i),
	.wb_ack_o  (wb_wbdemo_ack_o),
	.wb_sel_i  (wb_wbdemo_sel_i)
);

//
// Instantiation of the GPIO
//
gpio_top gpio_top_inst(
	
	// WISHBONE Interface
	.wb_clk_i	       ( wb_clk ),
	.wb_rst_i	       ( wb_rst ),
	.wb_cyc_i	       ( wb_gpio_cyc_i ),
	.wb_adr_i	       ( wb_gpio_adr_i[7:0] ),
	.wb_dat_i	       ( wb_gpio_dat_i ),
	.wb_sel_i	       ( wb_gpio_sel_i ),
	.wb_we_i	       ( wb_gpio_we_i ),
	.wb_stb_i	       ( wb_gpio_stb_i ),
	.wb_dat_o	       ( wb_gpio_dat_o ),
	.wb_ack_o	       ( wb_gpio_ack_o ),
	.wb_err_o	       ( wb_gpio_err_o ),
	.wb_inta_o	       ( pic_ints[`APP_INT_GPIO] ),
	
	// External GPIO Interface
	.ext_pad_i	       ( gpio_in ),
	.ext_pad_o	       ( gpio_out ),
	.ext_padoe_o	   	   ( gpio_oe )
);

/*  		m0--OR1200 Instruction Master 
		m1--OR1200 Data Master
		s0--on_chip memory
		s14--GPIO
*/
wb_conmax_top	wb_conmax_top_inst(
	
	.clk_i		   ( wb_clk ),
	.rst_i		   ( wb_rst ),
	
	// Master 0 Interface	-- OR1200 Instruction Master
	.m0_data_i	   ( wb_rim_dat_o ),
	.m0_data_o	   ( wb_rim_dat_i ),
	.m0_addr_i	   ( wb_rim_adr_o),
	.m0_sel_i	   ( wb_rim_sel_o ),
	.m0_we_i	   ( wb_rim_we_o ),
	.m0_cyc_i	   ( wb_rim_cyc_o ),
	.m0_stb_i	   ( wb_rim_stb_o ),
	.m0_ack_o	   ( wb_rim_ack_i ),
	.m0_err_o	   ( wb_rim_err_i ), 
	.m0_rty_o	   ( wb_rim_rty_i ),
	
	// Master 1 Interface	-- OR1200 Data Master
	.m1_data_i	   ( wb_rdm_dat_o ), 
	.m1_data_o	   ( wb_rdm_dat_i ), 
	.m1_addr_i	   ( wb_rdm_adr_o ), 
	.m1_sel_i	   ( wb_rdm_sel_o ), 
	.m1_we_i	   ( wb_rdm_we_o ), 
	.m1_cyc_i	   ( wb_rdm_cyc_o ),
	.m1_stb_i	   ( wb_rdm_stb_o ), 
	.m1_ack_o	   ( wb_rdm_ack_i ), 
	.m1_err_o	   ( wb_rdm_err_i ), 
	.m1_rty_o	   ( wb_rdm_rty_i ),
	
	// Master 3 Interface
	.m2_data_i	   ( 32'h0000_0000 ), 
	.m2_data_o	   (  ), 
	.m2_addr_i	   ( 32'h0000_0000 ), 
	.m2_sel_i	   ( 4'b0000 ), 
	.m2_we_i	   ( 1'b0 ), 
	.m2_cyc_i	   ( 1'b0 ),
	.m2_stb_i	   ( 1'b0 ), 
	.m2_ack_o	   (  ), 
	.m2_err_o	   (  ), 
	.m2_rty_o	   (  ),
	
	// Master 3 Interface
	.m3_data_i	   ( 32'h0000_0000 ), 
	.m3_data_o	   (  ), 
	.m3_addr_i	   ( 32'h0000_0000 ), 
	.m3_sel_i	   ( 4'b0000 ), 
	.m3_we_i	   ( 1'b0 ), 
	.m3_cyc_i	   ( 1'b0 ),
	.m3_stb_i	   ( 1'b0 ), 
	.m3_ack_o	   (  ), 
	.m3_err_o	   (  ), 
	.m3_rty_o	   (  ),
	
	// Master 4 Interface
	.m4_data_i	   ( 32'h0000_0000 ), 
	.m4_data_o	   (  ), 
	.m4_addr_i	   ( 32'h0000_0000 ), 
	.m4_sel_i	   ( 4'b0000 ), 
	.m4_we_i	   ( 1'b0 ), 
	.m4_cyc_i	   ( 1'b0 ),
	.m4_stb_i	   ( 1'b0 ), 
	.m4_ack_o	   (  ), 
	.m4_err_o	   (  ), 
	.m4_rty_o	   (  ),
	
	// Master 5 Interface
	.m5_data_i	   ( 32'h0000_0000 ), 
	.m5_data_o	   (  ), 
	.m5_addr_i	   ( 32'h0000_0000 ), 
	.m5_sel_i	   ( 4'b0000 ), 
	.m5_we_i	   ( 1'b0 ), 
	.m5_cyc_i	   ( 1'b0 ),
	.m5_stb_i	   ( 1'b0 ), 
	.m5_ack_o	   (  ), 
	.m5_err_o	   (  ), 
	.m5_rty_o	   (  ),
	
	// Master 6 Interface
	.m6_data_i	   ( 32'h0000_0000 ), 
	.m6_data_o	   (  ), 
	.m6_addr_i	   ( 32'h0000_0000 ), 
	.m6_sel_i	   ( 4'b0000 ), 
	.m6_we_i	   ( 1'b0 ), 
	.m6_cyc_i	   ( 1'b0 ),
	.m6_stb_i	   ( 1'b0 ), 
	.m6_ack_o	   (  ), 
	.m6_err_o	   (  ), 
	.m6_rty_o	   (  ),
	
	// Master 7 Interface
	.m7_data_i	   ( 32'h0000_0000 ), 
	.m7_data_o	   (  ), 
	.m7_addr_i	   ( 32'h0000_0000 ), 
	.m7_sel_i	   ( 4'b0000 ), 
	.m7_we_i	   ( 1'b0 ), 
	.m7_cyc_i	   ( 1'b0 ),
	.m7_stb_i	   ( 1'b0 ), 
	.m7_ack_o	   (  ), 
	.m7_err_o	   (  ), 
	.m7_rty_o	   (  ),
	
	// Slave 0 Interface -- on_chip mem
	.s0_data_i	   ( wb_ocm_dat_o ),
	.s0_data_o	   ( wb_ocm_dat_i ),
	.s0_addr_o	   ( wb_ocm_adr_i ),
	.s0_sel_o	   ( wb_ocm_sel_i ),
	.s0_we_o	   ( wb_ocm_we_i ), 
	.s0_cyc_o	   ( wb_ocm_cyc_i ),
	.s0_stb_o	   ( wb_ocm_stb_i ), 
	.s0_ack_i	   ( wb_ocm_ack_o ), 
	.s0_err_i	   ( 1'b0 ), 
	.s0_rty_i	   ( 1'b0 ),
	
	// Slave 1 Interface
	.s1_data_i	   ( 32'h0000_0000 ),
	.s1_data_o	   (  ),
	.s1_addr_o	   (  ),
	.s1_sel_o	   (  ),
	.s1_we_o	   (  ), 
	.s1_cyc_o	   (  ),
	.s1_stb_o	   (  ), 
	.s1_ack_i	   ( 1'b0 ), 
	.s1_err_i	   ( 1'b0 ), 
	.s1_rty_i	   ( 1'b0 ),
	
	// Slave 2 Interface
	.s2_data_i	   ( 32'h0000_0000 ),
	.s2_data_o	   (  ),
	.s2_addr_o	   (  ),
	.s2_sel_o	   (  ),
	.s2_we_o	   (  ), 
	.s2_cyc_o	   (  ),
	.s2_stb_o	   (  ), 
	.s2_ack_i	   ( 1'b0 ), 
	.s2_err_i	   ( 1'b0 ), 
	.s2_rty_i	   ( 1'b0 ),			
	// Slave 3 Interface
	.s3_data_i	   ( 32'h0000_0000 ),
	.s3_data_o	   (  ),
	.s3_addr_o	   (  ),
	.s3_sel_o	   (  ),
	.s3_we_o	   (  ), 
	.s3_cyc_o	   (  ),
	.s3_stb_o	   (  ), 
	.s3_ack_i	   ( 1'b0 ), 
	.s3_err_i	   ( 1'b0 ), 
	.s3_rty_i	   ( 1'b0 ),			
	// Slave 4 Interface
	.s4_data_i	   ( 32'h0000_0000 ),
	.s4_data_o	   (  ),
	.s4_addr_o	   (  ),
	.s4_sel_o	   (  ),
	.s4_we_o	   (  ), 
	.s4_cyc_o	   (  ),
	.s4_stb_o	   (  ), 
	.s4_ack_i	   ( 1'b0 ), 
	.s4_err_i	   ( 1'b0 ), 
	.s4_rty_i	   ( 1'b0 ),			
	
	// Slave 5 Interface
	.s5_data_i	   ( 32'h0000_0000 ),
	.s5_data_o	   (  ),
	.s5_addr_o	   (  ),
	.s5_sel_o	   (  ),
	.s5_we_o	   (  ), 
	.s5_cyc_o	   (  ),
	.s5_stb_o	   (  ), 
	.s5_ack_i	   ( 1'b0 ), 
	.s5_err_i	   ( 1'b0 ), 
	.s5_rty_i	   ( 1'b0 ),			
	
	// Slave 6 Interface	/*--wb_demo--*/
	.s6_data_i	   ( wb_wbdemo_dat_o ),
	.s6_data_o	   ( wb_wbdemo_dat_i ),
	.s6_addr_o	   ( wb_wbdemo_adr_i ),
	.s6_sel_o	   ( wb_wbdemo_sel_i ),
	.s6_we_o	   ( wb_wbdemo_we_i ), 
	.s6_cyc_o	   ( wb_wbdemo_cyc_i ),
	.s6_stb_o	   ( wb_wbdemo_stb_i ), 
	.s6_ack_i	   ( wb_wbdemo_ack_o ), 
	.s6_err_i	   ( 1'b0 ), 
	.s6_rty_i	   ( 1'b0 ),
	
	// Slave 7 Interface
	.s7_data_i	   ( 32'h0000_0000 ),
	.s7_data_o	   (  ),
	.s7_addr_o	   (  ),
	.s7_sel_o	   (  ),
	.s7_we_o	   (  ), 
	.s7_cyc_o	   (  ),
	.s7_stb_o	   (  ), 
	.s7_ack_i	   ( 1'b0 ), 
	.s7_err_i	   ( 1'b0 ), 
	.s7_rty_i	   ( 1'b0 ),			
	
	// Slave 8 Interface
	.s8_data_i	   ( 32'h0000_0000 ),
	.s8_data_o	   (  ),
	.s8_addr_o	   (  ),
	.s8_sel_o	   (  ),
	.s8_we_o	   (  ), 
	.s8_cyc_o	   (  ),
	.s8_stb_o	   (  ), 
	.s8_ack_i	   ( 1'b0 ), 
	.s8_err_i	   ( 1'b0 ), 
	.s8_rty_i	   ( 1'b0 ),			
	
	// Slave 9 Interface
	.s9_data_i	   ( 32'h0000_0000 ),
	.s9_data_o	   (  ),
	.s9_addr_o	   (  ),
	.s9_sel_o	   (  ),
	.s9_we_o	   (  ), 
	.s9_cyc_o	   (  ),
	.s9_stb_o	   (  ), 
	.s9_ack_i	   ( 1'b0 ), 
	.s9_err_i	   ( 1'b0 ), 
	.s9_rty_i	   ( 1'b0 ),			
	
	// Slave 10 Interface
	.s10_data_i	   ( 32'h0000_0000 ),
	.s10_data_o	   (  ),
	.s10_addr_o	   (  ),
	.s10_sel_o	   (  ),
	.s10_we_o	   (  ), 
	.s10_cyc_o	   (  ),
	.s10_stb_o	   (  ), 
	.s10_ack_i	   ( 1'b0 ), 
	.s10_err_i	   ( 1'b0 ), 
	.s10_rty_i	   ( 1'b0 ),			
	// Slave 11 Interface
	.s11_data_i	   ( 32'h0000_0000 ),
	.s11_data_o	   (  ),
	.s11_addr_o	   (  ),
	.s11_sel_o	   (  ),
	.s11_we_o	   (  ), 
	.s11_cyc_o	   (  ),
	.s11_stb_o	   (  ), 
	.s11_ack_i	   ( 1'b0 ), 
	.s11_err_i	   ( 1'b0 ), 
	.s11_rty_i	   ( 1'b0 ),			
	
	// Slave 12 Interface
	.s12_data_i	   ( 32'h0000_0000 ),
	.s12_data_o	   (  ),
	.s12_addr_o	   (  ),
	.s12_sel_o	   (  ),
	.s12_we_o	   (  ), 
	.s12_cyc_o	   (  ),
	.s12_stb_o	   (  ), 
	.s12_ack_i	   ( 1'b0 ), 
	.s12_err_i	   ( 1'b0 ), 
	.s12_rty_i	   ( 1'b0 ),
	// Slave 13 Interface
	.s13_data_i	   ( 32'h0000_0000 ),
	.s13_data_o	   (  ),
	.s13_addr_o	   (  ),
	.s13_sel_o	   (  ),
	.s13_we_o	   (  ), 
	.s13_cyc_o	   (  ),
	.s13_stb_o	   (  ), 
	.s13_ack_i	   ( 1'b0 ), 
	.s13_err_i	   ( 1'b0 ), 
	.s13_rty_i	   ( 1'b0 ),
	
	// Slave 14 Interface	/*--GPIO--*/
	.s14_data_i	   ( wb_gpio_dat_o ),
	.s14_data_o	   ( wb_gpio_dat_i ),
	.s14_addr_o	   ( wb_gpio_adr_i ),
	.s14_sel_o	   ( wb_gpio_sel_i ),
	.s14_we_o	   ( wb_gpio_we_i ), 
	.s14_cyc_o	   ( wb_gpio_cyc_i ),
	.s14_stb_o	   ( wb_gpio_stb_i ), 
	.s14_ack_i	   ( wb_gpio_ack_o ), 
	.s14_err_i	   ( wb_gpio_err_o ), 
	.s14_rty_i	   ( 1'b0 ),
	// Slave 15 Interface
	.s15_data_i	   ( 32'h0000_0000 ),
	.s15_data_o	   (  ),
	.s15_addr_o	   (  ),
	.s15_sel_o	   (  ),
	.s15_we_o	   (  ), 
	.s15_cyc_o	   (  ),
	.s15_stb_o	   (  ), 
	.s15_ack_i	   ( 1'b0 ), 
	.s15_err_i	   ( 1'b0 ), 
	.s15_rty_i	   ( 1'b0 )
);

endmodule
