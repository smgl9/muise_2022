// sync video input with signal generation

module frame_sync(
clk_i,
rst_i,    
first_pixel_i,
sync_o
);

input clk_i;
input rst_i;
input first_pixel_i;
output reg sync_o =0;

always @(posedge clk_i )
 begin

    if (rst_i) begin
        sync_o<=0;
    end else if (first_pixel_i) begin
        sync_o<=1;
    end
end

endmodule
