GENERATOR := ./generate.py
GENCONF := ./conf.ini

SCRIPT := output/style.js
STYLESHEET := output/stylesheet.css

all: generate $(SCRIPT) $(STYLESHEET)
tar: lug.umbc.edu.tar

.PHONY: all tar get-deps generate

get-deps:
	bower install mui
	bower install fontawesome

lug.umbc.edu.tar: all
	tar -cf $@ -C output .

generate: $(GENCONF) $(wildcard pages/*)
	$(GENERATOR) $(GENCONF)

$(SCRIPT): style.js
	cp -f style.js $(SCRIPT)

$(STYLESHEET): stylesheets/main.scss
	scss $^ > $(STYLESHEET)
