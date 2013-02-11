# encoding: UTF-8

module Spree
  module SlideshowTypesHelper
    
    def insert_slideshow(params={})
      params[:id] ||= "slides"
      params[:class] ||= "my_slide"
      params[:category] ||= "home"
      logger.info("#{params[:category]}")
      @@slideshow = Spree::SlideshowType.enable(params[:category]).try(:first)
      if @@slideshow.blank? || (!@@slideshow.blank? && @@slideshow.slides.empty?)
        return ''
      end
      params[:pagination_class] ||= "pagination"
      params[:slide_speed] ||= 350
      res = []
      
      res << content_tag(:div, content_tag(:div, slide_images(params, @@slideshow), :class => "slides_container"), :id => params[:id], :class => params[:class])
      res << "<script type='text/javascript'>
        $(function() {
          $('##{params[:id]}').slides({
            play: 100000,
            preload: true,
            generateNextPrev: #{@@slideshow.enable_navigation},
            generatePagination: #{@@slideshow.enable_pagination},
            paginationClass: '#{params[:pagination_class]}',
            slideSpeed: #{params[:slide_speed]}
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
        content_tag(:div, :class => "slide_list") do
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
end