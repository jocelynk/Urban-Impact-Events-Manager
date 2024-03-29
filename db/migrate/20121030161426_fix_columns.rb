class FixColumns < ActiveRecord::Migration
  def change
    #rename column from typo
    rename_column :events, :meals_server, :meals_served
    
    #change datetime field in table to date field (#change_column :your_table, :your_column, :type)
    change_column :events, :date, :date 
   
    #removes duplicate active columns
    remove_column :programs, :active 
    #adds column back in after removal
    add_column :programs, :active, :boolean    
    
    #adding start and end date to programs
    add_column :programs, :start_date, :date
    
    add_column :programs, :end_date, :date
    
    #renaming models
    rename_table :attendences, :attendances
    
    rename_table :groups, :sections
    
    #renaming column team_id to section_id b/c of model name change
    rename_column :registrations, :team_id, :section_id
    
    #removing program_id b/c of change in relationships
    remove_column :registrations, :program_id
    
    #adds column program_id to sections
    add_column :sections, :program_id, :integer    
    
    
  end
end
