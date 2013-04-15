TODO:
  default.html - delete #container, move styles to #main? #main needs .row

  Images next to posts in TAG archive

  absolute URLs in FEED, use regex to look for URL beggining with / (slash)

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
