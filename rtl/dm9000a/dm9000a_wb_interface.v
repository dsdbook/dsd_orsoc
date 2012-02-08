module dm9000a_wb_interface(
	wb_adr_i,
	wb_dat_i,
	wb_dat_o,
	wb_we_i,
	wb_sel_i,
	wb_stb_i,
	wb_ack_o,
	wb_cyc_i,
	wb_clk_i,
	wb_rst_i,
	oENET_CMD,
	oENET_CS_N,
	iENET_INT,
	oENET_INT,
	oENET_IOR_N,
	oENET_IOW_N,
	oENET_RESET_N,
	ENET_D_i,
	ENET_D_o,
	ENET_D_oe
);

input   wb_clk_i;
input   wb_rst_i;
input   iENET_INT;
output  oENET_INT;
input   [31:0]	wb_adr_i;
input   [15:0]	wb_dat_i;
output  [15:0]	wb_dat_o;
input   wb_we_i;
input   [3:0]	wb_sel_i;
input   wb_stb_i;
output  wb_ack_o;
input   wb_cyc_i;

output  oENET_CMD;
output  oENET_CS_N;
input   [15:0]	ENET_D_i;
output  [15:0]	ENET_D_o;
output  ENET_D_oe;
output  oENET_IOR_N;
output  oENET_IOW_N;
output  oENET_RESET_N;

reg     wb_ack_o;

assign  oENET_INT 	 =  iENET_INT;
assign  oENET_CS_N 	 =  ~(wb_stb_i & wb_cyc_i);

assign  oENET_IOR_N 	 =  ~(wb_stb_i & wb_cyc_i & (~wb_we_i));
assign  oENET_IOW_N 	 =  ~(wb_stb_i & wb_cyc_i & wb_we_i);

assign  oENET_RESET_N 	 =  (~wb_rst_i);

assign  oENET_CMD 	 =  wb_adr_i[2];
assign  ENET_D_oe	 =  wb_we_i;

assign  ENET_D_o	 =  { wb_dat_i[7:0],wb_dat_i[15:8] };
assign  wb_dat_o[15:0]	 =  { ENET_D_i[7:0],ENET_D_i[15:8] };

always@(posedge wb_clk_i)
	wb_ack_o 	<= 	wb_stb_i & wb_cyc_i & (~wb_ack_o);

endmodule
