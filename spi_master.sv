module master#(
    parameter clk_div = 4
)(

input logic clk,
input logic rst ,
input logic start,

  input logic [7:0] m_tx_data,
input logic miso,

output logic mosi,
output logic sclk ,
output logic cs_n,
  output logic [7:0] m_rx_data,

output logic busy,
output logic done
);


  logic [7:0] tx_shift;
  logic [7:0] rx_shift;

  logic [3:0] bit_count;
  logic [15:0] clk_count;


  always_ff @(posedge clk or posedge rst) begin

    if (rst) begin
      mosi      <= 0;
      sclk      <= 0;
      cs_n      <= 1;     // when cs_n = 0 then chip gets selected

      m_rx_data   <= 0;
      tx_shift  <= 0;
      rx_shift  <= 0;
      bit_count <= 0;
      clk_count <= 0;
      busy      <= 0;
      done      <= 0;
    end

    else begin

      done <= 0;

     
      if (start && !busy) begin
        tx_shift  <= m_tx_data;
        rx_shift  <= 0;
        bit_count <= 0;
        clk_count <= 0;

        mosi <= m_tx_data[7];
        sclk <= 0;
        cs_n <= 0;
        busy <= 1;
      end

      
      else if (busy) begin

        if (clk_count == clk_div - 1) begin
          clk_count <= 0;

          if (!sclk) begin
           
            sclk     <= 1;
            rx_shift <= {rx_shift[6:0], miso};
          end

          else begin
           
            sclk <= 0;

            if (bit_count == 7) begin
             
              m_rx_data <= rx_shift;
              cs_n    <= 1;
              busy    <= 0;
              done    <= 1;
            end
            else begin
              bit_count <= bit_count + 1;
              tx_shift  <= {tx_shift[6:0], 1'b0};
              mosi      <= tx_shift[6];
            end
          end
        end

        else begin
          clk_count <= clk_count + 1;
        end

      end
    end
  end

endmodule

