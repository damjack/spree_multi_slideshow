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
      @@slideshow = Spree::Slideshow.enable(params[:category]).try(:first)
      if @@slideshow.blank? || (!@@slideshow.blank? && @@slideshow.slides.enable.empty?)
        return ''
      end
      params[:pagination_class] ||= ""
      res = []
      
      res << content_tag(:ul, slide_images(params, @@slideshow), :class => "bxslider #{params[:class]}", :id => params[:id])
      res << "<script type='text/javascript'>
        $(function() {
          $('##{params[:id]}').bxSlider({
            auto: #{params[:auto]},
            adaptiveHeight: true,
            autoStart: #{@@slideshow.auto_start},
            mode: '#{@@slideshow.mode}',
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
            useCSS: true,
            pagerSelector: '#{params[:pagination_class]}'
          });
        });
        </script>"
      
      res.join.html_safe
    end

    def slide_images(params, slideshow)
      params[:style] ||= "medium"
      params[:show_content] ||= false
      slides = slideshow.slides.enable.sort_by { |slide| slide.position }
      
      slides.map do |slide|
        content_tag(:li, :class => "slides") do
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