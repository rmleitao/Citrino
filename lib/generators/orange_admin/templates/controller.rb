class Admin::<%=target_class_plural%>Controller < Admin::Application
  before_filter :set_options
  
  index! do |format|
    format.html{ render_admin_view("index") }        
  end
  edit! do |format|
    format.html{ render_admin_view("edit") }        
  end 
  new! do |format|
    format.html{ render_admin_view("new") }        
  end
  update! do |format|
    format.html{redirect_to admin_<%=targets%>_path}
  end
  create! do |format|
    format.html{redirect_to admin_<%=targets%>_path}
  end

  protected
    def collection
      @items ||= end_of_association_chain.find(:all, :order => @options[:order]).paginate(:page => params[:page], :per_page => 10)
    end
    
    def set_options
 
         
      @options= {:per_page => 50, :order => 'created_at desc', :page_title => '<%= target_class.constantize.human_name %>',
                 :columns => [<%= column_names.join(",") %>], 
                 :show_actions => true, 
                 :skip_new => false, 
                 :submenu_partial=>false}
    end
end
