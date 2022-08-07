SRC := ./extension
DIST := ./dist
ZIP := $(shell which zip)

PACKAGE_NAME := chrome-skk
PACKAGE_VERSION := $(shell node -e "fs=require('fs');console.log(JSON.parse(fs.readFileSync(process.argv[1])).version)" ./extension/manifest.json)
NODE_MODULES := ../node_modules

build: 3rd-party-licenses.txt
	rm -rf $(DIST); \
	mkdir -p $(DIST); \
	cd $(SRC); \
	find . -type f -print | $(ZIP) ../$(DIST)/$(PACKAGE_NAME)-$(PACKAGE_VERSION).zip -@; \
        $(ZIP) ../$(DIST)/$(PACKAGE_NAME)-$(PACKAGE_VERSION).zip -j $(NODE_MODULES)/pako/dist/pako_inflate.es5.min.js; \
	$(ZIP) ../$(DIST)/$(PACKAGE_NAME)-$(PACKAGE_VERSION).zip -j ../3rd-party-licenses.txt; \
	$(ZIP) ../$(DIST)/$(PACKAGE_NAME)-$(PACKAGE_VERSION).zip -j ../LICENSE;

3rd-party-licenses.txt: package.json
	npx generate-license-file --input package.json --output 3rd-party-licenses.txt --overwrite

clean:
	rm -rf $(DIST)