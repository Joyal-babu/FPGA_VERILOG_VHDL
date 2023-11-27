`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: JOYAL
// 
// Create Date: 27.11.2023 22:27:53
// Design Name: 
// Module Name: singleport_ram_tb
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


module singleport_ram_tb();

    localparam data_width = 16;
    localparam ram_depth  = 1024;

    reg   clock;
    reg   reset;
    reg   [15:0] data_ina;
    reg   [9:0]  addra;
    reg   we_a;
    wire  [15:0]data_outa;
    wire  rd_data_valid;

    singleport_ram #(.data_width(data_width), .ram_depth(ram_depth)) UUT
    (   .clock(clock),
        .reset(reset),
        .data_ina(data_ina),
        .addra(addra),
        .we_a(we_a),
        .data_outa(data_outa),
        .rd_data_valid(rd_data_valid)
    );

    always #5 clock <= ~clock; // 100MHz clock  (10 ns)

    initial
    begin
        clock    <= 1'b0;
        reset    <= 1'b1;
        data_ina <= 16'b0;
        addra    <= 10'b0;
        we_a     <= 1'b0;
        #500 reset <= 1'b0;

        repeat(ram_depth) // filling the memory
            begin
                we_a <= 1'b1;
                @(posedge(clock));
                data_ina <= data_ina + 4'hF;
                addra    <= addra + 1'b1;
            end

        we_a     <= 1'b0;
        addra    <= 10'b0;

        repeat(ram_depth)
            begin
                @(posedge(clock));
                addra <= addra + 1'b1;
            end

    end


endmodule
