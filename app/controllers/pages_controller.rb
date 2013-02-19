class PagesController < ApplicationController

  def home
    @title = "Home"
      if signed_in?
        @content = Content.new
        @contents = Content.all 
        @photos = Photo.all
        @everything = (@contents + @photos).sort_by(&:content_changed_at).reverse.paginate(page: params[:page], :per_page => 5)
        #render_nether("pages/contents")

        @comments = @everything.each do |content|
          content.comments
        end
        
        @search = Content.search(params[:search])
      end
      if signed_out?
        @contents = Content.all 
        @photos = Photo.all
        @everything = (@contents + @photos).sort_by(&:content_changed_at).reverse.paginate(page: params[:page], :per_page => 5)
        #render_nether("pages/contents")
      end
  end

  def contact
    @title = "Contact"
  end
  
  def about
    @title = "About"
    @page_url = url_for(options ={:only_path => false})
  end
  
  def help
    @title = "Help"
  end

  def contest
    @title = "Contest Instructions and Rules"
  end
end
