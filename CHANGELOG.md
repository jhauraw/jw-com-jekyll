TODO:

  Tag Pagination:
  https://github.com/ilyakhokhryakov/jekyll-tagging-pagination/blob/master/tags-pagination.rb

  http://realjenius.com/2012/12/01/jekyll-category-tag-paging-feeds/

  http://www.marran.com/tech/category-pagination-in-jekyll/

  http://www.nearinfinity.com/blogs/brandon_marc_aurele/2012/06/14/generating-jekyll-pages-with-pagination.html

  http://stackoverflow.com/questions/15423665/jekyll-paginate-blog-as-subdirectory
  https://github.com/MrWerewolf/jekyll-category-pagination

  flatterline jekyll github source for their blog
  blitz.io 0-250 in 10s, then sustain 250 for 50s

<ul class="navigation">
  {% for link in site.navigation %}
    {% assign current = nil %}
    {% if page.url == link.url or page.layout == link.layout %}
      {% assign current = 'current' %}
    {% endif %}

    <li class="{% if forloop.first %}first{% endif %} {{ current }} {% if forloop.last %}last{% endif %}">
      <a class="{{ current }}" href="{{ link.url }}">{{ link.text }}</a>
    </li>
  {% endfor %}
</ul>

{% for post in site.categories.photo %}
    # render the photo post html
{% endfor %}
