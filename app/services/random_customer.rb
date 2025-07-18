class RandomCustomer
  NAMES = %w[
    Gary\ the\ Banker     Rita\ the\ Rat            Phyllis\ the\ Philosopher
    Barry\ the\ Broker     Luna\ the\ Lunatic        Cassie\ the\ Cynic
    Milton\ the\ Miser     Penelope\ the\ Pundit     Oscar\ the\ Oracle
    Fiona\ the\ Fainter    Nigel\ the\ Negotiator    Zelda\ the\ Zealot
    Percy\ the\ Pulp\ Critic  Wanda\ the\ Worrywart   Hugo\ the\ Hedger
    Gloria\ the\ Gambler   Victor\ the\ Vegan        Daisy\ the\ Day‑Trader
    Calvin\ the\ Conspiracy\ Theorist  Beatrix\ the\ Bureaucrat
    Ivan\ the\ Inflationist  Maya\ the\ Market‑Mover  Quinn\ the\ Quant
    Felix\ the\ Futures\ Fan  Opal\ the\ Optimist    Greta\ the\ Gloomster
    Jasper\ the\ Juicer     Yolanda\ the\ Yield‑Chaser Xander\ the\ Xenophile
  ].freeze

  MOODS = %w[
    angry confused gleeful ecstatic skeptical hopeful exhausted paranoid jubilant
    apathetic terrified enlightened smug nostalgic bewildered indecisive furious
  ].freeze

  COMPLAINTS = [
    "Your pulp is too chunky!",
    "Where’s the garnish?!",
    "Needs more existential dread.",
    "I ordered existential bliss—got dread instead.",
    "Too much vitamin C… suspicious!",
    "Are these ice cubes ethically sourced?",
    "I detect metaphors—remove them.",
    "My horoscope warned me about this juice.",
    "Not enough irony in the flavor profile.",
    "Juice futures just crashed because of you!",
    "This straw isn’t carbon‑negative.",
    "Why does it taste like foreshadowing?",
    "The juice is fine, the vibes are not.",
    "Is this organic or just organized?",
    "I asked for pulp, not plot twists.",
    "Needs more liquidity (literally).",
    "Too fizzy—my aura’s vibrating.",
    "The color clashes with my aura.",
    "I require gluten‑free water, please.",
    "Tastes bearish—got anything bullish?"
  ].freeze
  
  def self.create!
    Customer.create!(
      name:       NAMES.sample,
      mood:       MOODS.sample,
      complaint:  COMPLAINTS.sample
    )
  end
end
