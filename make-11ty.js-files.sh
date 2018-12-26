mkdir -p 11ty.js/page/
for ((i=1; i<=$1; i++)); do
	page="11ty.js/page/$i.11ty.js"

	touch $page
	content=`cat src/content.html`
  echo "class MyTemplate {
  get data() {
  	return {
  		name: 'Zach $i',
  		index: $i,
  		layout: 'layout.11ty.js',
  		tags: 'name'
  	};
	}

	render(data) {
    return \`<h1>\${data.name}</h1>
$content\`;
  }
}

module.exports = MyTemplate;" > $page
done