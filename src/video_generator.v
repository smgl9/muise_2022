

module video_generator(
        clk_i,
        m_axis_tready,
        m_axis_tvalid,
        m_axis_tdata,
        m_axis_tlast ,
        m_axis_tuser
    );

    parameter image_width = 640;
    parameter image_heigh = 480;

    input   clk_i;
    input   m_axis_tready;
    output  m_axis_tvalid;
    output  [31:0] m_axis_tdata;
    output  m_axis_tlast ;
    output  m_axis_tuser ;

    reg [10:0] counter ;
    reg [10:0] h_counter = 0;
    reg [9:0] v_counter = 0;

    always @(posedge clk_i ) begin
        if (m_axis_tready) begin
        if (h_counter<image_width-1) begin
            h_counter<=h_counter+1;
        end

        if (h_counter==image_width-1) begin
            v_counter<=v_counter+1;
            h_counter<=0;
        end
        else if (v_counter==image_heigh-1)begin
            v_counter<=0;
        end
    end
    else begin
        h_counter<=0;
    end
end

    always @(posedge clk_i ) begin
        if (~m_axis_tready) begin
            counter <= 0;
        end
        else  begin
            counter[7:0] <= (h_counter[7:0] + v_counter[7:0])>>1;
            //counter <= counter +1;
        end 
    end

      assign m_axis_tvalid = (m_axis_tready)? 1:0;
      assign m_axis_tuser  = ((m_axis_tready==1) && (v_counter==0) && (h_counter==0))? 1:0;
      assign m_axis_tlast  = (h_counter==image_width-1)? 1:0; 
      assign m_axis_tdata  = {8'h00, counter[7:0],counter[7:0],counter[7:0]};

    //   `ifdef COCOTB_SIM
    //   initial begin
    //     $dumpfile ("video_generator.vcd");
    //     $dumpvars (0, video_generator);
    //   end
    //   `endif      

endmodule
