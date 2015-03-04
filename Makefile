GENERATOR := ./generate.py
GENCONF := ./conf.ini

SCRIPT := output/style.js
STYLESHEET := output/stylesheet.css

TARGETSERVER := gl.umbc.edu
TARGETPATH := /afs/umbc.edu/public/www/lug/

all: generate $(SCRIPT) $(STYLESHEET)
tar: lug.umbc.edu.tar

.PHONY: all tar get-deps generate deploy

get-deps:
	bower install mui
	bower install fontawesome

lug.umbc.edu.tar: all
	tar -cf $@ -C output .

deploy: lug.umbc.edu.tar
	scp lug.umbc.edu.tar $(TARGETSERVER):$(TARGETPATH)
	ssh $(TARGETSERVER) "tar -C $(TARGETPATH) -xf $(TARGETPATH)/$^"

generate: $(GENCONF) $(wildcard pages/*)
	$(GENERATOR) $(GENCONF)

$(SCRIPT): style.js
	cp -f style.js $(SCRIPT)

$(STYLESHEET): stylesheets/main.scss
	scss $^ > $(STYLESHEET)
