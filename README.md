# TM1637 Driver for Gowin Tang Nano 9K using VHDL

This repository contains the source code for a VHDL driver for the TM1637 LED display controller designed to run on the Gowin Tang Nano 9K FPGA. The TM1637 controller is commonly used to control 4-digit 7-segment LED displays. The Bit-Banging two-wire-alike approach is based on the work by [GitHub - mongoq/tm1637-fpga: 4-Digit 7-Segment Display for FPGAs](https://github.com/mongoq/tm1637-fpga)

This implementation supports 4-digit displays and converts 8 bit signed/unsigned data to a decimal representation and pushes it on the TM1637.

## Pinout

The following table shows the pinout for the TM1637 controller for the Tang Nano 9K:

| Pin | Description |
| --- | ----------- |
| CLK | Pin 38      |
| DIO | Pin 27      |

## Notes

- Set the Gowin IDE to synthesize is VHDL 2008 : Navigate to the Process tab and right click Synthesis, click Configuration > Synthesize > General > Synthesis Language and set to VHDL 2008. Back in the main window, click run all to synthesize, place and route. 
- Have experienced issues when a short connection on the data line. Perhaps adding a small capacitor (10nF) from data to ground might solve this.

## Future updates

- Adding brightness control

- Switching between Hexadecimal and Decimal representation

## Contact

If you have any questions or suggestions, please feel free to open an issue or contact the author directly.
