class Student < ActiveRecord::Base
  attr_accessible :barcode_number, :can_text, :cell_phone, :date_of_birth, :email, :first_name, :grade, :household_id, :is_male, :last_name, :photo, :status

  #Relationships
  belongs_to :household
  has_many :attendances
  has_many :registrations
  has_many :student_allergies
  has_many :allergies, :through => :student_allergies

  #Validations
  validates_presence_of :first_name, :last_name, :grade, :date_of_birth, :cell_phone
  validates :date_of_birth, :timeliness => {:on_or_before => lambda { Date.current }, :type => :date}
  
  #Scopes
  scope :active, where('active = ?', true)
  scope :inactive, where('active = ?', false)
  scope :alphabetical, order('last_name, first_name')
  validates_format_of :cell_phone, :with => /^\(?\d{3}\)?[-. ]?\d{3}[-.]?\d{4}$/, :allow_blank => true, :message => "should be 10 digits (area code needed) and delimited with dashes only"

  #Misc constants
  STATUS_LIST = [['Active', 'active'],['Inactive', 'inactive'],['College', 'college']]
  
  #Other methods
  def name
    "#{last_name}, #{first_name}"
  end
  
  def proper_name
    "#{first_name} #{last_name}"
  end
  
  def age
    (Time.now.to_s(:number).to_i - date_of_birth.to_time.to_s(:number).to_i)/10e9.to_i
  end
  
  # Callback code
  # -----------------------------
  private
  # We need to strip non-digits before saving to db
  def reformat_phone
    phone = self.phone.to_s # change to string in case input as all numbers
    phone.gsub!(/[^0-9]/,"") # strip all non-digits
    self.phone = phone # reset self.phone to new string
  end
  
end
