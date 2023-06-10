  module dds_stream
  #(
     parameter length = 100,      // 100 samples per frequency
     parameter phase  = 32'h28F5C29
     )
    
   (
     input  clk,
     input  reset,
     output sine_valid,
     output [15:0]sine_data,
     output phase_valid,
     output [31:0]phase_data
     );
     
     wire phase_incr_valid      = 1'b1;
     wire fft_ready             = 1'b1;
     wire phase_ready           = 1'b1;
     reg  [31:0]phase_incr_data = 'h28F5C29;
     //reg  [10:0]length_i        = length;
     
     
     dds_compiler_0 dds_0 (
       .aclk(clk),                                 // input wire aclk
       .aresetn(reset),                            // input wire aresetn
       .s_axis_phase_tvalid(phase_incr_valid),     // input wire s_axis_phase_tvalid
       .s_axis_phase_tready(),                     // output wire s_axis_phase_tready
       .s_axis_phase_tdata(phase_incr_data),       // input wire [31 : 0] s_axis_phase_tdata
       .m_axis_data_tvalid(sine_valid),            // output wire m_axis_data_tvalid
       .m_axis_data_tready(fft_ready),             // input wire m_axis_data_tready
       .m_axis_data_tdata(sine_data),              // output wire [15 : 0] m_axis_data_tdata
       .m_axis_phase_tvalid(phase_valid),          // output wire m_axis_phase_tvalid
       .m_axis_phase_tready(phase_ready),          // input wire m_axis_phase_tready
       .m_axis_phase_tdata(phase_data)             // output wire [31 : 0] m_axis_phase_tdata
     ); 
    
   /* dds_compiler_0 dds0 (
      .aclk(clk),                                  // input wire aclk
      .s_axis_phase_tvalid(phase_incr_valid),      // input wire s_axis_phase_tvalid
      .s_axis_phase_tdata(phase_incr_data),        // input wire [31 : 0] s_axis_phase_tdata
      .m_axis_data_tvalid(sine_valid),             // output wire m_axis_data_tvalid
      .m_axis_data_tdata(sine_data),               // output wire [7 : 0] m_axis_data_tdata
      .m_axis_phase_tvalid(phase_valid),           // output wire m_axis_phase_tvalid
      .m_axis_phase_tdata(phase_data)              // output wire [31 : 0] m_axis_phase_tdata
    ); */
    
    reg [20:0]glob_count = 0;
    reg [20:0]sine_count = 0;
    reg last;
    
    always @ (posedge clk)
    begin
        if( sine_valid )
        begin
            glob_count <= glob_count + 1;
            sine_count <= sine_count + 1;
            if(glob_count == (length - 1))
            begin
                last       <= 1;
                glob_count <= 0;
                //length_i   <= length_i/2;
                phase_incr_data <= phase_incr_data + phase;    
            end
            
            else
            begin
                last  <= 0;
                phase_incr_data <= phase_incr_data;    
            end
        end
        else
        begin
            last <= 0;
        end 
    end
endmodule
