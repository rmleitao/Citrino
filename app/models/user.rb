class User < ActiveRecord::Base
  acts_as_authentic
  acts_as_authorization_subject

  validates_presence_of :first_name, :last_name

  named_scope :admins, :conditions => { :has_role_admin => true }


  def deliver_password_reset_instructions!
    reset_perishable_token!
    Notifier.deliver_password_reset_instructions(self)  
  end
  
  def has_role_admin
    self.has_role? :admin
  end

  def has_role_admin=(flag)
    logger.debug("FLAG #{flag}")
    flag == true ? self.has_role!(:admin) : self.has_no_role!(:admin)
  end
     
  def name
    "#{self.first_name}, #{self.last_name}"
  end
  
  def created_at_formatted
    I18n.l(self.created_at.localtime, :format => "%e %B %Y") if self.created_at.present?
  end
  
  def last_login_at_formatted 
    self.last_login_at ? I18n.l(self.last_login_at.localtime, :format => "%e %B %Y") : "-"
  end
end
