`timescale 1ns / 1ps
///////////////////////////////////////////////////////////////////////////////
// Institution:    Universidade Federal de Sergipe
// Engineer:       Saulo G. Felix
//
// Create Date:    02:59:35 09/30/2019
// Design Name:    Deepak Kumar Tala, Saulo G. Felix
// Module Name:    read_only_memory_module
// Project Name:   elevetor_controller
// Target Devices: Spartan3E
// Tool versions:  ISE 14.7
// Description:    Dual port ansynchronous RAM module
///////////////////////////////////////////////////////////////////////////////
module ram_dual_port_async(
    address_0,                                                               // Address 0x00 input
    data_0,                                                                  // Data bi-direcional stream
    chip_select_0,                                                           // Chip select
    out_enable_0,                                                            // Output enable
    write_enable_0,                                                          // Write enable/read
    address_1,                                                               // Address 0x01 input
    data_1,                                                                  // Data bi-direcional stream
    chip_select_1,                                                           // Chip Select
    write_enable_1,                                                          // Write enable/read
    out_enable_1                                                             // Output enable
    );

    parameter DATA_WIDTH = 8;
    parameter ADDR_WIDTH = 8;
    parameter RAM_DEPTH  = 1 << ADDR_WIDTH;
    
    input [ADDR_WIDTH-1:0] address_0;
    input [ADDR_WIDTH-1:0] address_1;
    input                  chip_select_0;
    input                  write_enable_0;
    input                  out_enable_0; 
    input                  chip_select_1;
    input                  write_enable_1;
    input                  out_enable_1;
    
    inout [DATA_WIDTH-1:0] data_0;
    inout [DATA_WIDTH-1:0] data_1;
    
    reg [DATA_WIDTH-1:0] data_0_out;
    reg [DATA_WIDTH-1:0] data_1_out;
    reg [DATA_WIDTH-1:0] memory_storage [0:RAM_DEPTH-1];
    
// Memory write block
// It writes to data_0 when write_enable_0 and chip_select_0 equals 1
    always @(*)
    begin: MEM_WRITE
        if (chip_select_0 && write_enable_0) begin
            memory_storage[address_0] <= data_0;
        end
        else if (chip_select_1 && write_enable_1) begin
            memory_storage[address_1] <= data_1;
        end
    end
    
// Tri-state buffer control
    assign data_0 = (chip_select_0 && out_enable_0 && ~write_enable_0) ?     // Control output code is 0x06  
        data_0_out: 8'bz;

// Memory read block 0
// Do read operation at data_0 when write_enable_0, out_enable_0 and
// chip_select_0 equals 1
    always @(*)
    begin
        if (chip_select_0 && !write_enable_0 && out_enable_0) begin
            data_0_out <= memory_storage[address_0];
        end
        else begin
            data_0_out <= 0;
        end
    end
    
// Tri-state buffer control
    assign data_1 = (chip_select_1 && out_enable_1 && ~write_enable_1) ?     // Control output code is 0x06
        data_1_out:8'bz;
        
// Memory read block 1
// Do read operation at data_1 when write_enable_1, out_enable_1 and
// chip_select_1 equals 1 
    always @(*)
    begin: MEM_READ_1
        if (chip_select_1 && ~write_enable_1 && out_enable_1) begin
            data_1_out <= memory_storage[address_1];
        end
        else begin
            data_1_out <= 0;
        end
    end
endmodule

