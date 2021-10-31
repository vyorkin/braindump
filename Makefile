BASE_DIR=$(shell pwd)
SOURCE_ORG_FILES=$(BASE_DIR)/org
EMACS_BUILD_DIR=/tmp/braindump-build/
BUILD_DIR=/tmp/braindump-build/.cache/org-persist/
HUGO_SECTION=org

all: clean build publish

.PHONY: clean
clean:
	rm -rf content/posts

.PHONY: server
server:
	hugo server --minify --disableFastRender

.PHONY: publish
publish:
	./scripts/publish.sh

.PHONY: build
build:
	./build.py

# .PHONY: build
# build:
# 	mkdir -p $(BUILD_DIR)
# 	cp -r $(BASE_DIR)/init.el $(EMACS_BUILD_DIR)
# 	HOME=$(EMACS_BUILD_DIR) NOTES_ORG_SRC=$(SOURCE_ORG_FILES) HUGO_SECTION=$(HUGO_SECTION) HUGO_BASE_DIR=$(BASE_DIR) emacs -Q --batch --load $(EMACS_BUILD_DIR)/init.el --execute "(build/export-all)" --kill
