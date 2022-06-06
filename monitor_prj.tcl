# Copyright (C) 2020  Intel Corporation. All rights reserved.
# Your use of Intel Corporation's design tools, logic functions 
# and other software and tools, and any partner logic 
# functions, and any output files from any of the foregoing 
# (including device programming or simulation files), and any 
# associated documentation or information are expressly subject 
# to the terms and conditions of the Intel Program License 
# Subscription Agreement, the Intel Quartus Prime License Agreement,
# the Intel FPGA IP License Agreement, or other applicable license
# agreement, including, without limitation, that your use is for
# the sole purpose of programming logic devices manufactured by
# Intel and sold by Intel or its authorized distributors.  Please
# refer to the applicable agreement for further details, at
# https://fpgasoftware.intel.com/eula.

# Quartus Prime: Generate Tcl File for Project
# File: monitor_prj.tcl
# Generated on: Sat Jun  4 14:26:14 2022

# Load Quartus Prime Tcl Project package
package require ::quartus::project

set need_to_close_project 0
set make_assignments 1

# Check that the right project is open
if {[is_project_open]} {
	if {[string compare $quartus(project) "monitor"]} {
		puts "Project monitor is not open"
		set make_assignments 0
	}
} else {
	# Only open if not already open
	if {[project_exists monitor]} {
		project_open -revision monitor monitor
	} else {
		project_new -revision monitor monitor
	}
	set need_to_close_project 1
}

# Make assignments
if {$make_assignments} {
	set_global_assignment -name FAMILY "Cyclone V"
	set_global_assignment -name DEVICE 5CSEMA5F31C6
	set_global_assignment -name TOP_LEVEL_ENTITY system_top
	set_global_assignment -name ORIGINAL_QUARTUS_VERSION 20.1.1
	set_global_assignment -name PROJECT_CREATION_TIME_DATE "02:39:57  JUNE 01, 2022"
	set_global_assignment -name LAST_QUARTUS_VERSION "20.1.1 Lite Edition"
	set_global_assignment -name PROJECT_OUTPUT_DIRECTORY output_files
	set_global_assignment -name MIN_CORE_JUNCTION_TEMP 0
	set_global_assignment -name MAX_CORE_JUNCTION_TEMP 85
	set_global_assignment -name ERROR_CHECK_FREQUENCY_DIVISOR 256
	set_global_assignment -name POWER_PRESET_COOLING_SOLUTION "23 MM HEAT SINK WITH 200 LFPM AIRFLOW"
	set_global_assignment -name POWER_BOARD_THERMAL_MODEL "NONE (CONSERVATIVE)"
	set_global_assignment -name VERILOG_FILE ../src/video_generator.v
	set_global_assignment -name VERILOG_FILE ../src/system_top.v
	set_global_assignment -name VERILOG_FILE ../src/frame_sync.v
	set_global_assignment -name VERILOG_FILE ../src/vga_interface.v
	set_global_assignment -name SDC_FILE ../src/constraints.sdc
	set_global_assignment -name VERILOG_FILE ../src/monitor.v
	set_global_assignment -name PARTITION_NETLIST_TYPE SOURCE -section_id Top
	set_global_assignment -name PARTITION_FITTER_PRESERVATION_LEVEL PLACEMENT_AND_ROUTING -section_id Top
	set_global_assignment -name PARTITION_COLOR 16764057 -section_id Top
	set_location_assignment PIN_B11 -to hsync_o
	set_location_assignment PIN_F10 -to vid_blank_o
	set_location_assignment PIN_A11 -to vid_clk_o
	set_location_assignment PIN_D11 -to vsync_o
	set_location_assignment PIN_J14 -to vga_b_o[7]
	set_location_assignment PIN_G15 -to vga_b_o[6]
	set_location_assignment PIN_F15 -to vga_b_o[5]
	set_location_assignment PIN_H14 -to vga_b_o[4]
	set_location_assignment PIN_F14 -to vga_b_o[3]
	set_location_assignment PIN_H13 -to vga_b_o[2]
	set_location_assignment PIN_G13 -to vga_b_o[1]
	set_location_assignment PIN_B13 -to vga_b_o[0]
	set_location_assignment PIN_E11 -to vga_g_o[7]
	set_location_assignment PIN_F11 -to vga_g_o[6]
	set_location_assignment PIN_G12 -to vga_g_o[5]
	set_location_assignment PIN_G11 -to vga_g_o[4]
	set_location_assignment PIN_G10 -to vga_g_o[3]
	set_location_assignment PIN_H12 -to vga_g_o[2]
	set_location_assignment PIN_J10 -to vga_g_o[1]
	set_location_assignment PIN_J9 -to vga_g_o[0]
	set_location_assignment PIN_F13 -to vga_r_o[7]
	set_location_assignment PIN_E12 -to vga_r_o[6]
	set_location_assignment PIN_D12 -to vga_r_o[5]
	set_location_assignment PIN_C12 -to vga_r_o[4]
	set_location_assignment PIN_B12 -to vga_r_o[3]
	set_location_assignment PIN_E13 -to vga_r_o[2]
	set_location_assignment PIN_C13 -to vga_r_o[1]
	set_location_assignment PIN_A13 -to vga_r_o[0]
	set_location_assignment PIN_AF14 -to clk_50mhz_in
	set_instance_assignment -name PARTITION_HIERARCHY root_partition -to | -section_id Top

	# Commit assignments
	export_assignments

	# Close project
	if {$need_to_close_project} {
		project_close
	}
}
