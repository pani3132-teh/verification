# verification
> SystemVerilog-based APB slave design with a class-based testbench using virtual interfaces, mailboxes, and random stimulus generation. Includes aligned 32-bit read/write support, byte-wise enables, and error handling. Compatible with QuestaSim 10.4e. Great for learning protocol modeling.
# APB Slave Design with SystemVerilog Testbench

This repository contains a SystemVerilog implementation of an APB (Advanced Peripheral Bus) slave along with a class-based testbench using mailbox communication, virtual interfaces, and random transactions. It is designed to run on **QuestaSim 10.4e** or compatible simulators.

---

## 📌 Features

- ✅ APB slave supporting aligned 32-bit read and write operations  
- ✅ Byte-wise write enables via `pstrobe`  
- ✅ Error detection for unaligned accesses (`pslaverr`)  
- ✅ Modular testbench using:
  - `pkt`: Transaction class
  - `gen`: Random transaction generator
  - `bfm`: Bus functional model
  - `apb_interface`: Connects DUT and testbench

---

## 📂 Files

| File | Description |
|------|-------------|
| `apb.sv` | Contains APB slave module and testbench components |
| `interface` | Defines signals between DUT and testbench |
| `pkt` | Defines transaction structure |
| `gen` | Generates random test cases |
| `bfm` | Drives signals to DUT using interface |

---

## 🧪 Simulation Instructions

1. Open QuestaSim or ModelSim terminal  
2. Compile the design:
   ```sh
   vlog +sv apb.sv
