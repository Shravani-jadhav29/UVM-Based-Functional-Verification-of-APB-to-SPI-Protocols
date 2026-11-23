interface intff (input logic clk, input logic rst);

 
    logic  cmd_start;
   logic cmd_rw;          
  logic [3:0]  cmd_addr;
     logic [7:0]  cmd_data;

   logic [7:0]  cmd_rdata;
  logic  cmd_done;
     logic cmd_error;

  
   logic  psel;
    logic penable;
  logic   pwrite;
  logic [3:0]  paddr;
  logic [7:0]  pwdata;
   logic pready;
  logic  pslverr;
  logic [7:0]  prdata;

  
     logic   reg_write;
  logic   reg_read;
    logic [3:0]  addr;
  logic [7:0]  data;
  logic [7:0]  reg_rdata;       // register bank -> APB slave
    logic reg_err;

 
     logic  spi_start;
  logic [7:0]  spi_tx_data;
     logic [7:0]  spi_rx_data;
  logic   spi_busy;
  logic  spi_done;

  logic sclk;
  logic cs_n;
  logic mosi;
  logic   miso;


  logic [7:0]  s_tx_data;
  logic [7:0]  s_rx_data;

  
  modport TB (
    input  clk, rst,
    input  cmd_rdata, cmd_done, cmd_error,
    output cmd_start, cmd_rw, cmd_addr, cmd_data
  );

  modport APB_master_m1 (
    input  clk, rst,
    input  cmd_start, cmd_rw, cmd_addr, cmd_data,
    input  pready, pslverr, prdata,
    output psel, penable, pwrite, paddr, pwdata,
    output cmd_rdata, cmd_done, cmd_error
  );

  modport APB_slave_s (
    input  clk, rst,
    input  psel, penable, pwrite, paddr, pwdata,
    input  reg_rdata, reg_err,
    output pready, pslverr, prdata,
    output addr, data, reg_write, reg_read
  );

  modport reg_bank_r (
    input  clk, rst,
    input  reg_write, reg_read, addr, data,
    input  spi_rx_data, spi_busy, spi_done,
    output reg_rdata, reg_err,
    output spi_tx_data, spi_start
  );

  modport SPI_master_m (
    input  clk, rst,
    input  spi_start, spi_tx_data, miso,
    output mosi, sclk, cs_n,
    output spi_rx_data, spi_busy, spi_done
  );

  modport SPI_slave_s (
    input  clk, rst,
    input  sclk, cs_n, mosi, s_tx_data,
    output miso, s_rx_data
  );

endinterface
