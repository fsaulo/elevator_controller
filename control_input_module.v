`timescale 1ns / 1ps
///////////////////////////////////////////////////////////////////////////////
// Institution:    Universidade Federal de Sergipe
// Engineer:       Saulo G. Felix
//
// Create Date:    10:22:52 09/26/2019
// Design Name:    Saulo G. Felix
// Module Name:    control_input_module
// Project Name:   elevetor_controller
// Target Devices: Spartan3E
// Tool versions:  ISE 14.7
// Description:    The control system module
///////////////////////////////////////////////////////////////////////////////
module control_input_unit(
    output reg [3:0] memory_address_buffer,
    output reg [3:0] ctrl_load,
    input      [3:0] ctrl_seq,
    input            bt_floor_1,
    input            bt_floor_2,
    input            bt_floor_3,
    input            bt_floor_4,
    input            clk
    );

    // Defining registers
    reg  [3:0] ctrl_seq_register;

    // Defining wires
    wire [3:0] ctrl_seq_temp;
    wire       signal_floor_1;
    wire       signal_floor_2;
    wire       signal_floor_3;
    wire       signal_floor_4;

    // Digitalizing input signals
    debouncing_module C0(signal_floor_1, bt_floor_1, clk);
    debouncing_module C1(signal_floor_2, bt_floor_2, clk);
    debouncing_module C2(signal_floor_3, bt_floor_3, clk);
    debouncing_module C3(signal_floor_4, bt_floor_4, clk);

    // Store input control sequence
    assign ctrl_seq_temp =
   {
        signal_floor_4,
        signal_floor_3,
        signal_floor_2,
        signal_floor_1
    };

    // Output control sequence
    always @(*) begin
        case (ctrl_seq_temp)
            4'h1:    ctrl_seq_register = ctrl_seq_temp;
            4'h2:    ctrl_seq_register = ctrl_seq_temp;
            4'h4:    ctrl_seq_register = ctrl_seq_temp;
            4'h8:    ctrl_seq_register = ctrl_seq_temp;
            default: ctrl_seq_register = 4'h0;
        endcase
    end

    // Assigning values to the Memory Address Buffer
    always @(posedge clk)
    begin
        memory_address_buffer = ctrl_seq_register;
        if (ctrl_seq == 0)
            ctrl_load = ctrl_seq_register;
        else
            ctrl_load = ctrl_seq;
    end
endmodule
