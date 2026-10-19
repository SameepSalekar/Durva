`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/18/2026 03:50:50 PM
// Design Name: 
// Module Name: DatasetAddressGenerator
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


module DatasetAddressGenerator
#(parameter DEPTH = 256,
  parameter ADDRESS_WIDTH = $clog2(DEPTH),
  parameter INDEX_WIDTH = $clog2(DEPTH))
( input wire [ADDRESS_WIDTH - 1:0] BaseAddress,
  input wire [INDEX_WIDTH - 1:0] SampleIndex,
  output wire [ADDRESS_WIDTH - 1:0] MemoryAddress,
  output wire AddressOverflow );
  
  wire [ADDRESS_WIDTH:0] ExtendedAddress;
  
  assign ExtendedAddress = {1'b0, BaseAddress} + {{(ADDRESS_WIDTH - INDEX_WIDTH + 1){1'b0}}, SampleIndex};
  
  assign MemoryAddress = ExtendedAddress[ADDRESS_WIDTH - 1:0];
  
  assign AddressOverflow = ExtendedAddress[ADDRESS_WIDTH];
  
endmodule
