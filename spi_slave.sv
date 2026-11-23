module spi_slave (
    input  logic    rst,
    input  logic   sclk,
    input  logic cs_n,
    input  logic  mosi,
    input  logic [7:0] s_tx_data,

    output logic       miso,
    output logic [7:0] s_rx_data
);

    logic [7:0] tx_shift;
    logic [7:0] rx_shift;

    logic [2:0] tx_count;
    logic [3:0] rx_count;

    
    always_ff @(negedge cs_n or posedge rst) begin
        if (rst)
            tx_shift <= 8'b0;
        else
            tx_shift <= s_tx_data;
    end

    
    always_ff @(negedge sclk or posedge cs_n or posedge rst) begin
        if (rst || cs_n)
            tx_count <= 3'd0;
        else
            tx_count <= tx_count + 3'd1;
    end

    
    always_comb begin
        if (cs_n)
            miso = 1'b0;
        else
            miso = tx_shift[7 - tx_count];
    end

   
    always_ff @(posedge sclk or posedge cs_n or posedge rst) begin

        if (rst) begin
            rx_shift  <= 8'b0;
            s_rx_data <= 8'b0;
            rx_count  <= 4'd0;
        end

        else if (cs_n) begin
            rx_shift <= 8'b0;
            rx_count <= 4'd0;
        end

        else begin

            rx_shift <= {rx_shift[6:0], mosi};

            if (rx_count == 7) begin
                s_rx_data <= {rx_shift[6:0], mosi};
                rx_count  <= 4'd0;
            end

            else begin
                rx_count <= rx_count + 4'd1;
            end

        end
    end

endmodule

