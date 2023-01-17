mkdir -p njk/page/
for ((i=1; i<=$1; i++)); do
	page="njk/page/$i.njk"

	touch $page
	content=`cat src/content.html`
  echo "---
name: Zach $i
index: $i
layout: layout.njk
tags: name
---
<h1>{{ name }}</h1>
<h2>$i</h2>
$content" > $page
done

cp src/page.11tydata.json njk/page/