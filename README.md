EBAZ4205-10-HDMI Demo
=====================

English | [日本語](README_ja.md)

Description
-----------

This project is a port of the Digilent Zybo Z7-10 HDMI demo to the EBAZ4205 development board. It demonstrates how to use HDMI Sink and HDMI Source with the ZYNQ processor on EBAZ4205. Vivado is used to build the demo's hardware platform, and Vitis is used to program the bitstream onto the board and to build and deploy a C application.

Video data streams in through the HDMI in port and out through the HDMI out port. A UART interface is available to configure what is output through HDMI. The configuring options are shown in the table below.

The demo uses the UART interface to configure the HDMI Display. The EBAZ4205 must be connected to a computer via UART (J7 connector), which must be running a serial terminal. For more information on how to set up and use a serial terminal, such as Tera Term or PuTTY, refer to [this tutorial](https://reference.digilentinc.com/learn/programmable-logic/tutorials/tera-term).

**Note:** This project is based on the original [Zybo Z7-10 HDMI Demo](https://github.com/Digilent/Zybo-Z7-10-HDMI) and adapted for EBAZ4205 following the implementation guide by [kan573](https://qiita.com/kan573/items/aaacd53027471f36974d).

| Option    | Function                                                                                                                 |
| --------- | ------------------------------------------------------------------------------------------------------------------------ |
| 1         | Change the resolution of the HDMI output to the monitor.                                                                 |
| 2         | Changes the frame buffer to display on the HDMI monitor.                                                                 |
| 3/4       | Store one of two test patterns in the chosen video frame buffer.                                                         |
| 5         | Start/Stop streaming video data from HDMI to the chosen video frame buffer.                                              |
| 6         | Change the video frame buffer that HDMI data is streamed into.                                                           |
| 7         | Invert and store the current video frame into the next video frame buffer and display it.                                |
| 8         | Scale the current video frame to the display resolution, store it into the next video frame buffer, and then display it. |


Requirements
------------
* **EBAZ4205**: A low-cost Zynq-7000 development board (xc7z010clg400-1)
* **Vivado 2020.1 or later with Vitis**: To set up Vivado, see the [Installing Vivado Tutorial](https://reference.digilentinc.com/vivado/installing-vivado/start)
* **Serial Terminal Emulator Application**: For more information see the [Installing and Using a Terminal Emulator Tutorial](https://reference.digilentinc.com/learn/programmable-logic/tutorials/tera-term)
* **UART Cable** (for J7 connector)
* **HDMI Connectors** (custom HDMI IN/OUT connectors connected to DATA1, DATA2, DATA3 ports)
* **2 HDMI Cables**
* **HDMI capable Monitor/TV**
* **HDMI Source** (camera, player, etc.)

Hardware Modifications
----------------------

The EBAZ4205 does not have built-in HDMI connectors. You need to:

1. **Create HDMI Input/Output Connectors**: Connect HDMI connectors to the DATA1, DATA2, and DATA3 expansion ports on EBAZ4205
2. **Modify Damping Resistors**: Change 22Ω resistors to 0Ω and add TMDS termination resistors
3. **UART Connection**: Solder J7 UART connector if not present

For detailed hardware modification instructions, refer to:
- [EBAZ4205 HDMI Implementation Guide (Japanese)](https://qiita.com/kan573/items/aaacd53027471f36974d)
- [EBAZ4205 Hardware Information](https://github.com/xjtuecho/EBAZ4205)
- [EBAZ4205 Tutorial](https://github.com/tomorrow56/EBAZ4205_tutorial)

Demo Setup
----------

### Building the Hardware Project

1. Clone or download this repository
2. Open Vivado 2020.1 or later
3. Source the `digilent-vivado-scripts/digilent_vivado_checkout.tcl` script to create the project
4. The project will be configured for EBAZ4205 with:
   - Part: xc7z010clg400-1
   - Custom pin assignments for HDMI IN/OUT via EBAZ4205-Master.xdc
5. **Modify PS Configuration** (if using source files):
   - Open Block Design and double-click on ZYNQ7 Processing System
   - Peripheral I/O Pins:
     - Change Quad SPI Flash to NAND Flash
     - Change Ethernet 0 to EMIO, MDIO to EMIO
     - Uncheck USB 0
     - Move SD0 to pins 40-45, Card Detect to pin 34
     - Move UART1 to pins 24/25
   - DDR Configuration:
     - Memory Part: MT41K128M16JT-125
     - Effective DRAM Bus Width: 16 Bit
     - Reset DQS to Clock Delay and Board Delay to defaults (0.0 and 0.25)
6. Generate Bitstream
7. In the toolbar at the top of the Vivado window, select **File -> Export -> Export Hardware**. Select **\<Local to Project\>** as the Exported Location and make sure that the **Include bitstream** box is checked, then click **OK**.
8. In the toolbar at the top of the Vivado window, select **Tools -> Launch Vitis**.

### Building the Software Project

1. With Vitis opened, wait for the hardware platform exported by Vivado to be imported.
2. In the toolbar at the top of the Vitis window, select **File -> New -> Application Project**.
3. Fill out the fields in the first page of the New Application Project Wizard as in the table below. Most of the listed values will be the wizard's defaults, but are included in the table for completeness.

| Setting                                 | Value                              |
| --------------------------------------- | ---------------------------------- |
| Project Name                            | EBAZ4205-10-HDMI                   |
| Use default location                    | Checked box                        |
| OS Platform                             | standalone                         |
| Target Hardware: Hardware Platform      | design_1_wrapper_hw_platform_0     |
| Target Hardware: Processor              | ps7_cortexa9_0                     |
| Target Software: Language               | C                                  |
| Target Software: Board Support Package  | Create New (EBAZ4205-10-HDMI_bsp)  |

4. Click **Next**.
5. From the list of template applications, select "Empty Application", then click **Finish**.
6. In the Project Explorer pane to the left of the Vitis window, expand the new application project (named "EBAZ4205-10-HDMI").
7. Right click on the "src" subdirectory of the application project and select **Import**.
8. In the "Select an import wizard" pane of the window that pops up, expand **General** and select **File System**. Then click **Next**.
9. Fill out the fields of the "File system" screen as in the table below.

| Setting                                                | Value                                      |
| ------------------------------------------------------ | ------------------------------------------ |
| From directory                                         | \<original Zybo project\>/sdk_appsrc       |
| Files to import pane: sdk_appsrc                       | Checked box                                |
| Into folder                                            | EBAZ4205-10-HDMI/src                       |
| Options: Overwrite existing resources without warning  | Checked box                                |
| Options: Create top-level folder                       | Unchecked box                              |

10. Click **Finish**.
11. Build the project.

### Running the Demo

1. Plug in the HDMI IN/OUT cables as well as the HDMI capable Monitor/TV.
2. Connect UART cable to J7 connector on EBAZ4205.
3. Open a serial terminal application (such as [TeraTerm](https://ttssh2.osdn.jp/index.html.en)) and connect it to the EBAZ4205's UART port, using a baud rate of 115200.
4. Power the EBAZ4205 board (via DATA1/DATA2/DATA3 connector, 5V~12V, 400mA minimum).
5. In the toolbar at the top of the Vitis window, select **Xilinx -> Program FPGA**. Leave all fields as their defaults and click "Program".
6. In the Project Explorer pane, right click on the "EBAZ4205-10-HDMI" application project and select "Run As -> Launch on Hardware (System Debugger)".
7. The application will now be running on the EBAZ4205. It can be interacted with as described in the first section of this README.

Next Steps
----------
This demo can be used as a basis for other projects by modifying the hardware platform in the Vivado project's block design or by modifying the Vitis application project.

Check out the following resources for more information:
- [EBAZ4205 Tutorial](https://github.com/tomorrow56/EBAZ4205_tutorial)
- [EBAZ4205 Hardware Information](https://github.com/xjtuecho/EBAZ4205)
- [Original Zybo Z7-10 HDMI Demo](https://github.com/Digilent/Zybo-Z7-10-HDMI)
- [EBAZ4205 HDMI Implementation Guide (Japanese)](https://qiita.com/kan573/items/aaacd53027471f36974d)

Additional Notes
----------------
For more information on how this project is version controlled, refer to the [digilent-vivado-scripts repo](https://github.com/digilent/digilent-vivado-scripts).

## Acknowledgements

This project is based on:
- [Digilent Zybo Z7-10 HDMI Demo](https://github.com/Digilent/Zybo-Z7-10-HDMI) - Original project by Digilent
- [kan573's EBAZ4205 HDMI Implementation](https://qiita.com/kan573/items/aaacd53027471f36974d) - Hardware modification guide
- [xjtuecho's EBAZ4205 Resources](https://github.com/xjtuecho/EBAZ4205) - Hardware documentation
