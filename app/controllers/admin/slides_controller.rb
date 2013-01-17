class Admin::SlidesController < Admin::ResourceController
  before_filter :load_data

  def update_positions
    params[:positions].each do |id, index|
      Slide.update_all(['position=?', index], ['id=?', id])
    end

    respond_to do |format|
      format.js  { render :text => 'Ok' }
    end
  end

  private
  def location_after_save
    admin_slideshow_type_slides_url(@slideshow_type)
  end
  
  def load_data
    @slideshow_type = SlideshowType.find(params[:slideshow_type_id])
  end
end
