class Register
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  
  attr_accessor :title, :fname, :lname, :email, :landline, :mobile, :spid, :crn, :mail,:phone,:email1, :none, :policy, :terms
  TITLE = ["Mr", "Ms", "Miss", "Mrs", "Dr"]
  validates_presence_of :title, :message => "is a required field"
  validates_presence_of :fname, :message => "is a required field"
  validates_presence_of :lname, :message => "is a required field" 
  validates_presence_of :email, :message => "is a required field"
  validates_presence_of :spid, :message => "is a required field"
  validates_presence_of :crn, :message => "is a required field"
  
  validates_format_of :email, :with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{1,5}$/i , :message => "Please enter a valid email address"
  validates_numericality_of :landline, :unless => proc{|obj| obj.landline.blank?}
  
  validates_numericality_of :mobile, :unless => proc{|obj| obj.mobile.blank?}
  validates_inclusion_of :title , :in => TITLE, :message => 'Please enter either "Mr", "Ms", "Miss", "Mrs" or "Dr" '
  validate :at_least_one_checkbox_checked
  validate :terms_and_policy
 # validate :sp_validate
  
    
  def at_least_one_checkbox_checked
    #lets say that the checkboxes are used to set field1, field2 and field3, true or false
    unless self.mail == "1" || self.phone == "1"|| self.email1 =="1"|| self.none =="1"
      errors.add(:base, "You must select at least one option: mail, phone, email or none")
    end
  end
  def terms_and_policy
    unless self.terms == "1"
      errors.add(:base,  "You must agree to the terms and conditions")
    end
    unless self.policy == "1"
      errors.add(:base, "You must agree with the privacy policy")
    end
  end
  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end
  def check_title
    unless self.title == "Mr" || self.title == "Ms" || self.title == "Mrs" || self.title == "Dr" || self.title == "Miss"
      errors.add(:base, "Title is a required field")
      return false
    end
  end
  def persisted?
    false
  end
  
  def landline_xor_mobile
    if (landline.blank? and mobile.blank?)
      errors.add(:base,"Enter either telephone or mobile number or both")
    end
  end
  def sp_validate
    errors.add(:base, "Please enter a valid supply point ID") unless spid_valid?(spid, :spid)
  end
  def spid_valid?(spid, val)
    p "spid" , :spid
      spid1 = Salesforce::Site.find_by_spid__c(spid)
      spid1 == val ? true :false rescue false
  end
      
end