class my_test extends uvm_test;
  `uvm_component_utils(my_test)

my_sequence sequn;
my_env envn;

  function new(string name = "my_test",uvm_component parent = null);
    super.new(name,parent);
  endfunction 

function void build_phase(uvm_phase phase);
    super.build_phase(phase);
   
  //sequn = my_sequence::type_id::create("sequn"); // is the object so dont have parent 
  envn  = my_env::type_id::create("envn", this);
  
    `uvm_info("build_phase","calling from agent",UVM_NONE);
  endfunction


  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);

    //sequn.start(envn.agnt.seqn);

    `uvm_info("connect_phase","calling from agent",UVM_NONE);
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);

    sequn = my_sequence::type_id::create("sequn"); // is the object so dont have parent 
    sequn.start(envn.agnt.seqn);
    phase.drop_objection(this);

  endtask


endclass
