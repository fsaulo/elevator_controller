`timescale 1ns / 1ps
///////////////////////////////////////////////////////////////////////////////
// Institution:    Universidade Federal de Sergipe
// Engineer:       Saulo G. Felix
// 
// Create Date:    13:08:46 09/26/2019 
// Design Name:    Saulo G. Felix
// Module Name:    d_ff
// Project Name:   elevator_controller
// Target Devices: Spartan3E
// Tool versions:  ISE 14.7
// Description:    D-Flip Flop
///////////////////////////////////////////////////////////////////////////////
module d_ff(
    output reg Q,
    input      D,
    input      clk
    );
    
    always @(posedge clk)
    begin
        Q <= D;
    end    

endmodule
