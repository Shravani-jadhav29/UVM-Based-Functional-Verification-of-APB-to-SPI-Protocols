module apb_slave(

       input logic clk, rst,
    input logic psel,penable, pwrite,
    input logic [3:0] paddr,
      input logic [7:0] pwdata,
    input logic [7:0] read_data,
    input logic reg_err,
  
    output logic   pready, pslverr,
 output logic  [7:0] prdata,

    output logic reg_write, reg_read,
    output logic [3:0] addr,
      output logic [7:0] data
);

    always_comb begin

     pready = 1'b1;
    pslverr = psel && penable && reg_err;

    reg_write = 1'b0;
    reg_read= 1'b0;
        prdata =  8'h00;

   addr = paddr;
        data = pwdata;

        if (psel && penable) begin

            if (pwrite) begin
                    reg_write = 1'b1;
            end
            else begin
                  reg_read = 1'b1;
                prdata = read_data;
            end

        end
    end

endmodule
