module pwm_mod
  (    
   output reg pri,
   output wire[11:0]on_count,
   output wire sof,eof,
   input clk,reset
  );
//one clock plse = 0.01us = 10 ns (100MHz clock frequency)
 
parameter sof_length   = 400;                                //delay of 4us
parameter on           = 2048;
parameter off          = 4096;
parameter pulse_width  = on + off;
parameter pri_start    = 5000 + sof_length;                  //delay of 50us
parameter pri_end      = pri_start + (50*pulse_width);
parameter eof_length   = 1200;
parameter eof_start    = pri_end + 2000;                     //delay of  20us
parameter eof_end      = eof_start + eof_length;
 
reg [20:0]count_1 = 0;
reg [20:0]count_2 = 0;

assign  sof    =(reset)?0:(count_1 > sof_length) ? 0 : 1;
assign  eof    =(reset)?0:(count_1 > eof_start ) ? (count_1 < eof_end) ? 1 : 0: 0;

always @(posedge clk) 
begin
        if(reset)
        begin
            pri     <= 0;
            count_1 <= 0;
            count_2 <= 0;
        end
        else 
        begin
            count_1 <= count_1 + 1;
            if (count_1 > pri_start-1 & count_1 < pri_end)  
            begin
                if(count_2 > (on-1))                              
                begin
                     pri <= 0;
                end
                else
                begin
                     pri <= 1;
                end
                count_2 <= (count_2 > (pulse_width-1)) ? 0 : count_2 + 1;     
            end
            else
            begin
                pri <= 0;
            end
       end
end

endmodule
