---
layout: layout.liquid
---
# Markdown Collection List

{%- for page in collections.nameSorted %}
 * [{{ page.data.name }}]({{ page.url }})
{%- endfor %}
