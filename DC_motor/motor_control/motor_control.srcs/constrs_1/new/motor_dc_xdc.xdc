# Clock Source - Bank 13
# ----------------------------------------------------------------------------
set_property PACKAGE_PIN Y9 [get_ports CLK]
create_clock -period 10.000 -name sysclk -waveform {0.000 5.000} [get_ports CLK]
set_property IOSTANDARD LVCMOS33 [get_ports CLK]

## Motor pins -Pmod
#IN3
set_property PACKAGE_PIN AB11 [get_ports {MOTOR[0]}]
#IN4
set_property PACKAGE_PIN AB10 [get_ports {MOTOR[1]}]
#ENB
set_property PACKAGE_PIN AB9 [get_ports {MOTOR[2]}]

#Switch for the controlling the motor
## User DIP Switches - Bank 35
## ----------------------------------------------------------------------------
set_property PACKAGE_PIN F22 [get_ports {SWITCH[0]}]
set_property PACKAGE_PIN G22 [get_ports {SWITCH[1]}]
set_property PACKAGE_PIN H22 [get_ports {SWITCH[2]}]
#set_property PACKAGE_PIN F21 [get_ports {SW3}];  # "SW3"
#set_property PACKAGE_PIN H19 [get_ports {SW4}];  # "SW4"
#set_property PACKAGE_PIN H18 [get_ports {SW5}];  # "SW5"
#set_property PACKAGE_PIN H17 [get_ports {SW6}];  # "SW6"
#set_property PACKAGE_PIN M15 [get_ports {SW7}];  # "SW7"

set_property IOSTANDARD LVCMOS33 [get_ports {SWITCH[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SWITCH[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {SWITCH[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {MOTOR[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {MOTOR[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {MOTOR[2]}]
