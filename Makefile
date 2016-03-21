compile : 
	coffee -o js/ -m -c src/*.coffee
build :
	r.js -o build.js
	cp -r assets build/assets
	zip -r built.zip build 
	echo "Build complete; stored in built.zip"
