# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


10.times { |i| Contact.create!(first_name: "first name #{i}", last_name: "last name #{i}") }

contacts = Contact.all
contacts.each do |contact|
  times = rand(1..30)
  times.times { |i| EmailAddress.create!(contact: contact, address: "contact#{i}@gmail.com")}
end

addresses =  EmailAddress.all.select { |x| x.id % 3 == 0 }
addresses.each { |x| x.bounced = true }
addresses.save!