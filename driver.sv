class my_driver extends uvm_driver #(seq_item);
  `uvm_component_utils(my_driver)

  virtual intff inf;
  seq_item rsp;

  function new(string name = "my_driver", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    if (!uvm_config_db#(virtual intff)::get(this, "", "vif", inf))
      `uvm_fatal("DRV", "virtual interface not set")

    `uvm_info("build_phase", "calling from my_driver", UVM_NONE)
  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info("connect_phase", "calling from my_driver", UVM_NONE)
  endfunction

  task run_phase(uvm_phase phase);

    inf.cmd_start <= 0;
    inf.cmd_rw    <= 0;
    inf.cmd_addr  <= 0;
    inf.cmd_data  <= 0;

    wait(inf.rst == 0);

    forever begin
      seq_item_port.get_next_item(req);

      drive(req);

      rsp = seq_item::type_id::create("rsp");
      rsp.set_id_info(req);

      rsp.rw  = req.rw;
      rsp.addr = req.addr;
      rsp.data  = req.data;
      rsp.read_data = inf.cmd_rdata;
      rsp.done   = inf.cmd_done;
      rsp.error= inf.cmd_error;
     

      seq_item_port.item_done(rsp);
    end

  endtask


task drive(seq_item req);

    @(negedge inf.clk);

    if (req.addr == 4'h0 && req.rw == 1)
      inf.s_tx_data <= req.s_tx_data;

    inf.cmd_rw  <= req.rw;
    inf.cmd_addr <= req.addr;
    inf.cmd_data <= req.data;
    inf.cmd_start <= 1;

    @(negedge inf.clk);
    inf.cmd_start <= 0;

    @(posedge inf.cmd_done);

    @(negedge inf.clk);

endtask

endclass
