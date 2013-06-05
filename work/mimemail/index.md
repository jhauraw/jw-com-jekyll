---
layout: page
subtype: project
title: Mime Mail PHP Class
skills: [php, oop, mime, rfc2821]
excerpt: |
  PHP Class object for use in generating RFC MIME compliant email message headers and bodies. Supports plain text, HTML or Multipart message formats.
---

[![MimeMail PHP Class]({{ '/media/work/2004/mimemail-php-class.png' | to_cdnurl }})](https://github.com/jhauraw/mimemail)

PHP Class object for use in generating __RFC 2821 MIME__ compliant email message headers and bodies. Supports _plain text_, _HTML_ or _Multipart_ message formats.

Simple clear methods allow you to quickly generate one-off or personalized messages en masse. Works with PHP's `mail()` function or MTAs like qmail and Sendmail.

__Returns__

  - String headers formatted to RFC 2821 MIME specifications
  - String body with optional quoted-printable encoding (recommended for HTML messages)

__Released__: May 2004  
__Skills__: {% for s in page.skills %}<span class="label secondary radius">{{ s }}</span> {% endfor %}  
__Project URL__: <https://github.com/jhauraw/mimemail>

### Example: Create HTML Multipart MIME Message

Create a new instance of the `MimeMail` class:

```php
<?php
  $hpart =& $mmime->part(array(
    'type'     => 'text/html',
    'data'     => $htmlmsg,
    'charset'  => 'iso-8859-1',
    'encoding' => 'quoted-printable'));

  echo $mmime->hdrs2Str();
  echo "\n";
  echo $mmime->body2Str();
?>
```

Print statement `echo $mmime->hdrs2Str();` outputs:

```html
MIME-Version: 1.0
Date: Fri,  7 May 2004 20:10:07 -0700 (PDT)
Content-Type: multipart/alternative;
    boundary="_----=_Part_278ec89a148a9ff6fd2faf2e9798d0db_"

This is a multi-part message in MIME format.
```

Print statement `$mmime->body2Str();` outputs:

```html
--_----=_Part_278ec89a148a9ff6fd2faf2e9798d0db_
Content-Type: text/plain;
    charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Length: 91

Hello World,

Messages created with MimeMail are RFC compliant!

All the best,

The Author

--_----=_Part_278ec89a148a9ff6fd2faf2e9798d0db_
Content-Type: text/html;
    charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Length: 235

<html>
  <head>
    <title>MIME Class 1.0 Documentation HTML Example</title>
  </head>

  <body>
    <b>Hello World</b>,
    <p>
      Messages created with MimeMail are RFC compliant!
    </p>
    All the best,
    <br />
    The Author
  </body>
</html>

--_----=_Part_278ec89a148a9ff6fd2faf2e9798d0db_--
```

See the documentation via the _Project URL_ above for full usage and examples.
