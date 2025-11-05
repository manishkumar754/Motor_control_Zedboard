`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.11.2025 13:33:35
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
  input clk,        // System clock input (e.g., 100MHz from ZedBoard)
  input switch,     // Deep switch input to control blinking
  output reg led_out // Output to control the LED
);

  // Counter to create a delay for blinking
  reg [31:0] counter = 0; 
  // Define the maximum count for a desired blink rate (e.g., 1 second)
  parameter MAX_COUNT = 100_000_000; // For 100MHz clock, 1 second delay

  always @(posedge clk) begin
    if (switch) begin
      // When switch is ON (high), enable blinking
      if (counter == MAX_COUNT - 1) begin // Check if counter reached max value
        counter <= 0; // Reset counter
        led_out <= ~led_out; // Toggle LED state
      end else begin
        counter <= counter + 1; // Increment counter
      end
    end else begin
      // When switch is OFF (low), turn off LED and reset counter
      led_out <= 1'b0; // Turn off LED
      counter <= 0;    // Reset counter for consistent behavior when switch is turned back on
    end
  end

endmodule