%.js: %.coffee
	coffee -c $<

%.min.js: %.js
	minify $< > $@

.SECONDARY:

all: now.min.js

clean:
	-git clean -xdf .
