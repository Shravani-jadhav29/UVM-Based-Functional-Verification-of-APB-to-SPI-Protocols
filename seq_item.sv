class seq_item extends uvm_sequence_item;

  rand bit [3:0] addr;
  rand bit [7:0]data;
  rand bit start;
  rand bit rw;


  bit [7:0] read_data;
  bit done;
  bit error;

bit [3:0] paddr;
bit pwrite;
bit [7:0] pwdata;
bit pslverr;
bit [7:0] prdata;


bit [7:0] m_tx_data;
bit [7:0] m_rx_data;
rand bit [7:0] s_tx_data;
bit [7:0] s_rx_data;

   constraint c1 { addr inside {4'h0, 4'h4, 4'hC}; }
   constraint c2 {start ==1 ;}

`uvm_object_utils_begin(seq_item)

  `uvm_field_int(addr,UVM_ALL_ON)
  `uvm_field_int(data,UVM_ALL_ON)
  `uvm_field_int(start,UVM_ALL_ON)
  `uvm_field_int(rw,UVM_ALL_ON)

  `uvm_field_int(read_data,UVM_ALL_ON)

  `uvm_field_int(done,UVM_ALL_ON)

  `uvm_field_int(error,UVM_ALL_ON)
  `uvm_field_int(paddr, UVM_ALL_ON)
   `uvm_field_int(pwrite, UVM_ALL_ON)
`uvm_field_int(pwdata, UVM_ALL_ON)
   `uvm_field_int(pslverr, UVM_ALL_ON)
 `uvm_field_int(prdata, UVM_ALL_ON)

`uvm_field_int(m_tx_data, UVM_ALL_ON)
`uvm_field_int(m_rx_data, UVM_ALL_ON)
`uvm_field_int(s_tx_data, UVM_ALL_ON)
`uvm_field_int(s_rx_data, UVM_ALL_ON)
`uvm_object_utils_end

  function new(string name = "seq_item");
    super.new(name);
  endfunction
endclass
