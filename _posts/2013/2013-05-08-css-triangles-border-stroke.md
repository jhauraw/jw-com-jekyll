---
layout: post
published: true
category: web development
title: CSS Triangles with Border Stroke and Fill
excerpt: |
  CSS Triangles with Border Stroke and Fill
---

WIP.

{% highlight scss linenos %}
.tri-down {

  &:before, &:after {
    content: "";
    position: absolute;
    width: 0;
    height: 0;
    border-style: solid;
    border-color: transparent;
    border-bottom: 0;
  }

  &:before {
    bottom: -16px;
    left: 21px;
    border-top-color: #d6d6d6;
    border-width: 16px;
  }

  &:after {
    bottom: -15px;
    left: 22px;
    border-top-color: #fff;
    border-width: 15px;
  }
}
{% endhighlight %}