module freq_calc( 
  input sq_wave,
  output wire [31:0] time_period
);
  
  int on_counti,off_counti;
  //wire time_period;
  reg [31:0]on_count,off_count;
  reg ref_clk = 1'b0;
  
  assign time_period = (2*on_count)+(2*off_count);
  
  always #1 ref_clk <= ~ref_clk; //reference clock of time period 2 ns.
  
  always@( posedge ref_clk )
  begin
    if(sq_wave)
      on_counti = on_counti + 1;
    else
      off_counti = off_counti + 1;
  end
  
  always@( negedge sq_wave )
  begin
    on_count <= on_counti;
    on_counti = 0;
  end
  
  always@( posedge sq_wave )
  begin
    off_count <= off_counti;
    off_counti = 0;
  end
endmodule
