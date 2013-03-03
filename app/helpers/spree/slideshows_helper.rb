# encoding: UTF-8
module Spree
  module SlideshowsHelper
    
    def insert_slideshow(params={})
      params[:id] ||= "slideshow"
      params[:class] ||= "first_slideshow"
      params[:category] ||= "home"
      params[:auto] ||= false
      params[:next_text] ||= '>>'
      params[:prev_text] ||= '<<'
      params[:next_selector] ||= 'bx-next'
      params[:prev_selector] ||= 'bx-prev'
      @@slideshow = Spree::Slideshow.enable.find_by_category(params[:category])
      if @@slideshow.blank? || (!@@slideshow.blank? && @@slideshow.slides.empty?)
        return ''
      end
      params[:pagination_class] ||= "pagination"
      res = []
      
      res << content_tag(:div, content_tag(:div, slide_images(params, @@slideshow), :class => "slides_container"), :id => params[:id], :class => params[:class])
      res << "<script type='text/javascript'>
        $(function() {
          $('##{params[:id]}').bxSlider({
            auto: #{params[:auto]},
            autoStart: #{@@slideshow.auto_start},
            mode: #{@@slideshow.mode},
            controls: #{@@slideshow.enable_navigation},
            nextText: '#{params[:next_text]}',
            nextSelector: '#{params[:next_selector]}',
            prevText: '#{params[:prev_text]}',
            prevSelector: '#{params[:prev_selector]}',
            speed: 2000,
            pager: #{@@slideshow.enable_pagination},
            infiniteLoop: #{@@slideshow.infinite_loop},
            hideControlOnEnd: #{@@slideshow.hide_control_on_end},
            autoHover: true,
            pagerSelector: '#{params[:pagination_class]}'
          });
        });
        </script>"
      
      res.join.html_safe
    end

    def slide_images(params, slideshow)
      params[:style] ||= "medium"
      params[:show_content] ||= false
      max = slideshow.slides.enable.count
      slides = slideshow.slides.enable.limit(max).sort_by { |slide| slide.position }
      
      slides.map do |slide|
        content_tag(:div, :class => "slide_list") do
          divs = []
          
          divs << link_to(image_tag(slide.attachment.url(params[:style].to_sym)), (slide.url.blank? ? "javascript: void(0)" : slide.url), { :title => slide.title })
          if params[:show_content]
            divs << content_tag(:div, content_tag(:strong, raw(slide.title)) + content_tag(:p, raw(slide.presentation)), :class => "caption")
          end
          
          divs.join.html_safe
        end
      end.join.html_safe
    end
    
  end
end