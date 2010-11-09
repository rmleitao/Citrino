class Admin::Application < ApplicationController

  layout 'admin'
  inherit_resources
  include InheritedResources::DSL
  
   
  access_control do
   default :deny

   allow :admin
  end

  private
    def render_admin_view(filename)
     override = File.join(controller_full_path, "#{filename}.html.erb")
     override= "/admin/shared/templates/#{filename}" if !File.exists?(override)
     logger.debug("OVERRIDE #{override}")
     render :template => override
    end
  
    helper_method :controller_full_path
    def controller_full_path
      File.join 'app/views', self.controller_path
    end
  
    # Admin panel required SSL by default
    def ssl_required?
      #true
      false
    end

end
