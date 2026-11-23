class my_scb extends uvm_scoreboard;
  `uvm_component_utils(my_scb)

  uvm_analysis_imp #(seq_item, my_scb) ap_sb;

  bit [7:0] last_tx = 8'h00;

  function new(string name = "my_scb",
               uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    ap_sb = new("ap_sb", this);

    `uvm_info("build_phase", "calling from scoreboard", UVM_NONE)
  endfunction

  virtual function void write(seq_item t);

    bit addr_ok;
    bit exp_err;

    addr_ok = (t.paddr == 4'h0) ||(t.paddr == 4'h4) ||(t.paddr == 4'hC);

    exp_err = !addr_ok ||(t.pwrite && t.paddr == 4'h4);

   

    if (t.paddr !== t.addr)
      `uvm_error("SCB",$sformatf("Address mismatch: Expected=%h Actual=%h", t.addr, t.paddr))
//     else
//       `uvm_info("SCB",
      //         $sformatf("Address match: Expected=%h Actual=%h", t.addr, t.paddr), UVM_LOW)

    if (t.pwrite !== t.rw)
      `uvm_error("SCB",$sformatf("Read/Write mismatch: Expected=%b Actual=%b", t.rw, t.pwrite))
//     else
//       `uvm_info("SCB",
//         $sformatf("Read/Write match: Expected=%b Actual=%b",
//                   t.rw, t.pwrite), UVM_LOW)

    if (t.pwrite && t.pwdata !== t.data)
      `uvm_error("SCB",
        $sformatf("Write data mismatch: Expected=%h Actual=%h",
                  t.data, t.pwdata))
//     else
//       `uvm_info("SCB",
//         $sformatf("Write data match: Expected=%h Actual=%h",
//                   t.data, t.pwdata), UVM_LOW)

    if (t.pslverr !== exp_err)
      `uvm_error("SCB", $sformatf("PSLVERR mismatch: Expected=%b Actual=%b",exp_err, t.pslverr))

//     else
//       `uvm_info("SCB",
//         $sformatf("PSLVERR match: Expected=%b Actual=%b",
//                   exp_err, t.pslverr), UVM_LOW)

    if (t.error !== t.pslverr)
      `uvm_error("SCB",$sformatf("APB error mismatch: Expected=%b Actual=%b", t.pslverr, t.error))

//     else
//       `uvm_info("SCB",
//         $sformatf("APB error mismatch: Expected=%b Actual=%b",
//                   t.pslverr, t.error), UVM_LOW)

    if (t.pwrite && !t.pslverr && t.paddr == 4'h0) begin

      last_tx = t.pwdata;

      `uvm_info("SCB",$sformatf("TX_DATA WRITE PASS: Data=%h", last_tx),UVM_LOW)

    end

    if (!t.pwrite && !t.pslverr) begin

      if (t.paddr == 4'h0) begin

        if (t.prdata !== last_tx)
          `uvm_error("SCB",$sformatf("TX_DATA mismatch: Expected=%h Actual=%h",last_tx, t.prdata))

        else
          `uvm_info("SCB",$sformatf("TX_DATA mismatch: Expected=%h Actual=%h",last_tx, t.prdata), UVM_LOW)

      end

      if (t.paddr == 4'h4) begin

        
        if (t.prdata !== t.m_rx_data)
          `uvm_error("SCB",$sformatf("RX_DATA mismatch: Expected=%h Actual=%h",t.m_rx_data, t.prdata))
        else
          `uvm_info("SCB" , $sformatf("APB RX_DATA READ PASS: Expected=%h Actual=%h",t.m_rx_data, t.prdata), UVM_LOW)



        if (t.s_rx_data !== last_tx)
          `uvm_error("SCB",$sformatf("SPI Master-to-Slave FAIL: Expected=%h Actual=%h",last_tx, t.s_rx_data))
        else
          `uvm_info("SCB", $sformatf("SPI Master-to-Slave passs: Expected=%h Actual=%h",last_tx, t.s_rx_data), UVM_LOW)

        if (t.m_rx_data !== t.s_tx_data)
          `uvm_error("SCB", $sformatf("SPI Slave-to-Master FAIL: Expected=%h Actual=%h",  t.s_tx_data, t.m_rx_data))
        else
          `uvm_info("SCB", $sformatf("SPI Slave-to-Master pass: Expected=%h Actual=%h", t.s_tx_data, t.m_rx_data), UVM_LOW)

      end

      if (t.paddr == 4'hC) begin

        if (t.prdata[7:2] !== 6'b0)
          `uvm_error("SCB", $sformatf("STATUS upper bits mismatch: Expected=%b Actual=%b",6'b0, t.prdata[7:2]))

      end

    end

  endfunction

endclass
