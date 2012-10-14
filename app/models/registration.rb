class Registration < ActiveRecord::Base
  attr_accessible :program_id, :student_id, :group_id

  #Relationships
  belongs_to :group
  belongs_to :program
  belongs_to :student
  
  validates_presence_of :program, :group, :student

  
end
