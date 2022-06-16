# Clock signal
set_property PACKAGE_PIN W5 [get_ports clk]							
	set_property IOSTANDARD LVCMOS33 [get_ports clk]
	create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clk]
 
# Switches
# sw0
set_property PACKAGE_PIN V17 	 [get_ports {am_or_pm}]					
    set_property IOSTANDARD LVCMOS33 [get_ports {am_or_pm}]
# switch 1
set_property PACKAGE_PIN V16 [get_ports {add_cen}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {add_cen}]
# switch 2
set_property PACKAGE_PIN W16 [get_ports {reset}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {reset}]
 
# LEDs
# LED 0
set_property PACKAGE_PIN U16 [get_ports {led_second}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {led_second}]

# Buttons
# central
set_property PACKAGE_PIN U18 	 [get_ports add_day]						
    set_property IOSTANDARD LVCMOS33 [get_ports add_day]
# up
set_property PACKAGE_PIN T18 	 [get_ports add_month]						
    set_property IOSTANDARD LVCMOS33 [get_ports add_month]
# left
set_property PACKAGE_PIN W19 	 [get_ports add_hour]						
    set_property IOSTANDARD LVCMOS33 [get_ports add_hour]
# right
set_property PACKAGE_PIN T17 	 [get_ports add_min]						
    set_property IOSTANDARD LVCMOS33 [get_ports add_min]
# down
set_property PACKAGE_PIN U17 	 [get_ports add_year]						
    set_property IOSTANDARD LVCMOS33 [get_ports add_year]

# VGA Connector
set_property PACKAGE_PIN G19 [get_ports {rgb[0]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {rgb[0]}]
set_property PACKAGE_PIN H19 [get_ports {rgb[1]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {rgb[1]}]
set_property PACKAGE_PIN J19 [get_ports {rgb[2]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {rgb[2]}]
set_property PACKAGE_PIN N19 [get_ports {rgb[3]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {rgb[3]}]
set_property PACKAGE_PIN N18 [get_ports {rgb[4]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {rgb[4]}]
set_property PACKAGE_PIN L18 [get_ports {rgb[5]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {rgb[5]}]
set_property PACKAGE_PIN K18 [get_ports {rgb[6]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {rgb[6]}]
set_property PACKAGE_PIN J18 [get_ports {rgb[7]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {rgb[7]}]
set_property PACKAGE_PIN J17 [get_ports {rgb[8]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {rgb[8]}]
set_property PACKAGE_PIN H17 [get_ports {rgb[9]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {rgb[9]}]
set_property PACKAGE_PIN G17 [get_ports {rgb[10]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {rgb[10]}]
set_property PACKAGE_PIN D17 [get_ports {rgb[11]}]				
	set_property IOSTANDARD LVCMOS33 [get_ports {rgb[11]}]
set_property PACKAGE_PIN P19 [get_ports h_sync]						
    set_property IOSTANDARD LVCMOS33 [get_ports h_sync]
set_property PACKAGE_PIN R19 [get_ports v_sync]						
    set_property IOSTANDARD LVCMOS33 [get_ports v_sync]