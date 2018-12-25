class MyIndexPage {
	get data() {
		return {
			layout: "layout.11ty.js"
		};
	}

	render(data) {
		return `<h1>Liquid Collection List</h1>
<ul>
${data.collections.nameSorted.map(page => {
	return `  <li><a href="${page.url}">${page.data.name}</a></li>`;
}).join("\n")}
</ul>`;
	}
}

module.exports = MyIndexPage;