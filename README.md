# Eleventy Benchmark Speed Regression Test

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
---------------------------------------------------------
.liquid for Eleventy 0.7.0 using Node v10.14.2
---------------------------------------------------------
Processed 1001 files in 4.83 seconds (4.8ms each)
Processed 1001 files in 2.23 seconds (2.2ms each)
Processed 1001 files in 1.79 seconds (1.8ms each)
Processed 1001 files in 1.55 seconds (1.5ms each)
Processed 1001 files in 1.95 seconds (1.9ms each)
Processed 1001 files in 1.99 seconds (2.0ms each)
---------------------------------------------------------
.njk for Eleventy 0.7.0 using Node v10.14.2
---------------------------------------------------------
Processed 1001 files in 4.63 seconds (4.6ms each)
Processed 1001 files in 3.04 seconds (3.0ms each)
Processed 1001 files in 2.93 seconds (2.9ms each)
Processed 1001 files in 4.01 seconds (4.0ms each)
Processed 1001 files in 3.08 seconds (3.1ms each)
Processed 1001 files in 2.94 seconds (2.9ms each)
---------------------------------------------------------
.md for Eleventy 0.7.0 using Node v10.14.2
---------------------------------------------------------
Processed 1001 files in 4.23 seconds (4.2ms each)
Processed 1001 files in 2.51 seconds (2.5ms each)
Processed 1001 files in 2.51 seconds (2.5ms each)
Processed 1001 files in 2.80 seconds (2.8ms each)
Processed 1001 files in 3.01 seconds (3.0ms each)
Processed 1001 files in 2.48 seconds (2.5ms each)
---------------------------------------------------------
.11ty.js for Eleventy 0.7.0 using Node v10.14.2
---------------------------------------------------------
Processed 1001 files in 2.52 seconds (2.5ms each)
Processed 1001 files in 1.86 seconds (1.9ms each)
Processed 1001 files in 1.58 seconds (1.6ms each)
Processed 1001 files in 1.94 seconds (1.9ms each)
Processed 1001 files in 1.75 seconds (1.7ms each)
Processed 1001 files in 1.74 seconds (1.7ms each)
```