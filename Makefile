GENERATOR := ./generate.py
GENCONF := ./conf.ini

OUTPUT := output

RESOURCES := bower_components/Materialize/dist/css/materialize.min.css \
	bower_components/Materialize/dist/js/materialize.min.js \
	bower_components/jquery/dist/jquery.min.js

GL_USER ?= $(USER)

TARGETSERVER := $(GL_USER)@gl.umbc.edu
TARGETPATH := /afs/umbc.edu/public/www/lug/

all: generate
tar: lug.umbc.edu.tar

.PHONY: all tar get-deps generate deploy clean reallyclean

get-deps:
	bower install materialize

$(OUTPUT):
	mkdir -p $(OUTPUT)
	mkdir -p $(OUTPUT)/static

lug.umbc.edu.tar: all
	tar -cf $@ -C $(OUTPUT) .

deploy: lug.umbc.edu.tar
	scp lug.umbc.edu.tar $(TARGETSERVER):$(TARGETPATH)
	ssh $(TARGETSERVER) "tar -C $(TARGETPATH) -xf $(TARGETPATH)/$^"

generate: $(GENCONF) $(wildcard pages/*) $(RESOURCES) $(OUTPUT)
	$(GENERATOR) $(GENCONF)
	install $(RESOURCES) $(OUTPUT)/static

clean:
	rm -rf $(OUTPUT) .sass-cache

reallyclean: clean
	rm -rf bower_components
