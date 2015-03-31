targets=lib/now.min.js public/js/app.min.js public/css/app.min.css

coffee ?= /usr/local/bin/coffee

all: $(targets)

public/js/%.js: lib/%.js
	mv $< $@

%.min.css: %.css
	minify $< > $@~
	mv $@~ $@

%.min.js: %.js
	minify $< > $@~
	mv $@~ $@

lib/%.js: src/%.coffee
	mkdir -p lib
	$(coffee) -sc < $< > $@~
	mv $@~ $@

bin/%: lib/%.js
	mkdir -p bin
	@echo "#!/usr/bin/env node" > $@~
	cat $< >> $@~
	chmod +x $@~
	mv $@~ $@

%.json: %.yml
	yaml2json $< > $@~
	mv $@~ $@

clean:
	git clean -xdf

install: all
	npm install -g .

.PHONY: all clean install

.SECONDARY:
