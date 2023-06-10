`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.04.2023 14:37:52
// Design Name: 
// Module Name: LFM_foldback
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module LFM_foldback
    #(
     parameter length = 100,          // enter the number of samples required for each frequency
     parameter phase  = 32'h28F5C29
     )
     
    ( 
      input  clk,
      input  reset,
      output lfm_valid,
      output [31:0]lfm_data,
      output phase_valid,
      output [31:0]phase_data  
    );
    
    wire phase_incr_valid      = 1'b1;
    wire slave0_ready          = 1'b1;
    wire slave1_ready          = 1'b1;
    reg [31:0]phase_incr_data  = 32'h1999_999A;
    reg [20:0]count;
    reg [20:0]count1;
 
    dds_compiler_0 dds_lfm (
      .aclk(clk),                                // input wire aclk
      .aresetn(reset),                           // input wire aresetn
      .s_axis_phase_tvalid(phase_incr_valid),    // input wire s_axis_phase_tvalid
      .s_axis_phase_tready(),                    // output wire s_axis_phase_tready
      .s_axis_phase_tdata(phase_incr_data),      // input wire [31 : 0] s_axis_phase_tdata
      .m_axis_data_tvalid(lfm_valid),            // output wire m_axis_data_tvalid
      .m_axis_data_tready(slave0_ready),         // input wire m_axis_data_tready
      .m_axis_data_tdata(lfm_data),              // output wire [31 : 0] m_axis_data_tdata
      .m_axis_phase_tvalid(phase_valid),         // output wire m_axis_phase_tvalid
      .m_axis_phase_tready(slave1_ready),        // input wire m_axis_phase_tready
      .m_axis_phase_tdata(phase_data)            // output wire [31 : 0] m_axis_phase_tdata
    );
    
  always @ ( posedge clk)
   begin
        if(lfm_valid)
        begin
            count <= count + 1;
            if( count == length )
            begin
                count <= 0;
                if( count1 < 20 )
                begin
                    count1 <= count1 + 1;
                    if(count1 > 0 && count1 < 10)
                    begin
                        phase_incr_data <= phase_incr_data - phase;
                    end
                    else if(count1 > 10 && count1 < 20 )
                        phase_incr_data <= phase_incr_data + phase;
                    else
                        phase_incr_data <= 0;
                end
                else
                    count1 <= 1;
            end
            else
            begin
                phase_incr_data <= phase_incr_data;
            end   
        end
        else
        begin
            count <= 0;
            count1<= 1;
        end 
   end

endmodule
