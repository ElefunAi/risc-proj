all: run

TOP_MODULE = CPU
VSRC_DIR = ./src/verilog
BUILD_DIR = ./build
$(shell mkdir -p $(BUILD_DIR))

INPUT_FILES = ./src/verilog/ALU.v ./src/verilog/CPU.v
#INPUT_FILES = $(wildcard $(VSRC_DIR)/*.v)
OUT_FILE = $(BUILD_DIR)/$(TOP_MODULE).out

.PHONY: test
test:
	@echo $(VSRC_DIR)
	@echo $(INPUT_FILES)

.PHONY: build
build:
	iverilog $(INPUT_FILES) -I $(VSRC_DIR) -s $(TOP_MODULE) -o $(OUT_FILE)
	
.PHONY: run
run: build
	./$(OUT_FILE)

.PHONY: clean
clean:
	rm -rf ./build