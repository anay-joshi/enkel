COMPILER = iverilog
TARGET = enkel
VCDVIEW = gtkwave
TESTBENCH = test
.PHONY = clean

SOURCES = 3to8dec.v adder.v ALU.v carry_register.v choose.v compliment.v COMPUTER.v CPU.v d_array.v d_ff.v increment.v mux.v pulse.v ram.v register2.v REST.v tri_state_buffer.v

OBJECTS = $(subst .v,.o,$(SOURCES))

$(TARGET) : $(SOURCES)
	$(COMPILER) $(SOURCES) $(TESTBENCH).v -o $(TARGET)


view-vcd : $(TARGET)
	./$(TARGET)
	$(VCDVIEW) $(TESTBENCH).vcd	

clean : 
	rm $(TARGET) $(TESTBENCH).vcd -f
