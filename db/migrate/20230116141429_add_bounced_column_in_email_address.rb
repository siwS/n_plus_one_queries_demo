class AddBouncedColumnInEmailAddress < ActiveRecord::Migration[7.0]
  def change
    add_column :email_addresses, :bounced, :boolean, default: false
  end
end
