## Generated SDC file "DE2_OR1200_SOC_top.sdc"

## Copyright (C) 1991-2008 Altera Corporation
## Your use of Altera Corporation's design tools, logic functions 
## and other software and tools, and its AMPP partner logic 
## functions, and any output files from any of the foregoing 
## (including device programming or simulation files), and any 
## associated documentation or information are expressly subject 
## to the terms and conditions of the Altera Program License 
## Subscription Agreement, Altera MegaCore Function License 
## Agreement, or other applicable license agreement, including, 
## without limitation, that your use is for the sole purpose of 
## programming logic devices manufactured by Altera and sold by 
## Altera or its authorized distributors.  Please refer to the 
## applicable agreement for further details.


## VENDOR  "Altera"
## PROGRAM "Quartus II"
## VERSION "Version 8.1 Build 163 10/28/2008 SJ Full Version"

## DATE    "Wed Nov 26 16:18:07 2008"

##
## DEVICE  "EP2C70F896C6"
##


#**************************************************************
# Time Information
#**************************************************************

set_time_format -unit ns -decimal_places 3



#**************************************************************
# Create Clock
#**************************************************************

create_clock -name {clk} -period 20.000 -waveform { 0.000 10.000 } [get_ports {clk}]
create_clock -name {jtag_clk} -period 50.000 -waveform { 0.000 25.000 } [get_ports {jtag_tck}]
create_clock -name {wb_rst} -period 100.000 -waveform { 0.000 50.000 } [get_registers {wb_rst}]


#**************************************************************
# Create Generated Clock
#**************************************************************

create_generated_clock -name {wb_clk} -source [get_ports {clk}] -multiply_by 2 -divide_by 5 -master_clock {clk} [get_nets {pll_inst|altpll_component|_clk0}] 
create_generated_clock -name {mc_clk} -source [get_ports {clk}] -multiply_by 2 -divide_by 5 -master_clock {clk} [get_nets {pll_inst|altpll_component|_clk1}] 


#**************************************************************
# Set Clock Latency
#**************************************************************



#**************************************************************
# Set Clock Uncertainty
#**************************************************************



#**************************************************************
# Set Input Delay
#**************************************************************

set_input_delay -add_delay  -clock [get_clocks {wb_clk}]  5.000 [get_ports {flash_RY}]
set_input_delay -add_delay  -clock [get_clocks {wb_clk}]  3.000 [get_ports {flash_dq[0]}]
set_input_delay -add_delay  -clock [get_clocks {wb_clk}]  5.000 [get_ports {flash_dq[10]}]
set_input_delay -add_delay  -clock [get_clocks {wb_clk}]  5.000 [get_ports {flash_dq[11]}]
set_input_delay -add_delay  -clock [get_clocks {wb_clk}]  5.000 [get_ports {flash_dq[12]}]
set_input_delay -add_delay  -clock [get_clocks {wb_clk}]  5.000 [get_ports {flash_dq[13]}]
set_input_delay -add_delay  -clock [get_clocks {wb_clk}]  5.000 [get_ports {flash_dq[14]}]
set_input_delay -add_delay  -clock [get_clocks {wb_clk}]  5.000 [get_ports {flash_dq[15]}]
set_input_delay -add_delay  -clock [get_clocks {wb_clk}]  5.000 [get_ports {flash_dq[1]}]
set_input_delay -add_delay  -clock [get_clocks {wb_clk}]  5.000 [get_ports {flash_dq[2]}]
set_input_delay -add_delay  -clock [get_clocks {wb_clk}]  5.000 [get_ports {flash_dq[3]}]
set_input_delay -add_delay  -clock [get_clocks {wb_clk}]  5.000 [get_ports {flash_dq[4]}]
set_input_delay -add_delay  -clock [get_clocks {wb_clk}]  5.000 [get_ports {flash_dq[5]}]
set_input_delay -add_delay  -clock [get_clocks {wb_clk}]  5.000 [get_ports {flash_dq[6]}]
set_input_delay -add_delay  -clock [get_clocks {wb_clk}]  5.000 [get_ports {flash_dq[7]}]
set_input_delay -add_delay  -clock [get_clocks {wb_clk}]  5.000 [get_ports {flash_dq[8]}]
set_input_delay -add_delay  -clock [get_clocks {wb_clk}]  5.000 [get_ports {flash_dq[9]}]
set_input_delay -add_delay  -clock [get_clocks {wb_clk}]  5.000 [get_ports {gpio_in[0]}]
set_input_delay -add_delay  -clock [get_clocks {wb_clk}]  5.000 [get_ports {gpio_in[10]}]
set_input_delay -add_delay  -clock [get_clocks {wb_clk}]  5.000 [get_ports {gpio_in[11]}]
set_input_delay -add_delay  -clock [get_clocks {wb_clk}]  5.000 [get_ports {gpio_in[12]}]
set_input_delay -add_delay  -clock [get_clocks {wb_clk}]  5.000 [get_ports {gpio_in[13]}]
set_input_delay -add_delay  -clock [get_clocks {wb_clk}]  5.000 [get_ports {gpio_in[14]}]
set_input_delay -add_delay  -clock [get_clocks {wb_clk}]  5.000 [get_ports {gpio_in[15]}]
set_input_delay -add_delay  -clock [get_clocks {wb_clk}]  5.000 [get_ports {gpio_in[16]}]
set_input_delay -add_delay  -clock [get_clocks {wb_clk}]  5.000 [get_ports {gpio_in[17]}]
set_input_delay -add_delay  -clock [get_clocks {wb_clk}]  5.000 [get_ports {gpio_in[18]}]
set_input_delay -add_delay  -clock [get_clocks {wb_clk}]  5.000 [get_ports {gpio_in[19]}]
set_input_delay -add_delay  -clock [get_clocks {wb_clk}]  5.000 [get_ports {gpio_in[1]}]
set_input_delay -add_delay  -clock [get_clocks {wb_clk}]  5.000 [get_ports {gpio_in[20]}]
set_input_delay -add_delay  -clock [get_clocks {wb_clk}]  5.000 [get_ports {gpio_in[21]}]
set_input_delay -add_delay  -clock [get_clocks {wb_clk}]  5.000 [get_ports {gpio_in[22]}]
set_input_delay -add_delay  -clock [get_clocks {wb_clk}]  5.000 [get_ports {gpio_in[23]}]
set_input_delay -add_delay  -clock [get_clocks {wb_clk}]  5.000 [get_ports {gpio_in[24]}]
set_input_delay -add_delay  -clock [get_clocks {wb_clk}]  5.000 [get_ports {gpio_in[25]}]
set_input_delay -add_delay  -clock [get_clocks {wb_clk}]  5.000 [get_ports {gpio_in[26]}]
set_input_delay -add_delay  -clock [get_clocks {wb_clk}]  5.000 [get_ports {gpio_in[27]}]
set_input_delay -add_delay  -clock [get_clocks {wb_clk}]  5.000 [get_ports {gpio_in[28]}]
set_input_delay -add_delay  -clock [get_clocks {wb_clk}]  5.000 [get_ports {gpio_in[29]}]
set_input_delay -add_delay  -clock [get_clocks {wb_clk}]  5.000 [get_ports {gpio_in[2]}]
set_input_delay -add_delay  -clock [get_clocks {wb_clk}]  5.000 [get_ports {gpio_in[30]}]
set_input_delay -add_delay  -clock [get_clocks {wb_clk}]  5.000 [get_ports {gpio_in[31]}]
set_input_delay -add_delay  -clock [get_clocks {wb_clk}]  5.000 [get_ports {gpio_in[3]}]
set_input_delay -add_delay  -clock [get_clocks {wb_clk}]  5.000 [get_ports {gpio_in[4]}]
set_input_delay -add_delay  -clock [get_clocks {wb_clk}]  5.000 [get_ports {gpio_in[5]}]
set_input_delay -add_delay  -clock [get_clocks {wb_clk}]  5.000 [get_ports {gpio_in[6]}]
set_input_delay -add_delay  -clock [get_clocks {wb_clk}]  5.000 [get_ports {gpio_in[7]}]
set_input_delay -add_delay  -clock [get_clocks {wb_clk}]  5.000 [get_ports {gpio_in[8]}]
set_input_delay -add_delay  -clock [get_clocks {wb_clk}]  5.000 [get_ports {gpio_in[9]}]
set_input_delay -add_delay  -clock [get_clocks {mc_clk}]  5.000 [get_ports {sdram_dq[0]}]
set_input_delay -add_delay  -clock [get_clocks {mc_clk}]  5.000 [get_ports {sdram_dq[10]}]
set_input_delay -add_delay  -clock [get_clocks {mc_clk}]  5.000 [get_ports {sdram_dq[11]}]
set_input_delay -add_delay  -clock [get_clocks {mc_clk}]  5.000 [get_ports {sdram_dq[12]}]
set_input_delay -add_delay  -clock [get_clocks {mc_clk}]  5.000 [get_ports {sdram_dq[13]}]
set_input_delay -add_delay  -clock [get_clocks {mc_clk}]  5.000 [get_ports {sdram_dq[14]}]
set_input_delay -add_delay  -clock [get_clocks {mc_clk}]  5.000 [get_ports {sdram_dq[15]}]
set_input_delay -add_delay  -clock [get_clocks {mc_clk}]  5.000 [get_ports {sdram_dq[16]}]
set_input_delay -add_delay  -clock [get_clocks {mc_clk}]  5.000 [get_ports {sdram_dq[17]}]
set_input_delay -add_delay  -clock [get_clocks {mc_clk}]  5.000 [get_ports {sdram_dq[18]}]
set_input_delay -add_delay  -clock [get_clocks {mc_clk}]  5.000 [get_ports {sdram_dq[19]}]
set_input_delay -add_delay  -clock [get_clocks {mc_clk}]  5.000 [get_ports {sdram_dq[1]}]
set_input_delay -add_delay  -clock [get_clocks {mc_clk}]  5.000 [get_ports {sdram_dq[20]}]
set_input_delay -add_delay  -clock [get_clocks {mc_clk}]  5.000 [get_ports {sdram_dq[21]}]
set_input_delay -add_delay  -clock [get_clocks {mc_clk}]  5.000 [get_ports {sdram_dq[22]}]
set_input_delay -add_delay  -clock [get_clocks {mc_clk}]  5.000 [get_ports {sdram_dq[23]}]
set_input_delay -add_delay  -clock [get_clocks {mc_clk}]  5.000 [get_ports {sdram_dq[24]}]
set_input_delay -add_delay  -clock [get_clocks {mc_clk}]  5.000 [get_ports {sdram_dq[25]}]
set_input_delay -add_delay  -clock [get_clocks {mc_clk}]  5.000 [get_ports {sdram_dq[26]}]
set_input_delay -add_delay  -clock [get_clocks {mc_clk}]  5.000 [get_ports {sdram_dq[27]}]
set_input_delay -add_delay  -clock [get_clocks {mc_clk}]  5.000 [get_ports {sdram_dq[28]}]
set_input_delay -add_delay  -clock [get_clocks {mc_clk}]  5.000 [get_ports {sdram_dq[29]}]
set_input_delay -add_delay  -clock [get_clocks {mc_clk}]  5.000 [get_ports {sdram_dq[2]}]
set_input_delay -add_delay  -clock [get_clocks {mc_clk}]  5.000 [get_ports {sdram_dq[30]}]
set_input_delay -add_delay  -clock [get_clocks {mc_clk}]  5.000 [get_ports {sdram_dq[31]}]
set_input_delay -add_delay  -clock [get_clocks {mc_clk}]  5.000 [get_ports {sdram_dq[3]}]
set_input_delay -add_delay  -clock [get_clocks {mc_clk}]  5.000 [get_ports {sdram_dq[4]}]
set_input_delay -add_delay  -clock [get_clocks {mc_clk}]  5.000 [get_ports {sdram_dq[5]}]
set_input_delay -add_delay  -clock [get_clocks {mc_clk}]  5.000 [get_ports {sdram_dq[6]}]
set_input_delay -add_delay  -clock [get_clocks {mc_clk}]  5.000 [get_ports {sdram_dq[7]}]
set_input_delay -add_delay  -clock [get_clocks {mc_clk}]  5.000 [get_ports {sdram_dq[8]}]
set_input_delay -add_delay  -clock [get_clocks {mc_clk}]  5.000 [get_ports {sdram_dq[9]}]
set_input_delay -add_delay  -clock [get_clocks {wb_clk}]  5.000 [get_ports {uart_srx}]


#**************************************************************
# Set Output Delay
#**************************************************************

set_output_delay -add_delay  -clock [get_clocks {wb_clk}]  10.000 [get_ports {flash_addr[0]}]
set_output_delay -add_delay  -clock [get_clocks {wb_clk}]  10.000 [get_ports {flash_addr[10]}]
set_output_delay -add_delay  -clock [get_clocks {wb_clk}]  10.000 [get_ports {flash_addr[11]}]
set_output_delay -add_delay  -clock [get_clocks {wb_clk}]  10.000 [get_ports {flash_addr[12]}]
set_output_delay -add_delay  -clock [get_clocks {wb_clk}]  10.000 [get_ports {flash_addr[13]}]
set_output_delay -add_delay  -clock [get_clocks {wb_clk}]  10.000 [get_ports {flash_addr[14]}]
set_output_delay -add_delay  -clock [get_clocks {wb_clk}]  10.000 [get_ports {flash_addr[15]}]
set_output_delay -add_delay  -clock [get_clocks {wb_clk}]  10.000 [get_ports {flash_addr[16]}]
set_output_delay -add_delay  -clock [get_clocks {wb_clk}]  10.000 [get_ports {flash_addr[17]}]
set_output_delay -add_delay  -clock [get_clocks {wb_clk}]  10.000 [get_ports {flash_addr[18]}]
set_output_delay -add_delay  -clock [get_clocks {wb_clk}]  10.000 [get_ports {flash_addr[19]}]
set_output_delay -add_delay  -clock [get_clocks {wb_clk}]  10.000 [get_ports {flash_addr[1]}]
set_output_delay -add_delay  -clock [get_clocks {wb_clk}]  10.000 [get_ports {flash_addr[20]}]
set_output_delay -add_delay  -clock [get_clocks {wb_clk}]  10.000 [get_ports {flash_addr[21]}]
set_output_delay -add_delay  -clock [get_clocks {wb_clk}]  10.000 [get_ports {flash_addr[2]}]
set_output_delay -add_delay  -clock [get_clocks {wb_clk}]  10.000 [get_ports {flash_addr[3]}]
set_output_delay -add_delay  -clock [get_clocks {wb_clk}]  10.000 [get_ports {flash_addr[4]}]
set_output_delay -add_delay  -clock [get_clocks {wb_clk}]  10.000 [get_ports {flash_addr[5]}]
set_output_delay -add_delay  -clock [get_clocks {wb_clk}]  10.000 [get_ports {flash_addr[6]}]
set_output_delay -add_delay  -clock [get_clocks {wb_clk}]  10.000 [get_ports {flash_addr[7]}]
set_output_delay -add_delay  -clock [get_clocks {wb_clk}]  10.000 [get_ports {flash_addr[8]}]
set_output_delay -add_delay  -clock [get_clocks {wb_clk}]  10.000 [get_ports {flash_addr[9]}]
set_output_delay -add_delay  -clock [get_clocks {wb_clk}]  10.000 [get_ports {flash_ce_n}]
set_output_delay -add_delay  -clock [get_clocks {wb_clk}]  10.000 [get_ports {flash_dq[0]}]
set_output_delay -add_delay  -clock [get_clocks {wb_clk}]  10.000 [get_ports {flash_dq[10]}]
set_output_delay -add_delay  -clock [get_clocks {wb_clk}]  10.000 [get_ports {flash_dq[11]}]
set_output_delay -add_delay  -clock [get_clocks {wb_clk}]  10.000 [get_ports {flash_dq[12]}]
set_output_delay -add_delay  -clock [get_clocks {wb_clk}]  10.000 [get_ports {flash_dq[13]}]
set_output_delay -add_delay  -clock [get_clocks {wb_clk}]  10.000 [get_ports {flash_dq[14]}]
set_output_delay -add_delay  -clock [get_clocks {wb_clk}]  10.000 [get_ports {flash_dq[15]}]
set_output_delay -add_delay  -clock [get_clocks {wb_clk}]  10.000 [get_ports {flash_dq[1]}]
set_output_delay -add_delay  -clock [get_clocks {wb_clk}]  10.000 [get_ports {flash_dq[2]}]
set_output_delay -add_delay  -clock [get_clocks {wb_clk}]  10.000 [get_ports {flash_dq[3]}]
set_output_delay -add_delay  -clock [get_clocks {wb_clk}]  10.000 [get_ports {flash_dq[4]}]
set_output_delay -add_delay  -clock [get_clocks {wb_clk}]  10.000 [get_ports {flash_dq[5]}]
set_output_delay -add_delay  -clock [get_clocks {wb_clk}]  10.000 [get_ports {flash_dq[6]}]
set_output_delay -add_delay  -clock [get_clocks {wb_clk}]  10.000 [get_ports {flash_dq[7]}]
set_output_delay -add_delay  -clock [get_clocks {wb_clk}]  10.000 [get_ports {flash_dq[8]}]
set_output_delay -add_delay  -clock [get_clocks {wb_clk}]  10.000 [get_ports {flash_dq[9]}]
set_output_delay -add_delay  -clock [get_clocks {wb_clk}]  10.000 [get_ports {flash_oe_n}]
set_output_delay -add_delay  -clock [get_clocks {wb_clk}]  10.000 [get_ports {flash_reset_n}]
set_output_delay -add_delay  -clock [get_clocks {wb_clk}]  10.000 [get_ports {flash_we_n}]
set_output_delay -add_delay  -clock [get_clocks {wb_clk}]  10.000 [get_ports {flash_wp_n}]
set_output_delay -add_delay  -clock [get_clocks {wb_clk}]  10.000 [get_ports {gpio_out[0]}]
set_output_delay -add_delay  -clock [get_clocks {wb_clk}]  10.000 [get_ports {gpio_out[10]}]
set_output_delay -add_delay  -clock [get_clocks {wb_clk}]  10.000 [get_ports {gpio_out[11]}]
set_output_delay -add_delay  -clock [get_clocks {wb_clk}]  10.000 [get_ports {gpio_out[12]}]
set_output_delay -add_delay  -clock [get_clocks {wb_clk}]  10.000 [get_ports {gpio_out[13]}]
set_output_delay -add_delay  -clock [get_clocks {wb_clk}]  10.000 [get_ports {gpio_out[14]}]
set_output_delay -add_delay  -clock [get_clocks {wb_clk}]  10.000 [get_ports {gpio_out[15]}]
set_output_delay -add_delay  -clock [get_clocks {wb_clk}]  10.000 [get_ports {gpio_out[16]}]
set_output_delay -add_delay  -clock [get_clocks {wb_clk}]  10.000 [get_ports {gpio_out[17]}]
set_output_delay -add_delay  -clock [get_clocks {wb_clk}]  10.000 [get_ports {gpio_out[18]}]
set_output_delay -add_delay  -clock [get_clocks {wb_clk}]  10.000 [get_ports {gpio_out[19]}]
set_output_delay -add_delay  -clock [get_clocks {wb_clk}]  10.000 [get_ports {gpio_out[1]}]
set_output_delay -add_delay  -clock [get_clocks {wb_clk}]  10.000 [get_ports {gpio_out[20]}]
set_output_delay -add_delay  -clock [get_clocks {wb_clk}]  10.000 [get_ports {gpio_out[21]}]
set_output_delay -add_delay  -clock [get_clocks {wb_clk}]  10.000 [get_ports {gpio_out[22]}]
set_output_delay -add_delay  -clock [get_clocks {wb_clk}]  10.000 [get_ports {gpio_out[23]}]
set_output_delay -add_delay  -clock [get_clocks {wb_clk}]  10.000 [get_ports {gpio_out[24]}]
set_output_delay -add_delay  -clock [get_clocks {wb_clk}]  10.000 [get_ports {gpio_out[25]}]
set_output_delay -add_delay  -clock [get_clocks {wb_clk}]  10.000 [get_ports {gpio_out[26]}]
set_output_delay -add_delay  -clock [get_clocks {wb_clk}]  10.000 [get_ports {gpio_out[27]}]
set_output_delay -add_delay  -clock [get_clocks {wb_clk}]  10.000 [get_ports {gpio_out[28]}]
set_output_delay -add_delay  -clock [get_clocks {wb_clk}]  10.000 [get_ports {gpio_out[29]}]
set_output_delay -add_delay  -clock [get_clocks {wb_clk}]  10.000 [get_ports {gpio_out[2]}]
set_output_delay -add_delay  -clock [get_clocks {wb_clk}]  10.000 [get_ports {gpio_out[30]}]
set_output_delay -add_delay  -clock [get_clocks {wb_clk}]  10.000 [get_ports {gpio_out[31]}]
set_output_delay -add_delay  -clock [get_clocks {wb_clk}]  10.000 [get_ports {gpio_out[3]}]
set_output_delay -add_delay  -clock [get_clocks {wb_clk}]  10.000 [get_ports {gpio_out[4]}]
set_output_delay -add_delay  -clock [get_clocks {wb_clk}]  10.000 [get_ports {gpio_out[5]}]
set_output_delay -add_delay  -clock [get_clocks {wb_clk}]  10.000 [get_ports {gpio_out[6]}]
set_output_delay -add_delay  -clock [get_clocks {wb_clk}]  10.000 [get_ports {gpio_out[7]}]
set_output_delay -add_delay  -clock [get_clocks {wb_clk}]  10.000 [get_ports {gpio_out[8]}]
set_output_delay -add_delay  -clock [get_clocks {wb_clk}]  10.000 [get_ports {gpio_out[9]}]
set_output_delay -add_delay  -clock [get_clocks {mc_clk}]  10.000 [get_ports {sdram0_addr[0]}]
set_output_delay -add_delay  -clock [get_clocks {mc_clk}]  10.000 [get_ports {sdram0_addr[10]}]
set_output_delay -add_delay  -clock [get_clocks {mc_clk}]  10.000 [get_ports {sdram0_addr[11]}]
set_output_delay -add_delay  -clock [get_clocks {mc_clk}]  10.000 [get_ports {sdram0_addr[12]}]
set_output_delay -add_delay  -clock [get_clocks {mc_clk}]  10.000 [get_ports {sdram0_addr[1]}]
set_output_delay -add_delay  -clock [get_clocks {mc_clk}]  10.000 [get_ports {sdram0_addr[2]}]
set_output_delay -add_delay  -clock [get_clocks {mc_clk}]  10.000 [get_ports {sdram0_addr[3]}]
set_output_delay -add_delay  -clock [get_clocks {mc_clk}]  10.000 [get_ports {sdram0_addr[4]}]
set_output_delay -add_delay  -clock [get_clocks {mc_clk}]  10.000 [get_ports {sdram0_addr[5]}]
set_output_delay -add_delay  -clock [get_clocks {mc_clk}]  10.000 [get_ports {sdram0_addr[6]}]
set_output_delay -add_delay  -clock [get_clocks {mc_clk}]  10.000 [get_ports {sdram0_addr[7]}]
set_output_delay -add_delay  -clock [get_clocks {mc_clk}]  10.000 [get_ports {sdram0_addr[8]}]
set_output_delay -add_delay  -clock [get_clocks {mc_clk}]  10.000 [get_ports {sdram0_addr[9]}]
set_output_delay -add_delay  -clock [get_clocks {mc_clk}]  10.000 [get_ports {sdram0_ba[0]}]
set_output_delay -add_delay  -clock [get_clocks {mc_clk}]  10.000 [get_ports {sdram0_ba[1]}]
set_output_delay -add_delay  -clock [get_clocks {mc_clk}]  10.000 [get_ports {sdram0_cas_n}]
set_output_delay -add_delay  -clock [get_clocks {mc_clk}]  10.000 [get_ports {sdram0_cke}]
set_output_delay -add_delay  -clock [get_clocks {mc_clk}]  10.000 [get_ports {sdram0_clk}]
set_output_delay -add_delay  -clock [get_clocks {mc_clk}]  10.000 [get_ports {sdram0_cs_n}]
set_output_delay -add_delay  -clock [get_clocks {mc_clk}]  10.000 [get_ports {sdram0_dqm[0]}]
set_output_delay -add_delay  -clock [get_clocks {mc_clk}]  10.000 [get_ports {sdram0_dqm[1]}]
set_output_delay -add_delay  -clock [get_clocks {mc_clk}]  10.000 [get_ports {sdram0_ras_n}]
set_output_delay -add_delay  -clock [get_clocks {mc_clk}]  10.000 [get_ports {sdram0_we_n}]
set_output_delay -add_delay  -clock [get_clocks {mc_clk}]  10.000 [get_ports {sdram1_addr[0]}]
set_output_delay -add_delay  -clock [get_clocks {mc_clk}]  10.000 [get_ports {sdram1_addr[10]}]
set_output_delay -add_delay  -clock [get_clocks {mc_clk}]  10.000 [get_ports {sdram1_addr[11]}]
set_output_delay -add_delay  -clock [get_clocks {mc_clk}]  10.000 [get_ports {sdram1_addr[12]}]
set_output_delay -add_delay  -clock [get_clocks {mc_clk}]  10.000 [get_ports {sdram1_addr[1]}]
set_output_delay -add_delay  -clock [get_clocks {mc_clk}]  10.000 [get_ports {sdram1_addr[2]}]
set_output_delay -add_delay  -clock [get_clocks {mc_clk}]  10.000 [get_ports {sdram1_addr[3]}]
set_output_delay -add_delay  -clock [get_clocks {mc_clk}]  10.000 [get_ports {sdram1_addr[4]}]
set_output_delay -add_delay  -clock [get_clocks {mc_clk}]  10.000 [get_ports {sdram1_addr[5]}]
set_output_delay -add_delay  -clock [get_clocks {mc_clk}]  10.000 [get_ports {sdram1_addr[6]}]
set_output_delay -add_delay  -clock [get_clocks {mc_clk}]  10.000 [get_ports {sdram1_addr[7]}]
set_output_delay -add_delay  -clock [get_clocks {mc_clk}]  10.000 [get_ports {sdram1_addr[8]}]
set_output_delay -add_delay  -clock [get_clocks {mc_clk}]  10.000 [get_ports {sdram1_addr[9]}]
set_output_delay -add_delay  -clock [get_clocks {mc_clk}]  10.000 [get_ports {sdram1_ba[0]}]
set_output_delay -add_delay  -clock [get_clocks {mc_clk}]  10.000 [get_ports {sdram1_ba[1]}]
set_output_delay -add_delay  -clock [get_clocks {mc_clk}]  10.000 [get_ports {sdram1_cas_n}]
set_output_delay -add_delay  -clock [get_clocks {mc_clk}]  10.000 [get_ports {sdram1_cke}]
set_output_delay -add_delay  -clock [get_clocks {mc_clk}]  10.000 [get_ports {sdram1_clk}]
set_output_delay -add_delay  -clock [get_clocks {mc_clk}]  10.000 [get_ports {sdram1_cs_n}]
set_output_delay -add_delay  -clock [get_clocks {mc_clk}]  10.000 [get_ports {sdram1_dqm[0]}]
set_output_delay -add_delay  -clock [get_clocks {mc_clk}]  10.000 [get_ports {sdram1_dqm[1]}]
set_output_delay -add_delay  -clock [get_clocks {mc_clk}]  10.000 [get_ports {sdram1_ras_n}]
set_output_delay -add_delay  -clock [get_clocks {mc_clk}]  10.000 [get_ports {sdram1_we_n}]
set_output_delay -add_delay  -clock [get_clocks {mc_clk}]  10.000 [get_ports {sdram_dq[0]}]
set_output_delay -add_delay  -clock [get_clocks {mc_clk}]  10.000 [get_ports {sdram_dq[10]}]
set_output_delay -add_delay  -clock [get_clocks {mc_clk}]  10.000 [get_ports {sdram_dq[11]}]
set_output_delay -add_delay  -clock [get_clocks {mc_clk}]  10.000 [get_ports {sdram_dq[12]}]
set_output_delay -add_delay  -clock [get_clocks {mc_clk}]  10.000 [get_ports {sdram_dq[13]}]
set_output_delay -add_delay  -clock [get_clocks {mc_clk}]  10.000 [get_ports {sdram_dq[14]}]
set_output_delay -add_delay  -clock [get_clocks {mc_clk}]  10.000 [get_ports {sdram_dq[15]}]
set_output_delay -add_delay  -clock [get_clocks {mc_clk}]  10.000 [get_ports {sdram_dq[16]}]
set_output_delay -add_delay  -clock [get_clocks {mc_clk}]  10.000 [get_ports {sdram_dq[17]}]
set_output_delay -add_delay  -clock [get_clocks {mc_clk}]  10.000 [get_ports {sdram_dq[18]}]
set_output_delay -add_delay  -clock [get_clocks {mc_clk}]  10.000 [get_ports {sdram_dq[19]}]
set_output_delay -add_delay  -clock [get_clocks {mc_clk}]  10.000 [get_ports {sdram_dq[1]}]
set_output_delay -add_delay  -clock [get_clocks {mc_clk}]  10.000 [get_ports {sdram_dq[20]}]
set_output_delay -add_delay  -clock [get_clocks {mc_clk}]  10.000 [get_ports {sdram_dq[21]}]
set_output_delay -add_delay  -clock [get_clocks {mc_clk}]  10.000 [get_ports {sdram_dq[22]}]
set_output_delay -add_delay  -clock [get_clocks {mc_clk}]  10.000 [get_ports {sdram_dq[23]}]
set_output_delay -add_delay  -clock [get_clocks {mc_clk}]  10.000 [get_ports {sdram_dq[24]}]
set_output_delay -add_delay  -clock [get_clocks {mc_clk}]  10.000 [get_ports {sdram_dq[25]}]
set_output_delay -add_delay  -clock [get_clocks {mc_clk}]  10.000 [get_ports {sdram_dq[26]}]
set_output_delay -add_delay  -clock [get_clocks {mc_clk}]  10.000 [get_ports {sdram_dq[27]}]
set_output_delay -add_delay  -clock [get_clocks {mc_clk}]  10.000 [get_ports {sdram_dq[28]}]
set_output_delay -add_delay  -clock [get_clocks {mc_clk}]  10.000 [get_ports {sdram_dq[29]}]
set_output_delay -add_delay  -clock [get_clocks {mc_clk}]  10.000 [get_ports {sdram_dq[2]}]
set_output_delay -add_delay  -clock [get_clocks {mc_clk}]  10.000 [get_ports {sdram_dq[30]}]
set_output_delay -add_delay  -clock [get_clocks {mc_clk}]  10.000 [get_ports {sdram_dq[31]}]
set_output_delay -add_delay  -clock [get_clocks {mc_clk}]  10.000 [get_ports {sdram_dq[3]}]
set_output_delay -add_delay  -clock [get_clocks {mc_clk}]  10.000 [get_ports {sdram_dq[4]}]
set_output_delay -add_delay  -clock [get_clocks {mc_clk}]  10.000 [get_ports {sdram_dq[5]}]
set_output_delay -add_delay  -clock [get_clocks {mc_clk}]  10.000 [get_ports {sdram_dq[6]}]
set_output_delay -add_delay  -clock [get_clocks {mc_clk}]  10.000 [get_ports {sdram_dq[7]}]
set_output_delay -add_delay  -clock [get_clocks {mc_clk}]  10.000 [get_ports {sdram_dq[8]}]
set_output_delay -add_delay  -clock [get_clocks {mc_clk}]  10.000 [get_ports {sdram_dq[9]}]
set_output_delay -add_delay  -clock [get_clocks {wb_clk}]  10.000 [get_ports {uart_stx}]


#**************************************************************
# Set Clock Groups
#**************************************************************



#**************************************************************
# Set False Path
#**************************************************************

set_false_path  -from  [get_clocks {wb_clk}]  -to  [get_clocks {jtag_clk}]
set_false_path  -from  [get_clocks {jtag_clk}]  -to  [get_clocks {wb_clk}]
set_false_path  -from  [get_clocks {clk}]  -to  [get_clocks {wb_clk}]
set_false_path  -from  [get_clocks {wb_clk}]  -to  [get_clocks {clk}]
set_false_path  -from  [get_clocks {clk}]  -to  [get_clocks {jtag_clk}]
set_false_path  -from  [get_clocks {jtag_clk}]  -to  [get_clocks {clk}]
set_false_path  -from  [get_clocks {mc_clk}]  -to  [get_clocks {clk jtag_clk wb_clk}]
set_false_path  -from  [get_clocks {clk jtag_clk wb_clk}]  -to  [get_clocks {mc_clk}]
set_false_path  -from  [get_clocks {wb_rst}]  -to  [get_clocks *]
set_false_path  -from  [get_clocks *]  -to  [get_clocks {wb_rst}]
set_false_path -from [get_ports {rst_n}] 
set_false_path -from [get_registers {wb_rst}] 


#**************************************************************
# Set Multicycle Path
#**************************************************************



#**************************************************************
# Set Maximum Delay
#**************************************************************



#**************************************************************
# Set Minimum Delay
#**************************************************************



#**************************************************************
# Set Input Transition
#**************************************************************

