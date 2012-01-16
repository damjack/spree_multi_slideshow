SpreeMultiSlideshow
===================

Add multiple slideshow for Spree Commerce


Basic Installation
------------------

1. Add the following to your Gemfile
<pre>
  gem 'spree_multi_slideshow', :git => 'github.com/damianogiacomello/spree_multi_slideshow'
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


Copyright (c) 2012 [Damiano Giacomello], released under the New BSD License
