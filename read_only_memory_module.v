`timescale 1ns / 1ps
///////////////////////////////////////////////////////////////////////////////
// Institution:    Universidade Federal de Sergipe
// Engineer:       Saulo G. Felix
//
// Create Date:    02:59:35 09/30/2019
// Design Name:    Saulo G. Felix
// Module Name:    read_only_memory_module
// Project Name:   elevetor_controller
// Target Devices: Spartan3E
// Tool versions:  ISE 14.7
// Description:    Memory block to store instructions
///////////////////////////////////////////////////////////////////////////////
module rom_module(
    output [3:0] data_out,
    input  [3:0] data_in,
    input  [3:0] write_pointer,
    input  [3:0] read_pointer,
    input        write_enable,
    input        read_enable,
    input        clk
    );

    // Defining registers
    reg  [7:0] data_register[7:0];

    // Defining wires
    wire [3:0] data_bus;

    // Write to memory
    always @(posedge clk)
    begin
        if (write_enable) begin
          data_register[write_pointer[3:0]] <= data_in;
        end
    end
endmodule
