`timescale 1ns / 1ps
module UART_RECEIVER_TOP(
input i_clk,
input i_rst,
input i_dv,
input r_DATA_SER,
input [3:0] tx_dat,
output [3:0]recv_DATA,
output t_DATA_SER,
output rec_done,
output t_done
    );
UART_RECEIVER R_INST
        (
        .i_CLK(i_clk),
        .i_RST(i_rst),
        .DATA_SERIAL(r_DATA_SER),
        .RECV_DATA(recv_DATA),
        .RECV_DONE(rec_done)
        );
endmodule

module UART_RECEIVER
    #(parameter CLK_PER_BIT = 868)
    (
    input i_CLK,
    input i_RST,
    input DATA_SERIAL,
    output reg [3:0] RECV_DATA,
    output reg RECV_DONE
    );
    localparam IDLE = 2'b00;
    localparam DATA = 2'b01;
    localparam STOP = 2'b10;
    localparam NONE = 2'b11;
    
    reg [7:0] DATA_BYTE;
    reg [2:0] BIT_POS;
    reg [1:0] STATE;
    reg [9:0] CLK_COUNT = 0;
    
    always @(posedge i_CLK)
        if (~i_RST) 
        begin    
            CLK_COUNT <= 0;
            RECV_DATA <= 0;
            RECV_DONE <= 0;
            STATE<=IDLE;
        end
        else
        begin
        case (STATE)
//            NONE:
//                begin
//                    CLK_COUNT <= 0;
//                    RECV_DATA <= 0;
//                    RECV_DONE <= 0;
//                    STATE <= IDLE;
//                end // NONE END
            IDLE:
                begin
                    if (DATA_SERIAL == 0) begin
                        if (CLK_COUNT == CLK_PER_BIT-1)
                        begin
                            CLK_COUNT <= 0;
                            STATE <= DATA;
                            RECV_DONE <= 0;
                            RECV_DATA <= RECV_DATA;
                            BIT_POS <= 0;
                        end
                        else CLK_COUNT <= CLK_COUNT+1;    
                    end
                    else STATE <= IDLE;
                end // IDLE END
             DATA:
                begin
                    DATA_BYTE[BIT_POS] <= DATA_SERIAL;
                    if (CLK_COUNT < CLK_PER_BIT -1)
                        begin
                            CLK_COUNT <= CLK_COUNT + 1; 
                            STATE <= DATA;
                        end
                    else 
                        begin
                            if (BIT_POS < 7)
                                begin
                                BIT_POS<=BIT_POS+1;
                                STATE <= DATA;
                                CLK_COUNT <= 0;
                                end
                             else
                                begin
                                CLK_COUNT<= 0;
                                BIT_POS<=0;
                                STATE <= STOP;
                                end
                        end
                end // DATA END
              STOP:
                begin
                if (CLK_COUNT < CLK_PER_BIT -1)
                    begin
                    CLK_COUNT <= CLK_COUNT + 1;
                    STATE <= STOP;
                    end
                else
                    begin
                    RECV_DONE = 1'b1;
                    RECV_DATA = DATA_BYTE;
                    STATE <= IDLE;
                    end
                end // STOP END
        default: STATE <= IDLE;
        endcase
        end // ALWAYWS @ CLK
    endmodule
