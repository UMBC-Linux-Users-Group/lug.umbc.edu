STYLESHEET := stylesheet.css

all: $(STYLESHEET)

$(STYLESHEET): stylesheets/main.scss
	scss $^ > $(STYLESHEET)
