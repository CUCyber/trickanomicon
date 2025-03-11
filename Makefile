FILES := ${shell find ./ -type f -name "*.md" | sort}

build:
	pandoc -s --metadata title="Trickanomicon" --self-contained --toc -c style.css --highlight-style rose-pine.theme ${FILES} -o trickanomicon-lite.html

