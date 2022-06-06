// Stream to VGA interface module

//! {reg:[
//!   { "name": "VGA_R", "bits": 8, "attr": "R","type": 2  },
//!   { "name": "VGA_G", "bits": 8, "attr": "G","type": 6  },
//!   { "name": "VGA_B", "bits": 8, "attr": "B","type": 4  },
//! ]}

module vga_interface (

        clk_50mhz_in, 
        rst_i,
        vga_r_o,
        vga_g_o,
        vga_b_o,
        vid_clk_o,
        vsync_o,
        hsync_o,
        vid_blank_o,
        s_axis_tready,
        s_axis_tvalid,
        s_axis_tdata ,
        s_axis_tlast ,
        s_axis_tuser 
    );

    input clk_50mhz_in;   //! clock input
    input rst_i;   //! reset input
    output [7:0] vga_r_o; //! VGA DAC ouput
    output [7:0] vga_g_o; //! VGA DAC ouput
    output [7:0] vga_b_o; //! VGA DAC ouput
    output vid_clk_o;
    output vsync_o;
    output hsync_o;
    output vid_blank_o;
    output s_axis_tready;
    input  s_axis_tvalid;
    input  [31:0] s_axis_tdata;
    input  s_axis_tlast ;
    input  s_axis_tuser ;

    wire start_frame;
    wire frame_sync;
    wire pixel_enable;
    wire s_pixel_enable = pixel_enable & frame_sync;

    // reg [7:0] counter;

    monitor monitor_dut (
      .clk (clk_50mhz_in ),
      .start_frame_o (start_frame ),
      .vid_clk_o (vid_clk_o ),
      .vsync_o (vsync_o ),
      .hsync_o (hsync_o ),
      .vid_blank_o  ( vid_blank_o),
      .pixel_en_o (pixel_enable),
      .sync_i (frame_sync)
    );

    frame_sync frame_sync_dut (
      .clk_i (vid_clk_o ),
      .rst_i (rst_i ),
      .first_pixel_i (s_axis_tuser ),
      .sync_o  ( frame_sync)
    );
  
      //! drop data until frame sync is enabled.
      assign s_axis_tready =(frame_sync)? pixel_enable:1;

      assign vga_r_o = ((s_pixel_enable) & (s_axis_tvalid))? s_axis_tdata [7:0]  :0;
      assign vga_g_o = ((s_pixel_enable) & (s_axis_tvalid))? s_axis_tdata [15:8] :0;
      assign vga_b_o = ((s_pixel_enable) & (s_axis_tvalid))? s_axis_tdata [23:16]:0;

endmodule
