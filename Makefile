GENERATOR := ./generate.py
GENCONF := ./conf.ini

SCRIPT := output/style.js
STYLESHEET := output/stylesheet.css

all: generate $(SCRIPT) $(STYLESHEET)

.PHONY: get-deps generate

get-deps:
	bower install mui
	bower install fontawesome

generate: $(GENCONF) $(wildcard pages/*)
	$(GENERATOR) $(GENCONF)

$(SCRIPT): style.js
	cp -f style.js $(SCRIPT)

$(STYLESHEET): stylesheets/main.scss
	scss $^ > $(STYLESHEET)
