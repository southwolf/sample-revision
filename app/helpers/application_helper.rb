module ApplicationHelper
	def title
		base_title = "Sample App Revision"
    if @title.nil?
      title = base_title
    else
      title = "#{base_title} | #{@title}"
    end
	end
end
