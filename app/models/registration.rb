class Registration < ActiveRecord::Base
  attr_accessible :student_id, :section_id

  #Relationships
  belongs_to :section
  belongs_to :student
  
  has_one :program, :through => :section
  
  #Validations
  validates_presence_of :program_id, :group_id, :student_id
  validates_numericality_of :program_id, :student_id, :group_id, :greater_than_or_equal_to => 0

end
