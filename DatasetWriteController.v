`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/04/2026 08:13:18 PM
// Design Name: 
// Module Name: DatasetWriteController
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


module DatasetWriteController
#(parameter DEPTH = 256,
  parameter DATA_WIDTH = 16,
  parameter ADDRESS_WIDTH = $clog2(DEPTH),
  parameter INDEX_WIDTH = $clog2(DEPTH),
  parameter LENGTH_WIDTH = $clog2(DEPTH + 1))
 (input wire clk,
  input wire reset,
  input wire WriteRequest,
  input wire [INDEX_WIDTH - 1:0] SampleIndex,
  input wire [INDEX_WIDTH - 1:0] SampleData,
  input wire [LENGTH_WIDTH - 1:0] Length,
  input wire DescriptorValid,
  output reg WriteAccepted,
  output reg WriteRejected,
  output reg MemoryWriteEnable,
  output reg [ADDRESS_WIDTH - 1:0] MemoryWriteAddress,
  output reg [DATA_WIDTH - 1:0] MemoryWriteData);
  
  wire [ADDRESS_WIDTH - 1:0] GenerateAddress;
  wire AddressOverflow;
  
  wire [LENGTH_WIDTH - 1:0] ExtendedSampleIndex;
  wire SampleIndexValid;
  
  wire PhysicalAddressValid;
  
  wire WriteRequestValid;
  
  DatasetAddressGenerator #(.DEPTH(DEPTH), .ADDRESS_WIDTH(ADDRESS_WIDTH), .INDEX_WIDTH(INDEX_WIDTH)) 
  AddressGenerator(.BaseAddress(BaseAddress), .SampleIndex(SampleIndex), .MemoryAddress(GeneratedAddress),
                    .AddressOverflow(AddressOverflow));
  
  assign ExtendedSampleIndex = {{(LENGTH_WIDTH - INDEX_WIDTH){1'b0}}, SampleIndex};
  assign SampleIndexValid = (ExtendedSampleIndex < Length);
  
  assign PhysicalAddressValid = !AddressOverflow && (GeneratedAddress < DEPTH);
  
  assign WriteRequestValid = DescriptorValid && SampleIndexValid && PhysicalAddressValid;
  
  always @(posedge clk) begin
    if (reset) begin
        WriteAccepted <= 1'b0;
        WriteRejected <= 1'b0;
        MemoryWriteEnable <= 1'b0;
        MemoryWriteAddress <= {ADDRESS_WIDTH{1'b0}};
        MemoryWriteData <= {DATA_WIDTH{1'b0}};
    end
    else
    begin
        WriteAccepted <= 1'b0;
        WriteRejected <= 1'b0;
        MemoryWriteEnable <= 1'b0;
        if (WriteRequest) begin
            if (WriteRequestValid) begin
                MemoryWriteAddress <= GeneratedAddress;
                MemoryWriteData <= SampleData;
                MemoryWriteEnable <= 1'b1;
                WriteAccepted <= 1'b1;
            end
            else
            begin
                WriteRejected <= 1'b1;
            end
        end
    end
  end
endmodule