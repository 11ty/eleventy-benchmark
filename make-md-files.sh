mkdir -p md/page/
for ((i=1; i<=$1; i++)); do
	page="md/page/$i.md"

	touch $page
	content=`cat src/content.md`
  echo "---
name: Zach $i
index: $i
layout: layout.liquid
tags: name
---
# {{ name }}
$content" > $page
done

cp src/page.11tydata.json md/page/