module ApplicationHelper
	def title
		base_title = "Sample App Revision"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
	end

  def notice_message
    flash_messages = []

    flash.each do |type, message|
      type = :success if type == :notice
      text = content_tag(:div, link_to("x", "#", :class => "close") + message, :class => "alert-message #{type} fade in", "data-alert" => "alert")
      flash_messages << text if message
    end

    flash_messages.join("\n").html_safe
  end
end
