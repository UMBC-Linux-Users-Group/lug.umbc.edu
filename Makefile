STYLESHEET := stylesheet.css

all: $(STYLESHEET)

.PHONY: get-deps

get-deps:
	bower install mui

$(STYLESHEET): stylesheets/main.scss
	scss $^ > $(STYLESHEET)
