`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/01/12 19:37:56
// Design Name: 
// Module Name: cache
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
    
module cache(
    input clk_g,
    input resetn,
    input valid,
    input op,
    input index,
    input tag,
    input offset,
    input wstrb,
    input wdata,

    .addr_ok(cache_addr_ok),
    .data_ok(out_valid),
    .rdata,

    .rd_req   (rd_req   ),
    .rd_type  (rd_type  ),
    .rd_addr  (rd_addr  ),
    .rd_rdy   (rd_rdy   ),
    .ret_valid(ret_valid),
    .ret_last (ret_last ),
    .ret_data (ret_data ),

    .wr_req  (wr_req  ),
    .wr_type (wr_type ),
    .wr_addr (wr_addr ),
    .wr_wstrb(wr_wstrb),
    .wr_data (wr_data ),
    .wr_rdy  (wr_rdy  )
);
endmodule
