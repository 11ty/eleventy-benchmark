TEMPLATE_FILES=1000
# VERSIONS=("@11ty/eleventy@0.6.0" "file:../eleventy")
VERSIONS=("@11ty/eleventy@0.6.0")
for npmVersion in "${VERSIONS[@]}"; do
	npm install $npmVersion

	rm -rf _site

	eleventyVersion=`npx eleventy --version`
	nodeVersion=`node --version`

	# LANGS=("liquid" "njk" "md" "11ty.js")
	LANGS=("liquid" "njk" "md")

	for templateLang in "${LANGS[@]}"; do
		rm -rf ${templateLang}/page/
		echo "---------------------------------------------------------"
		echo ".${templateLang} for Eleventy $eleventyVersion using Node $nodeVersion"
		printf "Creating template files…\r"
		./make-${templateLang}-files.sh $TEMPLATE_FILES
		printf "Running…                \r"

		TIMES=""
		RUNS=10
		for ((i=1; i<=$RUNS; i++)); do
			eleventyTime=`npx eleventy --quiet --formats=${templateLang}`
			printf "."

			eleventyTimeNumber=`echo $eleventyTime | awk '/a/ {print $5}'`
			TIMES="$TIMES$eleventyTimeNumber\n"
		done
		printf " $RUNS runs, $TEMPLATE_FILES templates each.\n"
		median=`printf $TIMES | datamash median 1`
		mean=`printf $TIMES | datamash mean 1`
		perTemplate=`echo "$median * 1000 / $TEMPLATE_FILES" | bc`
		echo "* Median: $median seconds
* Median per template: $perTemplate ms"
	done
done