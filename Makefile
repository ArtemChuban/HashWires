IMAGE_NAME = latex:latest
SRC_DIR = src
BUILD_DIR = build
MAIN_TEX = $(SRC_DIR)/main.tex

.PHONY: all build view docker-build help

all: build

build:
	docker run --rm -v ${PWD}/$(SRC_DIR):/$(SRC_DIR):ro -v ${PWD}/$(BUILD_DIR):/$(BUILD_DIR) $(IMAGE_NAME) sh -c " \
		cp -r /$(SRC_DIR)/* . && \
		latexmk -pdflua main.tex && \
		cp $(notdir $(MAIN_TEX:.tex=.pdf)) /$(BUILD_DIR)"

view:
	xdg-open $(BUILD_DIR)/$(notdir $(MAIN_TEX:.tex=.pdf))

docker-build:
	docker build -t $(IMAGE_NAME) .

help:
	@echo "Makefile commands:"
	@echo "  make build         - Build the LaTeX document"
	@echo "  make view          - Open the generated PDF"
	@echo "  make build-docker  - Build docker image"
	@echo "  make help          - Show this help message"

