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
    
    def insert_carousel(params={})
      params[:id] ||= "carousel"
      params[:class] ||= "first_carousel"
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
      
      res << content_tag(:ul, carousel_images(params, @@slideshow), :class => "bxslider #{params[:class]}", :id => params[:id])
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
    
    def carousel_images(params, slideshow)
      params[:style] ||= "medium"
      slides = slideshow.slides.enable.sort_by { |slide| slide.position }
      
      slides.map do |slide|
        content_tag(:li, :class => "item") do
          divs = []
          
          divs << link_to(image_tag(slide.attachment.url(params[:style].to_sym)), (slide.url.blank? ? "javascript: void(0)" : slide.url), { :title => slide.title })          
          divs.join.html_safe
        end
      end.join.html_safe
    end
    
    def insert_carousel_taxon(params={})
      params[:type] ||= "bxslier"
      params[:id] ||= "carousel"
      params[:class] ||= "first_carousel"
      params[:category] ||= "home"
      params[:auto] ||= false
      params[:auto_start] ||= false
      params[:mode] ||= 'horizontal'
      params[:enable_navigation] ||= true
      params[:enable_pagination] ||= false
      params[:next_text] ||= '>>'
      params[:prev_text] ||= '<<'
      params[:next_selector] ||= 'bx-next'
      params[:prev_selector] ||= 'bx-prev'
      params[:item_width] ||= 120
      params[:item_margin] ||= 5
      @@taxon = Spree::Taxon.find_by_permalink!(params[:taxon])
      if @@taxon.blank? || (!@@taxon.blank? && @@taxon.children.empty?)
        return ''
      end
      params[:pagination_class] ||= ""
      res = []
      
      if params[:type] == "bxslider"
        res << content_tag(:ul, carousel_taxon_images(params, @@taxon), :class => "#{params[:class]}", :id => params[:id])
        res << "<script type='text/javascript'>
          $(function() {
            $('##{params[:id]}').bxSlider({
              auto: #{params[:auto]},
              adaptiveHeight: true,
              autoStart: #{params[:auto_start]},
              mode: '#{params[:mode]}',
              controls: #{params[:enable_navigation]},
              nextText: '#{params[:next_text]}',
              nextSelector: '#{params[:next_selector]}',
              prevText: '#{params[:prev_text]}',
              prevSelector: '#{params[:prev_selector]}',
              speed: 2000,
              pager: false,
              infiniteLoop: true,
              hideControlOnEnd: false,
              autoHover: true,
              useCSS: true,
              pagerSelector: '#{params[:pagination_class]}'
            });
          });
          </script>"
      else
        res << content_tag(:div, content_tag(:ul, carousel_taxon_images(params, @@taxon), :class => "slides"), :class => "#{params[:class]}", :id => params[:id])
        res << "<script type='text/javascript'>
          $(function() {
            $('##{params[:id]}').flexslider({
              itemWidth: #{params[:item_width]},
              animation: 'slide',
              animationLoop: false,
              controlNav: #{params[:enable_pagination]},
              itemMargin: #{params[:item_margin]}
            });
          });
          </script>"
      end
      
      res.join.html_safe
    end
    
    def carousel_taxon_images(params, taxon)
      items = taxon.children
      
      items.map do |item|
        content_tag(:li, :class => "item") do
          divs = []
          
          divs << link_to(image_tag(item.icon.url()), seo_url(item), { :title => item.name })
          divs.join.html_safe
        end
      end.join.html_safe
    end
    
  end
end