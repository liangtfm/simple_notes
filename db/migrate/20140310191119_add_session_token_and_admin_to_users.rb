class AddSessionTokenAndAdminToUsers < ActiveRecord::Migration
  def change
    add_column :users, :session_token, :string
    add_column :users, :admin, :boolean, default: false
  end
end
