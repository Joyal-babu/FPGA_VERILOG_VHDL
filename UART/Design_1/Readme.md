# UART - Universal Asynchronous Receiver and Transmitter

UART plays an important role in serial communication. A reuseable UART design using VHDL and VERILOG is proposed here. The proposed URT is composed of a Baud Rate Generator, Transmiter module and a receiver module. The N-8-1 (No Parity(N), Eight(8) data bits, One(1) stop bit) format is implemented but the design can be reconfigured for required width such as 16, 32 etc by making changes in generic section of top module.

The UART contains a receiver (serial to parallel converter) and a transmitter (parallel to serial converter). 


