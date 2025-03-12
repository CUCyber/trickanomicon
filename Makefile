FILES := ${shell find ./ -type f -name "*.md" | sort}

build:
	pandoc --standalone --self-contained \
		--metadata title="Trickanomicon" \
		--toc \
		-c style.css \
		--highlight-style rose-pine.theme ${FILES} \
		--lua-filter toc-css.lua \
		-o trickanomicon-lite.html
