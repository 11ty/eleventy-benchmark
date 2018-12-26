# Eleventy Benchmark Speed Regression Test

Creates 1000 Liquid, 1000 Nunjucks, and 1000 Markdown templates. Runs Eleventy against each template format individually and measures the Median Eleventy Runtime (over 10 runs) and Median Eleventy Per Template time.

Can optionally run serially against multiple Eleventy versions, for comparison.

## Usage

```sh
$ ./bench.sh
```

## Instructions

### Add additional template type

1. See `make-liquid-files.sh` as a template script to generate a bunch of sample files for a template type.
2. Add the template language key to `bench.sh`
3. Add `$key/page` to the `.gitignore` file.
4. Create a layout file in `_includes`
5. Create an index page that loops over all items in the collection at `$key/`

## Sample Output

```
~/Code/eleventy-bench ᐅ ./bench.sh
---------------------------------------------------------
.liquid for Eleventy 0.6.0 using Node v10.14.2
.......... 10 runs, 1000 templates each.
* Median: 2.075 seconds
* Median per template: 2 ms
---------------------------------------------------------
.njk for Eleventy 0.6.0 using Node v10.14.2
.......... 10 runs, 1000 templates each.
* Median: 3.39 seconds
* Median per template: 3 ms
---------------------------------------------------------
.md for Eleventy 0.6.0 using Node v10.14.2
.......... 10 runs, 1000 templates each.
* Median: 3.9 seconds
* Median per template: 3 ms
```