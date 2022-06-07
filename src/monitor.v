//! VGA DAC ADV7123 signals generator

module monitor (

        clk			,
        start_frame_o,
        vid_clk_o,
        vsync_o,
        hsync_o,
        vid_blank_o,
        pixel_en_o,
        sync_i
    );
    // signal directions

    input 		clk;  //! 50 Mhz clock
    input 		sync_i;  //! wait until sync
    output start_frame_o;
    output reg vid_clk_o = 0;
    output vsync_o;
    output hsync_o;
    output vid_blank_o;
    output pixel_en_o;

    // internal counters

    reg[10:0]	contvidv = 0; // vertical counter
    reg[10:0]	contvidh = 0; // horizontal counter
    reg[4:0]	clkcount = 0; // clock divider

    //    control values 

    reg 			vid_clk=0;

    wire			vsync = ((contvidv >= 491) && (contvidv < 493))? 1'b0 : 1'b1;
    wire			hsync = ((contvidh >= 664) && (contvidh < 760))? 1'b0 : 1'b1;
    wire			vid_blank = ((contvidv >= 8) && (contvidv <  420) && (contvidh >= 20) && (contvidh < 624))? 1'b1 : 1'b0;
    wire			clrvidh = (contvidh <= 800) ? 1'b0 : 1'b1;
    wire  	    	clrvidv = (contvidv <= 525) ? 1'b0 : 1'b1;
    wire            pixel_ena = vid_blank;   // active image region
    wire            start_frame = ((contvidv==8) && (contvidh==20))? 1'b1 : 1'b0;    // first pixel

    // general clock divider
    always @ (posedge clk )

    begin

        clkcount <= clkcount + 1;
        vid_clk <= clkcount[0];  //  25 Mhz clock
        vid_clk_o <= vid_clk;
    end

    // horizontal counter
    always @ (posedge vid_clk )

    begin

        if(clrvidh)
        begin
            contvidh <= 0;
        end

        else if (sync_i)
        begin
            contvidh <= contvidh + 1;
        end
    end

    // vertical counter when clrvidv is low
    always @ (posedge vid_clk)

    begin

        if (clrvidv)
        begin
            contvidv <= 0;
        end

        else
        begin
            if
            (contvidh == 798)
            begin
                contvidv <= contvidv + 1;
            end
        end
    end

    assign vsync_o = vsync;
    assign hsync_o = hsync;
    assign vid_blank_o = vid_blank;
    assign pixel_en_o = pixel_ena;
    assign start_frame_o = start_frame;

endmodule

