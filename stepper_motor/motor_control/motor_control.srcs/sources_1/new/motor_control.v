`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.09.2025 16:43:13
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




module motor_control (
    input  wire       CLK,        // 100 MHz system clock
    input  wire [2:0] SWITCH,     // [0]=Enable, [1]=Dir, [2]=Speed
    output reg  [3:0] MOTOR       // {A+,A-,B+,B-}
);

    // Clock divider for speed
    integer counter = 0;
    integer periodLengthSlow = 32'd10_000_000; // ~0.1s per step (faster than before)
    integer periodLengthFast = 32'd2_000_000;  // ~0.02s per step
    integer periodLength;

    // Step sequence state machine (8 states for half-step)
    reg [2:0] step_state = 3'b000;

    //--------------------------------------------
    // Select speed based on SWITCH[2]
    //--------------------------------------------
    always @(*) begin
        if (SWITCH[2] == 1'b0)
            periodLength = periodLengthSlow;
        else
            periodLength = periodLengthFast;
    end

    //--------------------------------------------
    // Step pulse generator & state update
    //--------------------------------------------
    always @(posedge CLK) begin
        if (SWITCH[0] == 1'b0) begin
            counter    <= 0;
            step_state <= 3'b000;
        end else begin
            if (counter < periodLength)
                counter <= counter + 1;
            else begin
                counter <= 0;
                if (SWITCH[1] == 1'b0) // CW
                    step_state <= step_state + 1;
                else                   // CCW
                    step_state <= step_state - 1;
            end
        end
    end

    //--------------------------------------------
    // Coil drive (half-step sequence, 8 states)
    //--------------------------------------------
    always @(*) begin
        if (SWITCH[0] == 1'b0) begin
            MOTOR = 4'b0000; // disabled
        end else begin
            case (step_state)
                3'b000: MOTOR = 4'b1000; // A+
                3'b001: MOTOR = 4'b1100; // A+ B+
                3'b010: MOTOR = 4'b0100; // B+
                3'b011: MOTOR = 4'b0110; // A- B+
                3'b100: MOTOR = 4'b0010; // A-
                3'b101: MOTOR = 4'b0011; // A- B-
                3'b110: MOTOR = 4'b0001; // B-
                3'b111: MOTOR = 4'b1001; // A+ B-
                default: MOTOR = 4'b0000;
            endcase
        end
    end

endmodule
