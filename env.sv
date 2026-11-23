class my_env extends uvm_env;
  `uvm_component_utils(my_env)

   my_agent agnt;
   my_scb scb;

  function new (string name = "my_env", uvm_component parent = null);
    super.new(name,parent);
  endfunction 


  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    agnt = my_agent::type_id::create("agnt",this);
    scb = my_scb::type_id::create("scb",this); 

    `uvm_info("build_phase","calling from env",UVM_NONE)
  endfunction


  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    agnt.mon.ap_mon.connect(scb.ap_sb);
    `uvm_info("connect_phase","calling from env",UVM_NONE)
  endfunction

endclass
