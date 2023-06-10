module dds_stream_tb;
    reg  clk;
    reg  reset;
    wire sine_valid;
    wire [15:0]sine_data;
    wire phase_valid;
    wire [31:0]phase_data;
    
    dds_stream tb1 ( .clk(clk), .reset(reset), .sine_valid(sine_valid), .sine_data(sine_data), .phase_valid(phase_valid), .phase_data(phase_data) );
    
    always #5 clk=~clk;
    
    initial 
    begin
        clk   <= 1'b0;
        reset <= 1'b0;
        #50 reset <= 1'b1;
    end

endmodule
