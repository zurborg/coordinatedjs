lib/%.js: src/%.coffee
	coffee -bsc < $? > $@

lib/%.min.js: lib/%.js
	minify $? > $@

public/js/%.js: src/%.coffee
	coffee -bsc < $? > $@

public/js/%.min.js: public/js/%.js
	minify $? > $@

public/css/%.min.css: public/css/%.css
	minify $? > $@

.SECONDARY:

all: lib/now.min.js public/js/app.min.js public/css/app.min.css

clean:
	-git clean -xdf
