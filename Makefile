IMAGE_NAME = latex:latest
SRC_DIR = src
BUILD_DIR = build
MAIN_TEX = $(SRC_DIR)/main.tex

.PHONY: all build clean view docker-build help

all: build

build:
	docker run --rm -v ${PWD}/$(SRC_DIR):/data/$(SRC_DIR):ro -v ${PWD}/$(BUILD_DIR):/data/$(BUILD_DIR) $(IMAGE_NAME) latexmk -outdir=$(BUILD_DIR) -pdflua $(MAIN_TEX)

clean:
	docker run --rm -v ${PWD}:/data $(IMAGE_NAME) latexmk -c -bibtex-cond1 -outdir=$(BUILD_DIR) $(MAIN_TEX)

view:
	xdg-open $(BUILD_DIR)/$(notdir $(MAIN_TEX:.tex=.pdf))

docker-build:
	docker build -t $(IMAGE_NAME) .

help:
	@echo "Makefile commands:"
	@echo "  make build         - Build the LaTeX document"
	@echo "  make clean         - Clean up generated files"
	@echo "  make view          - Open the generated PDF"
	@echo "  make build-docker  - Build docker image"
	@echo "  make help          - Show this help message"

