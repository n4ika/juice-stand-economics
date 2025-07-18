# Clear existing data
puts "Cleaning up database..."
Juice.destroy_all
Customer.destroy_all
Transaction.destroy_all
Economy.destroy_all
puts "Database cleaned."

# Economy Setup
puts "Creating economy..."
Economy.create!(
  inflation: 0.05,
  chaos_index: 3,
  rare_event_count: 1
)
puts "Economy created."

# Juices
puts "Seeding juices..."
juices = Juice.create!([
  { flavor: "Moonberry Meltdown", price: 3.99, popularity: 5 },
  { flavor: "Cursed Citrus", price: 2.50, popularity: 2 },
  { flavor: "Pineapple Panic", price: 4.25, popularity: 4 },
  { flavor: "Elderflower Eclipse", price: 5.00, popularity: 3 },
  { flavor: "Blood Orange Omen", price: 3.75, popularity: 1 }
])

Juice.update_all(scarcity_level: 0) 

puts "#{juices.count} juices created."

puts "✅ Seed complete."
