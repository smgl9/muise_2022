module video_generator_tb;

  // Parameters
  localparam  image_width = 640;
  localparam  image_heigh = 480;

  // Ports
  reg clk_i = 0;
  reg m_axis_tready = 0;
  wire m_axis_tvalid;
  wire [31:0] m_axis_tdata;
  wire m_axis_tlast;
  wire m_axis_tuser;

  video_generator 
  #(
    .image_width(image_width ),
    .image_heigh (
        image_heigh )
  )
  video_generator_dut (
    .clk_i (clk_i ),
    .m_axis_tready (m_axis_tready ),
    .m_axis_tvalid (m_axis_tvalid ),
    .m_axis_tdata (m_axis_tdata ),
    .m_axis_tlast (m_axis_tlast ),
    .m_axis_tuser  ( m_axis_tuser)
  );

  initial 
  begin
    begin
        $dumpfile("test.vcd");
        $dumpvars (0, video_generator_dut);
        # 2000;
        $finish;
    end
  end

  always
    #5  clk_i = ! clk_i ;

endmodule
