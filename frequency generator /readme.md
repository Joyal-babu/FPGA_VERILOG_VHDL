# FREQUENCY GENERATOR  <br>  
Design HDL code will create frequencies of 100 Hz, 50 Hz, 10 Hz and  1 Hz.<br>
system clock is at 100 MHz.

###  Constants to create the frequencies needed:<br>
  -- Formula is: ( (SYSTEM CLOCK FREQ. / REQUIRED FREQ.) * 50% duty cycle) <br>   
  -- So for 100 Hz: 100,000,000 / 100 * 0.5 = 500000 <br>
  -- So for 50  Hz: 100,000,000 / 50  * 0.5 = 1000000 <br>
  -- So for 10  Hz: 100,000,000 / 10  * 0.5 = 5000000 <br>
  -- So for 1   Hz: 100,000,000 / 1   * 0.5 = 50000000 <br>




>FREQUENCY 100 HZ
![100HZ](https://github.com/Joyal-babu/FPGA_VERILOG_VHDL/assets/123290522/407f0c12-957b-4fc5-9cc3-73319f626c7f)

>FREQUENCY 50HZ
![50HZ](https://github.com/Joyal-babu/FPGA_VERILOG_VHDL/assets/123290522/62178d88-6e7e-4792-ba60-dbdaafbf8229)

>FREQUENCY 10HZ
![10HZ](https://github.com/Joyal-babu/FPGA_VERILOG_VHDL/assets/123290522/f6f02b14-0a7c-4693-97d0-36cc3915a3c0)

>FREQUENCY 1HZ
![1HZ](https://github.com/Joyal-babu/FPGA_VERILOG_VHDL/assets/123290522/2db39e0c-9af6-47fa-ad86-c48eba626a3a)
