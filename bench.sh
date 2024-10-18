TEMPLATE_FILES=2500
RUNS=5

# "@11ty/eleventy@canary"
# "@11ty/eleventy@beta"
# "@11ty/eleventy@0.12.1"
# "@11ty/eleventy@1.0.0"
# "file:../eleventy"
VERSIONS=("@11ty/eleventy@0.12.1" "@11ty/eleventy@1.0.0" "file:../eleventy")

ALL_LANGS=("liquid" "njk" "md" "11ty.js")
LANGS=("liquid" "njk" "11ty.js" "md")

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
		# Delete previous template files
		for (( j=0; j<${#ALL_LANGS[@]}; j++ )); do
			rm -rf "${ALL_LANGS[$j]}/page/"
		done

		if [[ ${#RESULTS[@]} < $i+1 ]]; then
			RESULTS+=("")
		fi

		printf "Creating fresh template files…\r"
		./make-${LANGS[$i]}-files.sh $TEMPLATE_FILES
		printf "                              \r"
		printf ".${LANGS[$i]}: "

		TIMES=""
		for ((j=1; j<=$RUNS; j++)); do
			# No CPU profile
			# eleventyTime=`npx eleventy --quiet --formats=${LANGS[$i]}`

			# Includes a CPU profile for speedscope
			timestamp=`date +%y%m%d-%H%M%S`
			eleventyTime=`node --cpu-prof --cpu-prof-name=eleventybench-${eleventyVersion}_${LANGS[$i]}_r${j}_${timestamp}.cpuprofile ./node_modules/.bin/eleventy --quiet --formats=${LANGS[$i]}`
			printf "."

			# Extract the total time
			# Expected Format 0.x (print $5):
			# Copied 1 item and Processed 0 files in 0.14 seconds
			# Expected Format 1.0 (print $6):
			# [11ty] Wrote 114 files in 6.13 seconds (53.8ms each, v1.0.0-canary.45)
			# [11ty] Copied 4196 files / Wrote 114 files in 6.13 seconds (53.8ms each, v1.0.0-canary.45)
			# [11ty] Wrote 1001 files in 1.01 seconds (1.0ms each, v3.0.0)
			# TODO fix this to be automatic

			if [[ $npmVersion == "@11ty/eleventy@0.12.1" ]]; then
				eleventyTimeNumber=`echo $eleventyTime | awk '{split($0, array, " "); print array[5]}'`
			else
				eleventyTimeNumber=`echo $eleventyTime | awk '{split($0, array, " "); print array[6]}'`
			fi

			TIMES="$TIMES$eleventyTimeNumber\n"
		done

		printf " $RUNS runs:\n"
		median=`printf $TIMES | datamash median 1`
		perTemplate=`echo "$median * 1000000 / $TEMPLATE_FILES" | bc`

		printf "* Median: $median seconds"
		if [[ ${#BASELINEMEDIAN[@]} < $i+1 ]]; then
			BASELINEMEDIAN+=($median)
			echo ""
		else
			baselineCompare=`echo "$median * 100 / ${BASELINEMEDIAN[$i]} - 100" | bc`
			echo " (${baselineCompare}%)"
		fi

		printf "* Median per template: $perTemplate µs"
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

