# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

california = Organization.create!(name: 'California')
new_york = Organization.create!(name: 'New York')
orange = california.children.create!(name: 'Orange')
ventura = california.children.create!(name: 'Ventura')

annca = User.create!(email: 'annca@example.com', password: '9ran1Ready', organization: california)
annny = User.create!(email: 'annny@example.com', password: '9ran1Ready', organization: new_york)
annorange = User.create!(email: 'annorange@example.com', password: '9ran1Ready', organization: orange)
annventura = User.create!(email: 'annventura@example.com', password: '9ran1Ready', organization: ventura)

Attachment.create([{ name: 'California attachment 1', organization: california },
                   { name: 'Orange attachment 1', organization: orange },
                   { name: 'New York attachment 1', organization: new_york }])
