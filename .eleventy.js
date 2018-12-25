module.exports = function(eleventyConfig) {
	eleventyConfig.setUseGitIgnore(false);

	eleventyConfig.addCollection("nameSorted", function(collection) {
		return collection.getFilteredByTag("name").sort(function(a, b) {
			return parseInt(a.data.index, 10) - parseInt(b.data.index, 10);
		});
	});

	// return {
	// 	markdownTemplateEngine: false
	// }
};