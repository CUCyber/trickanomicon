FILES := ${shell find ./ -type f -name "*.md" | sort}

build:
	pandoc --self-contained --standalone \
		--metadata title="Trickanomicon" \
		--metadata toc-title="Contents" \
		--toc \
		-c style.css \
		--highlight-style rose-pine.theme \
		-H extras.html \
 		${FILES} \
		-o trickanomicon-lite.html
