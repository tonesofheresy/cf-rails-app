class AddRememberTokenToAdminUsers < ActiveRecord::Migration
  def change
  	add_column :admin_users, :remember_token, :string
  	add_index :admin_users, :remember_token
  end
end
