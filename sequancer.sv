class my_sequencer extends uvm_sequencer #(seq_item);
  `uvm_component_utils(my_sequencer)

  function new(string name = "my_sequencer", uvm_component parent = null);
    super.new(name, parent);
    `uvm_info("CONSTRUCTOR", "Calling from sequencer class", UVM_NONE)
  endfunction

endclass
