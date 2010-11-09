class OrangeAdminGenerator < Rails::Generator::NamedBase
  
  attr_reader :target, :targets, :target_class, :target_class_plural, :column_names

  def initialize(runtime_args, runtime_options = {})
    super
    @targets = file_name.downcase.pluralize
    @target = file_name.downcase
    @target_class= file_name.capitalize
    @target_class_plural=file_name.pluralize.capitalize
    
    @column_names=[]
    @target_class.camelize.constantize.columns.reject do |attribute|
      @column_names << attribute.name.to_s
    end
  end
  def column_names_array
    arr=[]
    @column_names.each do |att|
      arr<< "'#{att}'"
    end
    arr
  end
      
  def manifest
    #TODO
    #there must be a better way to pass variables!
    record do |m|
     # Controllers
     m.template "controller.rb", "app/controllers/admin/#{@targets}_controller.rb", :assigns => { :target => @target, :targets=>@targets, :target_class=>@target_class, :target_class_plural=>@target_class_plural, :column_names=>column_names_array }

     # create the directory
     m.directory "app/views/admin/#{@targets}"
       
     # Views
     m.template "_form.html.erb", "app/views/admin/#{@targets}/_form.html.erb", :assigns => { :target => @target, :targets=>@targets, :target_class=>@target_class, :target_class_plural=>@target_class_plural, :column_names=>@column_names }
     
    end
  end
end