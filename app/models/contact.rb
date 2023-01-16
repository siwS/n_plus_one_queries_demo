class Contact < ApplicationRecord
  has_many :email_addresses

  # has_many_aggregate :email_addresses, :max_length, :maximum, "LENGTH(address)", default: nil
  # has_many_aggregate :email_addresses, :count_all, :count, "*"
end
