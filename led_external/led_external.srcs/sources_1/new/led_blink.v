`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.11.2025 12:56:45
// Design Name: 
// Module Name: led_blink
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


module led_blink(
  input clk,       // System clock input (e.g., 100MHz from ZedBoard)
  output reg led_out // Output to control the LED
);

  // Counter to create a delay for blinking
  reg [31:0] counter = 0; 
  // Define the maximum count for a desired blink rate (e.g., 1 second)
  parameter MAX_COUNT = 100_000_000; // For 100MHz clock, 1 second delay

  always @(posedge clk) begin
    if (counter == MAX_COUNT - 1) begin // Check if counter reached max value
      counter <= 0; // Reset counter
      led_out <= ~led_out; // Toggle LED state
    end else begin
      counter <= counter + 1; // Increment counter
    end
  end

endmodule