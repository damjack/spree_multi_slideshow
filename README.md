SpreeMultiSlideshow
===================

Add multiple slideshow for Spree Commerce Shop


Basic Installation
------------------

1. Add the following to your Gemfile
<pre>
  gem 'spree_multi_slideshow', :git => 'git://github.com/damianogiacomello/spree_multi_slideshow'
</pre>
2. Run `bundle install`
3. To copy and apply migrations run:
<pre>
	rails g spree_multi_slideshow:install
</pre>

Example
=======

1. add slideshow helper method in your view:
<pre>
	<%= insert_slideshow %>
</pre>
add slides for the slideshow in the admin section

2. Additional options:
<pre>
	<%= insert_slideshow :category => "home" %>
</pre>
displays slides for which the groups column is empty or includes the value "home"
<pre>
	<%= insert_slideshow :max => 10 %>
</pre>
limits the number of slides shown to 10 (default 4)

Copyright (c) 2012 [Damiano Giacomello], released under the New BSD License
