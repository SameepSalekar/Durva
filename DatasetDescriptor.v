`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/18/2026 03:06:41 PM
// Design Name: 
// Module Name: DatasetDescriptor
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


module DatasetDescriptor
#(parameter DEPTH = 256,
  parameter ADDRESS_WIDTH = $clog2(DEPTH),
  parameter LENGTH_WIDTH = $clog2(DEPTH + 1))
( input wire clk,
  input wire reset,
  input wire LoadDescriptor,
  input wire ClearDescriptor,
  input wire [ADDRESS_WIDTH - 1:0] BaseAddressIn,
  input wire [LENGTH_WIDTH - 1:0] LengthIn,
  output reg [ADDRESS_WIDTH - 1:0] BaseAddress,
  output reg [LENGTH_WIDTH - 1:0] Length,
  output reg DescriptorValid,
  output wire Empty);
  
  assign Empty = (Length == {LENGTH_WIDTH{1'b0}});
  
  always @(posedge clk) begin
    if (reset) begin
        BaseAddress <= {ADDRESS_WIDTH{1'b0}};
        Length <= {LENGTH_WIDTH{1'b0}};
        DescriptorValid <= 1'b0;
    end
    else if (LoadDescriptor) begin
        BaseAddress <= BaseAddressIn;
        Length <= LengthIn;
        DescriptorValid <= 1'b1;    
    end
    else if (ClearDescriptor) begin
        DescriptorValid <= 1'b0;
    end
  end
endmodule
