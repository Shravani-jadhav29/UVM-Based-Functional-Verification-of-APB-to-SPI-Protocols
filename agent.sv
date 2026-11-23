class my_agent extends uvm_agent;
  `uvm_component_utils(my_agent)

    my_sequencer seqn;
    my_driver drv;
    my_monitor mon;

  function new (string name = "my_agent", uvm_component parent = null);
    super.new(name,parent);
  endfunction 


  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
   
    seqn = my_sequencer::type_id::create("seqn",this);
    drv  = my_driver::type_id::create("drv", this);
    mon  = my_monitor::type_id::create("mon", this);
    

    `uvm_info("build_phase","calling from agent",UVM_NONE);
  endfunction


  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);

    drv.seq_item_port.connect(seqn.seq_item_export);

    `uvm_info("connect_phase","calling from agent",UVM_NONE);
  endfunction

endclass
