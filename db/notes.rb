# N+1 queries session:
# Slides: https://docs.google.com/presentation/d/1HqHs-O6AP6PxFz9MqYNm5hAyW5xfx2lM-__xNUPO9pc/edit?usp=sharing

# Before starting with the code, show the models involved

# Step 1:
# Creates N+1 with .each

def get_addresses(contact)
  contact.email_addresses.map do |email|
    email.address
  end
end

Contact.all.map do |contact|
  get_addresses(contact).flatten
end


# Step 2:
# Creates N+1 with .count

def get_addresses_count(contact)
  contact.email_addresses.count
end

Contact.all.map do |contact|
  get_addresses_count(contact)
end

# Step 3:
# Creates N+1 with .max

def get_longest_address(contact)
  contact.email_addresses.maximum("LENGTH(address)")
end

Contact.all.map do |contact|
  get_longest_address(contact)
end

# Note: in Manage those will NOT create an N+1 query because we user our own gem to prevent them out of the box
# After jit preloader show how that happens

# Step 4:
# Fix with `includes(:association)`

def get_addresses(contact)
  contact.email_addresses.map do |email|
    email.address
  end
end

Contact.all.includes(:email_addresses).map do |contact|
  get_addresses(contact)
end

# Step 5
# Fix with eager load when used in where/order statement
#
# SELECT "contacts"."id" AS t0_r0, "contacts"."first_name" AS t0_r1, "contacts"."last_name" AS t0_r2, "contacts"."created_at" AS t0_r3, "contacts"."updated_at" AS t0_r4, "email_addresses"."id" AS t1_r0, "email_addresses"."contact_id" AS t1_r1, "email_addresses"."address" AS t1_r2, "email_addresses"."created_at" AS t1_r3, "email_addresses"."updated_at" AS t1_r4, "email_addresses"."bounced" AS t1_r5
# FROM "contacts" LEFT OUTER JOIN "email_addresses" ON "email_addresses"."contact_id" = "contacts"."id"
# WHERE (email_addresses.bounced = false)
#

# Problem with N+1 query where we select items based on a condition
Contact.all.map { |x| x.email_addresses.select { |z| !z.bounced }.count }

# Fix with eager load association
Contact.includes(:email_addresses).where("email_addresses.bounced = false").references(:email_addresses)

# Step 6:
# Fix with jit_preload

def get_addresses(contact)
  contact.email_addresses.map do |email|
    email.address
  end
end

Contact.jit_preload.each do |contact|
  get_addresses(contact)
end


# This circumvents the N+1 detection:
# Contact.jit_preload.each do |c|
#   EmailAddress.where(contact_id: c.id)
# end

# Step 7:
# Aggregate and max associations in model

Contact.jit_preload.each do |contact|
  puts contact.email_addresses_max_length
end

Contact.jit_preload.each do |contact|
  puts contact.email_addresses_count_all
end

# Show how it's used in Manage....
# We heavily monkey-patch the `has_many` method
# for associations to use jit_preloader which takes our DB sharding into consideration