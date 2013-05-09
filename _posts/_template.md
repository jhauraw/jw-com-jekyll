---
# REQUIRED: layout, published, category, title, excerpt
layout: (post|page|home)
published: (true|false)
category: (web-development|internet-marketing|workflow|lifestyle|business|news)
title:
author:
  name:
  link:
feature:
  # required for video, audio and gallery
  image:
    # /DIR/YYYY/NAME.ext. Absolute or Relative URL. Optimum size 16:9, 960 x 540
    src:

  video:
    aspect: (normal|wide)
    host: (self|youtube|vimeo)
    src: # video source URL

  audio:
    src: # audio source URL

  gallery:
    items: # YAML array of gallery images
      -
        src: # image source URL, e.g., /media/YYYY/dog.jpg
        caption: # textual information about image
      -
        src:
        caption:
      -
        src:
        caption:
excerpt: |
  Your excerpt here, 255 chars max.
---