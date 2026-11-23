# UVM-Based Verification of APB to SPI Protocol Integration
# UVM-Based Functional Verification of APB and SPI Protocols and Their Integration

## Overview

This project focuses on the functional verification of APB (Advanced Peripheral Bus) and SPI (Serial Peripheral Interface) protocols, including their integrated operation through an APB-to-SPI bridge.

The verification environment is developed using **SystemVerilog and UVM (Universal Verification Methodology)** to validate protocol functionality, register operations, serial data transfers, and error-handling mechanisms.

## Architecture

```text
             UVM Testbench
                   |
             APB Master
                   |
              APB Slave
                   |
              Register Bank
                   |
              SPI Master
                   |
               SPI Slave
```

## Key Features

- APB read and write transaction verification.
- SPI master-to-slave data transmission.
- SPI slave-to-master data reception.
- APB register access and control verification.
- APB-SPI integrated communication testing.
- Invalid address and error-response verification.
- Functional checking using a UVM scoreboard.

## Verification Methodology

The UVM testbench consists of:

| Component | Description |
|---|---|
| Sequence | Generates APB transactions |
| Sequencer | Controls transaction flow |
| Driver | Drives APB command signals |
| Monitor | Observes protocol activity |
| Scoreboard | Checks expected and actual results |
| Agent | Integrates driver, sequencer, and monitor |
| Environment | Connects verification components |
| Test | Executes verification scenarios |

## Verification Scenarios

### APB Protocol
- Read and write operations.
- Address and data validation.
- Register access verification.
- Invalid address access.
- Error response checking.

### SPI Protocol
- Master-to-slave communication.
- Slave-to-master communication.
- Serial data integrity checking.
- SPI transaction completion.

### APB-SPI Integration
- Writing data through APB registers.
- Initiating SPI transfers through APB.
- Monitoring SPI status.
- Reading received SPI data through APB.
- Checking integrated data flow.

## Tools and Technologies

- SystemVerilog
- UVM
- APB Protocol
- SPI Protocol
- Xcelium Simulator
- EDA Playground

## Repository Structure

```text
APB_SPI_UVM_Verification/
│
├── rtl/
│   ├── apb_master.sv
│   ├── apb_slave.sv
│   ├── register_bank.sv
│   ├── spi_master.sv
│   └── spi_slave.sv
│
├── uvm/
│   ├── interface.sv
│   ├── seq_item.sv
│   ├── sequence.sv
│   ├── sequencer.sv
│   ├── driver.sv
│   ├── monitor.sv
│   ├── scoreboard.sv
│   ├── agent.sv
│   ├── environment.sv
│   └── test.sv
│
├── tb/
│   └── top.sv
│
└── README.md
```

## Learning Outcomes

- Understanding APB and SPI protocol operations.
- Developing a structured UVM verification environment.
- Applying transaction-based verification.
- Using monitors and scoreboards for functional checking.
- Performing protocol-level and integration-level verification.

## Author

**Shravani Shrikant Jadhav**

Electronics and Telecommunication Engineering  
Interested in VLSI Design and Functional Verification
