# Clock constraint (example, verify with ZedBoard documentation)
set_property PACKAGE_PIN Y9 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]

# LED output constraint (example, choose an available PMOD pin)
set_property PACKAGE_PIN Y11 [get_ports led_out]
set_property IOSTANDARD LVCMOS33 [get_ports led_out]