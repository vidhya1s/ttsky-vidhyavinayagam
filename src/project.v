/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_example (
    input  wire [7:0] ui_in,    
    output wire [7:0] uo_out,   
    input  wire [7:0] uio_in,   
    output wire [7:0] uio_out,  
    output wire [7:0] uio_oe,   
    input  wire       ena,      
    input  wire       clk,      
    input  wire       rst_n     
);

    // ALU Inputs
    wire [3:0] a;
    wire [3:0] b;
    wire [1:0] sel;

    // ALU Output
    reg [3:0] y;

    // Assign inputs
    assign a   = ui_in[3:0];
    assign b   = uio_in[3:0];
    assign sel = ui_in[5:4];

    // ALU Operations
    always @(*) begin
        case(sel)
            2'b00: y = a + b; // Addition
            2'b01: y = a - b; // Subtraction
            2'b10: y = a & b; // AND
            2'b11: y = a | b; // OR
            default: y = 4'b0000;
        endcase
    end

    // Output assignment
    assign uo_out = {4'b0000, y};

    // Unused bidirectional pins
    assign uio_out = 8'b00000000;
    assign uio_oe  = 8'b00000000;

    // Prevent unused warnings
    wire _unused = &{ena, clk, rst_n, ui_in[7:6], uio_in[7:4], 1'b0};

endmodule

`default_nettype wire
