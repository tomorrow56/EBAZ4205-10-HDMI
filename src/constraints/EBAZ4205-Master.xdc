## This file is a general .xdc for the EBAZ4205
## Based on EBAZ4205 HDMI implementation by kan573
## https://qiita.com/kan573/items/aaacd53027471f36974d

## HDMI RX Configuration
set_property CLOCK_DEDICATED_ROUTE BACKBONE [get_nets design_1_i/dvi2rgb_0/U0/TMDS_ClockingX/CLK_IN_hdmi_clk];

## HDMI RX
set_property -dict { PACKAGE_PIN H20   IOSTANDARD LVCMOS33 } [get_ports { hdmi_in_ddc_scl_io }]; #IO_L17N_T2_AD5N_35 Sch=hdmi_rx_scl
set_property -dict { PACKAGE_PIN J20   IOSTANDARD LVCMOS33 } [get_ports { hdmi_in_ddc_sda_io }]; #IO_L17P_T2_AD5P_35 Sch=hdmi_rx_sda
set_property -dict { PACKAGE_PIN K18   IOSTANDARD TMDS_33  } [get_ports { hdmi_in_clk_n }]; #IO_L12N_T1_MRCC_35 Sch=hdmi_rx_clk_n
set_property -dict { PACKAGE_PIN K17   IOSTANDARD TMDS_33  } [get_ports { hdmi_in_clk_p }]; #IO_L12P_T1_MRCC_35 Sch=hdmi_rx_clk_p
set_property -dict { PACKAGE_PIN U20   IOSTANDARD TMDS_33  } [get_ports { hdmi_in_data_n[0] }]; #IO_L15N_T2_DQS_34 Sch=hdmi_rx_n[0]
set_property -dict { PACKAGE_PIN T20   IOSTANDARD TMDS_33  } [get_ports { hdmi_in_data_p[0] }]; #IO_L15P_T2_DQS_34 Sch=hdmi_rx_p[0]
set_property -dict { PACKAGE_PIN P20   IOSTANDARD TMDS_33  } [get_ports { hdmi_in_data_n[1] }]; #IO_L14N_T2_SRCC_34 Sch=hdmi_rx_n[1]
set_property -dict { PACKAGE_PIN N20   IOSTANDARD TMDS_33  } [get_ports { hdmi_in_data_p[1] }]; #IO_L14P_T2_SRCC_34 Sch=hdmi_rx_p[1]
set_property -dict { PACKAGE_PIN P18   IOSTANDARD TMDS_33  } [get_ports { hdmi_in_data_n[2] }]; #IO_L23N_T3_34 Sch=hdmi_rx_n[2]
set_property -dict { PACKAGE_PIN N17   IOSTANDARD TMDS_33  } [get_ports { hdmi_in_data_p[2] }]; #IO_L23P_T3_34 Sch=hdmi_rx_p[2]

set_property -dict { PACKAGE_PIN J18   IOSTANDARD LVCMOS33 } [get_ports { hdmi_in_hpd_tri_o }]; #IO_L14P_T2_AD4P_SRCC_35 Sch=hdmi_rx_hpd


## HDMI TX
set_property -dict { PACKAGE_PIN F20   IOSTANDARD TMDS_33  } [get_ports { hdmi_out_clk_n }]; #IO_L15N_T2_DQS_AD12N_35 Sch=hdmi_tx_clk_n
set_property -dict { PACKAGE_PIN F19   IOSTANDARD TMDS_33  } [get_ports { hdmi_out_clk_p }]; #IO_L15P_T2_DQS_AD12P_35 Sch=hdmi_tx_clk_p
set_property -dict { PACKAGE_PIN D20   IOSTANDARD TMDS_33  } [get_ports { hdmi_out_data_n[0] }]; #IO_L4N_T0_35 Sch=hdmi_tx_n[0]
set_property -dict { PACKAGE_PIN D19   IOSTANDARD TMDS_33  } [get_ports { hdmi_out_data_p[0] }]; #IO_L4P_T0_35 Sch=hdmi_tx_p[0]
set_property -dict { PACKAGE_PIN B20   IOSTANDARD TMDS_33  } [get_ports { hdmi_out_data_n[1] }]; #IO_L1N_T0_AD0N_35 Sch=hdmi_tx_n[1]
set_property -dict { PACKAGE_PIN C20   IOSTANDARD TMDS_33  } [get_ports { hdmi_out_data_p[1] }]; #IO_L1P_T0_AD0P_35 Sch=hdmi_tx_p[1]
set_property -dict { PACKAGE_PIN A20   IOSTANDARD TMDS_33  } [get_ports { hdmi_out_data_n[2] }]; #IO_L2N_T0_AD8N_35 Sch=hdmi_tx_n[2]
set_property -dict { PACKAGE_PIN B19   IOSTANDARD TMDS_33  } [get_ports { hdmi_out_data_p[2] }]; #IO_L2P_T0_AD8P_35 Sch=hdmi_tx_p[2]

set_property -dict { PACKAGE_PIN H18   IOSTANDARD LVCMOS33 } [get_ports { hdmi_out_ddc_scl_io }]; # Sch=hdmi_tx_scl
set_property -dict { PACKAGE_PIN E19   IOSTANDARD LVCMOS33 } [get_ports { hdmi_out_ddc_sda_io }]; # Sch=hdmi_tx_sda
