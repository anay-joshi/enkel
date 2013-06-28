Enkel is a an educational ASAIG (as simple as it gets) processor written in verilog HDL. As of this writing, the soft-core has been written completely (i might add some comments and clean up the code, but no more features in the soft processor would be added). 

To use the processor in its current state, run "make enkel" or "make view-vcd". A default program written in test.v would be run. This program compares two integers and tells which one is bigger.

In a few days, I would be adding a frontend (in python) to write programs in enkel assembly language and convert it into a testbench.

This project, hopefully would help students to get a feel of writing a soft core and also understand how a (simple) micro-processor works internally.
