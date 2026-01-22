// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2025.1 (win64) Build 6140274 Thu May 22 00:12:29 MDT 2025
// Date        : Thu Dec 25 17:40:12 2025
// Host        : LAPTOP-RU9TJ31G running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               d:/vivado_project/as_v4/as_v4.gen/sources_1/ip/clk_wiz_0/clk_wiz_0_stub.v
// Design      : clk_wiz_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a35tcsg324-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* CORE_GENERATION_INFO = "clk_wiz_0,clk_wiz_v6_0_16_0_0,{component_name=clk_wiz_0,use_phase_alignment=true,use_min_o_jitter=false,use_max_i_jitter=false,use_dyn_phase_shift=false,use_inclk_switchover=false,use_dyn_reconfig=false,enable_axi=0,feedback_source=FDBK_AUTO,PRIMITIVE=MMCM,num_out_clk=3,clkin1_period=10.000,clkin2_period=10.000,use_power_down=false,use_reset=true,use_locked=true,use_inclk_stopped=false,feedback_type=SINGLE,CLOCK_MGR_TYPE=NA,manual_override=false}" *) 
module clk_wiz_0(clk_100mhz, clk_150mhz, clk_50mhz, resetn, 
  locked, clk_in1)
/* synthesis syn_black_box black_box_pad_pin="resetn,locked,clk_in1" */
/* synthesis syn_force_seq_prim="clk_100mhz" */
/* synthesis syn_force_seq_prim="clk_150mhz" */
/* synthesis syn_force_seq_prim="clk_50mhz" */;
  output clk_100mhz /* synthesis syn_isclock = 1 */;
  output clk_150mhz /* synthesis syn_isclock = 1 */;
  output clk_50mhz /* synthesis syn_isclock = 1 */;
  input resetn;
  output locked;
  input clk_in1;
endmodule
