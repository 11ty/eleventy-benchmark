VERSIONS=("file:../eleventy") #"@11ty/eleventy@0.6.0"
for npmVersion in "${VERSIONS[@]}"; do
	# npm install $npmVersion

	rm -rf _site
	rm -rf liquid/page/
	rm -rf njk/page/
	rm -rf 11ty.js/page/
	rm -rf md/page/

	eleventyVersion=`npx eleventy --version`
	nodeVersion=`node --version`

	LANGS=("liquid" "njk" "md" "11ty.js")

	for templateLang in "${LANGS[@]}"; do
		echo "---------------------------------------------------------"
		echo ".${templateLang} for Eleventy $eleventyVersion using Node $nodeVersion"
		echo "---------------------------------------------------------"
		printf "Creating template files…\r"
		./make-${templateLang}-files.sh
		printf "Running…                \r"
		for ((i=1; i<=6; i++)); do
			eleventyTime=`npx eleventy --quiet --formats=${templateLang}` 
			echo "$eleventyTime"
		done
	done
done