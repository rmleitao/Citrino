class Admin::RolesController < Admin::Application
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
    format.html{redirect_to admin_roles_path}
  end
  create! do |format|
    format.html{redirect_to admin_roles_path}
  end

  protected
    def collection
      @items ||= end_of_association_chain.find(:all, :order => @options[:order]).paginate(:page => params[:page], :per_page => 10)
    end
    
    def set_options
      @options= {:per_page => 50, :order => 'created_at desc', :page_title => 'Papel',
                 :columns => ['name','authorizable_type','authorizable_id','created_at'], 
                 :show_actions => false, 
                 :skip_new => true, 
                 :submenu_partial=>'users'}
    end
end
