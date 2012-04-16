module Spree
  module SlideshowTypesHelper

    def insert_slideshow(params={})
      @content_for_head_added ||= false
      if not @content_for_head_added
        content_for(:head) { stylesheet_link_tag 'spree_multi_slideshow.css' }
        content_for(:head) { javascript_include_tag 'spree_multi_slideshow.js' }
        @content_for_head_added = true
      end
      if slide_images(params)
        navigation = enable_navigation(params)
        content_tag(:div, navigation[:prev] + content_tag(:div, content_tag(:ul, raw(slide_images(params))), :class => "frame") + navigation[:succ], :class => "gallery #{params[:class]}", :style => "width: #{Spree::SlideshowType.enable(params[:category] || "home").first.slide_width}px; height: #{Spree::SlideshowType.enable(params[:category] || "home").first.slide_height}px;")
      end
    end

    def slide_images(params)
      category = params[:category] || "home"
      style = params[:style] || "custom"
      slideshow = Spree::SlideshowType.enable(category)
      if !slideshow.blank?
        max = slideshow.first.slide_number || 4
        slides = Spree::Slide.where("slideshow_type_id = ?", slideshow.first.id).limit(max).sort_by { |slide| slide.position }

        slides.map do |slide|
          content_tag(:li, raw(link_to(image_tag(slide.attachment.url(style.to_sym)), slide.url, { :title => slide.title })) + raw(content_tag(:div, content_tag(:strong, raw(slide.title)) + content_tag(:p, raw(slide.content)), :class => "text-holder")))
        end.join
      else
        false
      end
    end

    def enable_navigation(params)
      container_nav = params[:container_navigation] || nil
      cl_nav_container = params[:class_navigation_container].split(",") || nil
      cl_nav_link = params[:class_navigation_link].split(",") || nil
      category = params[:category] || "home"
      slideshow = Spree::SlideshowType.enable(category)
      if !slideshow.blank?
        if slideshow.first.enable_navigation
          prev = link_to("prev", "#", :class => "prev #{cl_nav_link[0]}")
          succ = link_to("next", "#", :class => "next #{cl_nav_link[1]}")
        else
          prev = ""
          succ = ""
        end
        
        unless container_nav.blank?
          prev = content_tag(container_nav.to_sym, prev, :class => cl_nav_container[0])
          succ = content_tag(container_nav.to_sym, succ, :class => cl_nav_container[1])
        end
        
        res = Hash.new()
        res[:prev] = prev
        res[:succ] = succ
        return res
      end
    end
    
  end
end