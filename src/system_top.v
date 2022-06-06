

module system_top(
    clk_50mhz_in, 
    vga_r_o,
    vga_g_o,
    vga_b_o,
    vid_clk_o,
    vsync_o,
    hsync_o,
    vid_blank_o
);

input clk_50mhz_in;   //! clock input
output [7:0] vga_r_o; //! VGA DAC ouput
output [7:0] vga_g_o; //! VGA DAC ouput
output [7:0] vga_b_o; //! VGA DAC ouput
output vid_clk_o;
output vsync_o;
output hsync_o;
output vid_blank_o;

localparam image_width =604;
localparam image_heigh =413;

wire  s_axis_tready;
wire  s_axis_tvalid;
wire  [31:0] s_axis_tdata;
wire  s_axis_tlast ;
wire  s_axis_tuser ;

wire  m_axis_tready;
wire  m_axis_tvalid;
wire  [31:0] m_axis_tdata;
wire  m_axis_tlast ;
wire  m_axis_tuser ;
wire  vid_clk;

vga_interface vga_interface_dut (
  .clk_50mhz_in (clk_50mhz_in ),
  .rst_i (0 ),
  .vga_r_o (vga_r_o ),
  .vga_g_o (vga_g_o ),
  .vga_b_o (vga_b_o ),
  .vid_clk_o (vid_clk ),
  .vsync_o (vsync_o ),
  .hsync_o (hsync_o ),
  .vid_blank_o (vid_blank_o ),
  .s_axis_tready (m_axis_tready ),
  .s_axis_tvalid (m_axis_tvalid ),
  .s_axis_tdata (m_axis_tdata ),
  .s_axis_tlast (m_axis_tlast ),
  .s_axis_tuser  ( m_axis_tuser)
);


video_generator #(
  .image_width(image_width ),
  .image_heigh (image_heigh )
)
video_generator_dut (
  .clk_i (vid_clk ),
  .m_axis_tready (m_axis_tready ),
  .m_axis_tvalid (m_axis_tvalid ),
  .m_axis_tdata (m_axis_tdata ),
  .m_axis_tlast (m_axis_tlast ),
  .m_axis_tuser  ( m_axis_tuser)
);

assign  vid_clk_o = vid_clk;

`ifdef COCOTB_SIM
initial begin
  $dumpfile ("system_top.vcd");
  $dumpvars (0, system_top);
end
`endif  


endmodule
