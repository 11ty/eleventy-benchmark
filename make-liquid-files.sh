mkdir -p liquid/page/
for ((i=1; i<=$1; i++)); do
	page="liquid/page/$i.liquid"

	touch $page
	content=`cat src/content.html`
  echo "---
name: Zach $i
index: $i
layout: layout.liquid
tags: name
---
<h1>{{ name }}</h1>
<h2>$i</h2>
$content" > $page
done

cp src/page.11tydata.json liquid/page/