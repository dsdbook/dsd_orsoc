/*
 * Copyright 2008 Freescale Semiconductor, Inc.
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * Version 2 as published by the Free Software Foundation.
 */

#include <common.h>
#include <asm/fsl_ddr_sdram.h>

#include "ddr.h"

/*
 * compute_lowest_common_dimm_parameters()
 *
 * Determine the worst-case DIMM timing parameters from the set of DIMMs
 * whose parameters have been computed into the array pointed to
 * by dimm_params.
 */
unsigned int
compute_lowest_common_dimm_parameters(const dimm_params_t *dimm_params,
				      common_timing_params_t *outpdimm,
				      unsigned int number_of_dimms)
{
	unsigned int i;

	unsigned int tCKmin_X_ps = 0;
	unsigned int tCKmax_ps = 0xFFFFFFFF;
	unsigned int tCKmax_max_ps = 0;
	unsigned int tRCD_ps = 0;
	unsigned int tRP_ps = 0;
	unsigned int tRAS_ps = 0;
	unsigned int tWR_ps = 0;
	unsigned int tWTR_ps = 0;
	unsigned int tRFC_ps = 0;
	unsigned int tRRD_ps = 0;
	unsigned int tRC_ps = 0;
	unsigned int refresh_rate_ps = 0;
	unsigned int tIS_ps = 0;
	unsigned int tIH_ps = 0;
	unsigned int tDS_ps = 0;
	unsigned int tDH_ps = 0;
	unsigned int tRTP_ps = 0;
	unsigned int tDQSQ_max_ps = 0;
	unsigned int tQHS_ps = 0;

	unsigned int temp1, temp2;
	unsigned int lowest_good_caslat;
	unsigned int additive_latency = 0;
	const unsigned int mclk_ps = get_memory_clk_period_ps();
	unsigned int not_ok;

	debug("using mclk_ps = %u\n", mclk_ps);

	temp1 = 0;
	for (i = 0; i < number_of_dimms; i++) {
		/*
		 * If there are no ranks on this DIMM,
		 * it probably doesn't exist, so skip it.
		 */
		if (dimm_params[i].n_ranks == 0) {
			temp1++;
			continue;
		}

		/*
		 * Find minimum tCKmax_ps to find fastest slow speed,
		 * i.e., this is the slowest the whole system can go.
		 */
		tCKmax_ps = min(tCKmax_ps, dimm_params[i].tCKmax_ps);

		/* Either find maximum value to determine slowest
		 * speed, delay, time, period, etc */
		tCKmin_X_ps = max(tCKmin_X_ps, dimm_params[i].tCKmin_X_ps);
		tCKmax_max_ps = max(tCKmax_max_ps, dimm_params[i].tCKmax_ps);
		tRCD_ps = max(tRCD_ps, dimm_params[i].tRCD_ps);
		tRP_ps = max(tRP_ps, dimm_params[i].tRP_ps);
		tRAS_ps = max(tRAS_ps, dimm_params[i].tRAS_ps);
		tWR_ps = max(tWR_ps, dimm_params[i].tWR_ps);
		tWTR_ps = max(tWTR_ps, dimm_params[i].tWTR_ps);
		tRFC_ps = max(tRFC_ps, dimm_params[i].tRFC_ps);
		tRRD_ps = max(tRRD_ps, dimm_params[i].tRRD_ps);
		tRC_ps = max(tRC_ps, dimm_params[i].tRC_ps);
		tIS_ps = max(tIS_ps, dimm_params[i].tIS_ps);
		tIH_ps = max(tIH_ps, dimm_params[i].tIH_ps);
		tDS_ps = max(tDS_ps, dimm_params[i].tDS_ps);
		tDH_ps = max(tDH_ps, dimm_params[i].tDH_ps);
		tRTP_ps = max(tRTP_ps, dimm_params[i].tRTP_ps);
		tQHS_ps = max(tQHS_ps, dimm_params[i].tQHS_ps);
		refresh_rate_ps = max(refresh_rate_ps,
				      dimm_params[i].refresh_rate_ps);

		/*
		 * Find maximum tDQSQ_max_ps to find slowest.
		 *
		 * FIXME: is finding the slowest value the correct
		 * strategy for this parameter?
		 */
		tDQSQ_max_ps = max(tDQSQ_max_ps, dimm_params[i].tDQSQ_max_ps);
	}

	outpdimm->ndimms_present = number_of_dimms - temp1;

	if (temp1 == number_of_dimms) {
		debug("no dimms this memory controller\n");
		return 0;
	}

	outpdimm->tCKmin_X_ps = tCKmin_X_ps;
	outpdimm->tCKmax_ps = tCKmax_ps;
	outpdimm->tCKmax_max_ps = tCKmax_max_ps;
	outpdimm->tRCD_ps = tRCD_ps;
	outpdimm->tRP_ps = tRP_ps;
	outpdimm->tRAS_ps = tRAS_ps;
	outpdimm->tWR_ps = tWR_ps;
	outpdimm->tWTR_ps = tWTR_ps;
	outpdimm->tRFC_ps = tRFC_ps;
	outpdimm->tRRD_ps = tRRD_ps;
	outpdimm->tRC_ps = tRC_ps;
	outpdimm->refresh_rate_ps = refresh_rate_ps;
	outpdimm->tIS_ps = tIS_ps;
	outpdimm->tIH_ps = tIH_ps;
	outpdimm->tDS_ps = tDS_ps;
	outpdimm->tDH_ps = tDH_ps;
	outpdimm->tRTP_ps = tRTP_ps;
	outpdimm->tDQSQ_max_ps = tDQSQ_max_ps;
	outpdimm->tQHS_ps = tQHS_ps;

	/* Determine common burst length for all DIMMs. */
	temp1 = 0xff;
	for (i = 0; i < number_of_dimms; i++) {
		if (dimm_params[i].n_ranks) {
			temp1 &= dimm_params[i].burst_lengths_bitmask;
		}
	}
	outpdimm->all_DIMMs_burst_lengths_bitmask = temp1;

	/* Determine if all DIMMs registered buffered. */
	temp1 = temp2 = 0;
	for (i = 0; i < number_of_dimms; i++) {
		if (dimm_params[i].n_ranks) {
			if (dimm_params[i].registered_dimm)
				temp1 = 1;
			if (!dimm_params[i].registered_dimm)
				temp2 = 1;
		}
	}

	outpdimm->all_DIMMs_registered = 0;
	if (temp1 && !temp2) {
		outpdimm->all_DIMMs_registered = 1;
	}

	outpdimm->all_DIMMs_unbuffered = 0;
	if (!temp1 && temp2) {
		outpdimm->all_DIMMs_unbuffered = 1;
	}

	/* CHECKME: */
	if (!outpdimm->all_DIMMs_registered
	    && !outpdimm->all_DIMMs_unbuffered) {
		printf("ERROR:  Mix of registered buffered and unbuffered "
				"DIMMs detected!\n");
	}

	/*
	 * Compute a CAS latency suitable for all DIMMs
	 *
	 * Strategy for SPD-defined latencies: compute only
	 * CAS latency defined by all DIMMs.
	 */

	/*
	 * Step 1: find CAS latency common to all DIMMs using bitwise
	 * operation.
	 */
	temp1 = 0xFF;
	for (i = 0; i < number_of_dimms; i++) {
		if (dimm_params[i].n_ranks) {
			temp2 = 0;
			temp2 |= 1 << dimm_params[i].caslat_X;
			temp2 |= 1 << dimm_params[i].caslat_X_minus_1;
			temp2 |= 1 << dimm_params[i].caslat_X_minus_2;
			/*
			 * FIXME: If there was no entry for X-2 (X-1) in
			 * the SPD, then caslat_X_minus_2
			 * (caslat_X_minus_1) contains either 255 or
			 * 0xFFFFFFFF because that's what the glorious
			 * __ilog2 function returns for an input of 0.
			 * On 32-bit PowerPC, left shift counts with bit
			 * 26 set (that the value of 255 or 0xFFFFFFFF
			 * will have), cause the destination register to
			 * be 0.  That is why this works.
			 */
			temp1 &= temp2;
		}
	}

	/*
	 * Step 2: check each common CAS latency against tCK of each
	 * DIMM's SPD.
	 */
	lowest_good_caslat = 0;
	temp2 = 0;
	while (temp1) {
		not_ok = 0;
		temp2 =  __ilog2(temp1);
		debug("checking common caslat = %u\n", temp2);

		/* Check if this CAS latency will work on all DIMMs at tCK. */
		for (i = 0; i < number_of_dimms; i++) {
			if (!dimm_params[i].n_ranks) {
				continue;
			}
			if (dimm_params[i].caslat_X == temp2) {
				if (mclk_ps >= dimm_params[i].tCKmin_X_ps) {
					debug("CL = %u ok on DIMM %u at tCK=%u"
					    " ps with its tCKmin_X_ps of %u\n",
					       temp2, i, mclk_ps,
					       dimm_params[i].tCKmin_X_ps);
					continue;
				} else {
					not_ok++;
				}
			}

			if (dimm_params[i].caslat_X_minus_1 == temp2) {
				unsigned int tCKmin_X_minus_1_ps
					= dimm_params[i].tCKmin_X_minus_1_ps;
				if (mclk_ps >= tCKmin_X_minus_1_ps) {
					debug("CL = %u ok on DIMM %u at "
						"tCK=%u ps with its "
						"tCKmin_X_minus_1_ps of %u\n",
					       temp2, i, mclk_ps,
					       tCKmin_X_minus_1_ps);
					continue;
				} else {
					not_ok++;
				}
			}

			if (dimm_params[i].caslat_X_minus_2 == temp2) {
				unsigned int tCKmin_X_minus_2_ps
					= dimm_params[i].tCKmin_X_minus_2_ps;
				if (mclk_ps >= tCKmin_X_minus_2_ps) {
					debug("CL = %u ok on DIMM %u at "
						"tCK=%u ps with its "
						"tCKmin_X_minus_2_ps of %u\n",
					       temp2, i, mclk_ps,
					       tCKmin_X_minus_2_ps);
					continue;
				} else {
					not_ok++;
				}
			}
		}

		if (!not_ok) {
			lowest_good_caslat = temp2;
		}

		temp1 &= ~(1 << temp2);
	}

	debug("lowest common SPD-defined CAS latency = %u\n",
	       lowest_good_caslat);
	outpdimm->lowest_common_SPD_caslat = lowest_good_caslat;


	/*
	 * Compute a common 'de-rated' CAS latency.
	 *
	 * The strategy here is to find the *highest* dereated cas latency
	 * with the assumption that all of the DIMMs will support a dereated
	 * CAS latency higher than or equal to their lowest dereated value.
	 */
	temp1 = 0;
	for (i = 0; i < number_of_dimms; i++) {
		temp1 = max(temp1, dimm_params[i].caslat_lowest_derated);
	}
	outpdimm->highest_common_derated_caslat = temp1;
	debug("highest common dereated CAS latency = %u\n", temp1);

	/* Determine if all DIMMs ECC capable. */
	temp1 = 1;
	for (i = 0; i < number_of_dimms; i++) {
		if (dimm_params[i].n_ranks && dimm_params[i].edc_config != 2) {
			temp1 = 0;
			break;
		}
	}
	if (temp1) {
		debug("all DIMMs ECC capable\n");
	} else {
		debug("Warning: not all DIMMs ECC capable, cant enable ECC\n");
	}
	outpdimm->all_DIMMs_ECC_capable = temp1;


	/* FIXME: move to somewhere else to validate. */
	if (mclk_ps > tCKmax_max_ps) {
		printf("Warning: some of the installed DIMMs "
				"can not operate this slowly.\n");
		return 1;
	}

	/*
	 * Compute additive latency.
	 *
	 * For DDR1, additive latency should be 0.
	 *
	 * For DDR2, with ODT enabled, use "a value" less than ACTTORW,
	 *	which comes from Trcd, and also note that:
	 *	    add_lat + caslat must be >= 4
	 *
	 * For DDR3, FIXME additive latency determination
	 *
	 * When to use additive latency for DDR2:
	 *
	 * I. Because you are using CL=3 and need to do ODT on writes and
	 *    want functionality.
	 *    1. Are you going to use ODT? (Does your board not have
	 *      additional termination circuitry for DQ, DQS, DQS_,
	 *      DM, RDQS, RDQS_ for x4/x8 configs?)
	 *    2. If so, is your lowest supported CL going to be 3?
	 *    3. If so, then you must set AL=1 because
	 *
	 *       WL >= 3 for ODT on writes
	 *       RL = AL + CL
	 *       WL = RL - 1
	 *       ->
	 *       WL = AL + CL - 1
	 *       AL + CL - 1 >= 3
	 *       AL + CL >= 4
	 *  QED
	 *
	 *  RL >= 3 for ODT on reads
	 *  RL = AL + CL
	 *
	 *  Since CL aren't usually less than 2, AL=0 is a minimum,
	 *  so the WL-derived AL should be the  -- FIXME?
	 *
	 * II. Because you are using auto-precharge globally and want to
	 *     use additive latency (posted CAS) to get more bandwidth.
	 *     1. Are you going to use auto-precharge mode globally?
	 *
	 *        Use addtivie latency and compute AL to be 1 cycle less than
	 *        tRCD, i.e. the READ or WRITE command is in the cycle
	 *        immediately following the ACTIVATE command..
	 *
	 * III. Because you feel like it or want to do some sort of
	 *      degraded-performance experiment.
	 *     1.  Do you just want to use additive latency because you feel
	 *         like it?
	 *
	 * Validation:  AL is less than tRCD, and within the other
	 * read-to-precharge constraints.
	 */

	additive_latency = 0;

#if defined(CONFIG_FSL_DDR2)
	if (lowest_good_caslat < 4) {
		additive_latency = picos_to_mclk(tRCD_ps) - lowest_good_caslat;
		if (mclk_to_picos(additive_latency) > tRCD_ps) {
			additive_latency = picos_to_mclk(tRCD_ps);
			debug("setting additive_latency to %u because it was "
				" greater than tRCD_ps\n", additive_latency);
		}
	}

#elif defined(CONFIG_FSL_DDR3)
error "FIXME determine additive latency for DDR3"
#endif

	/*
	 * Validate additive latency
	 * FIXME: move to somewhere else to validate
	 *
	 * AL <= tRCD(min)
	 */
	if (mclk_to_picos(additive_latency) > tRCD_ps) {
		printf("Error: invalid additive latency exceeds tRCD(min).\n");
		return 1;
	}

	/*
	 * RL = CL + AL;  RL >= 3 for ODT_RD_CFG to be enabled
	 * WL = RL - 1;  WL >= 3 for ODT_WL_CFG to be enabled
	 * ADD_LAT (the register) must be set to a value less
	 * than ACTTORW if WL = 1, then AL must be set to 1
	 * RD_TO_PRE (the register) must be set to a minimum
	 * tRTP + AL if AL is nonzero
	 */

	/*
	 * Additive latency will be applied only if the memctl option to
	 * use it.
	 */
	outpdimm->additive_latency = additive_latency;

	return 0;
}
