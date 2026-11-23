UVM_INFO @ 0: reporter [RNTST] Running test my_test...
UVM_INFO test.sv(17) @ 0: uvm_test_top [build_phase] calling from agent
UVM_INFO environment.sv(18) @ 0: uvm_test_top.envn [build_phase] calling from env
UVM_INFO sequancer.sv(6) @ 0: uvm_test_top.envn.agnt.seqn [CONSTRUCTOR] Calling from sequencer class
UVM_INFO agent.sv(21) @ 0: uvm_test_top.envn.agnt [build_phase] calling from agent
UVM_INFO driver.sv(18) @ 0: uvm_test_top.envn.agnt.drv [build_phase] calling from my_driver
UVM_INFO scoreboard.sv(19) @ 0: uvm_test_top.envn.scb [build_phase] calling from scoreboard
UVM_INFO driver.sv(23) @ 0: uvm_test_top.envn.agnt.drv [connect_phase] calling from my_driver
UVM_INFO agent.sv(30) @ 0: uvm_test_top.envn.agnt [connect_phase] calling from agent
UVM_INFO environment.sv(25) @ 0: uvm_test_top.envn [connect_phase] calling from env
UVM_INFO test.sv(26) @ 0: uvm_test_top [connect_phase] calling from agent
UVM_INFO scoreboard.sv(75) @ 90: uvm_test_top.envn.scb [SCB] TX_DATA WRITE PASS: Data=70
UVM_INFO scoreboard.sv(97) @ 810: uvm_test_top.envn.scb [SCB] APB RX_DATA READ PASS: Expected=26 Actual=26
UVM_INFO scoreboard.sv(104) @ 810: uvm_test_top.envn.scb [SCB] SPI Master-to-Slave passs: Expected=70 Actual=70
UVM_INFO scoreboard.sv(109) @ 810: uvm_test_top.envn.scb [SCB] SPI Slave-to-Master pass: Expected=26 Actual=26
UVM_INFO sequance.sv(137) @ 810: uvm_test_top.envn.agnt.seqn@@sequn [SEQ] Master TX = 70, Slave TX = 26, SPI RX = 26, ERROR = 0
UVM_INFO scoreboard.sv(75) @ 850: uvm_test_top.envn.scb [SCB] TX_DATA WRITE PASS: Data=0f
UVM_INFO scoreboard.sv(97) @ 1570: uvm_test_top.envn.scb [SCB] APB RX_DATA READ PASS: Expected=ed Actual=ed
UVM_INFO scoreboard.sv(104) @ 1570: uvm_test_top.envn.scb [SCB] SPI Master-to-Slave passs: Expected=0f Actual=0f
UVM_INFO scoreboard.sv(109) @ 1570: uvm_test_top.envn.scb [SCB] SPI Slave-to-Master pass: Expected=ed Actual=ed
UVM_INFO sequance.sv(137) @ 1570: uvm_test_top.envn.agnt.seqn@@sequn [SEQ] Master TX = 0f, Slave TX = ed, SPI RX = ed, ERROR = 0
UVM_INFO /xcelium25.03/tools/methodology/UVM/CDNS-1.2/sv/src/base/uvm_objection.svh(1271) @ 1570: reporter [TEST_DONE] 'run' phase is ready to proceed to the 'extract' phase
UVM_INFO /xcelium25.03/tools/methodology/UVM/CDNS-1.2/sv/src/base/uvm_report_server.svh(851) @ 1570: reporter [UVM/REPORT/SERVER] 
