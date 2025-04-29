#############################################
#	Synopsys Design Constraints (SDC)
#	For FPGA fabric 
#	Description: Constrain timing of Switch Block sb_1__2_ for PnR
#	Author: Xifan TANG 
#	Organization: University of Utah 
#	Date: Tue Apr 29 16:10:15 2025
#############################################

#############################################
#	Define time unit 
#############################################
set_units -time s

set_max_delay -from fpga_top/sb_1__2_/top_left_grid_right_width_0_height_0_subtile_0__pin_O_1_[0] -to fpga_top/sb_1__2_/chany_top_out[3] 6.020400151e-11
set_max_delay -from fpga_top/sb_1__2_/top_left_grid_right_width_0_height_0_subtile_0__pin_O_9_[0] -to fpga_top/sb_1__2_/chany_top_out[3] 6.020400151e-11
set_max_delay -from fpga_top/sb_1__2_/top_right_grid_left_width_0_height_0_subtile_0__pin_O_7_[0] -to fpga_top/sb_1__2_/chany_top_out[3] 6.020400151e-11
set_max_delay -from fpga_top/sb_1__2_/chanx_left_in[0] -to fpga_top/sb_1__2_/chany_top_out[3] 6.020400151e-11
set_max_delay -from fpga_top/sb_1__2_/chanx_right_in[1] -to fpga_top/sb_1__2_/chany_top_out[3] 6.020400151e-11
set_max_delay -from fpga_top/sb_1__2_/chanx_left_in[2] -to fpga_top/sb_1__2_/chany_top_out[3] 6.020400151e-11
set_max_delay -from fpga_top/sb_1__2_/chanx_left_in[3] -to fpga_top/sb_1__2_/chany_top_out[3] 6.020400151e-11
set_max_delay -from fpga_top/sb_1__2_/chanx_right_in[4] -to fpga_top/sb_1__2_/chany_top_out[3] 6.020400151e-11
set_max_delay -from fpga_top/sb_1__2_/chanx_left_in[5] -to fpga_top/sb_1__2_/chany_top_out[3] 6.020400151e-11
set_max_delay -from fpga_top/sb_1__2_/chanx_right_in[6] -to fpga_top/sb_1__2_/chany_top_out[3] 6.020400151e-11
set_max_delay -from fpga_top/sb_1__2_/chanx_left_in[8] -to fpga_top/sb_1__2_/chany_top_out[3] 6.020400151e-11
set_max_delay -from fpga_top/sb_1__2_/chanx_right_in[9] -to fpga_top/sb_1__2_/chany_top_out[3] 6.020400151e-11
set_max_delay -from fpga_top/sb_1__2_/chanx_left_in[10] -to fpga_top/sb_1__2_/chany_top_out[3] 6.020400151e-11
set_max_delay -from fpga_top/sb_1__2_/chanx_right_in[7] -to fpga_top/sb_1__2_/chany_top_out[3] 6.020400151e-11
set_max_delay -from fpga_top/sb_1__2_/chany_bottom_in[3] -to fpga_top/sb_1__2_/chany_top_out[3] 6.020400151e-11
set_max_delay -from fpga_top/sb_1__2_/top_left_grid_right_width_0_height_0_subtile_0__pin_O_5_[0] -to fpga_top/sb_1__2_/chany_top_out[7] 6.020400151e-11
set_max_delay -from fpga_top/sb_1__2_/top_right_grid_left_width_0_height_0_subtile_0__pin_O_3_[0] -to fpga_top/sb_1__2_/chany_top_out[7] 6.020400151e-11
set_max_delay -from fpga_top/sb_1__2_/chanx_right_in[0] -to fpga_top/sb_1__2_/chany_top_out[7] 6.020400151e-11
set_max_delay -from fpga_top/sb_1__2_/chanx_left_in[1] -to fpga_top/sb_1__2_/chany_top_out[7] 6.020400151e-11
set_max_delay -from fpga_top/sb_1__2_/chanx_right_in[2] -to fpga_top/sb_1__2_/chany_top_out[7] 6.020400151e-11
set_max_delay -from fpga_top/sb_1__2_/chanx_left_in[4] -to fpga_top/sb_1__2_/chany_top_out[7] 6.020400151e-11
set_max_delay -from fpga_top/sb_1__2_/chanx_right_in[5] -to fpga_top/sb_1__2_/chany_top_out[7] 6.020400151e-11
set_max_delay -from fpga_top/sb_1__2_/chanx_left_in[6] -to fpga_top/sb_1__2_/chany_top_out[7] 6.020400151e-11
set_max_delay -from fpga_top/sb_1__2_/chanx_left_in[7] -to fpga_top/sb_1__2_/chany_top_out[7] 6.020400151e-11
set_max_delay -from fpga_top/sb_1__2_/chanx_right_in[8] -to fpga_top/sb_1__2_/chany_top_out[7] 6.020400151e-11
set_max_delay -from fpga_top/sb_1__2_/chanx_left_in[9] -to fpga_top/sb_1__2_/chany_top_out[7] 6.020400151e-11
set_max_delay -from fpga_top/sb_1__2_/chanx_right_in[10] -to fpga_top/sb_1__2_/chany_top_out[7] 6.020400151e-11
set_max_delay -from fpga_top/sb_1__2_/chanx_right_in[3] -to fpga_top/sb_1__2_/chany_top_out[7] 6.020400151e-11
set_max_delay -from fpga_top/sb_1__2_/chany_bottom_in[7] -to fpga_top/sb_1__2_/chany_top_out[7] 6.020400151e-11
set_max_delay -from fpga_top/sb_1__2_/right_bottom_grid_top_width_0_height_0_subtile_0__pin_O_0_[0] -to fpga_top/sb_1__2_/chanx_right_out[3] 6.020400151e-11
set_max_delay -from fpga_top/sb_1__2_/right_bottom_grid_top_width_0_height_0_subtile_0__pin_O_4_[0] -to fpga_top/sb_1__2_/chanx_right_out[3] 6.020400151e-11
set_max_delay -from fpga_top/sb_1__2_/right_top_grid_bottom_width_0_height_0_subtile_0__pin_O_2_[0] -to fpga_top/sb_1__2_/chanx_right_out[3] 6.020400151e-11
set_max_delay -from fpga_top/sb_1__2_/chanx_left_in[3] -to fpga_top/sb_1__2_/chanx_right_out[3] 6.020400151e-11
set_max_delay -from fpga_top/sb_1__2_/chany_bottom_in[0] -to fpga_top/sb_1__2_/chanx_right_out[3] 6.020400151e-11
set_max_delay -from fpga_top/sb_1__2_/chany_top_in[1] -to fpga_top/sb_1__2_/chanx_right_out[3] 6.020400151e-11
set_max_delay -from fpga_top/sb_1__2_/chany_bottom_in[3] -to fpga_top/sb_1__2_/chanx_right_out[3] 6.020400151e-11
set_max_delay -from fpga_top/sb_1__2_/chany_top_in[4] -to fpga_top/sb_1__2_/chanx_right_out[3] 6.020400151e-11
set_max_delay -from fpga_top/sb_1__2_/chany_bottom_in[5] -to fpga_top/sb_1__2_/chanx_right_out[3] 6.020400151e-11
set_max_delay -from fpga_top/sb_1__2_/chany_bottom_in[8] -to fpga_top/sb_1__2_/chanx_right_out[3] 6.020400151e-11
set_max_delay -from fpga_top/sb_1__2_/chany_top_in[9] -to fpga_top/sb_1__2_/chanx_right_out[3] 6.020400151e-11
set_max_delay -from fpga_top/sb_1__2_/chany_bottom_in[2] -to fpga_top/sb_1__2_/chanx_right_out[3] 6.020400151e-11
set_max_delay -from fpga_top/sb_1__2_/chany_top_in[6] -to fpga_top/sb_1__2_/chanx_right_out[3] 6.020400151e-11
set_max_delay -from fpga_top/sb_1__2_/chany_bottom_in[10] -to fpga_top/sb_1__2_/chanx_right_out[3] 6.020400151e-11
set_max_delay -from fpga_top/sb_1__2_/chany_top_in[7] -to fpga_top/sb_1__2_/chanx_right_out[3] 6.020400151e-11
set_max_delay -from fpga_top/sb_1__2_/right_bottom_grid_top_width_0_height_0_subtile_0__pin_O_0_[0] -to fpga_top/sb_1__2_/chanx_right_out[7] 6.020400151e-11
set_max_delay -from fpga_top/sb_1__2_/right_bottom_grid_top_width_0_height_0_subtile_0__pin_O_8_[0] -to fpga_top/sb_1__2_/chanx_right_out[7] 6.020400151e-11
set_max_delay -from fpga_top/sb_1__2_/right_top_grid_bottom_width_0_height_0_subtile_0__pin_O_6_[0] -to fpga_top/sb_1__2_/chanx_right_out[7] 6.020400151e-11
set_max_delay -from fpga_top/sb_1__2_/chanx_left_in[7] -to fpga_top/sb_1__2_/chanx_right_out[7] 6.020400151e-11
set_max_delay -from fpga_top/sb_1__2_/chany_top_in[0] -to fpga_top/sb_1__2_/chanx_right_out[7] 6.020400151e-11
set_max_delay -from fpga_top/sb_1__2_/chany_top_in[5] -to fpga_top/sb_1__2_/chanx_right_out[7] 6.020400151e-11
set_max_delay -from fpga_top/sb_1__2_/chany_bottom_in[7] -to fpga_top/sb_1__2_/chanx_right_out[7] 6.020400151e-11
set_max_delay -from fpga_top/sb_1__2_/chany_top_in[8] -to fpga_top/sb_1__2_/chanx_right_out[7] 6.020400151e-11
set_max_delay -from fpga_top/sb_1__2_/chany_top_in[2] -to fpga_top/sb_1__2_/chanx_right_out[7] 6.020400151e-11
set_max_delay -from fpga_top/sb_1__2_/chany_top_in[10] -to fpga_top/sb_1__2_/chanx_right_out[7] 6.020400151e-11
set_max_delay -from fpga_top/sb_1__2_/chany_top_in[3] -to fpga_top/sb_1__2_/chanx_right_out[7] 6.020400151e-11
set_max_delay -from fpga_top/sb_1__2_/bottom_left_grid_right_width_0_height_0_subtile_0__pin_O_1_[0] -to fpga_top/sb_1__2_/chany_bottom_out[3] 6.020400151e-11
set_max_delay -from fpga_top/sb_1__2_/bottom_left_grid_right_width_0_height_0_subtile_0__pin_O_9_[0] -to fpga_top/sb_1__2_/chany_bottom_out[3] 6.020400151e-11
set_max_delay -from fpga_top/sb_1__2_/bottom_right_grid_left_width_0_height_0_subtile_0__pin_O_7_[0] -to fpga_top/sb_1__2_/chany_bottom_out[3] 6.020400151e-11
set_max_delay -from fpga_top/sb_1__2_/chanx_right_in[0] -to fpga_top/sb_1__2_/chany_bottom_out[3] 6.020400151e-11
set_max_delay -from fpga_top/sb_1__2_/chanx_left_in[1] -to fpga_top/sb_1__2_/chany_bottom_out[3] 6.020400151e-11
set_max_delay -from fpga_top/sb_1__2_/chanx_right_in[2] -to fpga_top/sb_1__2_/chany_bottom_out[3] 6.020400151e-11
set_max_delay -from fpga_top/sb_1__2_/chanx_left_in[4] -to fpga_top/sb_1__2_/chany_bottom_out[3] 6.020400151e-11
set_max_delay -from fpga_top/sb_1__2_/chanx_right_in[5] -to fpga_top/sb_1__2_/chany_bottom_out[3] 6.020400151e-11
set_max_delay -from fpga_top/sb_1__2_/chanx_left_in[6] -to fpga_top/sb_1__2_/chany_bottom_out[3] 6.020400151e-11
set_max_delay -from fpga_top/sb_1__2_/chanx_left_in[7] -to fpga_top/sb_1__2_/chany_bottom_out[3] 6.020400151e-11
set_max_delay -from fpga_top/sb_1__2_/chanx_right_in[8] -to fpga_top/sb_1__2_/chany_bottom_out[3] 6.020400151e-11
set_max_delay -from fpga_top/sb_1__2_/chanx_left_in[9] -to fpga_top/sb_1__2_/chany_bottom_out[3] 6.020400151e-11
set_max_delay -from fpga_top/sb_1__2_/chanx_right_in[10] -to fpga_top/sb_1__2_/chany_bottom_out[3] 6.020400151e-11
set_max_delay -from fpga_top/sb_1__2_/chanx_right_in[3] -to fpga_top/sb_1__2_/chany_bottom_out[3] 6.020400151e-11
set_max_delay -from fpga_top/sb_1__2_/chany_top_in[3] -to fpga_top/sb_1__2_/chany_bottom_out[3] 6.020400151e-11
set_max_delay -from fpga_top/sb_1__2_/bottom_left_grid_right_width_0_height_0_subtile_0__pin_O_5_[0] -to fpga_top/sb_1__2_/chany_bottom_out[7] 6.020400151e-11
set_max_delay -from fpga_top/sb_1__2_/bottom_right_grid_left_width_0_height_0_subtile_0__pin_O_3_[0] -to fpga_top/sb_1__2_/chany_bottom_out[7] 6.020400151e-11
set_max_delay -from fpga_top/sb_1__2_/chanx_left_in[0] -to fpga_top/sb_1__2_/chany_bottom_out[7] 6.020400151e-11
set_max_delay -from fpga_top/sb_1__2_/chanx_left_in[2] -to fpga_top/sb_1__2_/chany_bottom_out[7] 6.020400151e-11
set_max_delay -from fpga_top/sb_1__2_/chanx_left_in[3] -to fpga_top/sb_1__2_/chany_bottom_out[7] 6.020400151e-11
set_max_delay -from fpga_top/sb_1__2_/chanx_left_in[5] -to fpga_top/sb_1__2_/chany_bottom_out[7] 6.020400151e-11
set_max_delay -from fpga_top/sb_1__2_/chanx_left_in[8] -to fpga_top/sb_1__2_/chany_bottom_out[7] 6.020400151e-11
set_max_delay -from fpga_top/sb_1__2_/chanx_left_in[10] -to fpga_top/sb_1__2_/chany_bottom_out[7] 6.020400151e-11
set_max_delay -from fpga_top/sb_1__2_/chanx_right_in[7] -to fpga_top/sb_1__2_/chany_bottom_out[7] 6.020400151e-11
set_max_delay -from fpga_top/sb_1__2_/chany_top_in[7] -to fpga_top/sb_1__2_/chany_bottom_out[7] 6.020400151e-11
set_max_delay -from fpga_top/sb_1__2_/left_bottom_grid_top_width_0_height_0_subtile_0__pin_O_0_[0] -to fpga_top/sb_1__2_/chanx_left_out[3] 6.020400151e-11
set_max_delay -from fpga_top/sb_1__2_/left_bottom_grid_top_width_0_height_0_subtile_0__pin_O_4_[0] -to fpga_top/sb_1__2_/chanx_left_out[3] 6.020400151e-11
set_max_delay -from fpga_top/sb_1__2_/left_top_grid_bottom_width_0_height_0_subtile_0__pin_O_2_[0] -to fpga_top/sb_1__2_/chanx_left_out[3] 6.020400151e-11
set_max_delay -from fpga_top/sb_1__2_/chanx_right_in[3] -to fpga_top/sb_1__2_/chanx_left_out[3] 6.020400151e-11
set_max_delay -from fpga_top/sb_1__2_/chany_top_in[0] -to fpga_top/sb_1__2_/chanx_left_out[3] 6.020400151e-11
set_max_delay -from fpga_top/sb_1__2_/chany_bottom_in[1] -to fpga_top/sb_1__2_/chanx_left_out[3] 6.020400151e-11
set_max_delay -from fpga_top/sb_1__2_/chany_bottom_in[4] -to fpga_top/sb_1__2_/chanx_left_out[3] 6.020400151e-11
set_max_delay -from fpga_top/sb_1__2_/chany_top_in[5] -to fpga_top/sb_1__2_/chanx_left_out[3] 6.020400151e-11
set_max_delay -from fpga_top/sb_1__2_/chany_bottom_in[7] -to fpga_top/sb_1__2_/chanx_left_out[3] 6.020400151e-11
set_max_delay -from fpga_top/sb_1__2_/chany_top_in[8] -to fpga_top/sb_1__2_/chanx_left_out[3] 6.020400151e-11
set_max_delay -from fpga_top/sb_1__2_/chany_bottom_in[9] -to fpga_top/sb_1__2_/chanx_left_out[3] 6.020400151e-11
set_max_delay -from fpga_top/sb_1__2_/chany_top_in[2] -to fpga_top/sb_1__2_/chanx_left_out[3] 6.020400151e-11
set_max_delay -from fpga_top/sb_1__2_/chany_bottom_in[6] -to fpga_top/sb_1__2_/chanx_left_out[3] 6.020400151e-11
set_max_delay -from fpga_top/sb_1__2_/chany_top_in[10] -to fpga_top/sb_1__2_/chanx_left_out[3] 6.020400151e-11
set_max_delay -from fpga_top/sb_1__2_/chany_top_in[3] -to fpga_top/sb_1__2_/chanx_left_out[3] 6.020400151e-11
set_max_delay -from fpga_top/sb_1__2_/left_bottom_grid_top_width_0_height_0_subtile_0__pin_O_0_[0] -to fpga_top/sb_1__2_/chanx_left_out[7] 6.020400151e-11
set_max_delay -from fpga_top/sb_1__2_/left_bottom_grid_top_width_0_height_0_subtile_0__pin_O_8_[0] -to fpga_top/sb_1__2_/chanx_left_out[7] 6.020400151e-11
set_max_delay -from fpga_top/sb_1__2_/left_top_grid_bottom_width_0_height_0_subtile_0__pin_O_6_[0] -to fpga_top/sb_1__2_/chanx_left_out[7] 6.020400151e-11
set_max_delay -from fpga_top/sb_1__2_/chanx_right_in[7] -to fpga_top/sb_1__2_/chanx_left_out[7] 6.020400151e-11
set_max_delay -from fpga_top/sb_1__2_/chany_bottom_in[0] -to fpga_top/sb_1__2_/chanx_left_out[7] 6.020400151e-11
set_max_delay -from fpga_top/sb_1__2_/chany_top_in[1] -to fpga_top/sb_1__2_/chanx_left_out[7] 6.020400151e-11
set_max_delay -from fpga_top/sb_1__2_/chany_bottom_in[3] -to fpga_top/sb_1__2_/chanx_left_out[7] 6.020400151e-11
set_max_delay -from fpga_top/sb_1__2_/chany_top_in[4] -to fpga_top/sb_1__2_/chanx_left_out[7] 6.020400151e-11
set_max_delay -from fpga_top/sb_1__2_/chany_bottom_in[5] -to fpga_top/sb_1__2_/chanx_left_out[7] 6.020400151e-11
set_max_delay -from fpga_top/sb_1__2_/chany_bottom_in[8] -to fpga_top/sb_1__2_/chanx_left_out[7] 6.020400151e-11
set_max_delay -from fpga_top/sb_1__2_/chany_top_in[9] -to fpga_top/sb_1__2_/chanx_left_out[7] 6.020400151e-11
set_max_delay -from fpga_top/sb_1__2_/chany_bottom_in[2] -to fpga_top/sb_1__2_/chanx_left_out[7] 6.020400151e-11
set_max_delay -from fpga_top/sb_1__2_/chany_top_in[6] -to fpga_top/sb_1__2_/chanx_left_out[7] 6.020400151e-11
set_max_delay -from fpga_top/sb_1__2_/chany_bottom_in[10] -to fpga_top/sb_1__2_/chanx_left_out[7] 6.020400151e-11
set_max_delay -from fpga_top/sb_1__2_/chany_top_in[7] -to fpga_top/sb_1__2_/chanx_left_out[7] 6.020400151e-11
