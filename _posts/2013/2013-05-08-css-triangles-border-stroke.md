---
layout: post
published: true
category: web development
title: CSS Triangles with Border Stroke and Fill
feature:
  image:
    src: /media/2013/css-triangles-border-stroke.png
excerpt: |
  How to quickly and easily create 100% pure CSS triangles with border stroke and color fill. No images, no font-icons and no JavaScript needed. Useful for navigation and pointer UI elements.
---

How to quickly and easily create 100% pure CSS triangles with border stroke and color fill. No images, no font-icons and no JavaScript needed. Useful for navigation and pointer UI elements.

Often, to achieve this effect, an image or font-icon is used, because in the normal CSS triangle markup you can't add a stroke color. As you might guess, a pure CSS solution eliminates the overhead associated with external resources.

By combining the CSS pseudo-classes `:before` and `:after` you can achieve the same effect in a pure CSS solution.

### Example Result

In the rendered example below we have a block element that is styled like a box-header and a downward facing triangle with different color __stroke__ and __fill__.

For kicks, we'll call the downward-facing triangle a _nubbin_ (I've seen it called that elsewhere, so not my term, but a fun way of referring to this UI pointer).

<style type="text/css">
.tri-down {
    position: relative;
    margin-bottom: 2em;
    padding: 1em;
    border-bottom: 1px solid #999;
    background: #f3f3f3;
  }
  .tri-down:before, .tri-down:after {
    content: "";
    position: absolute;
    width: 0;
    height: 0;
    border-style: solid;
    border-color: transparent;
    border-bottom: 0;
  }
  .tri-down:before {
    bottom: -16px;
    left: 21px;
    border-top-color: #777;
    border-width: 16px;
  }
  .tri-down:after {
    bottom: -15px;
    left: 22px;
    border-top-color: #f3f3f3;
    border-width: 15px;
  }
</style>

<div class="tri-down">Box with Down Triangle a.k.a. "Nubbin"</div>

### Example CSS and HTML Markup

Here is the CSS and HTML markup you need to create this effect in your own project.

{% highlight css linenos %}
<style type="text/css">
.tri-down {

    /* Styling block element, not required */
    position: relative;
    margin-bottom: 2em;
    padding: 1em;
    border-bottom: 1px solid #999;
    background: #f3f3f3;
  }

  /* Required for Down Triangle */
  .tri-down:before, .tri-down:after {
    content: "";
    position: absolute;
    width: 0;
    height: 0;
    border-style: solid;
    border-color: transparent;
    border-bottom: 0;
  }

  /* Stroke */
  .tri-down:before {
    bottom: -16px;
    left: 21px;

    /* If 1px darken stroke slightly */
    border-top-color: #777;
    border-width: 16px;
  }

  /* Fill */
  .tri-down:after {
    bottom: -15px;
    left: 22px;
    border-top-color: #f3f3f3;
    border-width: 15px;
  }
</style>
{% endhighlight %}

{% highlight html linenos %}
<!-- Element you want to add a down triangle too. -->
<div class="tri-down">Box with Down Triangle a.k.a. "Nubbin"</div>
{% endhighlight %}

#### Notes and Tips

  - Style the `.tri-down` element any way you like. A `border-bottom` to match the _nubbin_ bottom connects unifies the two items.

  - Stroke: Increase the `.tri-down:before` &raquo; `bottom` and `border-width` values so that they are different than your fill dimensions by whatever stroke width you want. In the example above, I have chosen a stroke of `1px`. Do the opposite with your stroke `left` value.

  - Stroke: When using `1px` strokes, slightly darken `.tri-down:before` &raquo; `border-top-color` compared to the `.tri-down` &raquo; `border-bottom-color`. At `1px` the _nubbin_ is slightly lighter than it should be because of the angle of the sides.

As you might imagine, by varying the border sides you can easily create upward and sideways facing triangles using this same technique.
