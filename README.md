SpreeMultiSlideshow
===================

Add multiple slideshow for Spree Commerce Shop [compatible with Amazon S3]


Basic Installation
------------------

1. Add the following to your Gemfile
<pre>
  gem 'spree_multi_slideshow', '~> 1.2.2'
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
	<%= insert_slideshow() %>
</pre>
add slides for the slideshow in the admin section
2. Additional options:
<pre>
	{
		:id => "slideshow"
		:class => "first_slideshow"
		:category => "my_category"
		:style => "custom"
		:auto => true|false
		:next_text => ">>"
		:prev_text => "<<"
		:next_selector => "bx-next"
		:prev_selector => "bx-prev"
		:pagination_class => "pagination"
		:show_content => true|false
	}
</pre>

Copyright (c) 2012 [Damiano Giacomello], released under the New BSD License
