//dxzhang@ustc.edu, 20101011

// synopsys translate_off
`include "timescale.v"
// synopsys translate_on

module wb_demo(
	// WISHBONE Interface
	wb_clk_i, wb_rst_i, wb_cyc_i, wb_adr_i, wb_dat_i, wb_sel_i,
	wb_we_i, wb_stb_i,wb_dat_o, wb_ack_o
	
);
//
// WISHBONE Interface
//
input   wb_clk_i;	// Clock
input   wb_rst_i;	// Reset
input   wb_cyc_i;	// cycle valid input
input   [4:0]     wb_adr_i;	// address bus inputs
input   [31:0]    wb_dat_i;	// input data bus
input   [3:0]     wb_sel_i;	// byte select inputs
input   wb_we_i;	// indicates write transfer
input   wb_stb_i;	// strobe input
output  [31:0]    wb_dat_o;	// output data bus
output  wb_ack_o;	// normal termination

reg     [31:0]    wb_dat_o;
wire    wb_ack_o;
reg     wb_ack_o_r;

reg     [31:0]	A;
reg     [31:0]	B;
reg     [31:0]	op;
reg     [31:0]	Y;
reg     [1:0] start_r;
wire    start;
reg     done_r;
wire    done;
wire    [31:0] Y_tmp;

wire    wb_write;
wire    wb_read;
assign  wb_write =  wb_cyc_i & wb_stb_i & wb_we_i;
assign  wb_read  =  wb_cyc_i & wb_stb_i & (!wb_we_i);

always@(posedge wb_clk_i)
begin
	if(wb_rst_i)
		wb_ack_o_r <= 1'b0;
	else
		wb_ack_o_r <= wb_cyc_i & wb_stb_i;
end

assign wb_ack_o = wb_cyc_i & wb_stb_i & wb_ack_o_r;


always@(posedge wb_clk_i)
begin
	if(wb_write) begin
		case(wb_adr_i[4:2])
		3'h0: begin
			A <= wb_dat_i;
		end
		3'h1: begin
			B <= wb_dat_i;
		end
		3'h2: begin
			op <= wb_dat_i;
		end
		endcase
	end
	else if(wb_read) begin
		case(wb_adr_i[4:2])
		3'h0: begin
			wb_dat_o <= A;
		end
		3'h1: begin
			wb_dat_o <= B;
		end
		3'h2: begin
			wb_dat_o <= op;
		end
		3'h3: begin
			wb_dat_o <= Y;
		end
		3'h4: begin     //done
			wb_dat_o <= {31'h0,done_r};
		end
		default: begin
			wb_dat_o <= 32'h0;
		end
		endcase
	end
end


// start signal
wire    write_op;
assign  write_op =  wb_stb_i & wb_cyc_i & (wb_adr_i[4:2]==3'h2) & wb_we_i;

always@(posedge wb_clk_i)
begin
	if(wb_rst_i) start_r[1:0] <=2'b0;
	else start_r[1:0] <= {start_r[1],write_op}; 
end
assign  start    =  start_r == 2'b01;

//done_r signal
always@(posedge wb_clk_i)
begin
	if(wb_rst_i) begin
		done_r <= 1'b0;
	end
	else 	begin
		if(done) begin
			done_r <= 1'b1;
		end
		else	begin
			if(start) begin
				done_r <= 1'b0;
			end
		end
	end
	
end
//Y signal
always@(posedge wb_clk_i)
begin
	if(wb_rst_i) begin
		Y <= 32'h0;
	end
	else 	begin
		if(done) begin
			Y <= Y_tmp;
		end
	end
end

demo  demo_inst(
	.clk       (wb_clk_i), 
	.rst       (wb_rst_i), 
	.start     (start), 
	.done      (done), 
	.A (A), 
	.B (B), 
	.op(op[2:0]), 
	.Y (Y_tmp) 
);

endmodule
