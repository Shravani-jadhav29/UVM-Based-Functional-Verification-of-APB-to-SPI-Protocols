module reg_bank(
    input  logic  clk,
    input  logic rst,

     
      input  logic  reg_write,
    input  logic  reg_read,
       input  logic [3:0] addr,
    input  logic   [7:0] data,

   
      input  logic [7:0] spi_rx_data,
      input  logic spi_busy,
 input  logic spi_done,
    output logic [7:0] read_data,
      output logic       reg_err,

   
    output logic [7:0] spi_tx_data,
    output logic  start
);

    logic [7:0] TX_DATA;
    logic [7:0] RX_DATA;
    logic       status_done;

    assign spi_tx_data = TX_DATA;

    wire active  = spi_busy | start;                 
    wire addr_ok = (addr == 4'h0) || (addr == 4'h4) || (addr == 4'hC);

    
  assign reg_err = (reg_write | reg_read) & ( ~addr_ok | (reg_write & (addr == 4'h4))| (reg_write & (addr == 4'h0) & active) );
  
    always_ff @(posedge clk or posedge rst) begin

        if (rst) begin
            TX_DATA     <= 8'h00;
            RX_DATA     <= 8'h00;
            start       <= 1'b0;
            status_done <= 1'b0;
        end

        else begin
            start <= 1'b0;                           

            if (reg_write) begin
                case (addr)

                    4'h0: begin
                        if (!active) begin
                       TX_DATA <= data;     // store the byte
                       start <= 1'b1;       // and send it to the slave
                       status_done <= 1'b0; // new transfer clears old done
                        end
                    end

                    4'hC: begin
                        if (data[1])  //0000_0010
                            status_done <= 1'b0;   // write 1 to clear done
                    end

                    default: ;
                endcase
            end

            if (spi_done) begin                      // transfer finished
                RX_DATA     <= spi_rx_data;          // keep the slave's byte
                status_done <= 1'b1;
            end
        end
    end

    
    always_comb begin
        read_data = 8'h00;

        if (reg_read) begin
            case (addr)
                4'h0: read_data = TX_DATA;
                4'h4: read_data = RX_DATA;
                4'hC: read_data = {6'b0, status_done, spi_busy};
                default: read_data = 8'h00;
            endcase
        end
    end

endmodule
