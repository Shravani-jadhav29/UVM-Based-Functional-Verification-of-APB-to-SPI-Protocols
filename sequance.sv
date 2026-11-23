// class my_sequence extends uvm_sequence #(seq_item);
//   `uvm_object_utils(my_sequence)

//   seq_item seq;
//   seq_item rsp;

//   function new(string name = "my_sequence");
//     super.new(name);
//   endfunction

//   task body();

//     bit [7:0] tx_values[5] = '{8'hE6, 8'h3C, 8'h91, 8'hB5, 8'h6F};

//     for (int i = 0; i < 5; i++) begin

    
//       seq = seq_item::type_id::create("seq");
//       start_item(seq);

//       seq.addr  = 4'h0;
//         seq.data = tx_values[i];
//       seq.rw    = 1;
//       seq.start = 1;

//       finish_item(seq);
//       get_response(rsp);

      
//       do begin
//         seq = seq_item::type_id::create("seq");
//        start_item(seq);

//         seq.addr  = 4'hC;
//         seq.data = 8'h00;
//         seq.rw  = 0;
//         seq.start = 1;

//         finish_item(seq);
//         get_response(rsp);

//       end while (rsp.read_data[0] == 1 || rsp.read_data[1] == 0);

     
//          seq = seq_item::type_id::create("seq");
//       start_item(seq);

//       seq.addr  = 4'h4;
//          seq.data = 8'h00;
//          seq.rw = 0;
//       seq.start = 1;

//       finish_item(seq);
//       get_response(rsp);

//       `uvm_info("SEQ",
//         $sformatf("Transaction %0d: SPI TX = %h, SPI RX = %h, ERROR = %b",
//                   i+1, tx_values[i], rsp.read_data, rsp.error),
//         UVM_LOW)

//     end

//   endtask
// endclass




class my_sequence extends uvm_sequence #(seq_item);
  `uvm_object_utils(my_sequence)

  seq_item seq;
  seq_item rsp;

  function new(string name = "my_sequence");
    super.new(name);
  endfunction

  task body();

    bit [7:0] master_tx;
    bit [7:0] slave_tx;

   // repeat(5) begin
    repeat(2) begin

      // WRITE TX_DATA
      seq = seq_item::type_id::create("seq");
      start_item(seq);

      assert(seq.randomize() with {
        addr == 4'h0;
        rw == 1;
        start == 1;
      });

      master_tx = seq.data;
      slave_tx  = seq.s_tx_data;

      finish_item(seq);
      get_response(rsp);

      // WAIT FOR SPI COMPLETION
      do begin
        seq = seq_item::type_id::create("seq");
        start_item(seq);

        assert(seq.randomize() with {
          addr == 4'hC;
          rw == 0;
          data == 8'h00;
          start == 1;
        });

        finish_item(seq);
        get_response(rsp);

      end while (rsp.read_data[0] == 1 || rsp.read_data[1] == 0);

      // READ RX_DATA
      seq = seq_item::type_id::create("seq");
      start_item(seq);

      assert(seq.randomize() with {
        addr == 4'h4;
        rw == 0;
        data == 8'h00;
        start == 1;
      });

      finish_item(seq);
      get_response(rsp);

      `uvm_info("SEQ",
        $sformatf("Master TX = %h, Slave TX = %h, SPI RX = %h, ERROR = %b",
                  master_tx, slave_tx, rsp.read_data, rsp.error),
        UVM_LOW)

    end

  endtask
endclass

