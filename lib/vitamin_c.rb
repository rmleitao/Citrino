module VitaminC
  def self.included(base)
    base.class_eval {
      # useful
      has_permalink :name 
      #scopes
      named_scope :active, :conditions => { :state=>'active'}
      named_scope :by_permalink, proc { |permalink| { :conditions => {  :permalink => permalink } } }
      named_scope :newest, :order => "created_at DESC"
      named_scope :freshest, :order => "updated_at DESC"
      named_scope :limit, lambda { |limit| {:limit => limit} }
    }
  end
    
  def initialize(attribs={})
    super(attribs)
    self.state = 'active' unless self.state.present?
    self
  end
  
  def is_active?
    return self.state=="active"
  end
end