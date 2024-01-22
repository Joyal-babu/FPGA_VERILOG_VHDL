# UART - Universal Asynchronous Receiver and Transmitter

UART plays an important role in serial communication. A reuseable UART design using VHDL and VERILOG is proposed here. The proposed URT is composed of a Baud Rate Generator, Transmiter module and a receiver module. The N-8-1 (No Parity(N), Eight(8) data bits, One(1) stop bit) format is implemented but the design can be reconfigured for required width such as 16, 32 etc by making changes in generic section of top module.

The UART contains a receiver (serial to parallel converter) and a transmitter (parallel to serial converter). It handles the convertion between serial and parallel data. Serial communication reduces the distortion of a signal, therefore makes data transfer between two systems seperated in great distance possible. 

The UART frame consists of 1 start bit, a number of data bits, an optional parity bit and 1 or 2 stop bits. The start bit goes _low_ for one bit time, then a number of data bits are transmitted, _least significant bit first_ and stop bit goes _high_ for one or two bit time. When no data is being transmitted, a logic 1 must be placed in the transmitted data line. The number of data bits, the parity bit and the number of stop bits must be set as a priori in all communication partners.  


