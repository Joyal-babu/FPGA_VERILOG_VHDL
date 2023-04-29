module freq_calc_tb;
  reg sq_wave;
  wire [31:0]time_period;
  
  freq_calc dut ( .sq_wave(sq_wave), .time_period(time_period) );
  
  initial 
  begin
    $dumpfile("dump.vcd");
    $dumpvars();
  end
  
  always #10 sq_wave <= ~sq_wave; //change the frequency of input sine wave here
  
  initial
  begin
    sq_wave <= 0;
    #1000 $finish();
  end
  
endmodule
