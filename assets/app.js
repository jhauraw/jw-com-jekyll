/*! jhaurawachsman.com - v0.9.0 - 2013-05-14 - http://jhaurawachsman.com/ - Copyright (c) 2013  - Licensed GPLv3, CC BY 3.0 */function getParameterByName(t){var e="[\\?&]"+t+"=([^&#]*)",i=RegExp(e),s=i.exec(window.location.search);return null==s?"":decodeURIComponent(s[1].replace(/\+/g," "))}(function(t){var e=getParameterByName("q");void 0!==e&&t("#q").val(e)})(window.Zepto||window.jQuery),function(t){"use strict";t.extend(t.fn,{navmenu:function(){var e,i,s=t(".navsection"),n=t(".navmenu"),o=t(".navmenu>li.submenu");t(o).mouseenter(function(){e=t(this).children(".submenu-content"),i=n.find(".submenu.active, .submenu.locked").length>0,n.find(".submenu").removeClass("active locked"),t(this).addClass("active locked"),i||(window.Zepto?e.animate({translate:"0, -300px"},0):e.css({transform:"translate(0, -300px)"}),setTimeout(function(){window.Zepto?e.animate({translate:"0, 0"},290):e.css({transition:"all 290ms linear",transform:"translate(0,0)"})},0))}),t(s).mouseleave(function(){s.find(".submenu").removeClass("active locked")})}})}(window.Zepto||window.jQuery),function(t){"use strict";t.extend(t.fn,{panelexpose:function(){var e=t("meta[name=viewport]"),i=t("html, body"),s=t(".toggle-menu a"),n=t("#peek"),o=t("#sticky"),a=t("#scrollable"),r=t("#navpanel");window.Zepto&&t(a).swipeRight(function(){n.hasClass("expose")||s.trigger("click")}).swipeLeft(function(){n.hasClass("expose")&&s.trigger("click")}),s.click(function(s){s.preventDefault(),n.toggleClass("expose"),n.hasClass("expose")?(r.show(),window.Zepto?n.animate({translate:"250px, 0"},150):n.css({transition:"all 150ms linear",transform:"translate(250px ,0)"}),a.click(function(s){t(this).clean(i,e,n,o,a,r,s)})):t(this).clean(i,e,n,o,a,r,s)})},clean:function(t,e,i,s,n,o){window.Zepto?i.animate({translate:"0, 0"},150):i.css({transition:"all 150ms linear",transform:"translate(0 ,0)"}),setTimeout(function(){i.css("-webkit-transform","none").css("-webkit-transform","").removeClass("expose"),o.hide()},300)}})}(window.Zepto||window.jQuery),function(t){"use strict";t.extend(t.fn,{iosfix:function(){var e=t("#sticky"),i=t("#navpanel");return/(ip(hone|od|ad))/i.test(navigator.userAgent)?(t('input[type="text"], input[type="password"], input[type="search"], textarea').css("font-size","1em"),t("input").focus(function(){e.add(i).css("position","absolute")}).blur(function(){}),window.addEventListener("load",function(){setTimeout(function(){window.scrollTo(0,1)},0)}),void 0):!1}})}(window.Zepto||window.jQuery),$(document).foundation(),$(document).navmenu(),$(document).panelexpose(),$(document).iosfix();