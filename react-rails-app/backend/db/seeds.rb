# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Clear existing data
Project.destroy_all

# Create sample projects
projects = [
  {
    title: "Learn Ruby on Rails",
    description: "Master the Rails framework and conventions",
    completed: false
  },
  {
    title: "Build REST API",
    description: "Create a JSON API with CRUD operations",
    completed: true
  },
  {
    title: "Connect with React Frontend",
    description: "Integrate Rails API with React application",
    completed: false
  },
  {
    title: "Deploy to Production",
    description: "Deploy the full-stack application to a cloud platform",
    completed: false
  }
]

projects.each do |project_data|
  Project.create!(project_data)
end

puts "Created #{Project.count} projects"
