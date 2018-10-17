SOURCE_URL := https://github.com/pages-themes/minimal/archive/master.zip
SOURCE_BASE := minimal-master
SOURCE_STYLE := $(SOURCE_BASE)/assets/css/style.scss
STYLE_BASE := static/css/style
CONTENT_BASE := docs-site/content

all: download assets css

download: clean
	curl -Lo $(SOURCE_BASE).zip $(SOURCE_URL)
	unzip $(SOURCE_BASE)

assets:
	# remove Jekyll header
	tail -n +5 $(SOURCE_BASE)/index.md > $(CONTENT_BASE)/_index.md
	cp -r $(SOURCE_BASE)/assets/* static/
	rm static/css/*

css:
	# remove Jekyll header
	tail -n +3 $(SOURCE_STYLE) > $(SOURCE_STYLE)2
	sassc -I $(SOURCE_BASE)/_sass $(SOURCE_STYLE)2 static/css/style.css

clean:
	rm $(SOURCE_BASE).zip || test 1
	rm -r $(SOURCE_BASE) || test 1

.PHONY: all
