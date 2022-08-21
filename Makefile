all: run

TOP_MODULE = CPU
VSRC_DIR = ./src/verilog
BUILD_DIR = ./build
$(shell mkdir -p $(BUILD_DIR))

INPUT_FILE_NAMES = \
	ALU.v \
	CPU.v \
	data_mem.v \
	decoder.v \
	inst_mem.v \
	instruction.v \
	jump_controller.v \
	pc.v \
	reg_decode_reg_file.v

INPUT_FILES = $(addprefix $(VSRC_DIR)/,$(INPUT_FILE_NAMES))
$(addprefix src/,$(FILES))  
#INPUT_FILES = $(wildcard $(VSRC_DIR)/*.v)
OUT_FILE = $(BUILD_DIR)/$(TOP_MODULE).out

.PHONY: test
test:
	@echo $(VSRC_DIR)
	@echo $(INPUT_FILES)

.PHONY: build
$(OUT_FILE): $(INPUT_FILES)
	iverilog $(INPUT_FILES) -I $(VSRC_DIR) -s $(TOP_MODULE) -o $(OUT_FILE)
	
.PHONY: run
run: $(OUT_FILE)
	./$(OUT_FILE)

.PHONY: clean
clean:
	rm -rf ./build