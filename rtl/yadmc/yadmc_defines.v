/*******************************************************/
/* USER CONFIGURATION                                  */
/*******************************************************/

/*
 * Uncomment this if the SDRAM clock is not the system clock.
 * The low-level part has been made simple in order to
 * reach high clock speeds (and cope with DRAM latencies).
 * When uncommented, no frequency or phase relationship is required
 * between the SDRAM and the system clocks, and you can (and should)
 * run the SDRAM at a higher frequency than the system.
 */
`define SDRAM_ASYNCHRONOUS

