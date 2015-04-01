GENERATOR := ./generate.py
GENCONF := ./conf.ini

OUTPUT := output
SCRIPT := $(OUTPUT)/style.js
STYLESHEET := $(OUTPUT)/stylesheet.css

TARGETSERVER := gl.umbc.edu
TARGETPATH := /afs/umbc.edu/public/www/lug/

all: generate $(SCRIPT) $(STYLESHEET)
tar: lug.umbc.edu.tar

.PHONY: all tar get-deps generate deploy

get-deps:
	bower install mui
	bower install fontawesome

$(OUTPUT):
	mkdir -p $(OUTPUT)

lug.umbc.edu.tar: all
	tar -cf $@ -C $(OUTPUT) .

deploy: lug.umbc.edu.tar
	scp lug.umbc.edu.tar $(TARGETSERVER):$(TARGETPATH)
	ssh $(TARGETSERVER) "tar -C $(TARGETPATH) -xf $(TARGETPATH)/$^"

generate: $(GENCONF) $(wildcard pages/*) $(OUTPUT)
	$(GENERATOR) $(GENCONF)

$(SCRIPT): style.js
	cp -f style.js $(SCRIPT)

$(STYLESHEET): stylesheets/main.scss
	scss $^ > $(STYLESHEET)
