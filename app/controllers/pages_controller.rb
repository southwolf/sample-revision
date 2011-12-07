class PagesController < ApplicationController
  def home
  	@title = "Home"
  end

  def contact
  	@title = "Contact"
    drop_breadcrumb("Contact")
  end

  def about
  	@title = "About"
    drop_breadcrumb("About")
  end

  def help
  	@title = "Help"
    drop_breadcrumb("Help")
  end
end
