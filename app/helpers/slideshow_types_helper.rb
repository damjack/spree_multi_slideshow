module SlideshowTypesHelper

  def insert_slideshow(params={})
    @content_for_head_added ||= false
    if not @content_for_head_added
      content_for(:head) { stylesheet_link_tag 'spree_multi_slideshow.css' }
      content_for(:head) { javascript_include_tag 'spree_multi_slideshow.js' }
      @content_for_head_added = true
    end
    content_tag :div, link_to("prev", "#", :class => "prev") + content_tag(:div, content_tag(:ul, slide_images(params)), :class => "frame") + link_to("next", "#", :class => "next"), :class => "gallery playing"
  end

  def slide_images(params)
    max = params[:max] || 5
    category = params[:category] || "home"
    slideshow = SlideshowType.enable(category)
    slides = slideshow.slides.sort_by { |slide| slide.position }

    slides.map do |slide|
      content_tag(:li, link_to(image_tag(slide.image.url(:slide)), slide.url, { :title => slide.title }) + content_tag(:div, content_tag(:strong, raw(slide.title)), :class => "text-holder"))
    end.join

  end

end