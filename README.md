# Smart Elevator Controller – Verilog HDL

## 📌 Overview
This project implements a **multi-floor smart elevator controller** using **Verilog HDL** and **FSM-based control logic**.  
The design tracks a target floor and ensures continuous movement until the destination is reached, with door operation restricted to the final stop.

The design is fully **Vivado 2024.2 compatible** and verified through simulation.

---

## ✨ Features
- Supports **4 floors (0–3)**
- FSM-based control architecture
- Target floor tracking
- Direction control (UP / DOWN / IDLE)
- Door opens **only at destination floor**
- Synthesizable Verilog-2001 code

---

## 🧠 FSM States
- `IDLE` – Waiting for request  
- `MOVE_UP` – Elevator moving upward  
- `MOVE_DOWN` – Elevator moving downward  
- `DOOR_OPEN` – Door open at target floor  
- `DOOR_CLOSE` – Door closing  

---

## 🔌 Inputs & Outputs

### Inputs
| Signal | Description |
|------|------------|
| clk | System clock |
| rst_n | Active-low reset |
| req[3:0] | Floor request inputs |

### Outputs
| Signal | Description |
|------|------------|
| current_floor[1:0] | Current floor |
| direction[1:0] | 00-IDLE, 01-UP, 10-DOWN |
| door_open | Door status |

---

## 🧪 Simulation
- Tool: **Xilinx Vivado 2024.2**
- Verified using a custom testbench
- Waveform confirms:
  - Continuous movement to target floor
  - Correct direction control
  - Door opening only at destination

---

## 🚀 How to Run
1. Open **Vivado**
2. Create a new RTL project
3. Add files from:
   - `src/` (Design sources)
   - `tb/` (Simulation sources)
4. Set `tb_elevator.v` as top module
5. Run **Behavioral Simulation**

---

## 📈 Future Enhancements
- SCAN / LOOK scheduling for multiple requests
- Emergency stop & overload detection
- Door and travel timers
- Seven-segment floor display

---

## 👨‍💻 Author
**Satwik Pal**  
NIT Jamshedpur
