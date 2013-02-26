SpreeMultiSlideshow
===================

Add multiple slideshow for Spree Commerce Shop [compatible with Amazon S3]


Basic Installation
------------------

1. Add the following to your Gemfile
<pre>
  gem 'spree_multi_slideshow', '~> 1.1.4'
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
	<%= insert_slideshow(:category => "my_category") %>
</pre>
displays slides for which the category column, dafault is "home"
<pre>
	<%= insert_slideshow(:style => "small") %>
</pre>
style layout for slideshow: [small, medium, slide, default => custom]
<pre>
	<%= insert_slideshow(:id => "slides", :class => "my_slide", :pagination_class => "pagination", :show_content => true) %>
</pre>
added class and id for slider, enable content slide

Copyright (c) 2012 [Damiano Giacomello], released under the New BSD License
