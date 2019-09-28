`timescale 1ns / 1ps
///////////////////////////////////////////////////////////////////////////////
// Institution:    Universidade Federal de Sergipe
// Engineer:       Saulo G. Felix
//
// Create Date:    13:52:10 09/28/2019
// Design Name:    Saulo G. Felix
// Module Name:    clock
// Project Name:   elevetor_controller
// Target Devices: Spartan3E
// Tool versions:  ISE 14.7
// Description:    Manage clock division in frequency
///////////////////////////////////////////////////////////////////////////////
module clock(clk, clk_scale, CCLK);

output reg   clk;
input [31:0] clk_scale;
input 		 CCLK;

reg [31:0]   clkq = 0;

always @(posedge CCLK)
begin
	clkq <= clkq + 1;
	if (clkq >= clk_scale)
	begin
		clk <= ~clk;
		clkq <= 0;
	end
end

endmodule
