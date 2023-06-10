module LFM_foldback_tb;
    reg  clk;
    reg  reset;
    wire lfm_valid;
    wire [31:0]lfm_data;
    wire phase_valid;
    wire [31:0]phase_data;
        
    LFM_foldback  tb1 ( .clk(clk), .reset(reset), .lfm_valid(lfm_valid), .lfm_data(lfm_data), .phase_valid(phase_valid), .phase_data(phase_data) );
    
    always #5 clk <= ~clk;
    
    initial 
    begin
        clk <= 1'b0;
        reset <= 1'b0;
        #1000 reset <= 1'b1;
    end
endmodule
