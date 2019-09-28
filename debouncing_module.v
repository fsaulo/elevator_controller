`timescale 1ns / 1ps
///////////////////////////////////////////////////////////////////////////////
// Institution:    Universidade Federal de Sergipe
// Engineer:       Saulo G. Felix
//
// Create Date:    13:02:02 09/26/2019
// Design Name:    Saulo G. Felix
// Module Name:    debouncing_module
// Project Name:   elevetor_controller
// Target Devices: Spartan3E
// Tool versions:  ISE 14.7
// Description:    Debouncing signal from mechanical buttons and sensors
///////////////////////////////////////////////////////////////////////////////
module debouncing_module(
    output pb_out,                                                           // Digitalized signal output
    input  pb_in,                                                            // Analog signal input
    input  clk                                                               // Clock input
    );

    // Defining wires
    wire Q1, Q2;

    // Modules instances
    d_ff  M0(Q1, pb_in, clk);                                                // D-Flip Flop module
    d_ff  M1(Q2, Q1, clk);

    // Debounced signal output
    assign pb_out = Q1 & ~Q2;

endmodule
