all: run

TOP_MODULE = computer_tb
VSRC_DIR = ./src/verilog
BUILD_DIR = ./build
$(shell mkdir -p $(BUILD_DIR))

VSRCS = $(wildcard ${VSRC_DIR}/*.v)

OUT_FILE = $(BUILD_DIR)/$(TOP_MODULE).out

.PHONY: build
$(OUT_FILE): $(VSRCS)
	iverilog $(VSRCS) -I $(VSRC_DIR) -s $(TOP_MODULE) -o $(OUT_FILE)
	
.PHONY: run
run: $(OUT_FILE)
	./$(OUT_FILE)

.PHONY: clean
clean:
	rm -rf ./build