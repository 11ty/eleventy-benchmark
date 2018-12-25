module.exports = function({content}) {
	return `<!doctype html>
<html lang="en">
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>Eleventy JS Benchmark</title>
	</head>
	<body>
		${content}
	</body>
</html>`;
};