# Eleventy Benchmark Speed Regression Test

Creates 1000 (Liquid|Nunjucks|Markdown) templates. Runs Eleventy against each template format individually and measures the Median Eleventy Runtime (over 10 runs) and Median Time Spent Per Template.

Can optionally run serially against multiple Eleventy versions, for comparison.

Eleventy features:
* Each individual template uses:
    - A layout file (of the same template type).
    - A tag to make it part of a collection
    - Front matter data used in the template content body
    - Markdown files are preprocessed by Liquid (as is Eleventy default)
    - Templates are not tiny—they use content and the output HTML is about 10KB.
* Template types have one index page template that lists all the templates in a custom sorted collection based on a front matter value.

## Usage

```sh
$ ./bench.sh
```

Requires the `datamash` utility (`brew install datamash` on Mac OS using homebrew). Uh, and all the prerequisites for Eleventy.

### Sample Output

```
~/Code/eleventy-bench ᐅ ./bench.sh
---------------------------------------------------------
Eleventy Benchmark (Node v10.14.2, 1000 templates each)
---------------------------------------------------------
Eleventy 0.5.4
---------------------------------------------------------
.liquid: .......... 10 runs.
* Median: 1.62 seconds
* Median per template: 1 ms

.njk: .......... 10 runs.
* Median: 2.775 seconds
* Median per template: 2 ms

.md: .......... 10 runs.
* Median: 2.915 seconds
* Median per template: 2 ms

---------------------------------------------------------
Eleventy 0.6.0
---------------------------------------------------------
.liquid: .......... 10 runs.
* Median: 1.755 seconds (8%)
* Median per template: 1 ms (0%)

.njk: .......... 10 runs.
* Median: 2.885 seconds (3%)
* Median per template: 2 ms (0%)

.md: .......... 10 runs.
* Median: 2.95 seconds (1%)
* Median per template: 2 ms (0%)
```

### Use with Speedscope

This benchmark uses Node’s --cpu-prof arg to create a `.cpuprofile` output that can be uploaded to [speedscope.app](speedscope.app).

### Steps to add additional template type

1. See `make-liquid-files.sh` as a template script to generate a bunch of sample files for a template type.
2. Add the template language key to `bench.sh`
3. Add `$key/page` to the `.gitignore` file.
4. Create a layout file in `_includes`
5. Create an index page that loops over all items in the collection at `$key/`
