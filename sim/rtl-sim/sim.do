#add wave -radix hex -recursive /or1200_soc_tb/i_or1200_soc_top/*
#add wave -radix hex -recursive /or1200_soc_tb/i_or1200_soc_top/or1200_soc_top_inst/or1200_top_inst/or1200_cpu/or1200_rf/rf_a/r*
#add wave -radix hex /or1200_soc_tb/i_or1200_soc_top/dbg_top_inst/*
#add wave -radix hex /or1200_soc_tb/i_or1200_soc_top/or1200_soc_top_inst/*
#add wave -radix hex /or1200_soc_tb/*
run -all
