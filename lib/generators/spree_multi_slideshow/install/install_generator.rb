module SpreeMultiSlideshow
  module Generators
    class InstallGenerator < Rails::Generators::Base
      
      def add_formtastic
        res = ask "Would you like to run the formtastic install now? [Y/n]"
        if res == "" || res.downcase == "y"
          run 'rails generate formtastic:install'
        else
          puts "Skiping rails generate formtastic:install, don't forget to run it!"
        end
      end
      
      def add_javascripts
        append_file "app/assets/javascripts/store/all.js", "//= require store/spree_multi_slideshow\n"
        #append_file "app/assets/javascripts/admin/all.js", "//= require admin/spree_multi_slideshow\n"
      end

      def add_stylesheets
        inject_into_file "app/assets/stylesheets/store/all.css", " *= require store/spree_multi_slideshow\n", :before => /\*\//, :verbose => true
        inject_into_file "app/assets/stylesheets/admin/all.css", " *= require admin/spree_multi_slideshow\n", :before => /\*\//, :verbose => true
      end

      def add_migrations
        run 'bundle exec rake railties:install:migrations FROM=spree_multi_slideshow'
      end

      def run_migrations
         res = ask "Would you like to run the migrations now? [Y/n]"
         if res == "" || res.downcase == "y"
           run 'bundle exec rake db:migrate'
         else
           puts "Skiping rake db:migrate, don't forget to run it!"
         end
      end
      
      def add_ckeditor
        res = ask "Would you like to run the ckeditor generator now? [Y/n]"
        if res == "" || res.downcase == "y"
          run 'rails generate ckeditor:install --orm=active_record --backend=paperclip'
        else
          puts "Skiping rails generate ckeditor:install --orm=active_record --backend=paperclip, don't forget to run it!"
        end
      end
      
    end
  end
end
