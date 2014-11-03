%.js: %.coffee
	coffee -bc $<

%.min.js: %.js
	minify $< > $@

.SECONDARY:

all: now.min.js

clean:
	-git clean -xdf .
