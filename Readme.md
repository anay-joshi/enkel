# Enkel

Enkel is a an educational **ASAIG** (as simple as it gets) processor written in **verilog HDL**.

To use the processor in its current state, run 

```
git clone http://github.com/anayjoshi/enkel
make enkel
make view-vcd
```

A default program written in `test.v` would be run. This program compares two integers and tells which one is bigger

Whenever I get some time, I would be adding a frontend (in python) to write programs in enkel assembly language and convert it into a testbench.
For now, you can go through the documentation of internals of Enkel from
the project report in the `docs/` folder. This project, hopefully would help students to get a feel of writing a softcore processor and also understand how a (simple) micro-processor works internally
