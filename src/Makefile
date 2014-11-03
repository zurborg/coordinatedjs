%.js: %.coffee
	coffee -bc $<

%.min.js: %.js
	minify $< > $@

.SECONDARY:

all: now.min.js app.min.js

clean:
	-git clean -xdf .
