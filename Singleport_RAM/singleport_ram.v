`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: JOYAL
// 
// Create Date: 27.11.2023 21:40:33
// Design Name: 
// Module Name: singleport_ram
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


module singleport_ram
    #( parameter data_width = 16,
       parameter ram_depth  = 1024
)
  
     ( input  clock,
    input  reset,
    input  [15:0] data_ina,
    input  [9:0]  addra,
    input  we_a,
    output reg [15:0]data_outa,
    output reg rd_data_valid
);

    reg [(data_width-1):0] sp_ram [(ram_depth-1):0];

    wire [9:0]addr_i;

    assign addr_i = addra;

    always@(posedge(clock))
    begin
        if(reset)
            begin
                data_outa <= 16'b0;
                rd_data_valid <= 1'b0;
            end
        else if(we_a)
            begin
                sp_ram[addr_i] <= data_ina;
                rd_data_valid  <= 1'b0;
            end
        else
            begin
                data_outa <= sp_ram[addr_i];
                rd_data_valid  <= 1'b1;
            end
    end


endmodule
