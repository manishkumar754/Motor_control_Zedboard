`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.10.2025 12:54:37
// Design Name: 
// Module Name: motor_control
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

module dual_control(
    input CLK,
    input [5:0] SWITCH,         // [2:0] -> Motor A, [5:3] -> Motor B
    output [5:0] MOTOR          // [2:0] -> Motor A, [5:3] -> Motor B
);
 
    // Control registers
    reg [2:0] controlA = 3'b000;  // [0]: IN1, [1]: IN2, [2]: Speed
    reg [2:0] controlB = 3'b000;  // [0]: IN3, [1]: IN4, [2]: Speed
 
    // PWM variables
    integer periodLength = 1000000;
    integer pulseLengthLow = 200000;
    integer pulseLengthHigh = 900000;
 
    integer pulseLengthA = 0;
    integer pulseLengthB = 0;
 
    integer counter = 0;
 
    // PWM counter
    always @(posedge CLK) begin
        if (counter < periodLength)
            counter <= counter + 1;
        else
            counter <= 0;
    end
 
    // Motor A Control
    always @(posedge CLK) begin
        if (SWITCH[0] == 1'b0) begin
            controlA <= 3'b000; // Motor A OFF
        end else begin
            controlA[2] <= SWITCH[2];         // Speed
            controlA[0] <= SWITCH[1];         // Direction IN1
            controlA[1] <= ~SWITCH[1];        // Direction IN2
        end
 
        pulseLengthA <= (controlA[2] == 1'b0) ? pulseLengthLow : pulseLengthHigh;
    end
 
    // Motor B Control
    always @(posedge CLK) begin
        if (SWITCH[3] == 1'b0) begin
            controlB <= 3'b000; // Motor B OFF
        end else begin
            controlB[2] <= SWITCH[5];         // Speed
            controlB[0] <= SWITCH[4];         // Direction IN3
            controlB[1] <= ~SWITCH[4];        // Direction IN4
        end
 
        pulseLengthB <= (controlB[2] == 1'b0) ? pulseLengthLow : pulseLengthHigh;
    end
 
    // Assign outputs to L298
    assign MOTOR[0] = controlA[0];                          // IN1
    assign MOTOR[1] = controlA[1];                          // IN2
    assign MOTOR[2] = (pulseLengthA > counter) ? 1'b1 : 1'b0; // ENA (PWM)
 
    assign MOTOR[3] = controlB[0];                          // IN3
    assign MOTOR[4] = controlB[1];                          // IN4
    assign MOTOR[5] = (pulseLengthB > counter) ? 1'b1 : 1'b0; // ENB (PWM)
 
endmodule