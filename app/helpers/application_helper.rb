# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  # Yield the content for a given block. If the block yiels nothing, the optionally specified default text is shown. 
  #
  #   yield_or_default(:user_status)
  #
  #   yield_or_default(:sidebar, "Sorry, no sidebar")
  #
  # +target+ specifies the object to yield.
  # +default_message+ specifies the message to show when nothing is yielded. (Default: "")
  def yield_or_default(message, default_message = "")
    message.nil? ? default_message : message
  end
    
  # Return true if the currently logged in user is an admin
  def admin?
    logged_in? && current_user.has_role?(:admin)
  end
  
  # Write a secure email adress
  def secure_mail_to(email)
    mail_to email, nil, :encode => 'javascript'
  end
  
  #DRY flash messages
  def flash_message
    messages = ""
    [:notice, :info, :warning, :error].each do|type|
      messages= "<div id=\"#{type}\">#{flash[type]}</div>" if flash[type]
    end
    messages
  end

  #write date in pt format
  def data_pt(date)
    "#{date.strftime("%d/%m/%Y")}" unless date.nil?
  end
   
end
