//////////////////////////////////////////////////////////////////////////////
//  File name : mt47h16m16.v
//////////////////////////////////////////////////////////////////////////////
//  Copyright (C) 2007 Free Model Foundry; http://www.FreeModelFoundry.com
//
//  This program is free software; you can redistribute it and/or modify
//  it under the terms of the GNU General Public License version 2 as
//  published by the Free Software Foundation.
//
//  MODIFICATION HISTORY :
//
//  version: | author:     | mod date:  | changes made:
//    V1.0    D.Beatovic     07 Jul 11    Initial release
//
//////////////////////////////////////////////////////////////////////////////
//  PART DESCRIPTION:
//
//  Library:        RAM
//  Technology:     CMOS
//  Part:           mt47h16m16
//
//  Description:    256Mb (4 Meg x 16 x 4 banks) DDR2 SDRAM
//
//////////////////////////////////////////////////////////////////////////////
//  Comments :
//      For correct simulation, simulator resolution should be set to 1ps
//
//////////////////////////////////////////////////////////////////////////////
//  Known Bugs:
//
//////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////
// MODULE DECLARATION                                                       //
//////////////////////////////////////////////////////////////////////////////
`timescale 1 ps/1 ps

module mt47h16m16
(
	BA1,
	BA0,
	
	A12,
	A11,
	A10,
	A9,
	A8,
	A7,
	A6,
	A5,
	A4,
	A3,
	A2,
	A1,
	A0,
	
	DQ15,
	DQ14,
	DQ13,
	DQ12,
	DQ11,
	DQ10,
	DQ9,
	DQ8,
	DQ7,
	DQ6,
	DQ5,
	DQ4,
	DQ3,
	DQ2,
	DQ1,
	DQ0,
	
	ODT,
	CK,
	CKNeg,
	CKE,
	CSNeg,
	RASNeg,
	CASNeg,
	WENeg,
	LDM,
	UDM,
	
	UDQS,
	UDQSNeg,
	LDQS,
	LDQSNeg
);

////////////////////////////////////////////////////////////////////////
// Port / Part Pin Declarations
////////////////////////////////////////////////////////////////////////
input   BA1;
input   BA0;

input   A12;
input   A11;
input   A10;
input   A9;
input   A8;
input   A7;
input   A6;
input   A5;
input   A4;
input   A3;
input   A2;
input   A1;
input   A0;

inout   DQ15;
inout   DQ14;
inout   DQ13;
inout   DQ12;
inout   DQ11;
inout   DQ10;
inout   DQ9 ;
inout   DQ8 ;
inout   DQ7 ;
inout   DQ6 ;
inout   DQ5 ;
inout   DQ4 ;
inout   DQ3 ;
inout   DQ2 ;
inout   DQ1 ;
inout   DQ0 ;

input   ODT;
input   CK;
input   CKNeg;
input   CKE;
input   CSNeg;
input   RASNeg;
input   CASNeg;
input   WENeg;
input   UDM;
input   LDM;

inout   UDQS;
inout   UDQSNeg;
inout   LDQS;
inout   LDQSNeg;

// interconnect path delay signals
wire    BA1_ipd;
wire    BA0_ipd;

wire    A12_ipd;
wire    A11_ipd;
wire    A10_ipd;
wire    A9_ipd;
wire    A8_ipd;
wire    A7_ipd;
wire    A6_ipd;
wire    A5_ipd;
wire    A4_ipd;
wire    A3_ipd;
wire    A2_ipd;
wire    A1_ipd;
wire    A0_ipd;

wire    DQ15_ipd;
wire    DQ14_ipd;
wire    DQ13_ipd;
wire    DQ12_ipd;
wire    DQ10_ipd;
wire    DQ11_ipd;
wire    DQ9_ipd;
wire    DQ8_ipd;
wire    DQ7_ipd;
wire    DQ6_ipd;
wire    DQ5_ipd;
wire    DQ4_ipd;
wire    DQ3_ipd;
wire    DQ2_ipd;
wire    DQ1_ipd;
wire    DQ0_ipd;

wire    ODT_ipd;
wire    CK_ipd;
wire    CKNeg_ipd;
wire    CKE_ipd;
wire    CSNeg_ipd ;
wire    RASNeg_ipd;
wire    CASNeg_ipd;
wire    WENeg_ipd;
wire    LDM_ipd;
wire    UDM_ipd;

wire    UDQS_ipd;
wire    UDQSNeg_ipd;
wire    LDQS_ipd;
wire    LDQSNeg_ipd;

wire    [1 : 0] BA;
assign  BA =  {BA1_ipd,
	BA0_ipd };

wire    [12 : 0] A;
assign  A  =  {A12_ipd,
	A11_ipd,
	A10_ipd,
	A9_ipd,
	A8_ipd,
	A7_ipd,
	A6_ipd,
	A5_ipd,
	A4_ipd,
	A3_ipd,
	A2_ipd,
	A1_ipd,
	A0_ipd };

wire    [15 : 0 ] DIn;
assign  DIn  =  {DQ15_ipd,
	DQ14_ipd,
	DQ13_ipd,
	DQ12_ipd,
	DQ11_ipd,
	DQ10_ipd,
	DQ9_ipd,
	DQ8_ipd,
	DQ7_ipd,
	DQ6_ipd,
	DQ5_ipd,
	DQ4_ipd,
	DQ3_ipd,
	DQ2_ipd,
	DQ1_ipd,
	DQ0_ipd };

wire    [15 : 0 ] DOut;
assign  DOut =  {DQ15,
	DQ14,
	DQ13,
	DQ12,
	DQ11,
	DQ10,
	DQ9,
	DQ8,
	DQ7,
	DQ6,
	DQ5,
	DQ4,
	DQ3,
	DQ2,
	DQ1,
	DQ0 };

wire    UDQSIn;
assign  UDQSIn =  UDQS_ipd;
wire    UDQSOut;
assign  UDQSOut  =  UDQS;
wire    UDQSNegIn;
assign  UDQSNegIn  =  UDQSNeg_ipd;
wire    UDQSNegOut;
assign  UDQSNegOut =  UDQSNeg;

wire    LDQSIn;
assign  LDQSIn =  LDQS_ipd;
wire    LDQSOut;
assign  LDQSOut  =  LDQS;
wire    LDQSNegIn;
assign  LDQSNegIn  =  LDQSNeg_ipd;
wire    LDQSNegOut;
assign  LDQSNegOut =  LDQSNeg;

reg     [3 : 0] tRC_out;        // ACTIVE-to-ACTIVE same bank
reg     [3 : 0] tRC_in;
reg     tRRD_out;               // ACTIVE bank a to ACTIVE bank b
reg     tRRD_in;
reg     [3 : 0] tRCD_out;       // ACTIVE-to-READ or WRITE
reg     [3 : 0] tRCD_in;
reg     [3 : 0] tFAW_out;       // four bank activate period
reg     [3 : 0] tFAW_in;
reg     [3 : 0] tRASMIN_out;    // ACTIVE-to-PRECHARGE minimum period
reg     [3 : 0] tRASMIN_in;
reg     [3 : 0] tRASMAX_out;    // ACTIVE-to-PRECHARGE maximum period
reg     [3 : 0] tRASMAX_in;
reg     [3 : 0] tRTP_out;       // Internal READ-to-PRECHARGE
reg     [3 : 0] tRTP_in;
reg     [3 : 0] tWR_out;        // WRITE Recovery time
reg     [3 : 0] tWR_in;
reg     [3 : 0] tWTR_out;       // Internal WRITE-to-READ
reg     [3 : 0] tWTR_in;
reg     [3 : 0] tRP_out;        // PRECHARGE command period
reg     [3 : 0] tRP_in;
reg     tRFCMIN_out;            // REFRESH-to-ACTIVE or REFRESH-to-REFRESH
reg     tRFCMIN_in;
reg     tRFCMAX_out;            // REFRESH-to-ACTIVE or REFRESH-to-REFRESH
reg     tRFCMAX_in;
reg     tXSNR_out;              // exit self refresh to non-READ command
reg     tXSNR_in;
reg     REFPer_out;             // REFRESH period
reg     REFPer_in;
reg     tCKAVGMAX_out;          // maximum clock cycle time
reg     tCKAVGMAX_in;
reg     tWPSTMAX_out;           // DQS WRITE postamble maximum delay
reg     tWPSTMAX_in;

reg     [15 : 0] DOut_zd =  16'bz;
assign  {DQ15_zd,
	DQ14_zd,
	DQ13_zd,
	DQ12_zd,
	DQ11_zd,
	DQ10_zd,
	DQ9_zd,
	DQ8_zd,
	DQ7_zd,
	DQ6_zd,
	DQ5_zd,
	DQ4_zd,
	DQ3_zd,
	DQ2_zd,
	DQ1_zd,
	DQ0_zd  }  =  DOut_zd;

reg     UDQS_zd  =  1'bz;
reg     UDQSNeg_zd =  1'bz;
reg     LDQS_zd    =  1'bz;
reg     LDQSNeg_zd =  1'bz;

parameter mem_file_name  =  "mt47h16m16.mem";
parameter UserPreload    =  1'b1;

parameter TimingModel    =  "defaulttimingmodel";

parameter PartID   =  "mt47h16m16";
parameter MaxData  =  8'hFF;
parameter MemSize  =  22'h3FFFFF;
parameter BankNum  =  3;
parameter RowNum   =  13'h1FFF;
parameter ColNum   =  9'h1FF;
parameter HiAddrBit  =  12;

integer TScal  =  1000;

//varaibles to resolve timing model used
reg     [20*8-1:0] tmp_timing;  //stores copy of TimingModel
reg     [7:0] char [5:0];
integer found  =  1'b0;
integer pos;
integer PD_del; //used to determine tXARDS delay

// powerup
reg     PoweredUp  =  1'b0;
reg     CK_stable  =  1'b0;

//differential inputs
reg     CKDiff =  1'bz ;
reg     CKDiff1  =  1'bz;
reg     LDQSDiff =  1'bz ;
reg     UDQSDiff =  1'bz ;

// DLL implementation
time CKPeriod    =  3000;
time CKHalfPer   =  0;
time CKDLLDelay  =  0;
integer DLL_TIME;
reg     CKInt    =  1'b0;
reg     CKtemp   =  1'b1;

// Skew check between DQS signals and clock
time CKDiff_rise =  0;
time LDQSDiff_rise =  0;
time LDQSIn_rise   =  0;
time UDQSDiff_rise =  0;
time UDQSIn_rise   =  0;
time CK_LDQS_time  =  0;
time CK_UDQS_time  =  0;
integer SKEW_TIME;

reg     In_d =  1'b0;   //delay before first precharge all
reg     Init_delay =  1'b0;     //command during initialization
reg     Initialized  =  1'b0;   //initialization completed
reg     DLL_delay    =  1'b0;   //DLL delay
reg     DLL_delay_elapsed  =  1'b0; //reset and read command
reg     In_data  =  1'b0;   //start of write operation
reg     preamble_gen =  1'bz;   //preamble before read operation
reg     Out_data =  1'bz;       //start of read operation

//burst sequences
integer Seq[0 : 63];
integer Inl[0 : 63];

//memory definition
integer Mem_Hi[0:  (BankNum+1)*(MemSize+1)-1];
integer Mem_Lo[0:  (BankNum+1)*(MemSize+1)-1];

//mode registers
reg     [12 : 0] MR  =  13'b0;
reg     [12 : 0] EMR =  13'b0;
reg     [12 : 0] EMR2  =  13'b0;
reg     [12 : 0] EMR3  =  13'b0;

integer burst_len ;     //burst length
integer add_lat  =  0 ; //additive latency
integer cas_lat  =  0 ; //CAS# latency
integer wr_rec ;        //write recovery
reg     active_forbid  =  1'b0; //more than 4 active commands during tFAW

//bank, row and column addresses of scheduled read or write operation
integer current_bank ;
integer current_row ;
integer current_column ;
integer WAddr;
integer RAddr;

//latencies of scheduled read and write operations
integer AL[0:      (BankNum+1)*11 - 1];
integer CL[0:      (BankNum+1)*11 - 1];

//all scheduled reads within all banks
reg     [10 : 0] read_sch [BankNum : 0] ;
//reads that should be preceeded by preamble
reg     [10 : 0] preamble [BankNum : 0] ;

//wait_read triggers process that counts remaining cycles to the
//beggining of scheduled read when aditive latency has elapsed, and
//read_delay keeps information of number of remaining cycles
reg     [10 : 0] wait_read [BankNum : 0] ;
integer read_delay =  0;

//needed for check if all rows were refreshed during refresh period
reg     Ref_per_start  =  1'b0;
reg     Ref_per_expired  =  1'b0;
integer Ref_cnt  =  0;

time CK_rise =  0;
time CK_period =  0;
time previous  =  0;
time tmpper    =  0;

reg     SR_cond  =  1'b0;       //self refresh can be entered
reg     SelfRefresh  =  1'b0;   //self refresh active
reg     SR_exit  =  1'b0;       //CKE high, self refresh exit
reg     SR_enter_cycle =  1'b0; //clock can be turned off

reg     Pre_PD =  1'b0;         //precharge power down active
reg     Act_PD =  1'b0;         //active power down active
reg     Read_Start =  1'b0;     //read burst in progress,
reg     ReadStart  =  1'b0;     //no pd entry

reg     Reset  =  1'b0; //reset function active
reg     Reset_enter_cycle  =  1'b0; //clocks can be turned off

reg     SimulationEnd  =  1'b0;
reg     preamble_check =  1'b0;
reg     postamble_check  =  1'b0;
reg     skew_check =  1'b0;
reg     prechall_viol  =  1'b0;     //command other than NOP or DES issued
//tRPA after precharge all
reg     idle =  1'b0;   //all banks idle state
integer active_row[0:BankNum];  //activated rows
//starting columns of scheduled read or write operations
integer start_column[0:(BankNum+1)*11 - 1];
//needed when multiple reads or writes scheduled in same bank
integer free_slot;
//all scheduled writes within all banks
reg     [10 : 0] write_sch [BankNum : 0] ;
//elapsed aditive latencies of scheduled reads
reg     [10 : 0] AL_elapsed [BankNum : 0] ;
//needed for verification of durations measured since end of write burst
reg     [BankNum : 0] last_write =  0;
//programmed write latency elapsed since end of write burst
reg     [BankNum : 0] WR_elapsed =  8'b11111111;
//2 cycles elapsed since end of write burst
reg     [BankNum : 0] WTR_elapsed  =  8'b11111111;
//AL + BL/2 elapsed since read command
reg     [BankNum : 0] RTP_elapsed  =  8'b11111111;
//cycles elapsed since read or write command before precharge command
integer precharge_cnt[0 : BankNum];
//cycles elapsed since write command before end of write burst
integer wr_rd_cnt[0 : BankNum];
//cycles elapsed since read command before bank returns to active state
integer rd_act_cnt[0 : BankNum];
//cycles elapsed since read command before write command
integer rd_wr_cnt;
//BL/2 + 2 cycles elapsed since read command
reg     RTW_elapsed  =  1'b1;
//cycles elapsed since write command before another write command
integer wr_wr_cnt;
//cycles elapsed since read command before another read command
integer rd_rd_cnt;

reg     read_permit  =  1'b0 ;  //read command accepted
reg     write_permit =  1'b0;   //write command accepted

reg     defined_logic_levels =  1'b1;
integer CK_cnt; //between commands during initialization
reg     power_down_cond  =  1'b0;   //pd can be entered
reg     active_pd_cond   =  1'b0;   //active pd can be entered
integer PD_exit_cnt  =  1;  //cycles since CKE went high
reg     PD_read_delay  =  1'b0; //tXSRD elapsed
integer PD_read_del_cnt  =  1;  //cycles of tXSRD
reg     ODT_off  =  1'b0;       //ODT turned off when precharge pd entered
reg     freq_change  =  1'b0;   //frequency has changed during precharge pd
integer freq_ch_cnt  =  0;      //cycles before frequency can change
reg     DLL_reset_needed =  1'b0;   //DLL must be reset prior to read command

//needed for CKE pulse width check
integer CKEcnt =  3;
reg     CKErise  =  1'b0;
reg     CKEfall  =  1'b1;

//needed for write
integer In_colw ;
integer Start_bankw ;
integer Start_roww ;
integer Start_colw ;
integer burst_cnt_low  =  8 ;
integer burst_cnt_hiw  =  8 ;
integer burst_seqw[0 : 7] ;
integer seqw ;

//needed for read
reg     preamble_done  =  1'b1;
reg     preamble_allow =  1'b0;
integer In_colr ;
integer Start_bankr ;
integer Start_rowr ;
integer Start_colr ;
integer burst_cntr =  9;
integer burst_seqr[0 : 7];
integer seqr ;
integer read_bank ;
integer read_row ;
integer read_column ;
reg     [15 : 0] out_buffer ;

integer delay[0:       (BankNum+1)*11 - 1];
integer temp_bank[0:   (BankNum+1)*11 - 1] ;
integer temp_row[0:    (BankNum+1)*11 - 1] ;
integer temp_column[0: (BankNum+1)*11 - 1] ;
event   wr_event;

integer act_num[0 : 3] ;
reg     next_slot  =  1'b0;

// timing check violation
reg     Viol =  1'b0;
// DLL delay counter
integer cnt;
integer i,j,k;
integer itmp, jtmp;
reg     foundone =  1'b0;

///////////////////////////////////////////////////////////////////////////////
//Interconnect Path Delay Section
///////////////////////////////////////////////////////////////////////////////
buf (BA1_ipd, BA1);
buf (BA0_ipd, BA0);

buf (A12_ipd, A12);
buf (A11_ipd, A11);
buf (A10_ipd, A10);
buf (A9_ipd , A9 );
buf (A8_ipd , A8 );
buf (A7_ipd , A7 );
buf (A6_ipd , A6 );
buf (A5_ipd , A5 );
buf (A4_ipd , A4 );
buf (A3_ipd , A3 );
buf (A2_ipd , A2 );
buf (A1_ipd , A1 );
buf (A0_ipd , A0 );

buf (DQ15_ipd, DQ15);
buf (DQ14_ipd, DQ14);
buf (DQ13_ipd, DQ13);
buf (DQ12_ipd, DQ12);
buf (DQ11_ipd, DQ11);
buf (DQ10_ipd, DQ10);
buf (DQ9_ipd , DQ9 );
buf (DQ8_ipd , DQ8 );
buf (DQ7_ipd , DQ7 );
buf (DQ6_ipd , DQ6 );
buf (DQ5_ipd , DQ5 );
buf (DQ4_ipd , DQ4 );
buf (DQ3_ipd , DQ3 );
buf (DQ2_ipd , DQ2 );
buf (DQ1_ipd , DQ1 );
buf (DQ0_ipd , DQ0 );

buf (ODT_ipd     , ODT    );
buf (CK_ipd      , CK     );
buf (CKNeg_ipd   , CKNeg  );
buf (CKE_ipd     , CKE    );
buf (CSNeg_ipd   , CSNeg  );
buf (RASNeg_ipd  , RASNeg );
buf (CASNeg_ipd  , CASNeg );
buf (WENeg_ipd   , WENeg  );
buf (LDM_ipd     , LDM    );
buf (UDM_ipd     , UDM    );

buf (UDQS_ipd    , UDQS   );
buf (UDQSNeg_ipd , UDQSNeg);
buf (LDQS_ipd    , LDQS   );
buf (LDQSNeg_ipd , LDQSNeg);

///////////////////////////////////////////////////////////////////////////////
// Propagation  delay Section
///////////////////////////////////////////////////////////////////////////////
nmos (DQ15,DQ15_zd,1);
nmos (DQ14,DQ14_zd,1);
nmos (DQ13,DQ13_zd,1);
nmos (DQ12,DQ12_zd,1);
nmos (DQ11,DQ11_zd,1);
nmos (DQ10,DQ10_zd,1);
nmos (DQ9 , DQ9_zd,1);
nmos (DQ8 , DQ8_zd,1);
nmos (DQ7 , DQ7_zd,1);
nmos (DQ6 , DQ6_zd,1);
nmos (DQ5 , DQ5_zd,1);
nmos (DQ4 , DQ4_zd,1);
nmos (DQ3 , DQ3_zd,1);
nmos (DQ2 , DQ2_zd,1);
nmos (DQ1 , DQ1_zd,1);
nmos (DQ0 , DQ0_zd,1);

nmos (UDQS   , UDQS_zd   , 1);
nmos (UDQSNeg, UDQSNeg_zd, 1);
nmos (LDQS   , LDQS_zd   , 1);
nmos (LDQSNeg, LDQSNeg_zd, 1);

wire    deg;
//VHDL VITAL CheckEnable equivalents
// Setup/Hold Check between DQIn and LDQS
wire    ChEn_DQ_LD;
assign  ChEn_DQ_LD   =  ~EMR[10] && deg;
//Setup/Hold Check between LDQSNrgIn and CK
wire    ChSetup_LD_CK3;
assign  ChSetup_LD_CK3 =  ~EMR[10] && (LDQSDiff!==LDQS_zd) &&
	~LDQSIn && ~postamble_check && In_data && (cas_lat == 3);
wire    ChSetup_LD_CK4;
assign  ChSetup_LD_CK4 =  ~EMR[10] && (LDQSDiff!==LDQS_zd) &&
	~LDQSIn && ~postamble_check && In_data && (cas_lat == 4);
wire    ChSetup_LD_CK5;
assign  ChSetup_LD_CK5 =  ~EMR[10] && (LDQSDiff!==LDQS_zd) &&
	~LDQSIn && ~postamble_check && In_data && (cas_lat == 5);
wire    ChSetup_LD_CK6;
assign  ChSetup_LD_CK6 =  ~EMR[10] && (LDQSDiff!==LDQS_zd) &&
	~LDQSIn && ~postamble_check && In_data && (cas_lat == 6);
wire    ChHold_LD_CK3;
assign  ChHold_LD_CK3  =  ~EMR[10] && (LDQSDiff!==LDQS_zd) &&
	~LDQSNeg && ~postamble_check && In_data && (cas_lat == 3);
wire    ChHold_LD_CK4;
assign  ChHold_LD_CK4  =  ~EMR[10] && (LDQSDiff!==LDQS_zd) &&
	~LDQSNeg && ~postamble_check && In_data && (cas_lat == 4);
wire    ChHold_LD_CK5;
assign  ChHold_LD_CK5  =  ~EMR[10] && (LDQSDiff!==LDQS_zd) &&
	~LDQSNeg && ~postamble_check && In_data && (cas_lat == 5);
wire    ChHold_LD_CK6;
assign  ChHold_LD_CK6  =  ~EMR[10] && (LDQSDiff!==LDQS_zd) &&
	~LDQSNeg && ~postamble_check && In_data && (cas_lat == 6);
//Setup/Hold Check between LDQSIn and CK
wire    ChSetup_LDIn_CK3;
assign  ChSetup_LDIn_CK3 =  (LDQSIn!==LDQS_zd) &&
	~LDQSIn && ~postamble_check && In_data && (cas_lat == 3);
wire    ChSetup_LDIn_CK4;
assign  ChSetup_LDIn_CK4 =  (LDQSIn!==LDQS_zd) &&
	~LDQSIn && ~postamble_check && In_data && (cas_lat == 4);
wire    ChSetup_LDIn_CK5;
assign  ChSetup_LDIn_CK5 =  (LDQSIn!==LDQS_zd) &&
	~LDQSIn && ~postamble_check && In_data && (cas_lat == 5);
wire    ChSetup_LDIn_CK6;
assign  ChSetup_LDIn_CK6 =  (LDQSIn!==LDQS_zd) &&
	~LDQSIn && ~postamble_check && In_data && (cas_lat == 6);
wire    ChHold_LDIn_CK3;
assign  ChHold_LDIn_CK3  =  (LDQSIn!==LDQS_zd) &&
	LDQSIn && ~postamble_check && In_data && (cas_lat == 3);
wire    ChHold_LDIn_CK4;
assign  ChHold_LDIn_CK4  =  (LDQSIn!==LDQS_zd) &&
	LDQSIn && ~postamble_check && In_data && (cas_lat == 4);
wire    ChHold_LDIn_CK5;
assign  ChHold_LDIn_CK5  =  (LDQSIn!==LDQS_zd) &&
	LDQSIn && ~postamble_check && In_data && (cas_lat == 5);
wire    ChHold_LDIn_CK6;
assign  ChHold_LDIn_CK6  =  (LDQSIn!==LDQS_zd) &&
	LDQSIn && ~postamble_check && In_data && (cas_lat == 6);
//Setup/Hold Check between UDQSNegIn and CK
wire    ChSetup_UD_CK3;
assign  ChSetup_UD_CK3   =  ~EMR[10] && (UDQSDiff!==UDQS_zd) &&
	~UDQSIn && ~postamble_check && In_data && (cas_lat == 3);
wire    ChSetup_UD_CK4;
assign  ChSetup_UD_CK4   =  ~EMR[10] && (UDQSDiff!==UDQS_zd) &&
	~UDQSIn && ~postamble_check && In_data && (cas_lat == 4);
wire    ChSetup_UD_CK5;
assign  ChSetup_UD_CK5   =  ~EMR[10] && (UDQSDiff!==UDQS_zd) &&
	~UDQSIn && ~postamble_check && In_data && (cas_lat == 5);
wire    ChSetup_UD_CK6;
assign  ChSetup_UD_CK6   =  ~EMR[10] && (UDQSDiff!==UDQS_zd) &&
	~UDQSIn && ~postamble_check && In_data && (cas_lat == 6);
wire    ChHold_UD_CK3;
assign  ChHold_UD_CK3    =  ~EMR[10] && (UDQSDiff!==UDQS_zd) &&
	~UDQSNeg && ~postamble_check && In_data && (cas_lat == 3);
wire    ChHold_UD_CK4;
assign  ChHold_UD_CK4    =  ~EMR[10] && (UDQSDiff!==UDQS_zd) &&
	~UDQSNeg && ~postamble_check && In_data && (cas_lat == 4);
wire    ChHold_UD_CK5;
assign  ChHold_UD_CK5    =  ~EMR[10] && (UDQSDiff!==UDQS_zd) &&
	~UDQSNeg && ~postamble_check && In_data && (cas_lat == 5);
wire    ChHold_UD_CK6;
assign  ChHold_UD_CK6    =  ~EMR[10] && (UDQSDiff!==UDQS_zd) &&
	~UDQSNeg && ~postamble_check && In_data && (cas_lat == 6);
//Setup/Hold Check between UDQSIn and CK
wire    ChSetup_UDIn_CK3;
assign  ChSetup_UDIn_CK3 =  (UDQSIn!==UDQS_zd) &&
	~UDQSIn && ~postamble_check && In_data && (cas_lat == 3);
wire    ChSetup_UDIn_CK4;
assign  ChSetup_UDIn_CK4 =  (UDQSIn!==UDQS_zd) &&
	~UDQSIn && ~postamble_check && In_data && (cas_lat == 4);
wire    ChSetup_UDIn_CK5;
assign  ChSetup_UDIn_CK5 =  (UDQSIn!==UDQS_zd) &&
	~UDQSIn && ~postamble_check && In_data && (cas_lat == 5);
wire    ChSetup_UDIn_CK6;
assign  ChSetup_UDIn_CK6 =  (UDQSIn!==UDQS_zd) &&
	~UDQSIn && ~postamble_check && In_data && (cas_lat == 6);
wire    ChHold_UDIn_CK3;
assign  ChHold_UDIn_CK3  =  (UDQSIn!==UDQS_zd) &&
	UDQSIn && ~postamble_check && In_data && (cas_lat == 3);
wire    ChHold_UDIn_CK4;
assign  ChHold_UDIn_CK4  =  (UDQSIn!==UDQS_zd) &&
	UDQSIn && ~postamble_check && In_data && (cas_lat == 4);
wire    ChHold_UDIn_CK5;
assign  ChHold_UDIn_CK5  =  (UDQSIn!==UDQS_zd) &&
	UDQSIn && ~postamble_check && In_data && (cas_lat == 5);
wire    ChHold_UDIn_CK6;
assign  ChHold_UDIn_CK6  =  (UDQSIn!==UDQS_zd) &&
	UDQSIn && ~postamble_check && In_data && (cas_lat == 6);
wire    ChNormalCL3;
assign  ChNormalCL3  =  ~preamble_check && ~postamble_check && (cas_lat == 3);
wire    ChNormalCL4;
assign  ChNormalCL4  =  ~preamble_check && ~postamble_check && (cas_lat == 4)
	&& LDQS !== 1'bz;
wire    ChNormalCL5;
assign  ChNormalCL5  =  ~preamble_check && ~postamble_check && (cas_lat == 5);
wire    CheckPreambleCL3;
assign  CheckPreambleCL3 =  ~EMR[10] && preamble_check && (cas_lat == 3);
wire    CheckPreambleCL4;
assign  CheckPreambleCL4 =  ~EMR[10] && preamble_check && (cas_lat == 4);
wire    CheckPreambleCL5;
assign  CheckPreambleCL5 =  ~EMR[10] && preamble_check && (cas_lat == 5);
wire    CheckPostambleCL3;
assign  CheckPostambleCL3  =  ~EMR[10] && postamble_check && (cas_lat == 3);
wire    CheckPostambleCL4;
assign  CheckPostambleCL4  =  ~EMR[10] && postamble_check && (cas_lat == 4);
wire    CheckPostambleCL5;
assign  CheckPostambleCL5  =  ~EMR[10] && postamble_check && (cas_lat == 5);
//PulseWidth and Period Check for CK
wire    ChEnable_CK3;
assign  ChEnable_CK3 =  CK_stable && ~SR_enter_cycle &&
	~Reset_enter_cycle && (cas_lat == 3);
wire    ChEnable_CK4;
assign  ChEnable_CK4 =  CK_stable && ~SR_enter_cycle &&
	~Reset_enter_cycle && (cas_lat == 4);
wire    ChEnable_CK5;
assign  ChEnable_CK5 =  CK_stable && ~SR_enter_cycle &&
	~Reset_enter_cycle && (cas_lat == 5);
wire    ChEnable_CK6;
assign  ChEnable_CK6 =  CK_stable && ~SR_enter_cycle &&
	~Reset_enter_cycle && (cas_lat == 6);
wire    ChDQSNeg;
assign  ChDQSNeg =  ~EMR[10];
wire    ChDQSNegCL3;
assign  ChDQSNegCL3  =  ~EMR[10] && (cas_lat == 3);
wire    ChDQSNegCL4;
assign  ChDQSNegCL4  =  ~EMR[10] && (cas_lat == 4) && LDQSNeg !== 1'bz;
wire    ChDQSNegCL5;
assign  ChDQSNegCL5  =  ~EMR[10] && (cas_lat == 5);
wire    ChPreambleCL3;
assign  ChPreambleCL3  =  preamble_check && (cas_lat == 3);
wire    ChPreambleCL4;
assign  ChPreambleCL4  =  preamble_check && (cas_lat == 4);
wire    ChPreambleCL5;
assign  ChPreambleCL5  =  preamble_check && (cas_lat == 5);
wire    ChPostambleCL3;
assign  ChPostambleCL3 =  postamble_check && (cas_lat == 3);
wire    ChPostambleCL4;
assign  ChPostambleCL4 =  postamble_check && (cas_lat == 4);
wire    ChPostambleCL5;
assign  ChPostambleCL5 =  postamble_check && (cas_lat == 5);
wire    CL3;
assign  CL3  =  (cas_lat == 3);
wire    CL4;
assign  CL4  =  (cas_lat == 4);
wire    CL5;
assign  CL5  =  (cas_lat == 5);

specify
// tipd delays: interconnect path delays , mapped to input port delays.
// In Verilog is not necessary to declare any tipd_ delay variables,
// they can be taken from SDF file
// With all the other delays real delays would be taken from SDF file

// tpd delays
specparam  tpd_CK_DQ0  =  1;
specparam  tpd_CK_DQ1  =  1;
specparam  tpd_CK_LDQS =  1;

// tsetup values: setup time
specparam  tsetup_DQ0_LDQS   =  1;  //tDSb
specparam  tsetup_A0_CK  =  1;      //tISb
specparam  tsetup_LDQS_CK  =  1;    //tDSS

// thold values: hold times
specparam  thold_DQ0_LDQS  =  1;    //tDHb
specparam  thold_A0_CK =  1;        //tIHb
specparam  thold_LDQS_CK =  1;      //tDSH

// tpw values: pulse width
specparam  tpw_CK_posedge  =  1;    //tCKHAVG
specparam  tpw_CK_negedge  =  1;    //tCKLAVG
specparam  tpw_A0  =  1;    //tIPW
specparam  tpw_DQ0 =  1;    //tDIPW
specparam  tpw_LDQS_posedge  =  1;  //tDQSH
specparam  tpw_LDQS_negedge  =  1;  //tDQSL, tWPRE, tWPST
specparam  tperiod_CK  =  1;        //tCKAVG(min)

// tdevice values: values for internal delays
specparam   tdevice_tRC  =  55;     //54ns;
specparam   tdevice_tRRD =  10;     //10 ns;
specparam   tdevice_tRCD =  15;     //12 ns;
specparam   tdevice_tFAW =  50;     //50 ns;
specparam   tdevice_tRASMIN  =  40; //40 ns;
specparam   tdevice_tRASMAX  =  70000;  //70 us;
specparam   tdevice_tRTP =  7500;       //7.5 ns;
specparam   tdevice_tWR  =  15; //15 ns;
specparam   tdevice_tWTR =  7500;   //7.5 ns;
specparam   tdevice_tRP  =  15;     //12 ns;
specparam   tdevice_tRFCMIN  =  75000;  //75 ns;
specparam   tdevice_tRFCMAX  =  70000;  //70 us;
specparam   tdevice_REFPer   =  64000000;   //64 ms;
specparam   tdevice_tCKAVGMAX  =  8;        //8 ns

///////////////////////////////////////////////////////////////////////////////
// Input Port  Delays  don't require Verilog description
///////////////////////////////////////////////////////////////////////////////
// Path delays                                                               //
///////////////////////////////////////////////////////////////////////////////
(CK => LDQS) =  tpd_CK_LDQS;
(CK => UDQS) =  tpd_CK_LDQS;
(CK => UDQSNeg)  =  tpd_CK_LDQS;
(CK => LDQSNeg)  =  tpd_CK_LDQS;

(CK => DQ0  )    =  tpd_CK_DQ0;
(CK => DQ1  )    =  tpd_CK_DQ0;
(CK => DQ2  )    =  tpd_CK_DQ0;
(CK => DQ3  )    =  tpd_CK_DQ0;
(CK => DQ4  )    =  tpd_CK_DQ0;
(CK => DQ5  )    =  tpd_CK_DQ0;
(CK => DQ6  )    =  tpd_CK_DQ0;
(CK => DQ7  )    =  tpd_CK_DQ0;
(CK => DQ8  )    =  tpd_CK_DQ0;
(CK => DQ9  )    =  tpd_CK_DQ0;
(CK => DQ10 )    =  tpd_CK_DQ0;
(CK => DQ11 )    =  tpd_CK_DQ0;
(CK => DQ12 )    =  tpd_CK_DQ0;
(CK => DQ13 )    =  tpd_CK_DQ0;
(CK => DQ14 )    =  tpd_CK_DQ0;
(CK => DQ15 )    =  tpd_CK_DQ0;

///////////////////////////////////////////////////////////////////////////////
// Timing Violation                                                          //
///////////////////////////////////////////////////////////////////////////////
$setup ( DQ0 , posedge LDQSNeg&&&ChEn_DQ_LD, tsetup_DQ0_LDQS, Viol);
$setup ( DQ1 , posedge LDQSNeg&&&ChEn_DQ_LD, tsetup_DQ0_LDQS, Viol);
$setup ( DQ2 , posedge LDQSNeg&&&ChEn_DQ_LD, tsetup_DQ0_LDQS, Viol);
$setup ( DQ3 , posedge LDQSNeg&&&ChEn_DQ_LD, tsetup_DQ0_LDQS, Viol);
$setup ( DQ4 , posedge LDQSNeg&&&ChEn_DQ_LD, tsetup_DQ0_LDQS, Viol);
$setup ( DQ5 , posedge LDQSNeg&&&ChEn_DQ_LD, tsetup_DQ0_LDQS, Viol);
$setup ( DQ6 , posedge LDQSNeg&&&ChEn_DQ_LD, tsetup_DQ0_LDQS, Viol);
$setup ( DQ7 , posedge LDQSNeg&&&ChEn_DQ_LD, tsetup_DQ0_LDQS, Viol);
$setup ( DQ8 , posedge UDQSNeg&&&ChEn_DQ_LD, tsetup_DQ0_LDQS, Viol);
$setup ( DQ9 , posedge UDQSNeg&&&ChEn_DQ_LD, tsetup_DQ0_LDQS, Viol);
$setup ( DQ10, posedge UDQSNeg&&&ChEn_DQ_LD, tsetup_DQ0_LDQS, Viol);
$setup ( DQ11, posedge UDQSNeg&&&ChEn_DQ_LD, tsetup_DQ0_LDQS, Viol);
$setup ( DQ12, posedge UDQSNeg&&&ChEn_DQ_LD, tsetup_DQ0_LDQS, Viol);
$setup ( DQ13, posedge UDQSNeg&&&ChEn_DQ_LD, tsetup_DQ0_LDQS, Viol);
$setup ( DQ14, posedge UDQSNeg&&&ChEn_DQ_LD, tsetup_DQ0_LDQS, Viol);
$setup ( DQ15, posedge UDQSNeg&&&ChEn_DQ_LD, tsetup_DQ0_LDQS, Viol);

$setup ( DQ0 , posedge LDQS&&&deg, tsetup_DQ0_LDQS, Viol);
$setup ( DQ1 , posedge LDQS&&&deg, tsetup_DQ0_LDQS, Viol);
$setup ( DQ2 , posedge LDQS&&&deg, tsetup_DQ0_LDQS, Viol);
$setup ( DQ3 , posedge LDQS&&&deg, tsetup_DQ0_LDQS, Viol);
$setup ( DQ4 , posedge LDQS&&&deg, tsetup_DQ0_LDQS, Viol);
$setup ( DQ5 , posedge LDQS&&&deg, tsetup_DQ0_LDQS, Viol);
$setup ( DQ6 , posedge LDQS&&&deg, tsetup_DQ0_LDQS, Viol);
$setup ( DQ7 , posedge LDQS&&&deg, tsetup_DQ0_LDQS, Viol);
$setup ( DQ8 , posedge UDQS&&&deg, tsetup_DQ0_LDQS, Viol);
$setup ( DQ9 , posedge UDQS&&&deg, tsetup_DQ0_LDQS, Viol);
$setup ( DQ10, posedge UDQS&&&deg, tsetup_DQ0_LDQS, Viol);
$setup ( DQ11, posedge UDQS&&&deg, tsetup_DQ0_LDQS, Viol);
$setup ( DQ12, posedge UDQS&&&deg, tsetup_DQ0_LDQS, Viol);
$setup ( DQ13, posedge UDQS&&&deg, tsetup_DQ0_LDQS, Viol);
$setup ( DQ14, posedge UDQS&&&deg, tsetup_DQ0_LDQS, Viol);
$setup ( DQ15, posedge UDQS&&&deg, tsetup_DQ0_LDQS, Viol);

$setup ( DQ0 , negedge LDQSNeg&&&ChEn_DQ_LD, tsetup_DQ0_LDQS, Viol);
$setup ( DQ1 , negedge LDQSNeg&&&ChEn_DQ_LD, tsetup_DQ0_LDQS, Viol);
$setup ( DQ2 , negedge LDQSNeg&&&ChEn_DQ_LD, tsetup_DQ0_LDQS, Viol);
$setup ( DQ3 , negedge LDQSNeg&&&ChEn_DQ_LD, tsetup_DQ0_LDQS, Viol);
$setup ( DQ4 , negedge LDQSNeg&&&ChEn_DQ_LD, tsetup_DQ0_LDQS, Viol);
$setup ( DQ5 , negedge LDQSNeg&&&ChEn_DQ_LD, tsetup_DQ0_LDQS, Viol);
$setup ( DQ6 , negedge LDQSNeg&&&ChEn_DQ_LD, tsetup_DQ0_LDQS, Viol);
$setup ( DQ7 , negedge LDQSNeg&&&ChEn_DQ_LD, tsetup_DQ0_LDQS, Viol);
$setup ( DQ8 , negedge UDQSNeg&&&ChEn_DQ_LD, tsetup_DQ0_LDQS, Viol);
$setup ( DQ9 , negedge UDQSNeg&&&ChEn_DQ_LD, tsetup_DQ0_LDQS, Viol);
$setup ( DQ10, negedge UDQSNeg&&&ChEn_DQ_LD, tsetup_DQ0_LDQS, Viol);
$setup ( DQ11, negedge UDQSNeg&&&ChEn_DQ_LD, tsetup_DQ0_LDQS, Viol);
$setup ( DQ12, negedge UDQSNeg&&&ChEn_DQ_LD, tsetup_DQ0_LDQS, Viol);
$setup ( DQ13, negedge UDQSNeg&&&ChEn_DQ_LD, tsetup_DQ0_LDQS, Viol);
$setup ( DQ14, negedge UDQSNeg&&&ChEn_DQ_LD, tsetup_DQ0_LDQS, Viol);
$setup ( DQ15, negedge UDQSNeg&&&ChEn_DQ_LD, tsetup_DQ0_LDQS, Viol);

$setup ( DQ0 , negedge LDQS&&&deg, tsetup_DQ0_LDQS, Viol);
$setup ( DQ1 , negedge LDQS&&&deg, tsetup_DQ0_LDQS, Viol);
$setup ( DQ2 , negedge LDQS&&&deg, tsetup_DQ0_LDQS, Viol);
$setup ( DQ3 , negedge LDQS&&&deg, tsetup_DQ0_LDQS, Viol);
$setup ( DQ4 , negedge LDQS&&&deg, tsetup_DQ0_LDQS, Viol);
$setup ( DQ5 , negedge LDQS&&&deg, tsetup_DQ0_LDQS, Viol);
$setup ( DQ6 , negedge LDQS&&&deg, tsetup_DQ0_LDQS, Viol);
$setup ( DQ7 , negedge LDQS&&&deg, tsetup_DQ0_LDQS, Viol);
$setup ( DQ8 , negedge UDQS&&&deg, tsetup_DQ0_LDQS, Viol);
$setup ( DQ9 , negedge UDQS&&&deg, tsetup_DQ0_LDQS, Viol);
$setup ( DQ10, negedge UDQS&&&deg, tsetup_DQ0_LDQS, Viol);
$setup ( DQ11, negedge UDQS&&&deg, tsetup_DQ0_LDQS, Viol);
$setup ( DQ12, negedge UDQS&&&deg, tsetup_DQ0_LDQS, Viol);
$setup ( DQ13, negedge UDQS&&&deg, tsetup_DQ0_LDQS, Viol);
$setup ( DQ14, negedge UDQS&&&deg, tsetup_DQ0_LDQS, Viol);
$setup ( DQ15, negedge UDQS&&&deg, tsetup_DQ0_LDQS, Viol);

$setup ( LDM , posedge LDQSNeg&&&ChDQSNeg, tsetup_DQ0_LDQS, Viol);
$setup ( LDM , posedge LDQS, tsetup_DQ0_LDQS, Viol);
$setup ( LDM , negedge LDQSNeg&&&ChDQSNeg, tsetup_DQ0_LDQS, Viol);
$setup ( LDM , negedge LDQS, tsetup_DQ0_LDQS, Viol);

$setup ( UDM , posedge UDQSNeg&&&ChDQSNeg, tsetup_DQ0_LDQS, Viol);
$setup ( UDM , posedge UDQS, tsetup_DQ0_LDQS, Viol);
$setup ( UDM , negedge UDQSNeg&&&ChDQSNeg, tsetup_DQ0_LDQS, Viol);
$setup ( UDM , negedge UDQS, tsetup_DQ0_LDQS, Viol);

$setup ( ODT ,    posedge CK, tsetup_A0_CK, Viol);
$setup ( CKE ,    posedge CK, tsetup_A0_CK, Viol);
$setup ( CSNeg ,  posedge CK, tsetup_A0_CK, Viol);
$setup ( RASNeg , posedge CK, tsetup_A0_CK, Viol);
$setup ( CASNeg , posedge CK, tsetup_A0_CK, Viol);
$setup ( WENeg ,  posedge CK, tsetup_A0_CK, Viol);

$setup ( BA1 , posedge CK, tsetup_A0_CK, Viol);
$setup ( BA0 , posedge CK, tsetup_A0_CK, Viol);

$setup ( A12 , posedge CK, tsetup_A0_CK, Viol);
$setup ( A11 , posedge CK, tsetup_A0_CK, Viol);
$setup ( A10 , posedge CK, tsetup_A0_CK, Viol);
$setup ( A9  , posedge CK, tsetup_A0_CK, Viol);
$setup ( A8  , posedge CK, tsetup_A0_CK, Viol);
$setup ( A7  , posedge CK, tsetup_A0_CK, Viol);
$setup ( A6  , posedge CK, tsetup_A0_CK, Viol);
$setup ( A5  , posedge CK, tsetup_A0_CK, Viol);
$setup ( A4  , posedge CK, tsetup_A0_CK, Viol);
$setup ( A3  , posedge CK, tsetup_A0_CK, Viol);
$setup ( A2  , posedge CK, tsetup_A0_CK, Viol);
$setup ( A1  , posedge CK, tsetup_A0_CK, Viol);
$setup ( A0  , posedge CK, tsetup_A0_CK, Viol);

$setup ( LDQSNeg , posedge CK&&&ChSetup_LD_CK3,tsetup_LDQS_CK, Viol);
$setup ( LDQSNeg , posedge CK&&&ChSetup_LD_CK4,tsetup_LDQS_CK, Viol);
$setup ( LDQSNeg , posedge CK&&&ChSetup_LD_CK5,tsetup_LDQS_CK, Viol);
$setup ( LDQSNeg , posedge CK&&&ChSetup_LD_CK6,tsetup_LDQS_CK, Viol);
$setup ( UDQSNeg , posedge CK&&&ChSetup_UD_CK3,tsetup_LDQS_CK, Viol);
$setup ( UDQSNeg , posedge CK&&&ChSetup_UD_CK4,tsetup_LDQS_CK, Viol);
$setup ( UDQSNeg , posedge CK&&&ChSetup_UD_CK5,tsetup_LDQS_CK, Viol);
$setup ( UDQSNeg , posedge CK&&&ChSetup_UD_CK6,tsetup_LDQS_CK, Viol);
$setup ( LDQS , posedge CK&&&ChSetup_LDIn_CK3,tsetup_LDQS_CK, Viol);
$setup ( LDQS , posedge CK&&&ChSetup_LDIn_CK4,tsetup_LDQS_CK, Viol);
$setup ( LDQS , posedge CK&&&ChSetup_LDIn_CK5,tsetup_LDQS_CK, Viol);
$setup ( LDQS , posedge CK&&&ChSetup_LDIn_CK6,tsetup_LDQS_CK, Viol);
$setup ( UDQS , posedge CK&&&ChSetup_UDIn_CK3,tsetup_LDQS_CK, Viol);
$setup ( UDQS , posedge CK&&&ChSetup_UDIn_CK4,tsetup_LDQS_CK, Viol);
$setup ( UDQS , posedge CK&&&ChSetup_UDIn_CK5,tsetup_LDQS_CK, Viol);
$setup ( UDQS , posedge CK&&&ChSetup_UDIn_CK6,tsetup_LDQS_CK, Viol);

$hold ( posedge LDQSNeg&&&ChEn_DQ_LD, DQ0 ,  thold_DQ0_LDQS, Viol);
$hold ( posedge LDQSNeg&&&ChEn_DQ_LD, DQ1 ,  thold_DQ0_LDQS, Viol);
$hold ( posedge LDQSNeg&&&ChEn_DQ_LD, DQ2 ,  thold_DQ0_LDQS, Viol);
$hold ( posedge LDQSNeg&&&ChEn_DQ_LD, DQ3 ,  thold_DQ0_LDQS, Viol);
$hold ( posedge LDQSNeg&&&ChEn_DQ_LD, DQ4 ,  thold_DQ0_LDQS, Viol);
$hold ( posedge LDQSNeg&&&ChEn_DQ_LD, DQ5 ,  thold_DQ0_LDQS, Viol);
$hold ( posedge LDQSNeg&&&ChEn_DQ_LD, DQ6 ,  thold_DQ0_LDQS, Viol);
$hold ( posedge LDQSNeg&&&ChEn_DQ_LD, DQ7 ,  thold_DQ0_LDQS, Viol);
$hold ( posedge UDQSNeg&&&ChEn_DQ_LD, DQ8 ,  thold_DQ0_LDQS, Viol);
$hold ( posedge UDQSNeg&&&ChEn_DQ_LD, DQ9 ,  thold_DQ0_LDQS, Viol);
$hold ( posedge UDQSNeg&&&ChEn_DQ_LD, DQ10,  thold_DQ0_LDQS, Viol);
$hold ( posedge UDQSNeg&&&ChEn_DQ_LD, DQ11,  thold_DQ0_LDQS, Viol);
$hold ( posedge UDQSNeg&&&ChEn_DQ_LD, DQ12,  thold_DQ0_LDQS, Viol);
$hold ( posedge UDQSNeg&&&ChEn_DQ_LD, DQ13,  thold_DQ0_LDQS, Viol);
$hold ( posedge UDQSNeg&&&ChEn_DQ_LD, DQ14,  thold_DQ0_LDQS, Viol);
$hold ( posedge UDQSNeg&&&ChEn_DQ_LD, DQ15,  thold_DQ0_LDQS, Viol);

$hold ( posedge LDQS&&&deg, DQ0 ,  thold_DQ0_LDQS, Viol);
$hold ( posedge LDQS&&&deg, DQ1 ,  thold_DQ0_LDQS, Viol);
$hold ( posedge LDQS&&&deg, DQ2 ,  thold_DQ0_LDQS, Viol);
$hold ( posedge LDQS&&&deg, DQ3 ,  thold_DQ0_LDQS, Viol);
$hold ( posedge LDQS&&&deg, DQ4 ,  thold_DQ0_LDQS, Viol);
$hold ( posedge LDQS&&&deg, DQ5 ,  thold_DQ0_LDQS, Viol);
$hold ( posedge LDQS&&&deg, DQ6 ,  thold_DQ0_LDQS, Viol);
$hold ( posedge LDQS&&&deg, DQ7 ,  thold_DQ0_LDQS, Viol);
$hold ( posedge UDQS&&&deg, DQ8 ,  thold_DQ0_LDQS, Viol);
$hold ( posedge UDQS&&&deg, DQ9 ,  thold_DQ0_LDQS, Viol);
$hold ( posedge UDQS&&&deg, DQ10,  thold_DQ0_LDQS, Viol);
$hold ( posedge UDQS&&&deg, DQ11,  thold_DQ0_LDQS, Viol);
$hold ( posedge UDQS&&&deg, DQ12,  thold_DQ0_LDQS, Viol);
$hold ( posedge UDQS&&&deg, DQ13,  thold_DQ0_LDQS, Viol);
$hold ( posedge UDQS&&&deg, DQ14,  thold_DQ0_LDQS, Viol);
$hold ( posedge UDQS&&&deg, DQ15,  thold_DQ0_LDQS, Viol);

$hold ( negedge LDQSNeg&&&ChEn_DQ_LD, DQ0 ,  thold_DQ0_LDQS, Viol);
$hold ( negedge LDQSNeg&&&ChEn_DQ_LD, DQ1 ,  thold_DQ0_LDQS, Viol);
$hold ( negedge LDQSNeg&&&ChEn_DQ_LD, DQ2 ,  thold_DQ0_LDQS, Viol);
$hold ( negedge LDQSNeg&&&ChEn_DQ_LD, DQ3 ,  thold_DQ0_LDQS, Viol);
$hold ( negedge LDQSNeg&&&ChEn_DQ_LD, DQ4 ,  thold_DQ0_LDQS, Viol);
$hold ( negedge LDQSNeg&&&ChEn_DQ_LD, DQ5 ,  thold_DQ0_LDQS, Viol);
$hold ( negedge LDQSNeg&&&ChEn_DQ_LD, DQ6 ,  thold_DQ0_LDQS, Viol);
$hold ( negedge LDQSNeg&&&ChEn_DQ_LD, DQ7 ,  thold_DQ0_LDQS, Viol);
$hold ( negedge UDQSNeg&&&ChEn_DQ_LD, DQ8 ,  thold_DQ0_LDQS, Viol);
$hold ( negedge UDQSNeg&&&ChEn_DQ_LD, DQ9 ,  thold_DQ0_LDQS, Viol);
$hold ( negedge UDQSNeg&&&ChEn_DQ_LD, DQ10,  thold_DQ0_LDQS, Viol);
$hold ( negedge UDQSNeg&&&ChEn_DQ_LD, DQ11,  thold_DQ0_LDQS, Viol);
$hold ( negedge UDQSNeg&&&ChEn_DQ_LD, DQ12,  thold_DQ0_LDQS, Viol);
$hold ( negedge UDQSNeg&&&ChEn_DQ_LD, DQ13,  thold_DQ0_LDQS, Viol);
$hold ( negedge UDQSNeg&&&ChEn_DQ_LD, DQ14,  thold_DQ0_LDQS, Viol);
$hold ( negedge UDQSNeg&&&ChEn_DQ_LD, DQ15,  thold_DQ0_LDQS, Viol);

$hold ( negedge LDQS&&&deg, DQ0 ,  thold_DQ0_LDQS, Viol);
$hold ( negedge LDQS&&&deg, DQ1 ,  thold_DQ0_LDQS, Viol);
$hold ( negedge LDQS&&&deg, DQ2 ,  thold_DQ0_LDQS, Viol);
$hold ( negedge LDQS&&&deg, DQ3 ,  thold_DQ0_LDQS, Viol);
$hold ( negedge LDQS&&&deg, DQ4 ,  thold_DQ0_LDQS, Viol);
$hold ( negedge LDQS&&&deg, DQ5 ,  thold_DQ0_LDQS, Viol);
$hold ( negedge LDQS&&&deg, DQ6 ,  thold_DQ0_LDQS, Viol);
$hold ( negedge LDQS&&&deg, DQ7 ,  thold_DQ0_LDQS, Viol);
$hold ( negedge UDQS&&&deg, DQ8 ,  thold_DQ0_LDQS, Viol);
$hold ( negedge UDQS&&&deg, DQ9 ,  thold_DQ0_LDQS, Viol);
$hold ( negedge UDQS&&&deg, DQ10,  thold_DQ0_LDQS, Viol);
$hold ( negedge UDQS&&&deg, DQ11,  thold_DQ0_LDQS, Viol);
$hold ( negedge UDQS&&&deg, DQ12,  thold_DQ0_LDQS, Viol);
$hold ( negedge UDQS&&&deg, DQ13,  thold_DQ0_LDQS, Viol);
$hold ( negedge UDQS&&&deg, DQ14,  thold_DQ0_LDQS, Viol);
$hold ( negedge UDQS&&&deg, DQ15,  thold_DQ0_LDQS, Viol);

$hold ( posedge LDQSNeg&&&ChDQSNeg, LDM ,  thold_DQ0_LDQS, Viol);
$hold ( posedge LDQS, LDM ,  thold_DQ0_LDQS, Viol);
$hold ( negedge LDQSNeg&&&ChDQSNeg, LDM ,  thold_DQ0_LDQS, Viol);
$hold ( negedge LDQS, LDM ,  thold_DQ0_LDQS, Viol);

$hold ( posedge UDQSNeg&&&ChDQSNeg, UDM ,  thold_DQ0_LDQS, Viol);
$hold ( posedge UDQS, UDM ,  thold_DQ0_LDQS, Viol);
$hold ( negedge UDQSNeg&&&ChDQSNeg, UDM ,  thold_DQ0_LDQS, Viol);
$hold ( negedge UDQS, UDM ,  thold_DQ0_LDQS, Viol);

$hold ( posedge CK, ODT ,     thold_A0_CK, Viol);
$hold ( posedge CK, CKE ,     thold_A0_CK, Viol);
$hold ( posedge CK, CSNeg ,   thold_A0_CK, Viol);
$hold ( posedge CK, RASNeg ,  thold_A0_CK, Viol);
$hold ( posedge CK, CASNeg ,  thold_A0_CK, Viol);
$hold ( posedge CK, WENeg ,   thold_A0_CK, Viol);

$hold ( posedge CK, BA1 ,  thold_A0_CK, Viol);
$hold ( posedge CK, BA0 ,  thold_A0_CK, Viol);

$hold ( posedge CK, A12 ,  thold_A0_CK, Viol);
$hold ( posedge CK, A11 ,  thold_A0_CK, Viol);
$hold ( posedge CK, A10 ,  thold_A0_CK, Viol);
$hold ( posedge CK, A9  ,  thold_A0_CK, Viol);
$hold ( posedge CK, A8  ,  thold_A0_CK, Viol);
$hold ( posedge CK, A7  ,  thold_A0_CK, Viol);
$hold ( posedge CK, A6  ,  thold_A0_CK, Viol);
$hold ( posedge CK, A5  ,  thold_A0_CK, Viol);
$hold ( posedge CK, A4  ,  thold_A0_CK, Viol);
$hold ( posedge CK, A3  ,  thold_A0_CK, Viol);
$hold ( posedge CK, A2  ,  thold_A0_CK, Viol);
$hold ( posedge CK, A1  ,  thold_A0_CK, Viol);
$hold ( posedge CK, A0  ,  thold_A0_CK, Viol);

$hold ( posedge CK&&&ChHold_LD_CK3,posedge LDQSNeg , thold_LDQS_CK, Viol);
$hold ( posedge CK&&&ChHold_LD_CK4,posedge LDQSNeg , thold_LDQS_CK, Viol);
$hold ( posedge CK&&&ChHold_LD_CK5,posedge LDQSNeg , thold_LDQS_CK, Viol);
$hold ( posedge CK&&&ChHold_LD_CK6,posedge LDQSNeg , thold_LDQS_CK, Viol);
$hold ( posedge CK&&&ChHold_UD_CK3,posedge UDQSNeg , thold_LDQS_CK, Viol);
$hold ( posedge CK&&&ChHold_UD_CK4,posedge UDQSNeg , thold_LDQS_CK, Viol);
$hold ( posedge CK&&&ChHold_UD_CK5,posedge UDQSNeg , thold_LDQS_CK, Viol);
$hold ( posedge CK&&&ChHold_UD_CK6,posedge UDQSNeg , thold_LDQS_CK, Viol);
$hold ( posedge CK&&&ChHold_LDIn_CK3, negedge LDQS , thold_LDQS_CK, Viol);
$hold ( posedge CK&&&ChHold_LDIn_CK4, negedge LDQS , thold_LDQS_CK, Viol);
$hold ( posedge CK&&&ChHold_LDIn_CK5, negedge LDQS , thold_LDQS_CK, Viol);
$hold ( posedge CK&&&ChHold_LDIn_CK6, negedge LDQS , thold_LDQS_CK, Viol);
$hold ( posedge CK&&&ChHold_UDIn_CK3, negedge UDQS , thold_LDQS_CK, Viol);
$hold ( posedge CK&&&ChHold_UDIn_CK4, negedge UDQS , thold_LDQS_CK, Viol);
$hold ( posedge CK&&&ChHold_UDIn_CK5, negedge UDQS , thold_LDQS_CK, Viol);
$hold ( posedge CK&&&ChHold_UDIn_CK6, negedge UDQS , thold_LDQS_CK, Viol);

$width (posedge A12&&&CL3==1     , tpw_A0);
$width (posedge A11&&&CL3==1     , tpw_A0);
$width (posedge A10&&&CL3==1     , tpw_A0);
$width (posedge A9&&&CL3==1      , tpw_A0);
$width (posedge A8&&&CL3==1      , tpw_A0);
$width (posedge A7&&&CL3==1      , tpw_A0);
$width (posedge A6&&&CL3==1      , tpw_A0);
$width (posedge A5&&&CL3==1      , tpw_A0);
$width (posedge A4&&&CL3==1      , tpw_A0);
$width (posedge A3&&&CL3==1      , tpw_A0);
$width (posedge A2&&&CL3==1      , tpw_A0);
$width (posedge A1&&&CL3==1      , tpw_A0);
$width (posedge A0&&&CL3==1      , tpw_A0);

$width (negedge A12&&&CL3==1     , tpw_A0);
$width (negedge A11&&&CL3==1     , tpw_A0);
$width (negedge A10&&&CL3==1     , tpw_A0);
$width (negedge A9&&&CL3==1      , tpw_A0);
$width (negedge A8&&&CL3==1      , tpw_A0);
$width (negedge A7&&&CL3==1      , tpw_A0);
$width (negedge A6&&&CL3==1      , tpw_A0);
$width (negedge A5&&&CL3==1      , tpw_A0);
$width (negedge A4&&&CL3==1      , tpw_A0);
$width (negedge A3&&&CL3==1      , tpw_A0);
$width (negedge A2&&&CL3==1      , tpw_A0);
$width (negedge A1&&&CL3==1      , tpw_A0);
$width (negedge A0&&&CL3==1      , tpw_A0);

$width (posedge A12&&&CL4==1     , tpw_A0);
$width (posedge A11&&&CL4==1     , tpw_A0);
$width (posedge A10&&&CL4==1     , tpw_A0);
$width (posedge A9&&&CL4==1      , tpw_A0);
$width (posedge A8&&&CL4==1      , tpw_A0);
$width (posedge A7&&&CL4==1      , tpw_A0);
$width (posedge A6&&&CL4==1      , tpw_A0);
$width (posedge A5&&&CL4==1      , tpw_A0);
$width (posedge A4&&&CL4==1      , tpw_A0);
$width (posedge A3&&&CL4==1      , tpw_A0);
$width (posedge A2&&&CL4==1      , tpw_A0);
$width (posedge A1&&&CL4==1      , tpw_A0);
$width (posedge A0&&&CL4==1      , tpw_A0);

$width (negedge A12&&&CL4==1     , tpw_A0);
$width (negedge A11&&&CL4==1     , tpw_A0);
$width (negedge A10&&&CL4==1     , tpw_A0);
$width (negedge A9&&&CL4==1      , tpw_A0);
$width (negedge A8&&&CL4==1      , tpw_A0);
$width (negedge A7&&&CL4==1      , tpw_A0);
$width (negedge A6&&&CL4==1      , tpw_A0);
$width (negedge A5&&&CL4==1      , tpw_A0);
$width (negedge A4&&&CL4==1      , tpw_A0);
$width (negedge A3&&&CL4==1      , tpw_A0);
$width (negedge A2&&&CL4==1      , tpw_A0);
$width (negedge A1&&&CL4==1      , tpw_A0);
$width (negedge A0&&&CL4==1      , tpw_A0);

$width (posedge A12&&&CL5==1     , tpw_A0);
$width (posedge A11&&&CL5==1     , tpw_A0);
$width (posedge A10&&&CL5==1     , tpw_A0);
$width (posedge A9&&&CL5==1      , tpw_A0);
$width (posedge A8&&&CL5==1      , tpw_A0);
$width (posedge A7&&&CL5==1      , tpw_A0);
$width (posedge A6&&&CL5==1      , tpw_A0);
$width (posedge A5&&&CL5==1      , tpw_A0);
$width (posedge A4&&&CL5==1      , tpw_A0);
$width (posedge A3&&&CL5==1      , tpw_A0);
$width (posedge A2&&&CL5==1      , tpw_A0);
$width (posedge A1&&&CL5==1      , tpw_A0);
$width (posedge A0&&&CL5==1      , tpw_A0);

$width (negedge A12&&&CL5==1     , tpw_A0);
$width (negedge A11&&&CL5==1     , tpw_A0);
$width (negedge A10&&&CL5==1     , tpw_A0);
$width (negedge A9&&&CL5==1      , tpw_A0);
$width (negedge A8&&&CL5==1      , tpw_A0);
$width (negedge A7&&&CL5==1      , tpw_A0);
$width (negedge A6&&&CL5==1      , tpw_A0);
$width (negedge A5&&&CL5==1      , tpw_A0);
$width (negedge A4&&&CL5==1      , tpw_A0);
$width (negedge A3&&&CL5==1      , tpw_A0);
$width (negedge A2&&&CL5==1      , tpw_A0);
$width (negedge A1&&&CL5==1      , tpw_A0);
$width (negedge A0&&&CL5==1      , tpw_A0);

$width (posedge ODT&&&CL3==1     , tpw_A0);
$width (posedge ODT&&&CL4==1     , tpw_A0);
$width (posedge ODT&&&CL5==1     , tpw_A0);
$width (posedge CSNeg&&&CL3==1   , tpw_A0);
$width (posedge CSNeg&&&CL4==1   , tpw_A0);
$width (posedge CSNeg&&&CL5==1   , tpw_A0);
$width (posedge RASNeg&&&CL3==1  , tpw_A0);
$width (posedge RASNeg&&&CL4==1  , tpw_A0);
$width (posedge RASNeg&&&CL5==1  , tpw_A0);
$width (posedge CASNeg&&&CL3==1  , tpw_A0);
$width (posedge CASNeg&&&CL4==1  , tpw_A0);
$width (posedge CASNeg&&&CL5==1  , tpw_A0);
$width (posedge WENeg&&&CL3==1   , tpw_A0);
$width (posedge WENeg&&&CL4==1   , tpw_A0);
$width (posedge WENeg&&&CL5==1   , tpw_A0);

$width (negedge ODT&&&CL3==1     , tpw_A0);
$width (negedge ODT&&&CL4==1     , tpw_A0);
$width (negedge ODT&&&CL5==1     , tpw_A0);
$width (negedge CSNeg&&&CL3==1   , tpw_A0);
$width (negedge CSNeg&&&CL4==1   , tpw_A0);
$width (negedge CSNeg&&&CL5==1   , tpw_A0);
$width (negedge RASNeg&&&CL3==1  , tpw_A0);
$width (negedge RASNeg&&&CL4==1  , tpw_A0);
$width (negedge RASNeg&&&CL5==1  , tpw_A0);
$width (negedge CASNeg&&&CL3==1  , tpw_A0);
$width (negedge CASNeg&&&CL4==1  , tpw_A0);
$width (negedge CASNeg&&&CL5==1  , tpw_A0);
$width (negedge WENeg&&&CL3==1   , tpw_A0);
$width (negedge WENeg&&&CL4==1   , tpw_A0);
$width (negedge WENeg&&&CL5==1   , tpw_A0);

$width (posedge DQ0&&&CL3==1     , tpw_DQ0);
$width (posedge DQ1&&&CL3==1     , tpw_DQ0);
$width (posedge DQ2&&&CL3==1     , tpw_DQ0);
$width (posedge DQ3&&&CL3==1     , tpw_DQ0);
$width (posedge DQ4&&&CL3==1     , tpw_DQ0);
$width (posedge DQ5&&&CL3==1     , tpw_DQ0);
$width (posedge DQ6&&&CL3==1     , tpw_DQ0);
$width (posedge DQ7&&&CL3==1     , tpw_DQ0);
$width (posedge DQ8&&&CL3==1     , tpw_DQ0);
$width (posedge DQ9&&&CL3==1     , tpw_DQ0);
$width (posedge DQ10&&&CL3==1    , tpw_DQ0);
$width (posedge DQ11&&&CL3==1    , tpw_DQ0);
$width (posedge DQ12&&&CL3==1    , tpw_DQ0);
$width (posedge DQ13&&&CL3==1    , tpw_DQ0);
$width (posedge DQ14&&&CL3==1    , tpw_DQ0);
$width (posedge DQ15&&&CL3==1    , tpw_DQ0);

$width (posedge DQ0&&&CL4==1     , tpw_DQ0);
$width (posedge DQ1&&&CL4==1     , tpw_DQ0);
$width (posedge DQ2&&&CL4==1     , tpw_DQ0);
$width (posedge DQ3&&&CL4==1     , tpw_DQ0);
$width (posedge DQ4&&&CL4==1     , tpw_DQ0);
$width (posedge DQ5&&&CL4==1     , tpw_DQ0);
$width (posedge DQ6&&&CL4==1     , tpw_DQ0);
$width (posedge DQ7&&&CL4==1     , tpw_DQ0);
$width (posedge DQ8&&&CL4==1     , tpw_DQ0);
$width (posedge DQ9&&&CL4==1     , tpw_DQ0);
$width (posedge DQ10&&&CL4==1    , tpw_DQ0);
$width (posedge DQ11&&&CL4==1    , tpw_DQ0);
$width (posedge DQ12&&&CL4==1    , tpw_DQ0);
$width (posedge DQ13&&&CL4==1    , tpw_DQ0);
$width (posedge DQ14&&&CL4==1    , tpw_DQ0);
$width (posedge DQ15&&&CL4==1    , tpw_DQ0);

$width (posedge DQ0&&&CL5==1     , tpw_DQ0);
$width (posedge DQ1&&&CL5==1     , tpw_DQ0);
$width (posedge DQ2&&&CL5==1     , tpw_DQ0);
$width (posedge DQ3&&&CL5==1     , tpw_DQ0);
$width (posedge DQ4&&&CL5==1     , tpw_DQ0);
$width (posedge DQ5&&&CL5==1     , tpw_DQ0);
$width (posedge DQ6&&&CL5==1     , tpw_DQ0);
$width (posedge DQ7&&&CL5==1     , tpw_DQ0);
$width (posedge DQ8&&&CL5==1     , tpw_DQ0);
$width (posedge DQ9&&&CL5==1     , tpw_DQ0);
$width (posedge DQ10&&&CL5==1    , tpw_DQ0);
$width (posedge DQ11&&&CL5==1    , tpw_DQ0);
$width (posedge DQ12&&&CL5==1    , tpw_DQ0);
$width (posedge DQ13&&&CL5==1    , tpw_DQ0);
$width (posedge DQ14&&&CL5==1    , tpw_DQ0);
$width (posedge DQ15&&&CL5==1    , tpw_DQ0);

$width (negedge DQ0&&&CL3==1     , tpw_DQ0);
$width (negedge DQ1&&&CL3==1     , tpw_DQ0);
$width (negedge DQ2&&&CL3==1     , tpw_DQ0);
$width (negedge DQ3&&&CL3==1     , tpw_DQ0);
$width (negedge DQ4&&&CL3==1     , tpw_DQ0);
$width (negedge DQ5&&&CL3==1     , tpw_DQ0);
$width (negedge DQ6&&&CL3==1     , tpw_DQ0);
$width (negedge DQ7&&&CL3==1     , tpw_DQ0);
$width (negedge DQ8&&&CL3==1     , tpw_DQ0);
$width (negedge DQ9&&&CL3==1     , tpw_DQ0);
$width (negedge DQ10&&&CL3==1    , tpw_DQ0);
$width (negedge DQ11&&&CL3==1    , tpw_DQ0);
$width (negedge DQ12&&&CL3==1    , tpw_DQ0);
$width (negedge DQ13&&&CL3==1    , tpw_DQ0);
$width (negedge DQ14&&&CL3==1    , tpw_DQ0);
$width (negedge DQ15&&&CL3==1    , tpw_DQ0);

$width (negedge DQ0&&&CL4==1     , tpw_DQ0);
$width (negedge DQ1&&&CL4==1     , tpw_DQ0);
$width (negedge DQ2&&&CL4==1     , tpw_DQ0);
$width (negedge DQ3&&&CL4==1     , tpw_DQ0);
$width (negedge DQ4&&&CL4==1     , tpw_DQ0);
$width (negedge DQ5&&&CL4==1     , tpw_DQ0);
$width (negedge DQ6&&&CL4==1     , tpw_DQ0);
$width (negedge DQ7&&&CL4==1     , tpw_DQ0);
$width (negedge DQ8&&&CL4==1     , tpw_DQ0);
$width (negedge DQ9&&&CL4==1     , tpw_DQ0);
$width (negedge DQ10&&&CL4==1    , tpw_DQ0);
$width (negedge DQ11&&&CL4==1    , tpw_DQ0);
$width (negedge DQ12&&&CL4==1    , tpw_DQ0);
$width (negedge DQ13&&&CL4==1    , tpw_DQ0);
$width (negedge DQ14&&&CL4==1    , tpw_DQ0);
$width (negedge DQ15&&&CL4==1    , tpw_DQ0);

$width (negedge DQ0&&&CL5==1     , tpw_DQ0);
$width (negedge DQ1&&&CL5==1     , tpw_DQ0);
$width (negedge DQ2&&&CL5==1     , tpw_DQ0);
$width (negedge DQ3&&&CL5==1     , tpw_DQ0);
$width (negedge DQ4&&&CL5==1     , tpw_DQ0);
$width (negedge DQ5&&&CL5==1     , tpw_DQ0);
$width (negedge DQ6&&&CL5==1     , tpw_DQ0);
$width (negedge DQ7&&&CL5==1     , tpw_DQ0);
$width (negedge DQ8&&&CL5==1     , tpw_DQ0);
$width (negedge DQ9&&&CL5==1     , tpw_DQ0);
$width (negedge DQ10&&&CL5==1    , tpw_DQ0);
$width (negedge DQ11&&&CL5==1    , tpw_DQ0);
$width (negedge DQ12&&&CL5==1    , tpw_DQ0);
$width (negedge DQ13&&&CL5==1    , tpw_DQ0);
$width (negedge DQ14&&&CL5==1    , tpw_DQ0);
$width (negedge DQ15&&&CL5==1    , tpw_DQ0);

$width (posedge LDM&&&CL3==1     , tpw_DQ0);
$width (posedge LDM&&&CL4==1     , tpw_DQ0);
$width (posedge LDM&&&CL5==1     , tpw_DQ0);
$width (posedge UDM&&&CL3==1     , tpw_DQ0);
$width (posedge UDM&&&CL4==1     , tpw_DQ0);
$width (posedge UDM&&&CL5==1     , tpw_DQ0);
$width (negedge LDM&&&CL3==1     , tpw_DQ0);
$width (negedge LDM&&&CL4==1     , tpw_DQ0);
$width (negedge LDM&&&CL5==1     , tpw_DQ0);
$width (negedge UDM&&&CL3==1     , tpw_DQ0);
$width (negedge UDM&&&CL4==1     , tpw_DQ0);
$width (negedge UDM&&&CL5==1     , tpw_DQ0);

$width (posedge ODT&&&CL3==1        , tpw_DQ0);
$width (posedge ODT&&&CL4==1        , tpw_DQ0);
$width (posedge ODT&&&CL5==1        , tpw_DQ0);
$width (posedge CSNeg&&&CL3==1      , tpw_DQ0);
$width (posedge CSNeg&&&CL4==1      , tpw_DQ0);
$width (posedge CSNeg&&&CL5==1      , tpw_DQ0);
$width (posedge RASNeg&&&CL3==1     , tpw_DQ0);
$width (posedge RASNeg&&&CL4==1     , tpw_DQ0);
$width (posedge RASNeg&&&CL5==1     , tpw_DQ0);
$width (posedge CASNeg&&&CL3==1     , tpw_DQ0);
$width (posedge CASNeg&&&CL4==1     , tpw_DQ0);
$width (posedge CASNeg&&&CL5==1     , tpw_DQ0);
$width (posedge WENeg&&&CL3==1      , tpw_DQ0);
$width (posedge WENeg&&&CL4==1      , tpw_DQ0);
$width (posedge WENeg&&&CL5==1      , tpw_DQ0);

$width (negedge ODT&&&CL3==1        , tpw_DQ0);
$width (negedge ODT&&&CL4==1        , tpw_DQ0);
$width (negedge ODT&&&CL5==1        , tpw_DQ0);
$width (negedge CSNeg&&&CL3==1      , tpw_DQ0);
$width (negedge CSNeg&&&CL4==1      , tpw_DQ0);
$width (negedge CSNeg&&&CL5==1      , tpw_DQ0);
$width (negedge RASNeg&&&CL3==1     , tpw_DQ0);
$width (negedge RASNeg&&&CL4==1     , tpw_DQ0);
$width (negedge RASNeg&&&CL5==1     , tpw_DQ0);
$width (negedge CASNeg&&&CL3==1     , tpw_DQ0);
$width (negedge CASNeg&&&CL4==1     , tpw_DQ0);
$width (negedge CASNeg&&&CL5==1     , tpw_DQ0);
$width (negedge WENeg&&&CL3==1      , tpw_DQ0);
$width (negedge WENeg&&&CL4==1      , tpw_DQ0);
$width (negedge WENeg&&&CL5==1      , tpw_DQ0);

$width (posedge LDQSNeg&&&ChDQSNegCL3 , tpw_LDQS_posedge);
$width (posedge LDQSNeg&&&ChDQSNegCL4 , tpw_LDQS_posedge);
$width (posedge LDQSNeg&&&ChDQSNegCL5 , tpw_LDQS_posedge);
$width (negedge LDQSNeg&&&ChDQSNegCL3 , tpw_LDQS_negedge);
$width (negedge LDQSNeg&&&ChDQSNegCL4 , tpw_LDQS_negedge);
$width (negedge LDQSNeg&&&ChDQSNegCL5 , tpw_LDQS_negedge);
$width (posedge LDQS&&&ChNormalCL3  , tpw_LDQS_posedge);
$width (posedge LDQS&&&ChNormalCL4  , tpw_LDQS_posedge);
$width (posedge LDQS&&&ChNormalCL5  , tpw_LDQS_posedge);
$width (negedge LDQS&&&ChNormalCL3  , tpw_LDQS_negedge);
$width (negedge LDQS&&&ChNormalCL4  , tpw_LDQS_negedge);
$width (negedge LDQS&&&ChNormalCL5  , tpw_LDQS_negedge);

$width (posedge UDQSNeg&&&ChDQSNegCL3 , tpw_LDQS_posedge);
$width (posedge UDQSNeg&&&ChDQSNegCL4 , tpw_LDQS_posedge);
$width (posedge UDQSNeg&&&ChDQSNegCL5 , tpw_LDQS_posedge);
$width (negedge UDQSNeg&&&ChDQSNegCL3 , tpw_LDQS_negedge);
$width (negedge UDQSNeg&&&ChDQSNegCL4 , tpw_LDQS_negedge);
$width (negedge UDQSNeg&&&ChDQSNegCL5 , tpw_LDQS_negedge);
$width (posedge UDQS&&&ChNormalCL3  , tpw_LDQS_posedge);
$width (posedge UDQS&&&ChNormalCL4  , tpw_LDQS_posedge);
$width (posedge UDQS&&&ChNormalCL5  , tpw_LDQS_posedge);
$width (negedge UDQS&&&ChNormalCL3  , tpw_LDQS_negedge);
$width (negedge UDQS&&&ChNormalCL4  , tpw_LDQS_negedge);
$width (negedge UDQS&&&ChNormalCL5  , tpw_LDQS_negedge);

$width (posedge LDQSNeg&&&CheckPreambleCL3 , tpw_LDQS_negedge);
$width (posedge LDQSNeg&&&CheckPreambleCL4 , tpw_LDQS_negedge);
$width (posedge LDQSNeg&&&CheckPreambleCL5 , tpw_LDQS_negedge);
$width (negedge LDQS&&&ChPreambleCL3       , tpw_LDQS_negedge);
$width (negedge LDQS&&&ChPreambleCL4       , tpw_LDQS_negedge);
$width (negedge LDQS&&&ChPreambleCL5       , tpw_LDQS_negedge);
$width (posedge UDQSNeg&&&CheckPreambleCL3 , tpw_LDQS_negedge);
$width (posedge UDQSNeg&&&CheckPreambleCL4 , tpw_LDQS_negedge);
$width (posedge UDQSNeg&&&CheckPreambleCL5 , tpw_LDQS_negedge);
$width (negedge UDQS&&&ChPreambleCL3       , tpw_LDQS_negedge);
$width (negedge UDQS&&&ChPreambleCL4       , tpw_LDQS_negedge);
$width (negedge UDQS&&&ChPreambleCL5       , tpw_LDQS_negedge);

$width (posedge LDQSNeg&&&CheckPostambleCL3 , tpw_LDQS_negedge);
$width (posedge LDQSNeg&&&CheckPostambleCL4 , tpw_LDQS_negedge);
$width (posedge LDQSNeg&&&CheckPostambleCL5 , tpw_LDQS_negedge);
$width (negedge LDQS&&&ChPostambleCL3       , tpw_LDQS_negedge);
$width (negedge LDQS&&&ChPostambleCL4       , tpw_LDQS_negedge);
$width (negedge LDQS&&&ChPostambleCL5       , tpw_LDQS_negedge);
$width (posedge UDQSNeg&&&CheckPostambleCL3 , tpw_LDQS_negedge);
$width (posedge UDQSNeg&&&CheckPostambleCL4 , tpw_LDQS_negedge);
$width (posedge UDQSNeg&&&CheckPostambleCL5 , tpw_LDQS_negedge);
$width (negedge UDQS&&&ChPostambleCL3       , tpw_LDQS_negedge);
$width (negedge UDQS&&&ChPostambleCL4       , tpw_LDQS_negedge);
$width (negedge UDQS&&&ChPostambleCL5       , tpw_LDQS_negedge);

$width (posedge CK&&&ChEnable_CK3   , tpw_CK_posedge);
$width (posedge CK&&&ChEnable_CK4   , tpw_CK_posedge);
$width (posedge CK&&&ChEnable_CK5   , tpw_CK_posedge);
$width (negedge CK&&&ChEnable_CK3   , tpw_CK_negedge);
$width (negedge CK&&&ChEnable_CK4   , tpw_CK_negedge);
$width (negedge CK&&&ChEnable_CK5   , tpw_CK_negedge);

$period(negedge CK&&&ChEnable_CK3, tperiod_CK);
$period(negedge CK&&&ChEnable_CK4, tperiod_CK);
$period(negedge CK&&&ChEnable_CK5, tperiod_CK);
$period(posedge CK&&&ChEnable_CK3, tperiod_CK);
$period(posedge CK&&&ChEnable_CK4, tperiod_CK);
$period(posedge CK&&&ChEnable_CK5, tperiod_CK);

endspecify
//tdevice parameters aligned to model timescale
time tdevice_tRC_ts        =  tdevice_tRC * 1000;
time tdevice_tRRD_ts       =  tdevice_tRRD * 1000;
time tdevice_tRCD_ts       =  tdevice_tRCD * 1000;
time tdevice_tFAW_ts       =  tdevice_tFAW * 1000;
time tdevice_tRASMIN_ts    =  tdevice_tRASMIN * 1000;
time tdevice_tRASMAX_ts    =  tdevice_tRASMAX * 1000;
time tdevice_tRTP_ts       =  tdevice_tRTP ;
time tdevice_tWR_ts        =  tdevice_tWR * 1000;
time tdevice_tWTR_ts       =  tdevice_tWTR ;
time tdevice_tRP_ts        =  tdevice_tRP * 1000;
time tdevice_tRFCMIN_ts    =  tdevice_tRFCMIN ;
time tdevice_tRFCMAX_ts    =  tdevice_tRFCMAX * 1000;
time tdevice_REFPer_ts     =  tdevice_REFPer * 1000;
time tdevice_tCKAVGMAX_ts  =  tdevice_tCKAVGMAX * 1000;

////////////////////////////////////////////////////////////////////////////////
// Main Behavior Block                                                        //
////////////////////////////////////////////////////////////////////////////////

// main FSM states
parameter precharged   =  4'd0;
parameter refreshing   =  4'd1;
parameter mrsetting    =  4'd2;
parameter activating   =  4'd3;
parameter active       =  4'd4;
parameter reading      =  4'd5;
parameter readingap    =  4'd6;
parameter writting     =  4'd7;
parameter writtingap   =  4'd8;
parameter precharging  =  4'd9;
parameter prechall     =  4'd10;

reg     [4:0] Curr_bank_state[BankNum : 0] ;
reg     [4:0] Next_bank_state[BankNum : 0] ;

//commands
parameter LM     =  4'd0;
parameter REF    =  4'd1;
parameter DES    =  4'd2;
parameter NOP    =  4'd3;
parameter PRE    =  4'd4;
parameter ACT    =  4'd5;
parameter WR     =  4'd6;
parameter RD     =  4'd7;
parameter ILL    =  4'd8;

reg     [4:0] Command;

// states during initialization
parameter illegal    =  4'd0;
parameter init0      =  4'd1;
parameter init1      =  4'd2;
parameter init2      =  4'd3;
parameter init3      =  4'd4;
parameter init4      =  4'd5;
parameter init5      =  4'd6;
parameter init6      =  4'd7;
parameter init7      =  4'd8;
parameter init8      =  4'd9;
parameter init9      =  4'd10;
parameter init10     =  4'd11;
parameter init11     =  4'd12;
parameter init12     =  4'd13;

reg     [4:0] Current_state;
reg     [4:0] Next_state;

reg     deq;

always @(DIn, DOut_zd)
begin
	if (DIn==DOut_zd || DIn===16'bx)
		deq=  1'b0;
	else
		deq=  1'b1;
end
// check when data is generated from model to avoid setuphold check in
// those occasion
assign  deg=  deq;

// initialize memory and load preload files if any
initial
begin: InitMemory
	integer i;
	for (i =  0;i<=((BankNum+1)*(MemSize+1)-1);i =  i+1)
	begin
		Mem_Hi[i]  =  -2;
		Mem_Lo[i]  =  -2;
	end
	// - Memory  preload file
	// m47h64m16.mem file
	// // - comment
	//   @aaaaaaa - <aaaaaaa> stands for address within memory,
	//              23 LSBits determine address within bank,
	//              other bits determine bank address,
	//              words within bank are written row by row
	//   dddd     - <dddd> is word to be written at Mem(aaaaaaa++)
	//              (aaaaaaa is incremented at every load)
	if (UserPreload && !(mem_file_name == "none"))
		$readmemh(mem_file_name,Mem_Lo);
	for (i =  0;i<=((BankNum+1)*(MemSize+1)-1);i =  i+1)
	begin
		Mem_Hi[i]  =  Mem_Lo[i]/256;
		Mem_Lo[i]  =  Mem_Lo[i]%256;
	end
end

// initialize burst sequences
initial
begin
	Seq[0]   =  0;
	Seq[1]   =  1;
	Seq[2]   =  2;
	Seq[3]   =  3;
	Seq[4]   =  4;
	Seq[5]   =  5;
	Seq[6]   =  6;
	Seq[7]   =  7;
	Seq[8]   =  0;
	Seq[9]   =  1;
	Seq[10]  =  2;
	Seq[11]  =  -1;
	Seq[12]  =  4;
	Seq[13]  =  5;
	Seq[14]  =  6;
	Seq[15]  =  3;
	Seq[16]  =  0;
	Seq[17]  =  1;
	Seq[18]  =  -2;
	Seq[19]  =  -1;
	Seq[20]  =  4;
	Seq[21]  =  5;
	Seq[22]  =  2;
	Seq[23]  =  3;
	Seq[24]  =  0;
	Seq[25]  =  -3;
	Seq[26]  =  -2;
	Seq[27]  =  -1;
	Seq[28]  =  4;
	Seq[29]  =  1;
	Seq[30]  =  2;
	Seq[31]  =  3;
	Seq[32]  =  0;
	Seq[33]  =  1;
	Seq[34]  =  2;
	Seq[35]  =  3;
	Seq[36]  =  -4;
	Seq[37]  =  -3;
	Seq[38]  =  -2;
	Seq[39]  =  -1;
	Seq[40]  =  0;
	Seq[41]  =  1;
	Seq[42]  =  2;
	Seq[43]  =  -1;
	Seq[44]  =  -4;
	Seq[45]  =  -3;
	Seq[46]  =  -2;
	Seq[47]  =  -5;
	Seq[48]  =  0;
	Seq[49]  =  1;
	Seq[50]  =  -2;
	Seq[51]  =  -1;
	Seq[52]  =  -4;
	Seq[53]  =  -3;
	Seq[54]  =  -6;
	Seq[55]  =  -5;
	Seq[56]  =  0;
	Seq[57]  =  -3;
	Seq[58]  =  -2;
	Seq[59]  =  -1;
	Seq[60]  =  -4;
	Seq[61]  =  -7;
	Seq[62]  =  -6;
	Seq[63]  =  -5;
	Inl[0]   =  0;
	Inl[1]   =  1;
	Inl[2]   =  2;
	Inl[3]   =  3;
	Inl[4]   =  4;
	Inl[5]   =  5;
	Inl[6]   =  6;
	Inl[7]   =  7;
	Inl[8]   =  0;
	Inl[9]   =  -1;
	Inl[10]  =  2;
	Inl[11]  =  1;
	Inl[12]  =  4;
	Inl[13]  =  3;
	Inl[14]  =  6;
	Inl[15]  =  5;
	Inl[16]  =  0;
	Inl[17]  =  1;
	Inl[18]  =  -2;
	Inl[19]  =  -1;
	Inl[20]  =  4;
	Inl[21]  =  5;
	Inl[22]  =  2;
	Inl[23]  =  3;
	Inl[24]  =  0;
	Inl[25]  =  -1;
	Inl[26]  =  -2;
	Inl[27]  =  -3;
	Inl[28]  =  4;
	Inl[29]  =  3;
	Inl[30]  =  2;
	Inl[31]  =  1;
	Inl[32]  =  0;
	Inl[33]  =  1;
	Inl[34]  =  2;
	Inl[35]  =  3;
	Inl[36]  =  -4;
	Inl[37]  =  -3;
	Inl[38]  =  -2;
	Inl[39]  =  -1;
	Inl[40]  =  0;
	Inl[41]  =  -1;
	Inl[42]  =  2;
	Inl[43]  =  1;
	Inl[44]  =  -4;
	Inl[45]  =  -5;
	Inl[46]  =  -2;
	Inl[47]  =  -3;
	Inl[48]  =  0;
	Inl[49]  =  1;
	Inl[50]  =  -2;
	Inl[51]  =  -1;
	Inl[52]  =  -4;
	Inl[53]  =  -3;
	Inl[54]  =  -6;
	Inl[55]  =  -5;
	Inl[56]  =  0;
	Inl[57]  =  -1;
	Inl[58]  =  -2;
	Inl[59]  =  -3;
	Inl[60]  =  -4;
	Inl[61]  =  -5;
	Inl[62]  =  -6;
	Inl[63]  =  -7;
end

initial
begin
	for(i=  0;i<=BankNum;i =  i+1)
	begin
		for(j=  0;j<=10;j=  j+1)
		begin
			read_sch[i][j] =  1'b0;
			preamble[i][j] =  1'b0;
			wait_read[i][j]  =  1'b0;
			write_sch[i][j]  =  1'b0;
			AL_elapsed[i][j] =  1'b0;
			delay[i*11+j]    =  0;
			temp_bank[i*11+j]  =  0;
			temp_row[i*11+j]   =  0;
			temp_column[i*11+j]  =  0;
		end
		Curr_bank_state[i] =  precharged;
		Next_bank_state[i] =  precharged;
		tRC_in[i]  =  1'b1;
		tRC_out[i] =  1'b1;
		tRP_in[i]  =  1'b0;
		tRP_out[i] =  1'b0;
		tRCD_in[i]   =  1'b0;
		tRCD_out[i]  =  1'b0;
		tRASMIN_in[i]  =  1'b1;
		tRASMIN_out[i] =  1'b1;
		tRASMAX_in[i]  =  1'b0;
		tRASMAX_out[i] =  1'b0;
		tRTP_in[i]     =  1'b1;
		tRTP_out[i]    =  1'b1;
		tWR_in[i]  =  1'b1;
		tWR_out[i] =  1'b1;
		tWTR_in[i]   =  1'b1;
		tWTR_out[i]  =  1'b1;
	end
	for(i=  0;i<=3;i =  i+1)
	begin
		act_num[i] =  0;
		tFAW_in[i]   =  1'b0;
		tFAW_out[i]  =  1'b0;
	end
end

initial
begin
	//Timing model determination
	//assumptions:
	//1. TimingModel has format as
	//mt47h16m16bt-xxxxx
	//2. TimingModel does not have more then 20 characters
	tmp_timing =  TimingModel;  //copy of TimingModel
	
	i  =  19;
	while ((i >= 0) && (found != 1'b1)) //search for first non null character
	begin                   //i keeps position of first non null character
		j  =  7;
		while ((j >= 0) && (found != 1'b1))
		begin
			if (tmp_timing[i*8+j] != 1'd0)
				found  =  1'b1;
			else
				j  =  j-1;
		end
		i  =  i - 1;
	end
	i  =  i +1;
	pos  =  i;
	if (found)  //if non null character is found
	begin
		for (j =  0;j<=5;j =  j+1)
		begin
			for (k =  0;k<=7;k =  k+1)
			begin
				char[j][k] =  TimingModel[(pos-13-j)*8+k];
			end
		end
		PD_del =  0;
		if (char[0]=="3" && char[1]!="7")
			PD_del =  1;
	end
end

initial
begin
	Current_state  =  init0;
	Next_state =  init0;
	Command    =  LM;
	CK_cnt =  0;
	rd_wr_cnt  =  0;
	wr_wr_cnt  =  0;
	rd_rd_cnt  =  0;
	tRRD_in    =  1'b1;
	tRRD_out   =  1'b1;
	tRFCMIN_in   =  1'b0;
	tRFCMIN_out  =  1'b0;
	tRFCMAX_in   =  1'b0;
	tRFCMAX_out  =  1'b0;
	tXSNR_in     =  1'b0;
	tXSNR_out    =  1'b0;
	REFPer_in    =  1'b0;
	REFPer_out   =  1'b0;
	tCKAVGMAX_in   =  1'b0;
	tCKAVGMAX_out  =  1'b0;
	tWPSTMAX_in    =  1'b0;
	tWPSTMAX_out   =  1'b0;
	for(i=  0;i<=BankNum;i =  i+1)
	begin
		precharge_cnt[i] =  0;
		wr_rd_cnt[i] =  0;
		rd_act_cnt[i]  =  0;
	end
end

//Power Up time 200 us;
always @(CK_stable)
begin: PowerUp
	if (CK_stable)
		#(200000*TScal) PoweredUp  =  1'b1;
end

always @(posedge tRC_in[0])
begin: tRC0r
	#(tdevice_tRC_ts - 1000) tRC_out[0]  =  tRC_in[0];
end
always @(negedge tRC_in[0])
begin: tRC0f
	#(1*TScal) tRC_out[0]  =  tRC_in[0];
end

always @(posedge tRC_in[1])
begin: tRC1r
	#(tdevice_tRC_ts - 1000) tRC_out[1]  =  tRC_in[1];
end
always @(negedge tRC_in[1])
begin: tRC1f
	#(1*TScal) tRC_out[1]  =  tRC_in[1];
end

always @(posedge tRC_in[2])
begin: tRC2r
	#(tdevice_tRC_ts - 1000) tRC_out[2]  =  tRC_in[2];
end
always @(negedge tRC_in[2])
begin: tRC2f
	#(1*TScal) tRC_out[2]  =  tRC_in[2];
end

always @(posedge tRC_in[3])
begin: tRC3r
	#(tdevice_tRC_ts - 1000) tRC_out[3]  =  tRC_in[3];
end
always @(negedge tRC_in[3])
begin: tRC3f
	#(1*TScal) tRC_out[3]  =  tRC_in[3];
end

always @(posedge tRRD_in)
begin: tRRDr
	#(tdevice_tRRD_ts - 1000) tRRD_out =  tRRD_in;
end
always @(negedge tRRD_in)
begin: tRRDf
	#(1*TScal) tRRD_out  =  tRRD_in;
end

always @(posedge tRCD_in[0])
begin: tRCD0r
	#(tdevice_tRCD_ts - 1000) tRCD_out[0]  =  tRCD_in[0];
end
always @(negedge tRCD_in[0])
begin: tRCD0f
	#(1*TScal) tRCD_out[0] =  tRCD_in[0];
end

always @(posedge tRCD_in[1])
begin: tRCD1r
	#(tdevice_tRCD_ts - 1000) tRCD_out[1]  =  tRCD_in[1];
end
always @(negedge tRCD_in[1])
begin: tRCD1f
	#(1*TScal) tRCD_out[1] =  tRCD_in[1];
end

always @(posedge tRCD_in[2])
begin: tRCD2r
	#(tdevice_tRCD_ts - 1000) tRCD_out[2]  =  tRCD_in[2];
end
always @(negedge tRCD_in[2])
begin: tRCD2f
	#(1*TScal) tRCD_out[2] =  tRCD_in[2];
end

always @(posedge tRCD_in[3])
begin: tRCD3r
	#(tdevice_tRCD_ts - 1000) tRCD_out[3]  =  tRCD_in[3];
end
always @(negedge tRCD_in[3])
begin: tRCD3f
	#(1*TScal) tRCD_out[3] =  tRCD_in[3];
end

always @(posedge tFAW_in[0])
begin: tFAW0r
	#(tdevice_tFAW_ts - 1000) tFAW_out[0]  =  tFAW_in[0];
end
always @(negedge tFAW_in[0])
begin: tFAW0f
	#(1*TScal) tFAW_out[0] =  tFAW_in[0];
end

always @(posedge tFAW_in[1])
begin: tFAW1r
	#(tdevice_tFAW_ts - 1000) tFAW_out[1]  =  tFAW_in[1];
end
always @(negedge tFAW_in[1])
begin: tFAW1f
	#(1*TScal) tFAW_out[1] =  tFAW_in[1];
end

always @(posedge tFAW_in[2])
begin: tFAW2r
	#(tdevice_tFAW_ts - 1000) tFAW_out[2]  =  tFAW_in[2];
end
always @(negedge tFAW_in[2])
begin: tFAW2f
	#(1*TScal) tFAW_out[2] =  tFAW_in[2];
end

always @(posedge tFAW_in[3])
begin: tFAW3r
	#(tdevice_tFAW_ts - 1000) tFAW_out[3]  =  tFAW_in[3];
end
always @(negedge tFAW_in[3])
begin: tFAW3f
	#(1*TScal) tFAW_out[3] =  tFAW_in[3];
end

always @(posedge tRASMIN_in[0])
begin: tRASMIN0r
	#(tdevice_tRASMIN_ts - 1000) tRASMIN_out[0]  =  tRASMIN_in[0];
end
always @(negedge tRASMIN_in[0])
begin: tRASMIN0f
	#(1*TScal) tRASMIN_out[0]  =  tRASMIN_in[0];
end

always @(posedge tRASMIN_in[1])
begin: tRASMIN1r
	#(tdevice_tRASMIN_ts - 1000) tRASMIN_out[1]  =  tRASMIN_in[1];
end
always @(negedge tRASMIN_in[1])
begin: tRASMIN1f
	#(1*TScal) tRASMIN_out[1]  =  tRASMIN_in[1];
end

always @(posedge tRASMIN_in[2])
begin: tRASMIN2r
	#(tdevice_tRASMIN_ts - 1000) tRASMIN_out[2]  =  tRASMIN_in[2];
end
always @(negedge tRASMIN_in[2])
begin: tRASMIN2f
	#(1*TScal) tRASMIN_out[2]  =  tRASMIN_in[2];
end

always @(posedge tRASMIN_in[3])
begin: tRASMIN3r
	#(tdevice_tRASMIN_ts - 1000) tRASMIN_out[3]  =  tRASMIN_in[3];
end
always @(negedge tRASMIN_in[3])
begin: tRASMIN3f
	#(1*TScal) tRASMIN_out[3]  =  tRASMIN_in[3];
end

always @(posedge tRASMAX_in[0])
begin: tRASMAX0r
	#(tdevice_tRASMAX_ts - 1000) tRASMAX_out[0]  =  tRASMAX_in[0];
end
always @(negedge tRASMAX_in[0])
begin: tRASMAX0f
	#(1*TScal) tRASMAX_out[0]  =  tRASMAX_in[0];
end

always @(posedge tRASMAX_in[1])
begin: tRASMAX1r
	#(tdevice_tRASMAX_ts - 1000) tRASMAX_out[1]  =  tRASMAX_in[1];
end
always @(negedge tRASMAX_in[1])
begin: tRASMAX1f
	#(1*TScal) tRASMAX_out[1]  =  tRASMAX_in[1];
end

always @(posedge tRASMAX_in[2])
begin: tRASMAX2r
	#(tdevice_tRASMAX_ts - 1000) tRASMAX_out[2]  =  tRASMAX_in[2];
end
always @(negedge tRASMAX_in[2])
begin: tRASMAX2f
	#(1*TScal) tRASMAX_out[2]  =  tRASMAX_in[2];
end

always @(posedge tRASMAX_in[3])
begin: tRASMAX3r
	#(tdevice_tRASMAX_ts - 1000) tRASMAX_out[3]  =  tRASMAX_in[3];
end
always @(negedge tRASMAX_in[3])
begin: tRASMAX3f
	#(1*TScal) tRASMAX_out[3]  =  tRASMAX_in[3];
end

always @(posedge tRTP_in[0])
begin: tRTP0r
	#(tdevice_tRTP_ts - 1000) tRTP_out[0]  =  tRTP_in[0];
end
always @(negedge tRTP_in[0])
begin: tRTP0f
	#(1*TScal) tRTP_out[0] =  tRTP_in[0];
end

always @(posedge tRTP_in[1])
begin: tRTP1r
	#(tdevice_tRTP_ts - 1000) tRTP_out[1]  =  tRTP_in[1];
end
always @(negedge tRTP_in[1])
begin: tRTP1f
	#(1*TScal) tRTP_out[1] =  tRTP_in[1];
end

always @(posedge tRTP_in[2])
begin: tRTP2r
	#(tdevice_tRTP_ts - 1000) tRTP_out[2]  =  tRTP_in[2];
end
always @(negedge tRTP_in[2])
begin: tRTP2f
	#(1*TScal) tRTP_out[2] =  tRTP_in[2];
end

always @(posedge tRTP_in[3])
begin: tRTP3r
	#(tdevice_tRTP_ts - 1000) tRTP_out[3]  =  tRTP_in[3];
end
always @(negedge tRTP_in[3])
begin: tRTP3f
	#(1*TScal) tRTP_out[3] =  tRTP_in[3];
end

always @(posedge tWR_in[0])
begin: tWR0r
	#(tdevice_tWR_ts - 1000) tWR_out[0]  =  tWR_in[0];
end
always @(negedge tWR_in[0])
begin: tWR0f
	#(1*TScal) tWR_out[0]  =  tWR_in[0];
end

always @(posedge tWR_in[1])
begin: tWR1r
	#(tdevice_tWR_ts - 1000) tWR_out[1]  =  tWR_in[1];
end
always @(negedge tWR_in[1])
begin: tWR1f
	#(1*TScal) tWR_out[1]  =  tWR_in[1];
end

always @(posedge tWR_in[2])
begin: tWR2r
	#(tdevice_tWR_ts - 1000) tWR_out[2]  =  tWR_in[2];
end
always @(negedge tWR_in[2])
begin: tWR2f
	#(1*TScal) tWR_out[2]  =  tWR_in[2];
end

always @(posedge tWR_in[3])
begin: tWR3r
	#(tdevice_tWR_ts - 1000) tWR_out[3]  =  tWR_in[3];
end
always @(negedge tWR_in[3])
begin: tWR3f
	#(1*TScal) tWR_out[3]  =  tWR_in[3];
end

always @(posedge tWTR_in[0])
begin: tWTR0r
	#(tdevice_tWTR_ts - 1000) tWTR_out[0]  =  tWTR_in[0];
end
always @(negedge tWTR_in[0])
begin: tWTR0f
	#(1*TScal) tWTR_out[0] =  tWTR_in[0];
end

always @(posedge tWTR_in[1])
begin: tWTR1r
	#(tdevice_tWTR_ts - 1000) tWTR_out[1]  =  tWTR_in[1];
end
always @(negedge tWR_in[1])
begin: tWTR1f
	#(1*TScal) tWTR_out[1] =  tWTR_in[1];
end

always @(posedge tWTR_in[2])
begin: tWTR2r
	#(tdevice_tWTR_ts - 1000) tWTR_out[2]  =  tWTR_in[2];
end
always @(negedge tWTR_in[2])
begin: tWTR2f
	#(1*TScal) tWTR_out[2] =  tWTR_in[2];
end

always @(posedge tWTR_in[3])
begin: tWTR3r
	#(tdevice_tWTR_ts - 1000) tWTR_out[3]  =  tWTR_in[3];
end
always @(negedge tWTR_in[3])
begin: tWTR3f
	#(1*TScal) tWTR_out[3] =  tWTR_in[3];
end

always @(posedge tRP_in[0])
begin: tRP0r
	#(tdevice_tRP_ts - 1000) tRP_out[0]  =  tRP_in[0];
end
always @(negedge tRP_in[0])
begin: tRP0f
	#(1*TScal) tRP_out[0]  =  tRP_in[0];
end

always @(posedge tRP_in[1])
begin: tRP1r
	#(tdevice_tRP_ts - 1000) tRP_out[1]  =  tRP_in[1];
end
always @(negedge tRP_in[1])
begin: tRP1f
	#(1*TScal) tRP_out[1]  =  tRP_in[1];
end

always @(posedge tRP_in[2])
begin: tRP2r
	#(tdevice_tRP_ts - 1000) tRP_out[2]  =  tRP_in[2];
end
always @(negedge tRP_in[2])
begin: tRP2f
	#(1*TScal) tRP_out[2]  =  tRP_in[2];
end

always @(posedge tRP_in[3])
begin: tRP3r
	#(tdevice_tRP_ts - 1000) tRP_out[3]  =  tRP_in[3];
end
always @(negedge tRP_in[3])
begin: tRP3f
	#(1*TScal) tRP_out[3]  =  tRP_in[3];
end

always @(posedge tXSNR_in)
begin: tXSNRr
	#(tdevice_tRFCMIN_ts + 9000) tXSNR_out =  tXSNR_in;
end
always @(negedge tXSNR_in)
begin: tXSNRf
	#(1*TScal) tXSNR_out =  tXSNR_in;
end

always @(posedge tRFCMIN_in)
begin: tRFCMINr
	#(tdevice_tRFCMIN_ts - 1000) tRFCMIN_out =  tRFCMIN_in;
end
always @(negedge tRFCMIN_in)
begin: tRFCMINf
	#(1*TScal) tRFCMIN_out =  tRFCMIN_in;
end

always @(posedge tRFCMAX_in)
begin: tRFCMAXr
	#(tdevice_tRFCMAX_ts - 1000) tRFCMAX_out =  tRFCMAX_in;
end
always @(negedge tRFCMAX_in)
begin: tRFCMAXf
	#(1*TScal) tRFCMAX_out =  tRFCMAX_in;
end

always @(posedge REFPer_in)
begin: REFPerr
	#(tdevice_REFPer_ts - 1000) REFPer_out =  REFPer_in;
end
always @(negedge REFPer_in)
begin: REFPerf
	#(1*TScal) REFPer_out  =  REFPer_in;
end

always @(posedge tCKAVGMAX_in)
begin: tCKAVGMAXr
	#(tdevice_tCKAVGMAX_ts - 1000) tCKAVGMAX_out =  tCKAVGMAX_in;
end
always @(negedge tCKAVGMAX_in)
begin: tCKAVGMAXf
	#(1*TScal) tCKAVGMAX_out =  tCKAVGMAX_in;
end

///////////////////////////////////////////////////////////////////////////////
// Process for clock frequency determination
///////////////////////////////////////////////////////////////////////////////
always @(CKDiff)
begin : CK_period_scan
	if (CKDiff)
	begin
		tmpper =  $time - previous;
		if (tmpper > 0)
			CKPeriod =  tmpper;
		previous =  $time;
		CKHalfPer  =  CKPeriod/2;
		CKDLLDelay =  CKPeriod - DLL_TIME;
	end
end
///////////////////////////////////////////////////////////////////////////////
// Processes for generating internal clock from DLL
///////////////////////////////////////////////////////////////////////////////
reg     CKInt1;
always @(CKDiff)
begin : CK_temp
	if ($time != 0)
		CKtemp <= #(CKHalfPer - 3) ~CKDiff;
end
always @(CKtemp)
begin : DLL_block
	CKInt <= #(CKDLLDelay + 3) CKtemp;
	#1 CKInt1  =  CKInt;
end

always @(In_d)
begin : Init_d
	if (In_d)
		#(400000) Init_delay =  1'b1;
	else
		Init_delay =  1'b0;
end

always @(posedge DLL_delay)
begin : DLLdelay
	cnt  =  0;
	DLL_delay_elapsed  =  1'b0;
end

always @(posedge CKDiff)
begin : DLLdelay1
	cnt  =  cnt + 1;
	if (cnt == 199)
		DLL_delay_elapsed  =  1'b1;
end

///////////////////////////////////////////////////////////////////////////////
// Process for generating differential clock from CK and CKNeg
///////////////////////////////////////////////////////////////////////////////
always @(CK, CKNeg)
begin : DiffCK
	if (CK && ~CKNeg)
		CKDiff =  1'b1;
	if (~CK && CKNeg)
		CKDiff =  1'b0;
	#1 CKDiff1 =  CKDiff;
end

always @(UDQSIn, UDQSNegIn)
begin : DiffUDQS
	if (UDQSIn && ~UDQSNegIn)
		UDQSDiff =  1'b1;
	if (~UDQSIn && UDQSNegIn)
		UDQSDiff =  1'b0;
end

always @(LDQSIn, LDQSNegIn)
begin : DiffLDQS
	if (LDQSIn && ~LDQSNegIn)
		LDQSDiff =  1'b1;
	if (~LDQSIn && LDQSNegIn)
		LDQSDiff =  1'b0;
end

always @(MR)
begin
	if (MR[2:0]==3'b010)
		burst_len  =  4;
	else if (MR[2:0]==3'b011)
		burst_len  =  8;
	wr_rec =  MR[11:9] + 1;
	cas_lat  =  MR[6:4];
	if (((char[0]=="5" || (char[0]=="3" && char[1]=="7")) &&
		(cas_lat==5)) || ((char[0]=="3" && char[1]=="E") && cas_lat==3))
	begin
		$display("Programmed CL value is not supported in ");
		$display("this speed grade! ");
	end
end

always @(EMR)
begin
	add_lat  =  EMR[5:3];
end
/////////////////////////////////////////////////////////////////////////////
////Check Read task
/////////////////////////////////////////////////////////////////////////////
reg     WTR_viol =  1'b0;
reg     rd_rd_viol =  1'b0;
reg     rd_interr_viol =  1'b0;
reg     rd_DLL_viol    =  1'b0;
reg     rd_PD_viol =  1'b0;
reg     rd_lock_viol =  1'b0;

task CheckRead;
begin
	read_permit  =  1'b1;
	WTR_viol =  1'b0;
	rd_rd_viol =  1'b0;
	rd_interr_viol =  1'b0;
	rd_DLL_viol    =  1'b0;
	rd_PD_viol =  1'b0;
	rd_lock_viol =  1'b0;
	for(j=  0;j<=BankNum;j =  j+1)
	begin
		if (WTR_elapsed[j]==1'b0 || tWTR_out[j]==1'b0)
		begin
			WTR_viol =  1'b1;
			read_permit  =  1'b0;
		end
	end
	if (rd_rd_cnt == 1)
	begin
		rd_rd_viol =  1'b1;
		read_permit  =  1'b0;
	end
	if (rd_rd_cnt == 3 && burst_len == 8)
	begin
		rd_interr_viol =  1'b1;
		read_permit    =  1'b0;
	end
	if (DLL_delay_elapsed == 1'b0)
	begin
		rd_DLL_viol    =  1'b1;
		read_permit    =  1'b0;
	end
	if (PD_read_delay == 1'b1)
	begin
		rd_PD_viol =  1'b1;
		read_permit  =  1'b0;
	end
	if (DLL_reset_needed == 1'b1)
	begin
		rd_lock_viol =  1'b1;
		read_permit  =  1'b0;
	end
	if (WTR_viol == 1'b1)
		$display("tWTR has not elapsed since the end of last write burst!");
	if (rd_rd_viol == 1'b1)
		$display("2 cycles must elapse between consecutive READ commands!");
	if (rd_interr_viol == 1'b1)
	begin
		$display("Interrupting READ command must be issued exactly 2 ");
		$display("cycles after previous READ command!");
	end
	if (rd_DLL_viol == 1'b1)
	begin
		$display("200 cycles must elapse between DLL reset and READ ");
		$display("command!");
	end
	if (rd_PD_viol == 1'b1)
		$display("tXARDS has not elapsed since slow-exit power-down exit!");
	if (rd_lock_viol == 1'b1)
		$display("DLL must be reset prior to read command!");
end
endtask
/////////////////////////////////////////////////////////////////////////////
////Check Write task
/////////////////////////////////////////////////////////////////////////////
reg     RTW_viol =  1'b0;
reg     wr_wr_viol =  1'b0;
reg     wr_interr_viol =  1'b0;

task CheckWrite;
begin
	write_permit =  1'b1;
	RTW_viol =  1'b0;
	wr_wr_viol =  1'b0;
	wr_interr_viol =  1'b0;
	if (RTW_elapsed == 1'b0)
	begin
		RTW_viol   =  1'b1;
		write_permit =  1'b0;
	end
	if (wr_wr_cnt == 1)
	begin
		wr_wr_viol   =  1'b1;
		write_permit =  1'b0;
	end
	if (wr_wr_cnt == 3 && burst_len == 8)
	begin
		wr_interr_viol =  1'b1;
		write_permit   =  1'b0;
	end
	if (RTW_viol == 1'b1)
	begin
		$display("BL/2 + 2 cycles must elapse ");
		$display("between READ and WRITE commands!");
	end
	if (wr_wr_viol == 1'b1)
	begin
		$display("2 cycles must elapse between ");
		$display("consecutive WRITE commands!");
	end
	if (wr_interr_viol == 1'b1)
	begin
		$display("Interrupting WRITE command must ");
		$display("be issued exactly 2 cycles after ");
		$display(" previous WRITE command!");
	end
end
endtask

always @(posedge CKDiff)
begin : CK_frequency
	if (CK_rise != 0)
	begin
		if (CK_stable == 1'b1)
		begin
			if (($time - CK_rise)!= CK_period)
			begin
				if (Pre_PD && ODT_off && freq_ch_cnt == 0)
					freq_change  =  1'b1;
				else if (~SR_enter_cycle && ~Reset_enter_cycle)
				begin
					$display("Input clock frequency is not stable!");
				end
			end
			fork
			SimulationEnd <= #(1000) 1'b0;
			SimulationEnd <= #(2*CK_period) 1'b1;
			join
			if ((CK_period > tdevice_tCKAVGMAX_ts) && ~SR_enter_cycle &&
				~Reset_enter_cycle)
				$display("Input clock period exceeds tCKAVG(max)!");
		end
		CK_stable  =  1'b1;
	end
	CK_period  =  $time - CK_rise;
	CK_rise    =  $time;
end

always @(posedge CKDiff)
begin : logic_levels
	defined_logic_levels =  1'b1;
	if ((CKE !== 0 && CKE !== 1) || (RASNeg !== 0 && RASNeg !== 1) ||
		(CASNeg !== 0 && CASNeg !== 1) || (WENeg !== 0 && WENeg !== 1))
		defined_logic_levels =  1'b0;
	for(i=  0;i<=1;i =  i+1)
	begin
		if (BA[i] !== 0 && BA[i] !== 1)
			defined_logic_levels =  1'b0;
	end
	for(i=  0;i<=12;i=  i+1)
	begin
		if (A[i] !== 0 && A[i] !== 1)
			defined_logic_levels =  1'b0;
	end
end

always @(posedge CKDiff1)
begin : command_decode
	Command  =  ILL;
	if (defined_logic_levels)
	begin
		if (~CSNeg && ~RASNeg && ~CASNeg && ~WENeg )
			Command  =  LM;
		else if (~CSNeg && ~RASNeg && ~CASNeg && WENeg)
			Command  =  REF;
		else if (CSNeg)
			Command  =  DES;
		else if (~CSNeg && RASNeg && CASNeg && WENeg)
			Command  =  NOP;
		else if (~CSNeg && ~RASNeg && CASNeg && ~WENeg)
			Command  =  PRE;
		else if (~CSNeg && ~RASNeg && CASNeg && WENeg)
			Command  =  ACT;
		else if (~CSNeg && RASNeg && ~CASNeg && ~WENeg)
			Command  =  WR;
		else if (~CSNeg && RASNeg && ~CASNeg && WENeg)
			Command  =  RD;
	end
end

always @(posedge CKDiff1)
begin : initialization
	case (Current_state)
	init0 :
	begin
		if (CKE == 1)
		begin
			if (PoweredUp && (Command == NOP || Command == DES))
			begin
				Next_state =  init1;
				In_d =  1'b1;
				if (((CK_period < tperiod_CK) && (cas_lat > 2) &&
					(cas_lat < 7)) || CK_period > tdevice_tCKAVGMAX_ts)
				begin
					$display("Clock must be stable before CKE is ");
					$display("raised high!");
				end
			end
			else
			begin
				$display("Invalid start of initialization!");
				Next_state =  illegal;
			end
		end
	end
	
	init1 :
	begin
		if (Init_delay && Command == PRE && A[10] == 1)
		begin
			Next_state =  init2;
			CK_cnt =  0;
			In_d   =  0;
			tRP_in[0]  =  0;
			tRP_in[0] <= #(1000) 1;
		end
	end
	
	init2 :
	begin
		if (tRP_out[0] == 1)
		begin
			if (CK_cnt < 1)
				CK_cnt =  CK_cnt + 1;
			else if (Command == LM && BA == 2)
			begin
				Next_state =  init3;
				CK_cnt =  0;
				EMR2   =  A;
				if (EMR2 != 0)
					$display("Invalid value programmed to EMR2!");
			end
		end
	end
	
	init3 :
	begin
		if (CK_cnt < 1)
			CK_cnt =  CK_cnt + 1;
		else if (Command == LM && BA == 3)
		begin
			Next_state =  init4;
			CK_cnt =  0;
			EMR3   =  A;
			if (EMR3 != 0)
				$display("Invalid value programmed to EMR3!");
		end
	end
	
	init4 :
	begin
		if (CK_cnt < 1)
			CK_cnt =  CK_cnt + 1;
		else if (Command == LM && BA == 1 && A[0] == 0)
		begin
			Next_state =  init5;
			CK_cnt =  0;
			EMR    =  A;
			if (EMR[9:7] != 0)
				$display("Invalid value programmed to EMR!");
		end
	end
	
	init5 :
	begin
		if (CK_cnt < 1)
			CK_cnt =  CK_cnt + 1;
		else if (Command == LM && BA == 0 && A[8] == 1)
		begin
			Next_state =  init6;
			CK_cnt =  0;
			DLL_delay  =  1;
			DLL_delay <= #(1000) 0;
		end
	end
	
	init6 :
	begin
		if (CK_cnt < 1)
			CK_cnt =  CK_cnt + 1;
		else if (Command == PRE && A[10] == 1)
		begin
			Next_state =  init7;
			CK_cnt =  0;
			tRP_in[0]  =  0;
			tRP_in[0] <= #(1000) 1;
		end
	end
	
	init7 :
	begin
		if (tRP_out[0] == 1)
		begin
			if (CK_cnt < 1)
				CK_cnt =  CK_cnt + 1;
			else if (Command == REF)
			begin
				Next_state =  init8;
				tRFCMIN_in =  0;
				tRFCMAX_in =  0;
				fork
				tRFCMIN_in <= #(1000) 1;
				tRFCMAX_in <= #(1000) 1;
				join
			end
		end
	end
	
	init8 :
	begin
		if (tRFCMIN_out && Command == REF)
		begin
			Next_state =  init9;
			tRFCMIN_in =  0;
			tRFCMAX_in =  0;
			fork
			tRFCMIN_in <= #(1000) 1;
			tRFCMAX_in <= #(1000) 1;
			join
		end
	end
	
	init9 :
	begin
		if (tRFCMIN_out && Command == LM && BA == 0 && A[8] == 0)
		begin
			Next_state =  init10;
			CK_cnt =  0;
			MR =  A;
			if (MR[11:9] == 0 || MR[11:9] > 5 || MR[6:4] < 3 ||
				MR[6:4] > 5 || (MR[2:0] != 2 && MR[2:0] !=3))
				$display("Invalid value programmed to mode register!");
			if (MR[7] != 0)
				$display("Mode should be set to normal, not test!");
		end
	end
	
	init10 :
	begin
		if (CK_cnt < 1)
			CK_cnt =  CK_cnt + 1;
		else if (Command == LM && BA == 1 && A[9:7] == 7)
		begin
			Next_state =  init11;
			CK_cnt =  0;
		end
	end
	
	init11 :
	begin
		if (CK_cnt < 1)
			CK_cnt =  CK_cnt + 1;
		else if (Command == LM && BA == 1 && A[9:7] == 0)
		begin
			Next_state =  init12;
			CK_cnt =  0;
			EMR    =  A;
			if (add_lat > 4)
				$display("Invalid AL value programmed!");
			if (EMR[0] != 0)
				$display("DLL must be enabled for normal operation!");
		end
	end
	
	init12 :
	begin
		Initialized  =  1'b1;
	end
	
	illegal :
	begin
	end
	endcase
	Current_state    =  Next_state;
end

always @(posedge CKDiff1)
begin : StateGen
	if (Initialized)
	begin
		idle =  1'b1;
		for(i=  0;i<=BankNum;i =  i+1)
		begin
			if (Curr_bank_state[i] != precharged)
				idle =  1'b0;
		end
		if (CKE && ~(SelfRefresh || Pre_PD || Act_PD || Reset))
		begin
			if (Command == LM)
			begin
				if (idle)
				begin
					for(i=  0;i<=BankNum;i =  i+1)
					begin
						Next_bank_state[i] =  mrsetting;
					end
					if (BA == 0)
					begin
						MR =  A;
						if (MR[8] == 1)
							fork
							DLL_delay  =  1;
						DLL_delay <= #(1000) 0;
						ODT_off  =  1'b0;
						freq_change  =  1'b0;
						DLL_reset_needed =  1'b0;
						join
						if (MR[11:9] == 0 || MR[11:9] > 5 || cas_lat < 3 ||
							cas_lat > 5 || (MR[2:0] != 2 && MR[2:0] !=3))
							$display("Invalid value programmed to mode reg. !");
						if (MR[7] != 0)
							$display("Mode should be set to normal, not test!");
					end
					if (BA == 1)
					begin
						EMR  =  A;
						if ((add_lat > 4) || (EMR[9:7] != 0 &&
							EMR[9:7] != 7))
							$display("Invalid value programmed to EMR !");
						if (EMR[0] != 0)
							$display("DLL must be enabled for normal oper. !");
					end
					if (BA == 2)
					begin
						EMR2 =  A;
						if (EMR2 != 0)
							$display("Invalid value programmed to EMR2!");
					end
					if (BA == 3)
					begin
						EMR3 =  A;
						if (EMR3 != 0)
							$display("Invalid value programmed to EMR3!");
					end
				end
				else
				begin
					$display("The LM command can only be issued when");
					$display("all banks are idle!");
				end
			end
			if (Curr_bank_state[0] == mrsetting && Command != NOP &&
				Command != DES)
			begin
				$display("Only NOP or DESELECT commands are valid during ");
				$display("tMRD after LM command!");
			end
			if (Command == REF)
			begin
				if (idle)
				begin
					for(i=  0;i<=BankNum;i =  i+1)
					begin
						Next_bank_state[i] =  refreshing;
					end
					tRFCMIN_in =  0;
					tRFCMAX_in =  0;
					fork
					tRFCMIN_in <= #(1000) 1;
					tRFCMAX_in <= #(1000) 1;
					join
				end
				else
				begin
					$display("The REFRESH command can only be ");
					$display("issued when all banks are idle!");
				end
			end
			if (Curr_bank_state[0] == refreshing && Command != NOP &&
				Command != DES)
			begin
				$display("Only NOP or DESELECT commands are valid during ");
				$display("tRFC(min) after REFRESH command!");
			end
			prechall_viol  =  1'b0;
			for(i=  0;i<=BankNum;i =  i+1)
			begin
				if (Curr_bank_state[i] == prechall && Command != NOP &&
					Command != DES)
					prechall_viol  =  1'b1;
			end
			if (prechall_viol)
			begin
				$display("Only NOP or DESELECT commands are valid during ");
				$display("tRPA after PRECHARGE ALL command!");
			end
			if (Command == PRE && A[10] == 1 && tRASMIN_out != 8'hF)
			begin
				$display("tRAS(min) has not elapsed since activation of ");
				$display("the last activated bank!");
			end
			
			for(i=  0;i<=BankNum;i =  i+1)
			begin
				case (Curr_bank_state[i])
				precharged :
				begin
					if (Command == ACT && BA == i)
					begin
						if (~active_forbid)
						begin
							if (tRRD_out == 1)
							begin
								if (tRC_out[i] == 1)
								begin
									Next_bank_state[i] =  activating;
									active_row[i]  =  A;
									tRCD_in[i] =  0;
									tRASMIN_in[i]  =  0;
									tRASMAX_in[i]  =  1;
									tRRD_in  =  0;
									tRC_in[i]  =  0;
									fork
									tRCD_in[i] <= #(1000) 1;
									tRASMIN_in[i] <= #(1000)  1;
									tRRD_in <= #(1000) 1;
									tRC_in[i] <= #(1000) 1;
									join
								end
								else
								begin
									$display("tRC has not elapsed since");
									$display("activation of the bank!");
								end
							end
							else
							begin
								$display("tRRD has not elapsed since ");
								$display("activation of the last ");
								$display("activated bank! ");
							end
						end
						else
						begin
							$display("More than 4 ACTIVE commands ");
							$display("issued during tFAW!");
						end
					end
				end
				
				mrsetting :
				begin
					Next_bank_state[i] =  precharged;
				end
				
				precharging :
				begin
					if (Command != NOP && Command != DES && BA == i)
					begin
						$display("During tRP after PRECHARGE command only");
						$display("valid commands to same bank are NOP or ");
						$display("DESELECT !");
					end
				end
				
				prechall :
				begin
					if (tRP_out[i] == 1)
						Next_bank_state[i] =  precharged;
				end
				
				active :
				begin
					if (Command == PRE && A[10] == 0 && BA == i)
					begin
						if (tRASMIN_out[i] == 1'b1)
						begin
							Next_bank_state[i] =  precharging;
							tRASMAX_in[i]  =  0;
							tRP_in[i]  =  0;
							tRP_in[i] <= #(1000) 1;
						end
						else
						begin
							$display("tRAS(min) has not elapsed ");
							$display("since activation of the bank!");
						end
					end
					else if (Command == PRE && A[10] == 1)
					begin
						if (tRASMIN_out == 8'hF)
						begin
							Next_bank_state[i] =  prechall;
							tRASMAX_in =  0;
							tRP_in[i]  =  0;
							tRP_in[i] <= #(1000) 1;
						end
					end
					else if (Command == WR && BA == i)
					begin
						CheckWrite;
						if (write_permit)
						begin
							wr_wr_cnt  =  0;
							start_column[i*11] =  A[9:0];
							AL[i*11] =  add_lat;
							CL[i*11] =  cas_lat;
							write_sch[i][0]  =  1'b1;
							WR_elapsed[i]    =  1'b0;
							tWR_in[i]  =  1'b0;
							WTR_elapsed[i] =  1'b0;
							tWTR_in[i] =  1'b0;
							precharge_cnt[i] =  0;
							wr_rd_cnt[i] =  0;
							if (A[10] == 0)
								Next_bank_state[i] =  writting;
							else
								Next_bank_state[i] =  writtingap;
						end
					end
					else if (Command == RD && BA == i)
					begin
						CheckRead;
						if (read_permit)
						begin
							start_column[i*11] =  A[9:0];
							AL[i*11] =  add_lat;
							CL[i*11] =  cas_lat;
							read_sch[i][0] =  1'b1;
							AL_elapsed[i][0] =  1'b0;
							RTP_elapsed[i]   =  1'b0;
							tRTP_in[i] =  1'b0;
							RTW_elapsed  =  1'b0;
							rd_wr_cnt    =  0;
							precharge_cnt[i] =  0;
							rd_act_cnt[i]    =  0;
							if (rd_rd_cnt >= ((burst_len/2)-1))
								preamble[i][0] =  1'b1;
							else
								preamble[i][0] =  1'b0;
							rd_rd_cnt  =  0;
							if (add_lat == 0 && burst_len == 4)
							begin
								tRTP_in[i] =  0;
								tRTP_in[i] <= #(1000) 1;
							end
							if (A[10] == 0)
								Next_bank_state[i] =  reading;
							else
								Next_bank_state[i] =  readingap;
						end
					end
					if (Command == ACT && BA == i)
					begin
						$display("Previous active row in same bank ");
						$display("not been closed (precharged)!");
					end
				end
				
				activating :
				begin
					if (BA == i)
					begin
						if (Command == WR)
						begin
							if ((add_lat*CK_period) < tdevice_tRCD_ts)
							begin
								$display("Greater AL value should ");
								$display("be programmed !");
							end
							else
							begin
								CheckWrite;
								if (write_permit)
								begin
									wr_wr_cnt  =  0;
									start_column[i*11] =  A[9:0];
									AL[i*11] =  add_lat;
									CL[i*11] =  cas_lat;
									write_sch[i][0]  =  1'b1;
									tWR_in[i]  =  0;
									WTR_elapsed[i] =  1'b0;
									WR_elapsed[i]  =  1'b0;
									tWTR_in[i] =  1'b0;
									precharge_cnt[i] =  0;
									wr_rd_cnt[i] =  0;
									if (A[10] == 0)
										Next_bank_state[i] =  writting;
									else
										Next_bank_state[i] =  writtingap;
								end
							end
						end
						else if (Command == RD)
						begin
							if ((add_lat*CK_period) < tdevice_tRCD_ts)
							begin
								$display("Greater AL value should ");
								$display("be programmed !");
							end
							else
							begin
								CheckRead;
								if (read_permit)
								begin
									start_column[i*11] =  A[9:0];
									AL[i*11] =  add_lat;
									CL[i*11] =  cas_lat;
									read_sch[i][0] =  1'b1;
									AL_elapsed[i][0] =  1'b0;
									RTP_elapsed[i]   =  1'b0;
									tRTP_in[i] =  1'b0;
									RTW_elapsed  =  1'b0;
									rd_wr_cnt    =  0;
									precharge_cnt[i] =  0;
									rd_act_cnt[i]    =  0;
									if (rd_rd_cnt >= ((burst_len/2)-1))
										preamble[i][0] =  1'b1;
									else
										preamble[i][0] =  1'b0;
									rd_rd_cnt  =  0;
									if (A[10] == 0)
										Next_bank_state[i] =  reading;
									else
										Next_bank_state[i] =  readingap;
								end
							end
						end
						else if (Command != NOP && Command != DES)
						begin
							$display("Illegal command to same bank ");
							$display("during tRCD after activation!");
						end
					end
				end
				
				writting :
				begin
					if (last_write[i] == 1'b1)
					begin
						precharge_cnt[i] =  precharge_cnt[i] + 1;
						wr_rd_cnt[i] =  wr_rd_cnt[i] + 1;
						if (precharge_cnt[i] == (burst_len/2)+1)
						begin
							tWR_in[i]  =  0;
							tWR_in[i] <= #(1000) 1;
						end
						else if (precharge_cnt[i] == (burst_len/2) +
							wr_rec + 1)
							WR_elapsed[i]  =  1'b1;
						if (wr_rd_cnt[i] == (burst_len/2)+1)
						begin
							tWTR_in[i] =  0;
							tWTR_in[i] <= #(1000) 1;
						end
					end
					for(j=  0;j<=10;j  =  j+1)
					begin
						if (write_sch[i][j])
						begin
							if (AL[i*11+j] > 0)
								AL[i*11+j] =  AL[i*11+j] - 1;
							else if (CL[i*11+j] > 3)
								CL[i*11+j] =  CL[i*11+j] - 1;
							else
								fork
								current_bank =  i;
							current_row  =  active_row[i];
							current_column =  start_column[i*11+j];
							In_data  =  0;
							In_data <= #((3*CK_period/4) - 1000) 1;
							write_sch[i][j]  =  1'b0;
							last_write[i]    =  1'b1;
							precharge_cnt[i] =  0;
							wr_rd_cnt[i] =  0;
							WR_elapsed[i]  =  1'b0;
							WTR_elapsed[i] =  1'b0;
							join
						end
					end
					if (Command == WR && BA == i)
					begin
						CheckWrite;
						if (write_permit)
						begin
							wr_wr_cnt  =  0;
							last_write[i]  =  1'b0;
							precharge_cnt[i] =  0;
							wr_rd_cnt[i] =  0;
							WR_elapsed[i]  =  1'b0;
							WTR_elapsed[i] =  1'b0;
							free_slot  =  freeslot(write_sch[i]);
							start_column[i*11+free_slot] =  A[9:0];
							AL[i*11+free_slot] =  add_lat;
							CL[i*11+free_slot] =  cas_lat;
							write_sch[i][free_slot]  =  1'b1;
							tWR_in[i]  =  0;
							tWTR_in[i] =  1'b0;
							if (A[10] == 0)
								Next_bank_state[i] =  writting;
							else
								Next_bank_state[i] =  writtingap;
						end
					end
					else if (Command == RD && BA == i)
					begin
						CheckRead;
						if (read_permit)
						begin
							start_column[i*11] =  A[9:0];
							AL[i*11] =  add_lat;
							CL[i*11] =  cas_lat;
							read_sch[i][0] =  1'b1;
							AL_elapsed[i][0] =  1'b0;
							RTP_elapsed[i]   =  1'b0;
							tRTP_in[i] =  1'b0;
							RTW_elapsed  =  1'b0;
							rd_wr_cnt    =  0;
							precharge_cnt[i] =  0;
							rd_act_cnt[i]    =  0;
							preamble[i][0]   =  1'b1;
							rd_rd_cnt  =  0;
							if (add_lat == 0 && burst_len == 4)
							begin
								tRTP_in[i] =  0;
								tRTP_in[i] <= #(1000) 1;
							end
							if (A[10] == 0)
								Next_bank_state[i] =  reading;
							else
								Next_bank_state[i] =  readingap;
						end
					end
					else if (WR_elapsed[i])
					begin
						if (tWR_out[i])
						begin
							if (Command == PRE && A[10] == 0 && BA == i)
							begin
								if (tRASMIN_out[i] == 1'b1)
								begin
									Next_bank_state[i] =  precharging;
									tRASMAX_in[i]  =  0;
									tRP_in[i]  =  0;
									tRP_in[i] <= #(1000) 1;
								end
								else
								begin
									$display("tRAS(min) has not elapsed ");
									$display("since activ. of the bank!");
								end
							end
							else if (Command == PRE && A[10] == 1)
							begin
								if (tRASMIN_out == 8'hF)
								begin
									Next_bank_state[i] =  prechall;
									tRASMAX_in =  0;
									tRP_in[i]  =  0;
									tRP_in[i] <= #(1000) 1;
								end
							end
							else
								Next_bank_state[i] =  active;
						end
						else
						begin
							$display("Greater WR value should ");
							$display("be programmed!");
						end
					end
					if (wr_rd_cnt[i] ==(burst_len/2) + 2)
						WTR_elapsed[i] =  1'b1;
				end
				
				writtingap :
				begin
					if (last_write[i] == 1'b1)
					begin
						precharge_cnt[i] =  precharge_cnt[i] + 1;
						wr_rd_cnt[i] =  wr_rd_cnt[i] + 1;
						if (precharge_cnt[i] == (burst_len/2)+1)
						begin
							tWR_in[i]  =  0;
							tWR_in[i] <= #(1000) 1;
						end
						else if (precharge_cnt[i] == (burst_len/2) +
							wr_rec + 1)
							WR_elapsed[i]  =  1'b1;
						if (wr_rd_cnt[i] == (burst_len/2)+1)
						begin
							tWTR_in[i] =  0;
							tWTR_in[i] <= #(1000) 1;
						end
						else if (wr_rd_cnt[i] == (burst_len/2)+3)
							WTR_elapsed[i] =  1'b1;
					end
					for(j=  0;j<=10;j=  j+1)
					begin
						if (write_sch[i][j])
						begin
							if (AL[i*11+j] > 0)
								AL[i*11+j] =  AL[i*11+j] - 1;
							else if (CL[i*11+j] > 3)
								CL[i*11+j] =  CL[i*11+j] - 1;
							else
								fork
								current_bank =  i;
							current_row  =  active_row[i];
							current_column =  start_column[i*11+j];
							In_data  =  0;
							In_data <= #((3*CK_period/4) - 1000) 1;
							write_sch[i][j]  =  1'b0;
							last_write[i]    =  1'b1;
							precharge_cnt[i] =  0;
							wr_rd_cnt[i] =  0;
							WR_elapsed[i]  =  1'b0;
							join
						end
					end
					if (WR_elapsed[i])
					begin
						if (tWR_out[i])
						begin
							Next_bank_state[i] =  precharging;
							tRASMAX_in[i]  =  0;
							tRP_in[i]  =  0;
							tRP_in[i] <= #(1000) 1;
						end
						else
						begin
							$display("Greater WR value should ");
							$display("be programmed!");
						end
					end
				end
				
				reading :
				begin
					precharge_cnt[i]   =  precharge_cnt[i] + 1;
					rd_act_cnt[i]  =  rd_act_cnt[i] + 1;
					if (precharge_cnt[i] == add_lat + (burst_len/2) - 2)
					begin
						tRTP_in[i] =  0;
						tRTP_in[i] <= #(1000) 1;
					end
					else if (precharge_cnt[i] == add_lat +
						(burst_len/2))
						RTP_elapsed[i] =  1'b1;
					for(j=  0;j<=10;j  =  j+1)
					begin
						if (read_sch[i][j] == 1'b1 &&
							AL_elapsed[i][j] == 1'b0)
						begin
							if (AL[i*11+j] > 0)
								AL[i*11+j] =  AL[i*11+j] - 1;
							else
							begin
								current_bank =  i;
								current_row  =  active_row[i];
								current_column =  start_column[i*11+j];
								read_delay =  CL[i*11+j];
								if (read_delay == 3)
								begin
									if (preamble[i][j])
										fork
										preamble_gen =  1'b0;
									preamble_gen <=
									#((3*CK_period/4) - 1000) 1'b1;
									preamble_gen <=
									#(3*CK_period/4) 1'bz;
									join
								end
								itmp =  i;
								jtmp =  j;
								wait_read[i][j]  =  0;
								->wr_event;
								AL_elapsed[i][j] =  1'b1;
							end
						end
					end
					if (Command == RD && BA == i)
					begin
						CheckRead;
						if (read_permit)
						begin
							precharge_cnt[i] =  0;
							rd_wr_cnt  =  0;
							rd_act_cnt[i]  =  0;
							RTP_elapsed[i] =  1'b0;
							RTW_elapsed    =  1'b0;
							free_slot  =  freeslot(read_sch[i]);
							start_column[i*11+free_slot] =  A[9:0];
							AL[i*11+free_slot] =  add_lat;
							CL[i*11+free_slot] =  cas_lat;
							read_sch[i][free_slot] =  1'b1;
							AL_elapsed[i][free_slot] =  1'b0;
							tRTP_in[i] =  1'b0;
							if (rd_rd_cnt >= (burst_len/2)+1)
								preamble[i][free_slot] =  1'b1;
							else
								preamble[i][free_slot] =  1'b0;
							rd_rd_cnt  =  0;
							if (add_lat == 0 && burst_len == 4)
							begin
								tRTP_in[i] =  0;
								tRTP_in[i] <= #(1000) 1;
							end
							if (A[10] == 0)
								Next_bank_state[i] =  reading;
							else
								Next_bank_state[i] =  readingap;
						end
					end
					else if (Command == WR && BA == i)
					begin
						CheckWrite;
						if (write_permit)
						begin
							wr_wr_cnt  =  0;
							start_column[i*11] =  A[9:0];
							AL[i*11] =  add_lat;
							CL[i*11] =  cas_lat;
							write_sch[i][0]  =  1'b1;
							tWR_in[i]  =  0;
							WTR_elapsed[i] =  1'b0;
							WR_elapsed[i]  =  1'b0;
							tWTR_in[i] =  1'b0;
							precharge_cnt[i] =  0;
							wr_rd_cnt[i] =  0;
							if (A[10] == 0)
								Next_bank_state[i] =  writting;
							else
								Next_bank_state[i] =  writtingap;
						end
					end
					else if (RTP_elapsed[i] && tRTP_out[i] &&
						Command == PRE && (BA == i || A[10] == 1))
					begin
						if (A[10] == 0 && BA == i)
						begin
							if (tRASMIN_out[i] == 1'b1)
							begin
								Next_bank_state[i] =  precharging;
								tRASMAX_in[i]  =  0;
								tRP_in[i]  =  0;
								tRP_in[i] <= #(1000) 1;
							end
							else
							begin
								$display("tRAS(min) has not elapsed ");
								$display("since activ. of the bank!");
							end
						end
						else
						begin
							if (tRASMIN_out == 8'hF)
							begin
								Next_bank_state[i] =  prechall;
								tRASMAX_in =  0;
								tRP_in[i]  =  0;
								tRP_in[i] <= #(1000) 1;
							end
						end
					end
					else if (rd_act_cnt[i] == add_lat + cas_lat +
						(burst_len/2))
						Next_bank_state[i] =  active;
				end
				
				readingap :
				begin
					precharge_cnt[i] =  precharge_cnt[i] + 1;
					if (precharge_cnt[i] == add_lat + (burst_len/2) - 2)
					begin
						tRTP_in[i]   =  0;
						tRTP_in[i] <= #(1000) 1;
					end
					else if (precharge_cnt[i] == add_lat +
						(burst_len/2))
						RTP_elapsed[i] =  1'b1;
					for(j=  0;j<=10;j  =  j+1)
					begin
						if (read_sch[i][j] == 1'b1 &&
							AL_elapsed[i][j] == 1'b0)
						begin
							if (AL[i*11+j] > 0)
								AL[i*11+j] =  AL[i*11+j] - 1;
							else
							begin
								current_bank =  i;
								current_row  =  active_row[i];
								current_column =  start_column[i*11+j];
								read_delay =  CL[i*11+j];
								if (read_delay == 3)
								begin
									if (preamble[i][j])
										fork
										preamble_gen =  1'b0;
									preamble_gen <=
									#((3*CK_period/4) - 1000) 1'b1;
									preamble_gen <=
									#(3*CK_period/4) 1'bz;
									join
								end
								itmp =  i;
								jtmp =  j;
								wait_read[i][j]  =  0;
								AL_elapsed[i][j] =  1'b1;
								->wr_event;
							end
						end
					end
					if (RTP_elapsed[i] && tRTP_out[i])
					begin
						Next_bank_state[i] =  precharging;
						tRASMAX_in[i]  =  0;
						tRP_in[i]  =  0;
						tRP_in[i] <= #(1000) 1;
					end
				end
				endcase
				Curr_bank_state[i] =  Next_bank_state[i];
			end
			if (rd_rd_cnt < 5)
				rd_rd_cnt  =  rd_rd_cnt + 1;
			if (wr_wr_cnt < 4)
				wr_wr_cnt  =  wr_wr_cnt + 1;
			if (rd_wr_cnt == (burst_len/2) + 1)
				RTW_elapsed  =  1'b1;
			if (rd_wr_cnt < 6)
				rd_wr_cnt    =  rd_wr_cnt + 1;
		end
		if (~CKE && ~CKEfall)
		begin
			CKEfall  =  1'b1;
			CKErise  =  1'b0;
			if (CKEcnt != 3)
				$display("CKE has not been high for tCKE(min)!");
			CKEcnt   =  0;
		end
		if (CKE && ~CKErise)
		begin
			CKErise  =  1'b1;
			CKEfall  =  1'b0;
			if (CKEcnt != 3)
				$display("CKE has not been low for tCKE(min)!");
			CKEcnt   =  0;
		end
		if (CKEcnt < 3)
			CKEcnt   =  CKEcnt + 1;
		if (~CKE && idle && Command == REF && ~SelfRefresh &&
			(~ODT || (~EMR[6] && ~EMR[2])) && ~Act_PD && ~Pre_PD && ~Reset)
		begin
			SR_cond  =  1'b1;
			SelfRefresh  =  1'b1;
			SR_exit  =  1'b0;
		end
		if (SelfRefresh && ~SR_exit && ~SR_enter_cycle && ~CKE)
			SR_enter_cycle =  1'b1;
		if (CKE && SelfRefresh && ~SR_exit)
			fork
			SR_exit  =  1'b1;
		tXSNR_in =  0;
		tXSNR_in <= #(1000) 1;
		DLL_delay  =  0;
		DLL_delay <= #(1000) 1;
		join
		if (Command != NOP && Command != DES && SR_exit && SelfRefresh)
		begin
			$display("Only NOP and DESELECT commands are valid tXSNR ");
			$display("after self refresh exit!");
		end
		if (~CKE && (Command == NOP || Command == DES) && ~Act_PD &&
			~Pre_PD && ~SelfRefresh && ~Reset)
		begin
			power_down_cond  =  1'b1;
			active_pd_cond   =  1'b0;
			for(i=  0;i<=BankNum;i =  i+1)
			begin
				if (Curr_bank_state[i] == mrsetting ||
					Curr_bank_state[i] == reading ||
					Curr_bank_state[i] == readingap ||
					(Curr_bank_state[i] == writting &&
					~(WTR_elapsed[i] && tWTR_out[i])) ||
					Curr_bank_state[i] == writtingap ||
					ReadStart || Read_Start)
					power_down_cond  =  1'b0;
				else if (Curr_bank_state[i] == activating ||
					Curr_bank_state[i] == active ||
					(Curr_bank_state[i] == writting &&
					WTR_elapsed[i] && tWTR_out[i]))
					active_pd_cond   =  1'b1;
			end
			if (power_down_cond)
			begin
				if (~DLL_delay_elapsed)
					DLL_reset_needed =  1'b1;
				if (active_pd_cond)
				begin
					Act_PD =  1'b1;
					for(i  =  0;i<=BankNum;i =  i+1)
					begin
						if (Curr_bank_state[i] == activating ||
							Curr_bank_state[i] == writting ||
							Curr_bank_state[i] == active)
							Curr_bank_state[i] =  active;
						else
							Curr_bank_state[i] =  precharged;
					end
				end
				else
				begin
					Pre_PD =  1'b1;
					if (~ODT || (~EMR[6] && ~EMR[2]))
						ODT_off  =  1'b1;
					freq_ch_cnt  =  2;
					for(i=  0;i<=BankNum;i =  i+1)
					begin
						Curr_bank_state[i] =  precharged;
					end
				end
			end
		end
		if (freq_ch_cnt > 0)
			freq_ch_cnt  =  freq_ch_cnt - 1;
		if (CKE && Pre_PD)
		begin
			if (PD_exit_cnt == 0)
			begin
				power_down_cond  =  1'b0;
				PD_exit_cnt  =  1;
				Pre_PD =  1'b0;
			end
			else
			begin
				PD_exit_cnt  =  0;
				if (freq_change)
					DLL_reset_needed =  1'b1;
			end
		end
		if (CKE && Act_PD)
		begin
			if (PD_exit_cnt == 0)
			begin
				PD_exit_cnt  =  1;
				Act_PD =  1'b0;
			end
			else
			begin
				PD_exit_cnt  =  0;
				if (~PD_read_delay && MR[12])
				begin
					PD_read_delay  =  1'b1;
					PD_read_del_cnt  =  6 - add_lat + PD_del;
				end
			end
		end
		if (PD_read_del_cnt > 1 && PD_read_delay)
			PD_read_del_cnt  =  PD_read_del_cnt - 1;
		else
			PD_read_delay    =  1'b0;
		if (~CKE && ~SR_cond && ~power_down_cond && ~Act_PD &&
			~Pre_PD && ~SelfRefresh && ~Reset)
		begin
			Reset  =  1'b1;
			for (i =  0;i<=((BankNum+1)*(MemSize+1)-1);i =  i+1)
			begin
				Mem_Hi[i]  =  -2;
				Mem_Lo[i]  =  -2;
			end
			tRFCMAX_in =  0;
		end
		if (Reset && ~Reset_enter_cycle && ~CKE)
			Reset_enter_cycle  =  1'b1;
	end
end

always @(negedge CKE)
begin
	if (~Initialized && $time != 0)
	begin
		$display("CKE must be driven high during initialization!");
		Current_state  =  illegal;
		Next_state =  illegal;
	end
end

always @(tRFCMIN_out)
begin
	if (tRFCMIN_out)
	begin
		for(i=  0;i<=BankNum;i =  i+1)
		begin
			if (Curr_bank_state[i] == refreshing)
			begin
				Curr_bank_state[i] =  precharged;
				Next_bank_state[i] =  precharged;
			end
		end
	end
end

always @(tRFCMAX_out)
begin
	if (tRFCMAX_out)
		$display("tRFC(max) has elapsed since last REFRESH command!");
end

always @(posedge ODT)
begin
	if (SelfRefresh && SR_exit && ~(~EMR[6] && ~EMR[2]))
	begin
		$display("After exiting self refresh, ODT must remain turned ");
		$display("off until tXSNR is satisfied!");
	end
	if (~(~EMR[6] && ~EMR[2]) && ODT_off)
		ODT_off  =  1'b0;
end

always @(tXSNR_out)
begin
	if (tXSNR_out && SelfRefresh && SR_exit)
	begin
		SR_cond  =  1'b0;
		SelfRefresh  =  1'b0;
		SR_exit  =  1'b0;
	end
end

always @(posedge CKE)
begin
	if (SelfRefresh && ~SR_exit)
	begin
		SR_enter_cycle =  1'b0;
		if (((CK_period < tperiod_CK) && (cas_lat > 2) &&
			(cas_lat < 7)) || CK_period > tdevice_tCKAVGMAX_ts)
		begin
			$display("Clock must be stable and meeting tCK specifications ");
			$display("at least 1 x tCK prior to exiting self refresh mode!");
		end
	end
end

always @(negedge CKE)
begin
	if (SelfRefresh && SR_exit)
		$display("CKE must stay high until tXSNR is met!");
end

always @(SelfRefresh)
begin
	if (SelfRefresh)
		tRFCMAX_in =  0;
	Ref_per_start  =  0;
end

always @(SimulationEnd)
begin
	if (SimulationEnd && ~SR_enter_cycle && ~Reset_enter_cycle)
		tRFCMAX_in =  0;
	Ref_per_start  =  0;
	disable REFPer;
end

always @(SR_exit)
begin
	if (SR_exit)
		fork
		tRFCMAX_in =  0;
	tRFCMAX_in <= #(1000) 1;
	Ref_cnt  =  0;
	Ref_per_start  =  0;
	Ref_per_start <= #(1000) 1;
	join
end

always @(posedge CKE)
begin
	if (Reset)
	begin
		Reset  =  1'b0;
		Reset_enter_cycle  =  1'b0;
		Initialized  =  1'b0;
		Current_state  =  init0;
		for(i=  0;i<=BankNum;i =  i+1)
		begin
			Curr_bank_state[i] =  precharged;
		end
	end
end

always @(tRFCMAX_in)
begin
	if (tRFCMAX_in && (Ref_cnt < RowNum + 1))
		Ref_cnt  =  Ref_cnt + 1;
end

always @(Ref_per_expired)
begin
	if (Ref_per_expired)
	begin
		Ref_cnt  =  0;
		Ref_per_start  =  0;
		Ref_per_start <= #(1000) 1;
		if (Ref_cnt != RowNum + 1)
			$display("Not all rows were refreshed during refresh period!");
	end
end

always @(Initialized)
begin
	if (Initialized)
	begin
		Ref_cnt  =  0;
		Ref_per_start  =  0;
		Ref_per_start <= #(1000) 1;
	end
end

always @(Reset)
begin
	if (Reset)
		Ref_per_start  =  0;
end

always @(posedge Ref_per_start)
begin : REFPer
	#(tdevice_REFPer_ts-1000) Ref_per_expired  =  1;
end

always @(negedge Ref_per_start)
begin
	#(1000) Ref_per_expired  =  0;
end

/////////////////////////////////////////////////////////////////////////////
////Write Memory task
/////////////////////////////////////////////////////////////////////////////
integer waddr_temp;
reg     Lower_byte;

task WriteMem;
input   Lower_byte;
begin
	waddr_temp =  Start_roww*(ColNum+1) + In_colw;
	WAddr  =  Start_bankw*(MemSize+1) + waddr_temp;
	if (Lower_byte == 1'b1)
	begin
		if (~LDM)
		begin
			Mem_Lo[WAddr]  =  -1;
			if (~Viol)
				Mem_Lo[WAddr]  =  DIn[7:0];
		end
	end
	else
	begin
		if (~UDM)
		begin
			Mem_Hi[WAddr]  =  -1;
			if (~Viol)
				Mem_Hi[WAddr]  =  DIn[15:8];
		end
	end
end
endtask

always @(posedge In_data)
begin : indata
	Start_bankw  =  current_bank;
	Start_roww   =  current_row;
	Start_colw   =  current_column;
	In_colw  =  Start_colw;
	burst_cnt_low  =  0;
	burst_cnt_hiw  =  0;
	seqw =  In_colw % 8;
	if (~MR[3])
	begin
		for(j=  0;j<=7;j =  j+1)
		begin
			burst_seqw[j]  =  Seq[(seqw*8)+j];
		end
	end
	else
	begin
		for(j=  0;j<=7;j   =  j+1)
		begin
			burst_seqw[j]  =  Inl[(seqw*8)+j];
		end
	end
	fork
	skew_check =  1'b1;
	preamble_check =  1'b1;
	preamble_check <= #((CK_period/2) + 1000) 1'b0;
	join
end

always @(LDQSDiff)
begin : lbwritediff
	if (~EMR[10])
	begin
		if (burst_cnt_low == 0)
		begin
			if (LDQSDiff)
			begin
				burst_cnt_low  =  1;
				WriteMem(1);
			end
		end
		else if (burst_cnt_low > 0 && burst_cnt_low < burst_len)
		begin
			In_colw  =  Start_colw + burst_seqw[burst_cnt_low];
			if (burst_cnt_low == (burst_len - 1))
				fork
				burst_cnt_low  =  8;
			skew_check =  1'b0;
			postamble_check  =  1'b1;
			postamble_check <= #(CK_period) 1'b0;
			join
			else
				burst_cnt_low  =  burst_cnt_low + 1;
			WriteMem(1);
		end
	end
end

always @(LDQSIn)
begin : lbwritein
	if (EMR[10])
	begin
		if (burst_cnt_low == 0)
		begin
			if (LDQSIn)
			begin
				burst_cnt_low  =  1;
				WriteMem(1);
			end
		end
		else if (burst_cnt_low > 0 && burst_cnt_low < burst_len)
		begin
			In_colw  =  Start_colw + burst_seqw[burst_cnt_low];
			if (burst_cnt_low == (burst_len - 1))
				fork
				burst_cnt_low  =  8;
			skew_check =  1'b0;
			postamble_check  =  1'b1;
			postamble_check <= #(CK_period) 1'b0;
			join
			else
				burst_cnt_low  =  burst_cnt_low + 1;
			WriteMem(1);
		end
	end
end

always @(UDQSDiff)
begin : ubwritediff
	if (~EMR[10])
	begin
		if (burst_cnt_hiw == 0)
		begin
			if (UDQSDiff)
			begin
				burst_cnt_hiw  =  1;
				WriteMem(0);
			end
		end
		else if (burst_cnt_hiw > 0 && burst_cnt_hiw < burst_len)
		begin
			In_colw  =  Start_colw + burst_seqw[burst_cnt_hiw];
			if (burst_cnt_hiw == (burst_len - 1))
				fork
				burst_cnt_hiw  =  8;
			skew_check =  1'b0;
			postamble_check  =  1'b1;
			postamble_check <= #(CK_period) 1'b0;
			join
			else
				burst_cnt_hiw  =  burst_cnt_hiw + 1;
			WriteMem(0);
		end
	end
end

always @(UDQSIn)
begin : ubwritein
	if (EMR[10])
	begin
		if (burst_cnt_hiw == 0)
		begin
			if (UDQSIn)
			begin
				burst_cnt_hiw  =  1;
				WriteMem(0);
			end
		end
		else if (burst_cnt_hiw > 0 && burst_cnt_hiw < burst_len)
		begin
			In_colw  =  Start_colw + burst_seqw[burst_cnt_hiw];
			if (burst_cnt_hiw == (burst_len - 1))
				fork
				burst_cnt_hiw  =  8;
			skew_check =  1'b0;
			postamble_check  =  1'b1;
			postamble_check <= #(CK_period) 1'b0;
			join
			else
				burst_cnt_hiw  =  burst_cnt_hiw + 1;
			WriteMem(0);
		end
	end
end

/////////////////////////////////////////////////////////////////////////////
////Read Memory task
/////////////////////////////////////////////////////////////////////////////
integer raddr_temp;
integer data_temp;

task ReadMem;
begin
	raddr_temp =  Start_rowr*(ColNum+1) + In_colr;
	RAddr  =  Start_bankr*(MemSize+1) + raddr_temp;
	data_temp  =  Mem_Lo[RAddr];
	out_buffer =  16'bx;
	if (data_temp >= 0)
		out_buffer[7:0]  =  data_temp;
	data_temp  =  Mem_Hi[RAddr];
	if (data_temp >= 0)
		out_buffer[15:8] =  data_temp;
end
endtask

always @(posedge CKInt)
begin
	if ($time != 0)
	begin
		preamble_allow   =  1'b0;
		if (~preamble_done)
		begin
			preamble_allow =  1'b1;
			preamble_done  =  1'b1;
			if (~EMR[12])
				fork
				UDQS_zd    =  ~CKInt;
			LDQS_zd  =  ~CKInt;
			if (~EMR[10])
				fork
				UDQSNeg_zd =  CKInt;
			LDQSNeg_zd =  CKInt;
			join
			join
		end
	end
end

always @(preamble_gen)
begin
	if (preamble_gen)
		preamble_done  =  1'b0;
end

always @(posedge Out_data)
begin
	Start_bankr  =  read_bank;
	Start_rowr   =  read_row;
	Start_colr   =  read_column;
	In_colr  =  Start_colr;
	burst_cntr =  0;
	seqr =  In_colr % 8;
	if (~MR[3])
	begin
		for(j=  0;j<=7;j =  j+1)
		begin
			burst_seqr[j]  =  Seq[(seqr*8)+j];
		end
	end
	else
	begin
		for(j=  0;j<=7;j   =  j+1)
		begin
			burst_seqr[j]  =  Inl[(seqr*8)+j];
		end
	end
end

always @(CKInt)
begin : outgen
	if (CKInt && burst_cntr == 0)
	begin
		burst_cntr =  1;
		ReadMem;
		if (~EMR[12])
			fork
			UDQS_zd  =  CKInt;
		LDQS_zd  =  CKInt;
		if (~EMR[10])
			fork
			UDQSNeg_zd =  ~CKInt;
		LDQSNeg_zd =  ~CKInt;
		join
		DOut_zd    =  out_buffer;
		join
	end
	else if ((burst_cntr > 0) && (burst_cntr < burst_len))
	begin
		ReadStart  =  1'b1;
		In_colr    =  Start_colr + burst_seqr[burst_cntr];
		burst_cntr =  burst_cntr + 1;
		ReadMem;
		if (~EMR[12])
			fork
			UDQS_zd  =  CKInt;
		LDQS_zd  =  CKInt;
		if (~EMR[10])
			fork
			UDQSNeg_zd =  ~CKInt;
		LDQSNeg_zd =  ~CKInt;
		join
		DOut_zd    =  out_buffer;
		join
	end
	else if ((burst_cntr == burst_len) && ~preamble_allow)
		fork
		burst_cntr =  9;
	UDQS_zd  =  1'bz;
	UDQSNeg_zd =  1'bz;
	LDQS_zd    =  1'bz;
	LDQSNeg_zd =  1'bz;
	DOut_zd    =  16'bz;
	ReadStart <= #((CK_period/4) + 1000) 1'b0;
	Read_Start =  1'b0;
	join
end

always @(wr_event)
	fork
	wait_read[itmp][jtmp] <= #(1000) 1;
Read_Start =  1'b1;
delay[itmp*11+jtmp]  =  read_delay;
temp_bank[itmp*11+jtmp]  =  current_bank;
temp_row[itmp*11+jtmp]   =  current_row;
temp_column[itmp*11+jtmp]  =  current_column;
wait_read[itmp][jtmp] <= #(2000) 0;
join

always @(posedge CKDiff)
begin : readsch
	for(i=  0;i<=BankNum;i =  i+1)
	begin
		for(j=  0;j<=10;j=  j+1)
		begin
			if (delay[i*11+j] > 4)
				delay[i*11+j]  =  delay[i*11+j] - 1;
			else if (delay[i*11+j] == 4)
			begin
				delay[i*11+j]  =  delay[i*11+j] - 1;
				if (preamble[i][j])
					fork
					preamble_gen =  1'b0;
				preamble_gen <= #((3*CK_period/4) - 1000) 1'b1;
				preamble_gen <= #(3*CK_period/4) 1'bz;
				join
			end
			else if (delay[i*11+j] == 3)
				fork
				delay[i*11+j]    =  delay[i*11+j] - 1;
			read_bank  =  temp_bank[i*11+j];
			read_row   =  temp_row[i*11+j];
			read_column  =  temp_column[i*11+j];
			read_sch[i][j] =  1'b0;
			Out_data =  1'b0;
			Out_data <= #((3*CK_period/4) - 1000) 1'b1;
			Out_data <= #(3*CK_period/4) 1'bz;
			join
		end
	end
end

always @(posedge tRRD_in)
begin
	if ($time != 0 )
	begin
		for(i=  0;i<=3;i =  i+1)
		begin
			if (act_num[i] == 0)
			begin
				if (i == 0)
					fork
					act_num[0] =  1;
				tFAW_in[0] =  1'b0;
				tFAW_in[0] <= #(1000) 1'b1;
				join
				else
				begin
					next_slot  =  1'b1;
					for(j=  0;j<=(i-1);j =  j+1)
					begin
						if (act_num[j] == 0)
							next_slot  =  1'b0;
					end
					if (next_slot)
						fork
						act_num[i] =  1;
					tFAW_in[i] =  1'b0;
					tFAW_in[i] <= #(1000) 1'b1;
					join
				end
			end
			else
			begin
				if (act_num[i] == 3)
					active_forbid  =  1'b1;
				else
					act_num[i] =  act_num[i] + 1;
			end
		end
	end
end

always @(tRCD_out)
begin
	for (i =  0; i<=BankNum; i =  i+1)
	begin
		if (tRCD_out[i] && Curr_bank_state[i] == activating)
		begin
			Curr_bank_state[i] =  active;
			Next_bank_state[i] =  active;
		end
	end
end

always @(tRP_out)
begin
	for (i =  0; i<=BankNum; i =  i+1)
	begin
		if (tRP_out[i] && Curr_bank_state[i] == precharging)
		begin
			Curr_bank_state[i] =  precharged;
			Next_bank_state[i] =  precharged;
		end
	end
end

always @(tRASMAX_out)
begin
	for (i =  0; i<=BankNum; i =  i+1)
	begin
		if (tRASMAX_out[i])
		begin
			$display("tRAS(max) has elapsed since activation of bank, and ");
			$display("PRECHARGE command still hasn't been issued!");
		end
	end
end

always @(posedge tFAW_out[0])
begin
	act_num[0] =  0;
	active_forbid  =  1'b0;
end

always @(posedge tFAW_out[1])
begin
	act_num[1] =  0;
	active_forbid  =  1'b0;
end

always @(posedge tFAW_out[2])
begin
	act_num[2] =  0;
	active_forbid  =  1'b0;
end

always @(posedge tFAW_out[3])
begin
	act_num[3] =  0;
	active_forbid  =  1'b0;
end

//Clock and DQS signal events
always @(posedge CKDiff)
begin
	CKDiff_rise    =  $time;
end
always @(LDQSDiff)
begin
	if (LDQSDiff)
		LDQSDiff_rise  =  $time;
end
always @(LDQSIn)
begin
	if (LDQSIn)
		LDQSIn_rise    =  $time;
end
always @(UDQSDiff)
begin
	if (UDQSDiff)
		UDQSDiff_rise  =  $time;
end
always @(UDQSIn)
begin
	if (UDQSIn)
		UDQSIn_rise    =  $time;
end

always @(CKDiff_rise, LDQSDiff_rise, LDQSIn_rise,
	UDQSDiff_rise, UDQSIn_rise )
begin : SkewCheck
	if (~EMR[10])
	begin
		CK_LDQS_time   =  CKDiff_rise - LDQSDiff_rise;
		CK_UDQS_time   =  CKDiff_rise - UDQSDiff_rise;
	end
	else
	begin
		CK_LDQS_time   =  CKDiff_rise - LDQSIn_rise;
		CK_UDQS_time   =  CKDiff_rise - UDQSIn_rise;
	end
	if ((CK_LDQS_time > SKEW_TIME &&
		CK_LDQS_time < (CK_period - SKEW_TIME)) ||
		(CK_UDQS_time > SKEW_TIME &&
		CK_UDQS_time < (CK_period - SKEW_TIME)))
		$display("Skew violation, simulation may be inaccurate!1");
end

function integer freeslot;
input   [10:0] sch;
begin
	freeslot =  0;
	while (sch[freeslot]) begin
		freeslot =  freeslot + 1;
	end
end
endfunction

reg     BuffInDLL, BuffInSKEW;
wire    BuffOutDLL, BuffOutSKEW;

BUFFER    BUFDLL   (BuffOutDLL, BuffInDLL);
BUFFER    BUFSKEW  (BuffOutSKEW,BuffInSKEW);

initial
begin
	BuffInDLL    =  1'b1;
	BuffInSKEW   =  1'b1;
end

always @(posedge BuffOutDLL)
begin
	DLL_TIME =  $time;
end

always @(posedge BuffOutSKEW)
begin
	SKEW_TIME  =  $time;
end

endmodule

module BUFFER (OUT,IN);
input   IN;
output  OUT;
buf   ( OUT, IN);
endmodule
