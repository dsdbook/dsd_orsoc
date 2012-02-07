//**********************************************************
// Copyright (c) 2008 by Dynalith Systems Co., Ltd.
// All right reserved.
//**********************************************************
// VERSION: 2008.08.27
//********************************************************/
// a simplified version of Intel Flash
// with Wishbone bus interface
//
// Macros:
//
// Note: FLASH_A[21:0] for  32Mbit ( 4Mbyte) Flash chip
//       FLASH_A[22:0] for  64Mbit ( 8Mbyte) Flash chip
//       FLASH_A[23:0] for 128Mbit (16Mbyte) Flash chip
// Note: There are two Flash chip and thus the total
//       memory space will be double; i.e., when 32Mbit Flash
//       chip is mounted, there is 8Mbyte in total.
//

`timescale 1ns/1ps
`include "../top/or1200_soc_top_defines.v"

// -----------------------------------------------------------------------------

module wb_flash_if (
	wb_rst_i,
	wb_clk_i,
	wb_cyc_i,
	wb_stb_i,
	wb_adr_i,
	wb_sel_i,
	wb_we_i,
	wb_dat_i,
	wb_dat_o,
	wb_ack_o,
	wb_err_o,
	wb_rty_o,
	//       wb_cti_i,
	//       wb_bte_i,
	//       wb_lock_i,
	FLASH_A,
	FLASH_CE_N,
	FLASH_D_I,
	FLASH_D_O,
	FLASH_D_T_N,
	FLASH_OE_N,
	FLASH_RP_N,
	//       FLASH_SnADDR1, 
	FLASH_SnBYTE,
	FLASH_SnWR,
	FLASH_STS
);
//parameter WCLK_PERIOD=40; // 25Mhz
parameter WCLK_PERIOD=  `WB_CLK_PERIOD;
parameter WRITE_DELAY_NS =  70;
parameter READ_DELAY_NS =  180;
parameter WRITE_DELAY_COUNT=  WRITE_DELAY_NS/WCLK_PERIOD;
parameter READ_DELAY_COUNT =  READ_DELAY_NS/WCLK_PERIOD;
input   wb_rst_i ; wire    wb_rst_i ;
input   wb_clk_i ; wire    wb_clk_i ;
input   wb_cyc_i ; wire    wb_cyc_i ;
input   wb_stb_i ; wire    wb_stb_i ;
input   [31:0] wb_adr_i ; wire    [31:0] wb_adr_i ;
input   [ 3:0] wb_sel_i ; wire    [ 3:0] wb_sel_i ;
input   wb_we_i  ; wire    wb_we_i  ;
input   [31:0] wb_dat_i ; wire    [31:0] wb_dat_i ;
output  [31:0] wb_dat_o ; reg     [31:0] wb_dat_o ;
output  wb_ack_o ; reg     wb_ack_o ;
output  wb_err_o ; wire    wb_err_o=  1'b0 ;
output  wb_rty_o ; wire    wb_rty_o=  1'b0 ;
//   input  [ 2:0] wb_cti_i ; wire [ 2:0] wb_cti_i ;
//   input  [ 1:0] wb_bte_i ; wire [ 1:0] wb_bte_i ;
//   input         wb_lock_i; wire        wb_lock_i;
//----------------------------------------------------
output  [21:0] FLASH_A;       reg     [21:0] FLASH_A;      
//   output        FLASH_SnADDR1; reg          FLASH_SnADDR1;
output  FLASH_CE_N;    reg     FLASH_CE_N;
input   [15:0] FLASH_D_I;     wire    [15:0] FLASH_D_I;
output  [15:0] FLASH_D_O;     reg     [15:0] FLASH_D_O;
output  FLASH_D_T_N;     reg     FLASH_D_T_N;
output  FLASH_OE_N;    reg     FLASH_OE_N;
output  FLASH_RP_N;    reg     FLASH_RP_N;
output  FLASH_SnBYTE;  reg     FLASH_SnBYTE;
output  FLASH_SnWR;    reg     FLASH_SnWR;
input   FLASH_STS;     wire    FLASH_STS;    
/*********************************************************/
reg     [4:0] read_delay, write_delay;
/*********************************************************/
reg     [3:0] state;
localparam STH_RESET   =  4'h0,
STH_IDLE   =  4'h1,
STH_CHECK  =  4'h2,
STH_WRITE0 =  4'h3,
STH_WRITE1 =  4'h4,
STH_WRITE2 =  4'h5,
STH_READ0  =  4'h6,
STH_READ1  =  4'h7,
STH_READ2  =  4'h8,
STH_READ_NEXT  =  4'h9,
STH_READ_NEXT0 =  4'hA,
STH_READ_NEXT1 =  4'hB,
STH_WRITE_NEXT =  4'hC,
STH_WRITE_NEXT0  =  4'hD;

//add by dxzhang ,check 32bit or 16bit access
wire    sel_0123, sel_01, sel_23;
assign  sel_0123 =  (wb_sel_i == 4'b1111);
assign  sel_01   =  (wb_sel_i == 4'b0011);
assign  sel_23   =  (wb_sel_i == 4'b1100);

/*********************************************************/
//   always @ (posedge wb_clk_i or posedge wb_rst_i) begin
always @ (posedge wb_clk_i) begin
	if (wb_rst_i==1) begin
		wb_dat_o      <= 32'h0;
		wb_ack_o      <= 1'b0;
		FLASH_A       <= 22'b0;
		//           FLASH_SnADDR1 <= 1'b0;
		FLASH_CE_N    <= 1'b1;
		FLASH_OE_N    <= 1'b1;
		FLASH_RP_N    <= 1'b0;
		FLASH_D_O     <= 1'b0;
		FLASH_D_T_N     <= 1'b1;
		FLASH_SnBYTE  <= 1'b1;  // no byte enable mode
		FLASH_SnWR    <= 1'b1;
		read_delay    <= 4'h0;
		write_delay   <= 4'h0;
		state         <= STH_RESET;
	end else begin  // if (HRESETn==0) begin
		case (state)
		STH_RESET: begin
			FLASH_RP_N <= 1'b1;
			if (FLASH_STS) state <= STH_IDLE;
		end
		STH_IDLE: begin
			if (wb_cyc_i&wb_stb_i) begin
				
				    // 4byte align, read first 2bytes
				if(sel_01)
					FLASH_A       <= #1 { wb_adr_i[22:2],1'b1 };
				else    //sel_23 or sel_0123,or other
					FLASH_A       <= #1 { wb_adr_i[22:2],1'b0 };
				
				if (FLASH_STS) begin
					if (wb_we_i) begin  // write
						FLASH_D_T_N  <= #1 1'b0;
						if(sel_01)
							state <= STH_WRITE_NEXT;
						else
							state      <= STH_WRITE0;
					end else begin      // read
						if(sel_01)
							state <= STH_READ_NEXT;
						else
							state      <= STH_READ0;
					end
				end else begin
					state      <= STH_CHECK;
				end
			end
		end // STH_IDLE
		STH_CHECK: begin
			if (FLASH_STS) begin
				if (wb_we_i) begin  // write
					FLASH_D_T_N  <= #1 1'b0;
					if(sel_01)
						state <= STH_WRITE_NEXT;
					else
						state      <= STH_WRITE0;
				end else begin      // read
					if(sel_01)
						state <= STH_READ_NEXT;
					else
						state      <= STH_READ0;
				end
			end
		end // STH_CHECK
		STH_WRITE0: begin
			FLASH_D_O[7:0] <= #1 wb_dat_i[31:24];
			FLASH_D_O[15:8] <= #1 wb_dat_i[23:16];
			state      <= STH_WRITE1;
		end // STH_WRITE0
		STH_WRITE1: begin
			FLASH_CE_N    <= #1 1'b0;
			FLASH_SnWR <= #1 1'b0;
			write_delay <= write_delay+1;
			if (write_delay>=WRITE_DELAY_COUNT) begin
				FLASH_SnWR  <= #1 1'b1;
				if(sel_23) begin
					wb_ack_o    <= 1'b1;
					state <= STH_WRITE2;
				end
				else
					state       <= STH_WRITE_NEXT;
			end
		end // STH_WRITE1
		STH_WRITE_NEXT: begin
			FLASH_A       <= #1 { wb_adr_i[22:2],1'b1};
			FLASH_D_O[7:0] <= #1 wb_dat_i[15:8];
			FLASH_D_O[15:8] <= #1 wb_dat_i[7:0];
			write_delay  <= #1 4'h0;
			state <= STH_WRITE_NEXT0;	
		end
		STH_WRITE_NEXT0: begin
			FLASH_CE_N    <= #1 1'b0;
			FLASH_SnWR <= #1 1'b0;
			write_delay <= write_delay+1;
			if (write_delay>=WRITE_DELAY_COUNT) begin
				FLASH_SnWR  <= #1 1'b1;
				wb_ack_o    <= 1'b1;
				state       <= STH_WRITE2;
			end
		end
		STH_WRITE2: begin
			FLASH_CE_N  <= #1 1'b1;
			FLASH_D_T_N   <= #1 1'b1;
			write_delay <= #1 4'h0;
			wb_ack_o    <= 1'b0;
			state       <= STH_IDLE;
		end // STH_WRITE2
		STH_READ0: begin
			FLASH_OE_N <= #1 1'b0;
			FLASH_CE_N <= #1 1'b0;
			read_delay <= read_delay+1;
			if (read_delay>=READ_DELAY_COUNT) begin
				state     <= STH_READ1;
			end
		end // STH_READ0
		STH_READ1: begin
			FLASH_CE_N  <= #1 1'b1;
			FLASH_OE_N  <= #1 1'b1;
			wb_dat_o[31:24]    <= #1 FLASH_D_I[7:0];
			wb_dat_o[23:16]    <= #1 FLASH_D_I[15:8];
			if(sel_23) begin
				read_delay  <= #1 4'h0;
				wb_ack_o    <= 1'b1;
				state <= STH_READ2;
			end
			else
				state       <= STH_READ_NEXT;
		end // STH_READ2
		STH_READ_NEXT: begin
			FLASH_A       <= #1 { wb_adr_i[22:2],1'b1};
			read_delay  <= #1 4'h0;
			state <= STH_READ_NEXT0;	
		end
		STH_READ_NEXT0: begin
			FLASH_CE_N  <= #1 1'b0;
			FLASH_OE_N  <= #1 1'b0;
			read_delay <= read_delay+1;
			if (read_delay>=READ_DELAY_COUNT) begin
				state     <= STH_READ_NEXT1;
			end
		end // STH_READ_NEXT0
		STH_READ_NEXT1: begin
			FLASH_CE_N  <= #1 1'b1;
			FLASH_OE_N  <= #1 1'b1;
			wb_dat_o[15:8]    <= #1 FLASH_D_I[7:0];
			wb_dat_o[7:0]    <= #1 FLASH_D_I[15:8];
			
			read_delay  <= #1 4'h0;
			wb_ack_o    <= 1'b1;
			state       <= STH_READ2;
		end
		
		STH_READ2: begin
			wb_ack_o    <= 1'b0;
			state       <= STH_IDLE;
		end // STH_READ2
		endcase // state
	end // if (wb_rst_i==1)
end     // always 
// synopsys translate_off
initial begin
	$display("WCLK_PERIOD      =%d"  , WCLK_PERIOD);
	$display("WRITE_DELAY_NS      =%d"  , WRITE_DELAY_NS);
	$display("READ_DELAY_NS       =%d"  , READ_DELAY_NS);
	$display("WRITE_DELAY_COUNT=%d"  , WRITE_DELAY_COUNT);
	$display("READ_DELAY_COUNT =%d"  , READ_DELAY_COUNT);
end
// synopsys translate_on
endmodule
//********************************************************
//
// 2008.08.27: Creator: Ando Ki 
//
// http://www.dynalith.com
// adki@dynalith.com
//*******************************************************
