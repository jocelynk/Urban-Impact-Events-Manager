class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :username
      t.string :email
      t.string :password_digest
      t.string :password_confirmation
      t.string :role
      t.integer :department_id
      t.boolean :active

      t.timestamps
    end
  end
end