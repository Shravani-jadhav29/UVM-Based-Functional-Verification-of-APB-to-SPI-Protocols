class my_monitor extends uvm_monitor;
  `uvm_component_utils(my_monitor)

  virtual intff inf2;
  seq_item seq;

  uvm_analysis_port #(seq_item) ap_mon;

  function new(string name = "my_monitor",
               uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    ap_mon = new("ap_mon", this);

    if (!uvm_config_db#(virtual intff)::get(this, "", "vif", inf2))
      `uvm_fatal("MON", "Virtual interface not set")
  endfunction


  task run_phase(uvm_phase phase);

    wait(inf2.rst == 0);

    forever begin

      @(posedge inf2.clk);

      if (inf2.cmd_start) begin

        seq = seq_item::type_id::create("seq");

        
        seq.start = inf2.cmd_start;
        seq.addr = inf2.cmd_addr;
        seq.data =  inf2.cmd_data;
        seq.rw  = inf2.cmd_rw;

        do begin
          @(negedge inf2.clk);

          if (inf2.psel && inf2.penable && inf2.pready) begin
            seq.paddr   = inf2.paddr;
            seq.pwrite  = inf2.pwrite;
            seq.pwdata  = inf2.pwdata;
            seq.pslverr = inf2.pslverr;
            seq.prdata  = inf2.prdata;
          end

        end while (!inf2.cmd_done);

     
        seq.read_data = inf2.cmd_rdata;
        seq.error     = inf2.cmd_error;
        seq.done      = inf2.cmd_done;

     
        seq.m_tx_data = inf2.spi_tx_data;
        seq.m_rx_data = inf2.spi_rx_data;
        seq.s_tx_data = inf2.s_tx_data;
        seq.s_rx_data = inf2.s_rx_data;

        ap_mon.write(seq);

      end
    end

  endtask

endclass

