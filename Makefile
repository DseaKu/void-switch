# Makefile for generating STLs from void_switch.scad

# Check if 'openscad' is in PATH; if not, fallback to default macOS app location
OPENSCAD ?= $(shell which openscad 2>/dev/null || echo "/Applications/OpenSCAD.app/Contents/MacOS/OpenSCAD")

SRC = scad/void_switch.scad
OUT_DIR = build
PARTS = body sheath stem

TARGETS = $(patsubst %,$(OUT_DIR)/%.stl,$(PARTS))

.PHONY: all clean $(PARTS)

# By default, build all parts
all: $(TARGETS)

# Create the output directory if it doesn't exist
$(OUT_DIR):
	mkdir -p $(OUT_DIR)

# Shortcuts to build individual parts (e.g., `make body`)
$(PARTS): %: $(OUT_DIR)/%.stl

# Rule to generate the STL for each part by passing the RENDER variable to OpenSCAD
$(OUT_DIR)/%.stl: $(SRC) | $(OUT_DIR)
	$(OPENSCAD) -D 'RENDER=["$*"]' -o $@ $<

# Clean up generated files
clean:
	rm -rf $(OUT_DIR)
