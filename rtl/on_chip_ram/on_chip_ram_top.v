
// synopsys translate_off
`include "timescale.v"
// synopsys translate_on

module on_chip_ram_top (
	//
	// I/O Ports
	//
	input		wb_clk_i,
	input		wb_rst_i,

	//
	// WB slave i/f
	//
	input	[31:0]	wb_dat_i,
	output	[31:0]	wb_dat_o,
	input	[31:0]	wb_adr_i,
	input	[3:0]	wb_sel_i,
	input		wb_we_i,
	input		wb_cyc_i,
	input		wb_stb_i,
	output 		wb_ack_o,
	output		wb_err_o
);

//
// Paraneters
//
parameter		AW = 13;	// RAM size = 8 kwords (32 kbytes)


//
// Internal wires and regs
//
wire	 		we;
reg	[1:0]		ack;
wire [3:0]		be_i;

//
// Aliases and simple assignments
//

assign wb_err_o = 1'b0;

assign we = wb_cyc_i & wb_stb_i & wb_we_i & (| wb_sel_i[3:0]);

assign be_i = (wb_cyc_i & wb_stb_i) ? wb_sel_i : 4'b0000;

//
always @ (posedge wb_clk_i or posedge wb_rst_i)
begin
	if (wb_rst_i) begin
		ack <= 2'b00;
	end
	else if (wb_cyc_i & wb_stb_i) begin
			ack <= {ack[0],1'b1};
		end
		else ack <= 2'b00;
end

assign wb_ack_o = wb_we_i? (ack[0] & wb_cyc_i & wb_stb_i):(ack[1] & wb_cyc_i & wb_stb_i);
//assign wb_ack_o = ack[1] & wb_cyc_i & wb_stb_i;


on_chip_ram	on_chip_ram_inst (
	.address ( wb_adr_i[AW+2-1:2] ),
	.clock ( wb_clk_i ),
	.byteena (be_i),
	.data ( wb_dat_i ),
	.wren ( we ),
	.q ( wb_dat_o )
	);


endmodule
