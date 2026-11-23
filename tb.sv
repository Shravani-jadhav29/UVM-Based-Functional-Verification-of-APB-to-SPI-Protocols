`timescale 1ns/1ns

`include "uvm_macros.svh"
`include "interface.sv"

package apb_pkg;
    import uvm_pkg::*;

    `include "seq_item.sv"
    `include "sequance.sv"
    `include "sequancer.sv"
    `include "driver.sv"
    `include "monitor.sv"
    `include "scoreboard.sv"
    `include "agent.sv"
    `include "environment.sv"
    `include "test.sv"

endpackage


module top;

    import uvm_pkg::*;
    import apb_pkg::*;

    parameter int CLK_DIV = 4;

    bit clk = 0;
    logic rst;

    intff inf4 (
        .clk(clk),
        .rst(rst)
    );

    always #5 clk = ~clk;


    // APB MASTER
    apb u_apb_master (
        .clk       (clk),
        .rst       (rst),
        .start     (inf4.cmd_start),
        .rw        (inf4.cmd_rw),
        .addr      (inf4.cmd_addr),
        .data      (inf4.cmd_data),
        .pready    (inf4.pready),
        .pslverr   (inf4.pslverr),
        .prdata    (inf4.prdata),
        .psel      (inf4.psel),
        .penable   (inf4.penable),
        .pwrite    (inf4.pwrite),
        .paddr     (inf4.paddr),
        .pwdata    (inf4.pwdata),
        .read_data (inf4.cmd_rdata),
        .done      (inf4.cmd_done),
        .error     (inf4.cmd_error)
    );


    // APB SLAVE
    apb_slave u_apb_slave (
        .clk       (clk),
        .rst       (rst),
        .psel      (inf4.psel),
        .penable   (inf4.penable),
        .pwrite    (inf4.pwrite),
        .paddr     (inf4.paddr),
        .pwdata    (inf4.pwdata),
        .read_data (inf4.reg_rdata),
        .reg_err   (inf4.reg_err),
        .pready    (inf4.pready),
        .pslverr   (inf4.pslverr),
        .prdata    (inf4.prdata),
        .reg_write (inf4.reg_write),
        .reg_read  (inf4.reg_read),
        .addr      (inf4.addr),
        .data      (inf4.data)
    );


    // REGISTER BANK
    reg_bank u_reg_bank (
        .clk         (clk),
        .rst         (rst),
        .reg_write   (inf4.reg_write),
        .reg_read    (inf4.reg_read),
        .addr        (inf4.addr),
        .data        (inf4.data),
        .spi_rx_data (inf4.spi_rx_data),
        .spi_busy    (inf4.spi_busy),
        .spi_done    (inf4.spi_done),
        .read_data   (inf4.reg_rdata),
        .reg_err     (inf4.reg_err),
        .spi_tx_data (inf4.spi_tx_data),
        .start       (inf4.spi_start)
    );


    // SPI MASTER
    master #(.clk_div(CLK_DIV)) u_spi_master (
        .clk       (clk),
        .rst       (rst),
        .start     (inf4.spi_start),
        .m_tx_data (inf4.spi_tx_data),
        .miso      (inf4.miso),
        .mosi      (inf4.mosi),
        .sclk      (inf4.sclk),
        .cs_n      (inf4.cs_n),
        .m_rx_data (inf4.spi_rx_data),
        .busy      (inf4.spi_busy),
        .done      (inf4.spi_done)
    );


    // SPI SLAVE
    spi_slave u_spi_slave (
        .rst       (rst),
        .sclk      (inf4.sclk),
        .cs_n      (inf4.cs_n),
        .mosi      (inf4.mosi),
        .s_tx_data (inf4.s_tx_data),
        .miso      (inf4.miso),
        .s_rx_data (inf4.s_rx_data)
    );


 
    initial begin
        rst = 1'b1;


        repeat (5) @(posedge clk);
        @(negedge clk);

        rst = 1'b0;
    end

    initial begin
        uvm_config_db#(virtual intff)::set(
            null, "*", "vif", inf4
        );

        run_test("my_test");
    end

endmodule
