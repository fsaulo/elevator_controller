`timescale 1ns / 1ps

/* modulo de clock para a placa nexys2
* @author: fsaulo
*/
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

