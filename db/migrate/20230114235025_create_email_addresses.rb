class CreateEmailAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :email_addresses do |t|
      t.references :contact, null: false, foreign_key: true
      t.string :address

      t.timestamps
    end
  end
end
