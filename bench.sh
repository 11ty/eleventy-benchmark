TEMPLATE_FILES=1000
RUNS=10

 # Also use a local version like "file:../eleventy"
VERSIONS=("@11ty/eleventy@0.5.4" "@11ty/eleventy@0.6.0")

# LANGS=("liquid" "njk" "md" "11ty.js")
LANGS=("liquid" "njk" "md")


LINESEP="---------------------------------------------------------"
nodeVersion=`node --version`
echo "$LINESEP"
echo "Eleventy Benchmark (Node $nodeVersion, $TEMPLATE_FILES templates each)"

BASELINEMEDIAN=()
BASELINEPERTEMPLATE=()
RESULTS=()
for npmVersion in "${VERSIONS[@]}"; do
	echo "$LINESEP"
	printf "Running npm install $npmVersion\r"
	npm install $npmVersion > /dev/null 2>&1

	rm -rf _site

	eleventyVersion=`npx eleventy --version`
	echo "Eleventy $eleventyVersion                                        "
	echo "$LINESEP"

	for (( i=0; i<${#LANGS[@]}; i++ )); do
		if [[ ${#RESULTS[@]} < $i+1 ]]; then
			RESULTS+=("")
		fi

		rm -rf "${LANGS[$i]}/page/"
		printf "Creating template files…\r"
		./make-${LANGS[$i]}-files.sh $TEMPLATE_FILES
		printf "                        \r"
		printf ".${LANGS[$i]}: "

		TIMES=""
		for ((j=1; j<=$RUNS; j++)); do
			eleventyTime=`npx eleventy --quiet --formats=${LANGS[$i]}`
			printf "."

			# Extract the total time
			# Expected Format: Copied 1 item and Processed 0 files in 0.14 seconds
			eleventyTimeNumber=`echo $eleventyTime | awk '/a/ {print $5}'`
			TIMES="$TIMES$eleventyTimeNumber\n"
		done

		printf " $RUNS runs.\n"

		median=`printf $TIMES | datamash median 1`
		perTemplate=`echo "$median * 1000 / $TEMPLATE_FILES" | bc`

		printf "* Median: $median seconds"
		if [[ ${#BASELINEMEDIAN[@]} < $i+1 ]]; then
			BASELINEMEDIAN+=($median)
			echo ""
		else
			baselineCompare=`echo "$median * 100 / ${BASELINEMEDIAN[$i]} - 100" | bc`
			echo " (${baselineCompare}%)"
		fi

		printf "* Median per template: $perTemplate ms"
		if [[ ${#BASELINEPERTEMPLATE[@]} < $i+1 ]]; then
			BASELINEPERTEMPLATE+=($perTemplate)
			echo ""
		else
			baselinePerTemplateCompare=`echo "$perTemplate * 100 / ${BASELINEPERTEMPLATE[$i]} - 100" | bc`
			echo " (${baselinePerTemplateCompare}%)"
		fi
		echo ""
	done
done

