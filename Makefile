STYLESHEET := stylesheet.css

all: $(STYLESHEET)

.PHONY: get-deps

get-deps:
	bower install mui
	bower install fontawesome

$(STYLESHEET): stylesheets/main.scss
	scss $^ > $(STYLESHEET)
