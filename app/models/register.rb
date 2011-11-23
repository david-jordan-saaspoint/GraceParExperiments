class Register
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  
  attr_accessor :title, :fname, :lname, :email, :landline, :mobile, :spid, :crn
  
  validates_presence_of :title, :fname, :lname, :email,  :spid, :crn
  validates_format_of :email, :with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i
  validates_numericality_of :landline, :unless => proc{|obj| obj.landline.blank?}
  validates_numericality_of :mobile, :unless => proc{|obj| obj.mobile.blank?}
  validate :landline_xor_mobile
  
  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end
  
  def persisted?
    false
  end
  
  def landline_xor_mobile
    if !(landline.blank? ^ mobile.blank?)
      errors.add_to_base("Enter either landline or mobile number or both")
    end
  end

  
end
