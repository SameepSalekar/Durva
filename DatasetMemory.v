`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/15/2026 05:47:19 PM
// Design Name: 
// Module Name: DatasetMemory
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


module DatasetMemory
#(parameter DATA_WIDTH = 16,
 parameter DEPTH = 256,
 parameter ADDRESS_WIDTH = $clog2(DEPTH))
(input wire clk,
 input wire WriteEnable,
 input wire [ADDRESS_WIDTH - 1:0] WriteAddress,
 input wire [DATA_WIDTH - 1:0] WriteData,
 input wire ReadEnable,
 input wire [ADDRESS_WIDTH - 1:0] ReadAddress,
 output reg [DATA_WIDTH - 1:0] ReadData);
 
 reg [DATA_WIDTH - 1:0] Memory [0:DEPTH - 1];
 
 always @(posedge clk) begin
    if (WriteEnable) begin
        Memory[WriteAddress] <= WriteData;
    end
 end

 always @(posedge clk) begin
    if (ReadEnable) begin
        ReadData <= Memory[ReadAddress];
    end
 end 
    
endmodule
