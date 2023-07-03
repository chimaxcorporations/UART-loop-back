#clk
set_property -dict {PACKAGE_PIN Y9 IOSTANDARD LVCMOS33} [get_ports {clk}];

#outputs
#set_property -dict {PACKAGE_PIN T22 IOSTANDARD LVCMOS33} [get_ports {tx_led}];
#set_property -dict {PACKAGE_PIN T21 IOSTANDARD LVCMOS33} [get_ports {clk_hz}];
#set_property -dict {PACKAGE_PIN U22 IOSTANDARD LVCMOS33} [get_ports {full}];
set_property -dict {PACKAGE_PIN U21 IOSTANDARD LVCMOS33} [get_ports {tx_done}];
set_property -dict {PACKAGE_PIN Y10 IOSTANDARD LVCMOS33} [get_ports {tx}];

#LEDS
#set_property -dict {PACKAGE_PIN T22 IOSTANDARD LVCMOS33} [get_ports {rx_data[0]}];
#set_property -dict {PACKAGE_PIN T21 IOSTANDARD LVCMOS33} [get_ports {rx_data[1]}];
#set_property -dict {PACKAGE_PIN U22 IOSTANDARD LVCMOS33} [get_ports {rx_data[2]}];
#set_property -dict {PACKAGE_PIN U21 IOSTANDARD LVCMOS33} [get_ports {rx_data[3]}];
#set_property -dict {PACKAGE_PIN V22 IOSTANDARD LVCMOS33} [get_ports {rx_data[4]}];
#set_property -dict {PACKAGE_PIN W22 IOSTANDARD LVCMOS33} [get_ports {rx_data[5]}];
#set_property -dict {PACKAGE_PIN U19 IOSTANDARD LVCMOS33} [get_ports {rx_data[6]}];
#set_property -dict {PACKAGE_PIN U14 IOSTANDARD LVCMOS33} [get_ports {rx_data[7]}];

#inputs
#set_property -dict {PACKAGE_PIN R16  IOSTANDARD LVCMOS18} [get_ports {tx_start}];
set_property -dict {PACKAGE_PIN P16 IOSTANDARD LVCMOS18} [get_ports {rst}];
set_property -dict {PACKAGE_PIN AA9 IOSTANDARD LVCMOS33} [get_ports rx];


