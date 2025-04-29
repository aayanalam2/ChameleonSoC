//
// Clock Generator Divider Length
//

`define SPI_DIVIDER_LEN_8
//`define SPI_DIVIDER_LEN_16
//`define SPI_DIVIDER_LEN_24
//`define SPI_DIVIDER_LEN_32

`ifdef SPI_DIVIDER_LEN_8
  `define SPI_DIVIDER_LEN      2   // Can be set from 1 to 8
  //`define SPI_DIVIDER_LEN      4   // Can be set from 1 to 8
`endif

`ifdef SPI_DIVIDER_LEN_16
  `define SPI_DIVIDER_LEN      16  // Can be set from 1 to 16
`endif

`ifdef SPI_DIVIDER_LEN_24
  `define SPI_DIVIDER_LEN      24  // Can be set from 1 to 24
`endif

`ifdef SPI_DIVIDER_LEN_32
  `define SPI_DIVIDER_LEN      32  // Can be set from 1 to 32
`endif


//
// Max Number Of Bits That Can Be Sent/Recieved At Once
//

`define SPI_MAX_CHAR_8
//`define SPI_MAX_CHAR_16
//`define SPI_MAX_CHAR_24
//`define SPI_MAX_CHAR_32
//`define SPI_MAX_CHAR_64
//`define SPI_MAX_CHAR_128

`ifdef SPI_MAX_CHAR_8
  `define SPI_MAX_CHAR 8
  `define SPI_CHAR_LEN_BITS 3
`endif

`ifdef SPI_MAX_CHAR_16
  `define SPI_MAX_CHAR 16
  `define SPI_CHAR_LEN_BITS 4
`endif

`ifdef SPI_MAX_CHAR_24
  `define SPI_MAX_CHAR 24
  `define SPI_CHAR_LEN_BITS 5
`endif

`ifdef SPI_MAX_CHAR_32
  `define SPI_MAX_CHAR 32
  `define SPI_CHAR_LEN_BITS 5
`endif

`ifdef SPI_MAX_CHAR_64
  `define SPI_MAX_CHAR 64
  `define SPI_CHAR_LEN_BITS 6
`endif

`ifdef SPI_MAX_CHAR_128
  `define SPI_MAX_CHAR 128
  `define SPI_CHAR_LEN_BITS 7
`endif


//
// Number of Devices Select Signals
//

`define SPI_SS_NB_8
//`define SPI_SS_NB_16
//`define SPI_SS_NB_24
//`define SPI_SS_NB_32

`ifdef SPI_SS_NB_8
  `define SPI_SS_NB 8
`endif
`ifdef SPI_SS_NB_16
  `define SPI_SS_NB 16
`endif
`ifdef SPI_SS_NB_24
  `define SPI_SS_NB 24
`endif
`ifdef SPI_SS_NB_32
  `define SPI_SS_NB 32
`endif


//
// Register Offsets
//

`define SPI_RX_0    5'b00000
`define SPI_RX_1    5'b00100
`define SPI_RX_2    5'b01000
`define SPI_RX_3    5'b01100
`define SPI_TX_0    5'b00000
`define SPI_TX_1    5'b00100
`define SPI_TX_2    5'b01000
`define SPI_TX_3    5'b01100
`define SPI_CTRL    5'b10000
`define SPI_DIVIDE  5'b10100
`define SPI_SS      5'b11000


//
// No. of Bits in CTRL Register
//

`define SPI_CTRL_BIT_NB 14


//
// Control Register Bit Position
//

`define SPI_CTRL_ASS          13
`define SPI_CTRL_IE           12
`define SPI_CTRL_LSB          11
`define SPI_CTRL_TX_NEGEDGE   10
`define SPI_CTRL_RX_NEGEDGE   9
`define SPI_CTRL_GO           8
`define SPI_CTRL_RES_1        7
`define SPI_CTRL_CHAR_LEN     6:0

//SPI Master Core

module spi_top(wb_clk_in,
               wb_rst_in,
               wb_adr_in,
               wb_dat_o,
               wb_sel_in,
               wb_we_in,
               wb_stb_in,
               wb_cyc_in,
               wb_ack_out,
               wb_int_o,
               wb_dat_in,
               ss_pad_o,
               sclk_out,
               mosi,
               miso);

input wb_clk_in,
      wb_rst_in,
      wb_we_in,
      wb_stb_in,
      wb_cyc_in,
      miso;

input [4:0]  wb_adr_in;
input [31:0] wb_dat_in;
input [3:0]  wb_sel_in;

output reg [31:0] wb_dat_o;

output wb_ack_out,wb_int_o,sclk_out,mosi;

reg wb_ack_out,wb_int_o;

output [`SPI_SS_NB-1:0] ss_pad_o;

//Internal signals......................................

wire rx_negedge;                        //miso is sampled on negative edge
wire tx_negedge;                        //mosi is driven on negative edge
wire [3:0] spi_tx_sel;                  //tx_1 register selected
wire [`SPI_CHAR_LEN_BITS-1:0] char_len; //char len
wire go,ie,ass;                         //go
wire lsb;
wire cpol_0,cpol_1,last,tip;
wire [`SPI_MAX_CHAR-1:0] rx;
wire spi_divider_sel,spi_ctrl_sel,spi_ss_sel;
reg  [`SPI_DIVIDER_LEN-1:0] divider;    //Divider register
reg  [31:0] wb_temp_dat;
reg  [`SPI_CTRL_BIT_NB-1:0] ctrl;       //Control and status register
reg  [`SPI_SS_NB-1:0] ss;               //Slave select register

//Instantiate the SPI_CLK_GENERATOR Module
spi_clgen SC(wb_clk_in,
             wb_rst_in,
             go,
             tip,
             last,
	     divider,
             sclk_out,
             cpol_0,
             cpol_1);

//Instantiate the SPI shift register
spi_shift_reg SR(rx_negedge,
                 tx_negedge,
                 wb_sel_in,
                 (spi_tx_sel[3:0] & {4{wb_we_in}}),
                 char_len,
                 wb_dat_in,
                 wb_clk_in,
                 wb_rst_in,
                 go,
                 miso,
                 lsb,
                 sclk_out,
                 cpol_0,
                 cpol_1,
                 rx,
                 last,
                 mosi,
                 tip);

//Address decoder
assign spi_divider_sel = wb_cyc_in & wb_stb_in & (wb_adr_in == (5'b10100));
assign spi_ctrl_sel    = wb_cyc_in & wb_stb_in & (wb_adr_in == (5'b10000));
assign spi_ss_sel      = wb_cyc_in & wb_stb_in & (wb_adr_in == (5'b11000));
assign spi_tx_sel[0]   = wb_cyc_in & wb_stb_in & (wb_adr_in == (5'b00000));
assign spi_tx_sel[1]   = wb_cyc_in & wb_stb_in & (wb_adr_in == (5'b00100));
assign spi_tx_sel[2]   = wb_cyc_in & wb_stb_in & (wb_adr_in == (5'b01000));
assign spi_tx_sel[3]   = wb_cyc_in & wb_stb_in & (wb_adr_in == (5'b01100));

//Read from registers
always@(*)
begin
    case(wb_adr_in)
        `ifdef SPI_MAX_CHAR_128
            `SPI_RX_0 : wb_temp_dat = rx[31:0];
            `SPI_RX_1 : wb_temp_dat = rx[63:32];
            `SPI_RX_2 : wb_temp_dat = rx[95:64];
            `SPI_RX_3 : wb_temp_dat = rx[127:96];
        `else
        `ifdef SPI_MAX_CHAR_64
            `SPI_RX_0 : wb_temp_dat = rx[31:0];
            `SPI_RX_1 : wb_temp_dat = rx[63:32];
            `SPI_RX_2 : wb_temp_dat = 0;
            `SPI_RX_3 : wb_temp_dat = 0;
        `else
            `SPI_RX_0 : wb_temp_dat = rx[`SPI_MAX_CHAR-1:0];
            `SPI_RX_1 : wb_temp_dat = 32'b0;
            `SPI_RX_2 : wb_temp_dat = 32'b0;
            `SPI_RX_3 : wb_temp_dat = 32'b0;
        `endif
    `endif
        `SPI_CTRL     : wb_temp_dat = ctrl;
        `SPI_DIVIDE   : wb_temp_dat = divider;
        `SPI_SS       : wb_temp_dat = ss;
         default      : wb_temp_dat = 32'dx;
    endcase
end

//WB data out
always@(posedge wb_clk_in or posedge wb_rst_in)
begin
    if(wb_rst_in)
        wb_dat_o <= 32'd0;
    else
        wb_dat_o <= wb_temp_dat;
end

//WB acknowledge
always@(posedge wb_clk_in or posedge wb_rst_in)
begin
    if(wb_rst_in)
        begin
            wb_ack_out <= 0;
        end
    else
        begin
            wb_ack_out <= wb_cyc_in & wb_stb_in & ~wb_ack_out;
        end
end

//Interrupt
always@(posedge wb_clk_in or posedge wb_rst_in)
begin
    if (wb_rst_in)
        wb_int_o <= 1'b0;
    else if (ie && tip && last && cpol_0)
        wb_int_o <= 1'b1;
    else if (wb_ack_out)
        wb_int_o <= 1'b0;
end

//Selecting Slave device from a group of 32 slave devices
assign ss_pad_o = ~((ss & {`SPI_SS_NB{tip & ass}}) | (ss & {`SPI_SS_NB{!ass}}));

//Divider register
always@(posedge wb_clk_in or posedge wb_rst_in)
begin
    if(wb_rst_in)
        begin
            divider <= 0;
        end
    else if(spi_divider_sel && wb_we_in && !tip)
        begin
            `ifdef SPI_DIVIDER_LEN_8
                if(wb_sel_in[0])
                    divider <= 1;
            `endif
            `ifdef SPI_DIVIDER_LEN_16
                if(wb_sel_in[0])
                    divider[7:0] <= wb_dat_in[7:0];
                if(wb_sel_in[1])
                    divider[15:8] <= wb_dat_in[`SPI_DIVIDER_LEN-1:8];
            `endif
            `ifdef SPI_DIVIDER_LEN_24
                if(wb_sel_in[0])
                    divider[7:0] <= wb_dat_in[7:0];
                if(wb_sel_in[1])
                    divider[15:8] <= wb_dat_in[15:8];
                if(wb_sel_in[2])
                    divider[23:16] <= wb_dat_in[`SPI_DIVIDER_LEN-1:16];
            `endif
            `ifdef SPI_DIVIDER_LEN_32
                if(wb_sel_in[0])
                    divider[7:0] <= wb_dat_in[7:0];
                if(wb_sel_in[1])
                    divider[15:8] <= wb_dat_in[15:8];
                if(wb_sel_in[2])
                    divider[23:16] <= wb_dat_in[23:16];
                if(wb_sel_in[3])
                    divider[31:24] <= wb_dat_in[`SPI_DIVIDER_LEN-1:24];
            `endif
        end
end

//Control and status register
always@(posedge wb_clk_in or posedge wb_rst_in)
begin
    if(wb_rst_in)
        ctrl <= 0;
    else
        begin
            if(spi_ctrl_sel && wb_we_in && !tip)
                begin
                    if(wb_sel_in[0])
                        ctrl[7:0] <= wb_dat_in[7:0] | {7'd0, ctrl[0]};
                    if(wb_sel_in[1])
                        ctrl[`SPI_CTRL_BIT_NB-1:8] <= wb_dat_in[`SPI_CTRL_BIT_NB-1:8];
                end
            else if(tip && last && cpol_0)
                ctrl[`SPI_CTRL_GO] <= 1'b0;
        end
end

assign rx_negedge = ctrl[`SPI_CTRL_RX_NEGEDGE];
assign tx_negedge = ctrl[`SPI_CTRL_TX_NEGEDGE];
assign lsb = ctrl[`SPI_CTRL_LSB];
assign ie  = ctrl[`SPI_CTRL_IE];
assign ass = ctrl[`SPI_CTRL_ASS];
assign go  = ctrl[`SPI_CTRL_GO];
assign char_len = ctrl[`SPI_CTRL_CHAR_LEN];

//Slave select
always@(posedge wb_clk_in or posedge wb_rst_in)
begin
    if(wb_rst_in)
        begin
            ss <= 0;
        end
    else
        begin
            if(spi_ss_sel && wb_we_in && !tip)
                begin
                    `ifdef SPI_SS_NB_8
                        if(wb_sel_in[0])
                            ss <= wb_dat_in[`SPI_SS_NB-1:0];
                    `endif

                    `ifdef SPI_SS_NB_16
                        if(wb_sel_in[0])
                            ss <= wb_dat_in[7:0];
                        if(wb_sel_in[1])
                            ss <= wb_dat_in[`SPI_SS_NB-1:8];
                    `endif

                    `ifdef SPI_SS_NB_24
                        if(wb_sel_in[0])
                            ss <= wb_dat_in[7:0];
                        if(wb_sel_in[1])
                            ss <= wb_dat_in[15:8];
                        if(wb_sel_in[2])
                            ss <= wb_dat_in[`SPI_SS_NB-1:16];
                    `endif

                    `ifdef SPI_SS_NB_32
                        if(wb_sel_in[0])
                            ss <= wb_dat_in[7:0];
                        if(wb_sel_in[1])
                            ss <= wb_dat_in[15:8];
                        if(wb_sel_in[2])
                            ss <= wb_dat_in[23:16];
                        if(wb_sel_in[3])
                            ss <= wb_dat_in[`SPI_SS_NB-1:24];
                    `endif
                end
        end
end

endmodule

module spi_clgen (wb_clk_in,
		  wb_rst,
		  tip,
		  go,
		  last_clk,
		  divider,
		  sclk_out,
		  cpol_0,
		  cpol_1);

  input                         wb_clk_in;
  input                         wb_rst;
  input                         tip;
  input                         go;
  input                         last_clk;
  input [`SPI_DIVIDER_LEN-1:0] divider;
  output                        sclk_out;
  output                        cpol_0;
  output                        cpol_1;
  
  reg                           sclk_out;
  reg                           cpol_0;
  reg                           cpol_1;
  
  reg [`SPI_DIVIDER_LEN-1:0]    cnt;

  
  
  
  // Counter counts half period
  always@(posedge wb_clk_in or posedge wb_rst)
  begin
    if(wb_rst)
      begin
        cnt <= {{`SPI_DIVIDER_LEN{1'b0}},1'b1};
      end
    else if(tip)
      begin
        if(cnt == (divider + 1))
          begin
            cnt <= {{`SPI_DIVIDER_LEN{1'b0}},1'b1};
          end
        else
          begin
            cnt <= cnt + 1;
          end
      end
    else if(cnt == 0)
      begin
        cnt <= {{`SPI_DIVIDER_LEN{1'b0}},1'b1};
      end
  end
  
  
  // Generation of the serial clock
  always@(posedge wb_clk_in or posedge wb_rst)
  begin
    if(wb_rst)
      begin
        sclk_out <= 1'b0;
      end
    else if(tip)
      begin
        if(cnt == (divider + 1))
          begin
            if(!last_clk || sclk_out)
              sclk_out <= ~sclk_out;
          end
      end
  end
  
endmodule
module spi_shift_reg(rx_negedge,
                     tx_negedge,
                     byte_sel,
                     latch,
                     len,
                     p_in,
                     wb_clk_in,
                     wb_rst,
                     go,
                     miso,
                     lsb,
                     sclk,
                     cpol_0,
                     cpol_1,
                     p_out,
                     last,
                     mosi,
                     tip);

    input   rx_negedge,
            tx_negedge,
            wb_clk_in,
            wb_rst,
            go,miso,
            lsb,
            sclk,
            cpol_0,
            cpol_1;

    input [3:0] byte_sel,latch;
    input [`SPI_CHAR_LEN_BITS-1:0] len;
    input [31:0] p_in;

    output [`SPI_MAX_CHAR-1:0] p_out;
    output reg tip,mosi;
    output last;

    reg [`SPI_CHAR_LEN_BITS:0] char_count;  
    reg [`SPI_MAX_CHAR-1:0] master_data;    // shift register
    reg [`SPI_CHAR_LEN_BITS:0] tx_bit_pos;  // next bit position
    reg [`SPI_CHAR_LEN_BITS:0] rx_bit_pos;  // next bit position
    wire rx_clk;                            // rx clock enable
    wire tx_clk;                            // tx clock enable

// Character bit counter...............
always@(posedge wb_clk_in or posedge wb_rst)
begin
  if(wb_rst)
    begin
      char_count <= 0;
    end
  else
    begin
      if(tip)
        begin
          if(cpol_0)
            begin
              char_count <= char_count - 1;
            end
        end
      else
        char_count <= {1'b0,len}; // This stores the character bits other than 128 bits
    end
end

// Calculate transfer in progress
always@(posedge wb_clk_in or posedge wb_rst)
begin
  if(wb_rst)
    begin
      tip <= 0;
    end
  else
    begin
      if(go && ~tip)
        begin
          tip <= 1;
        end
      else if(last && tip && cpol_0)
        begin
          tip <= 0;
        end
    end
end

// Calculate last
assign last = ~(|char_count);

// Calculate the serial out
always@(posedge wb_clk_in or posedge wb_rst)
begin
  if(wb_rst)
    begin
      mosi <= 0;
    end
  else
    begin
      if(tx_clk)
        begin
          mosi <= master_data[tx_bit_pos[`SPI_CHAR_LEN_BITS-1:0]];
        end
    end
end

// Calculate tx_clk,rx_clk
assign tx_clk = ((tx_negedge)?cpol_1 : cpol_0) && !last;
assign rx_clk = ((rx_negedge)?cpol_1 : cpol_0) && (!last || sclk);

// Calculate TX_BIT Position
always@(lsb,len,char_count)
begin
  if(lsb)
    begin
      tx_bit_pos = ({~{|len},len}-char_count);
    end
  else
    begin
      tx_bit_pos = char_count-1;
    end
end

// Calculate RX_BIT Position based on rx_negedge as miso depends on rx_clk
always@(lsb,len,rx_negedge,char_count)
begin
  if(lsb)
    begin
      if(rx_negedge)
        rx_bit_pos = {~(|len),len}-(char_count+1);
      else
        rx_bit_pos = {~(|len),len}-char_count;
    end
  else
    begin
      if(rx_negedge)
        begin
          rx_bit_pos = char_count;
        end
      else
        begin
          rx_bit_pos = char_count-1;
        end
    end
end

// Calculate p_out
assign p_out = master_data;

// Latching of data
always@(posedge wb_clk_in or posedge wb_rst)
begin
  if(wb_rst)
    master_data <= {`SPI_MAX_CHAR{1'b0}};

    // Recieving bits from the parallel line
    `ifdef SPI_MAX_CHAR_128
      else if(latch[0] && !tip) // TX0 is selected
        begin
          if(byte_sel[0])
            begin
             master_data[7:0] <= p_in[7:0];
            end
          if(byte_sel[1])
            begin
             master_data[15:8] <= p_in[15:8];
            end
          if(byte_sel[2])
            begin
             master_data[23:16] <= p_in[23:16];
            end
          if(byte_sel[3])
            begin
             master_data[31:24] <= p_in[31:24];
            end
        end
      else if(latch[1] && !tip) // TX1 is selected
        begin
          if(byte_sel[0])
            begin
              master_data[39:32] <= p_in[7:0];
            end
          if(byte_sel[1])
            begin
              master_data[47:40] <= p_in[15:8];
            end
          if(byte_sel[2])
            begin
              master_data[55:48] <= p_in[23:16];
            end
          if(byte_sel[3])
            begin
              master_data[63:56] <= p_in[31:24];
            end
        end
      else if(latch[2] && !tip) // TX2 is selected
        begin
          if(byte_sel[0])
            begin
              master_data[71:64] <= p_in[7:0];
            end
          if(byte_sel[1])
            begin
              master_data[79:72] <= p_in[15:8];
            end
          if(byte_sel[2])
            begin
              master_data[87:80] <= p_in[23:16];
            end
          if(byte_sel[3])
            begin
              master_data[95:88] <= p_in[31:24];
            end
        end
      else if(latch[3] && !tip) // TX3 is selected
        begin
          if(byte_sel[0])
            begin
              master_data[103:96] <= p_in[7:0];
            end
          if(byte_sel[1])
            begin
              master_data[111:104] <= p_in[15:8];
            end
          if(byte_sel[2])
            begin
              master_data[119:112] <= p_in[23:16];
            end
          if(byte_sel[3])
            begin
              master_data[127:120] <= p_in[31:24];
            end
        end
    `else
    `ifdef SPI_MAX_CHAR_64
      else if(latch[0] && !tip) // TX0 is selected
        begin
          if(byte_sel[0])
            begin
             master_data[7:0] <= p_in[7:0];
            end
          if(byte_sel[1])
            begin
             master_data[15:8] <= p_in[15:8];
            end
          if(byte_sel[2])
            begin
             master_data[23:16] <= p_in[23:16];
            end
          if(byte_sel[3])
            begin
             master_data[31:24] <= p_in[31:24];
            end
        end
      else if(latch[1] && !tip) // TX1 is selected
        begin
          if(byte_sel[0])
            begin
              master_data[39:32] <= p_in[7:0];
            end
          if(byte_sel[1])
            begin
              master_data[47:40] <= p_in[15:8];
            end
          if(byte_sel[2])
            begin
              master_data[55:48] <= p_in[23:16];
            end
          if(byte_sel[3])
            begin
              master_data[63:56] <= p_in[31:24];
            end
        end
    `else
      else if(latch[0] && !tip) //TX0 is selected
        begin

          `ifdef SPI_MAX_CHAR_8
            if(byte_sel[0])
              begin
                master_data[7:0] <= p_in[7:0];
              end
          `endif

          `ifdef SPI_MAX_CHAR_16
            if(byte_sel[0])
              begin
                master_data[7:0] <= p_in[7:0];
              end
            if(byte_sel[1])
              begin
                master_data[15:8] <= p_in[15:8];
              end
          `endif

          `ifdef SPI_MAX_CHAR_24
            if(byte_sel[0])
              begin
                master_data[7:0] <= p_in[7:0];
              end
            if(byte_sel[1])
              begin
                master_data[15:8] <= p_in[15:8];
              end
            if(byte_sel[2])
              begin
                master_data[23:16] <= p_in[23:16];
              end
          `endif

          `ifdef SPI_MAX_CHAR_32
            if(byte_sel[0])
              begin
                master_data[7:0] <= p_in[7:0];
               end
            if(byte_sel[1])
              begin
                master_data[15:8] <= p_in[15:8];
              end
            if(byte_sel[2])
              begin
                master_data[23:16] <= p_in[23:16];
              end
            if(byte_sel[3])
              begin
                master_data[31:24] <= p_in[31:24];
              end
          `endif
        end
      `endif
    `endif

    // Receiving bits from the serial line
    else
      begin
        if(rx_clk)
          master_data[rx_bit_pos[`SPI_CHAR_LEN_BITS-1:0]] <= miso;
        end
    end
  // Posedge and negedge detection of sclk
always@(posedge wb_clk_in or posedge wb_rst)
  begin
    if(wb_rst)
      begin
        cpol_0 <= 1'b0;
        cpol_1 <= 1'b0;
      end
    else
      begin
        cpol_0 <= 0;
        cpol_1 <= 0;
          if(tip)
            begin
              if(~sclk_out)
                begin
                  if(cnt == divider)
                    begin
                      cpol_0 <= 1;
                    end
                end
            end
          if(tip)
            begin
              if(sclk_out)
                begin
                  if(cnt == divider)
                    begin
                      cpol_1 <= 1;
                    end
                end
            end
      end
   end


endmodule



module spi_slave (input sclk,mosi,
                  input [`SPI_SS_NB-1:0]ss_pad_o,
                  output miso);

    reg rx_slave = 1'b0; //Slave recieving from SPI_MASTER
    reg tx_slave = 1'b0; //Slave transmitting to SPI_MASTER

    //Initial value of temp is 0
    reg [127:0]temp1 = 0;
    reg [127:0]temp2 = 0;

    reg miso1 = 1'b0;
    reg miso2 = 1'b1;

    always@(posedge sclk)
    begin
        if ((ss_pad_o != 8'b11111111) && ~rx_slave && tx_slave) //Posedge of the Serial Clock
            begin
                temp1 <= {temp1[126:0],mosi};
            end
    end

    always@(negedge sclk)
    begin
        if ((ss_pad_o != 8'b11111111) && rx_slave && ~tx_slave) //Negedge of the Serial Clock
            begin
                temp2 <= {temp2[126:0],mosi};
            end
    end

    always@(negedge sclk)
    begin
        if (rx_slave && ~tx_slave) //Posedge of the Serial Clock
            begin
                miso1 <= temp1[127];
            end
    end
    
    always@(negedge sclk)
    begin
        if (~rx_slave && tx_slave) //Posedge of the Serial Clock
            begin
                miso2 <= temp2[127];
            end
    end

    assign miso = miso1 || miso2;

endmodule
   
   

