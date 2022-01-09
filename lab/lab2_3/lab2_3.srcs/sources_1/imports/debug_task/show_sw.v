
module show_sw (
    input             clk,          
    input             resetn,     

    input      [3 :0] switch,    //input

    output     [7 :0] num_csn,   //new value   
    output     [6 :0] num_a_g,      

    output     [3 :0] led        //previous value
);
//1. get switch data
//2. show switch data in digital number:
//   only show 0~9
//   if >=10, digital number keep old data.
//3. show previous switch data in led.
//   can show any switch data.

reg [3:0] show_data;
reg [3:0] show_data_r;
reg [3:0] prev_data;

//new value
always @(posedge clk)
begin
    show_data   <= ~switch;
end

always @(posedge clk)
begin
    show_data_r = show_data;
end
//previous value
always @(posedge clk)
begin
    if(!resetn)
    begin
        prev_data <= 4'd0;
    end
    else if(show_data_r != show_data)
    begin
        prev_data <= show_data_r;
    end
end

//show led: previous value
assign led = ~prev_data;

//show number: new value
show_num u_show_num(
        .clk        (clk      ),
        .resetn     (resetn   ),
        
        .show_data  (show_data),
        .num_csn    (num_csn  ),
        .num_a_g    (num_a_g  )
);

endmodule

//---------------------------{digital number}begin-----------------------//
module show_num (
    input             clk,          
    input             resetn,     

    input      [3 :0] show_data,
    output     [7 :0] num_csn,      
    output reg [6 :0] num_a_g      
);
//digital number display
assign num_csn = 8'b0111_1111;

wire [6:0] nxt_a_g;

always @(posedge clk)
begin
    if ( !resetn )
    begin
        num_a_g <= 7'b0000000;
    end
    else
    begin
        num_a_g <= nxt_a_g;
    end
end

//keep unchange if show_dtaa>=10
wire [6:0] keep_a_g;
assign     keep_a_g = num_a_g;

assign nxt_a_g = show_data==4'h0 ? 7'b1111110 :   //0
                 show_data==4'h1 ? 7'b0110000 :   //1
                 show_data==4'h2 ? 7'b1101101 :   //2
                 show_data==4'h3 ? 7'b1111001 :   //3
                 show_data==4'h4 ? 7'b0110011 :   //4
                 show_data==4'h5 ? 7'b1011011 :   //5
                 show_data==4'h6 ? 7'b1011111 :   //6
                 show_data==4'h7 ? 7'b1110000 :   //7
                 show_data==4'h8 ? 7'b1111111 :   //8
                 show_data==4'h9 ? 7'b1111011 :   //9
                 
                 /* show_data==4'ha ? 7'b1110111 :   //a
                 show_data==4'hb ? 7'b0011111 :   //b
                 show_data==4'hc ? 7'b1001110 :   //c
                 show_data==4'hd ? 7'b0111101 :   //d
                 show_data==4'he ? 7'b1101111 :   //e
                 show_data==4'hf ? 7'b1000111 :   //f */
                                   keep_a_g   ;
endmodule
//----------------------------{digital number}end------------------------//
