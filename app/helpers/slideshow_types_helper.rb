module SlideshowTypesHelper

  def insert_slideshow(params={})
    @@slideshow = SlideshowType.enable.find_by_category(params[:category])
    if @@slideshow.blank? || (!@@slideshow.blank? && @@slideshow.slides.empty?)
      return ''
    end
    res = []
    
    res << content_tag(:div, content_tag(:ul, slide_images(params, @@slideshow), :class => "bxslider"), :class => "slideshow")
    res << "<script type='text/javascript'>
    $(function() {
      $('.bxslider').bxSlider({
          adaptiveHeight: true,
          controls: #{@@slideshow.enable_navigation},
          autoStart: false,
          infiniteLoop: false,
          hideControlOnEnd: true
        });
      });
    </script>"
    
    res.join.html_safe
  end
  
  def slide_images(params, slideshow)
    params[:style] ||= "custom"
    params[:show_content] ||= false
    max = slideshow.slide_number || slideshow.slides.count
    slides = slideshow.slides.limit(max).sort_by { |slide| slide.position }

    slides.map do |slide|
      content_tag(:li, :class => "slide") do
        divs = []

        divs << link_to(image_tag(slide.attachment.url(params[:style].to_sym)), (slide.url.blank? ? "javascript: void(0)" : slide.url), { :title => slide.title })
        if params[:show_content]
          divs << content_tag(:div, content_tag(:strong, raw(slide.title)) + content_tag(:p, raw(slide.content)), :class => "text-holder")
        end

        divs.join.html_safe
      end
    end.join.html_safe
  end
end