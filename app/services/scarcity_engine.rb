puts "🔄  Resetting database…"
[Transaction, Customer, Juice, Economy].each(&:delete_all)

# ------------------------------------------------------------------
#  Economy
# ------------------------------------------------------------------
puts "🏦  Creating economy…"
Economy.create!(
  inflation:        rand(0.00..0.08).round(2),     
  chaos_index:      rand(0..20),                   
  rare_event_count: rand(0..3)
)

# ------------------------------------------------------------------
#  Juices  (12 flavours, randomised attributes)
# ------------------------------------------------------------------
FLAVOURS = [
  "Moonberry Meltdown",
  "Cursed Citrus",
  "Pineapple Panic",
  "Elderflower Eclipse",
  "Blood Orange Omen",
  "Dragonfruit Doom",
  "Guava Grudge",
  "Lemon Lament",
  "Kiwi Karma",
  "Mango Mayhem",
  "Strawberry Scream",
  "Peach Pandemonium"
]

puts "🧃  Seeding juices…"
juices = FLAVOURS.map do |fl|
  Juice.create!(
    flavor:         fl,
    price:          rand(2.50..6.00).round(2),
    popularity:     rand(0..5),
    scarcity_level: rand(0..20)        
  )
end
puts "   → #{juices.size} juices created."


puts "✅  Seed complete!"
