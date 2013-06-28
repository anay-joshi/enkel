COMPILER = iverilog
TARGET = enkel
VCDVIEW = gtkwave
TESTBENCH = test
HEAD_MODULE = src/COMPUTER
.PHONY = clean

SOURCES = src/decoder_plus.v src/adder.v src/ALU.v src/carry_register.v src/choose.v src/compliment.v src/COMPUTER.v src/CPU.v src/d_array.v src/d_ff.v src/increment.v src/mux.v src/pulse.v src/ram.v src/register2.v src/REST.v src/tri_state_buffer.v

OBJECTS = $(subst .v,.o,$(SOURCES))

$(TARGET) : $(SOURCES)
	$(COMPILER) $(SOURCES) src/$(TESTBENCH).v -o $(TARGET)

vcd: $(TARGET)
	./$(TARGET)

view-vcd : $(TARGET)
	./$(TARGET)
	$(VCDVIEW) $(TESTBENCH).vcd	

	

clean : 
	rm $(TARGET) $(TESTBENCH).vcd -f
	rm obj_dir/ -rf
