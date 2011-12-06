module ApplicationHelper
	def title
		base_title = "Sample App"
    if @title.nil?
      title = base_title
    else
      title = "#{base_title} | #{@title}"
    end
	end
end
