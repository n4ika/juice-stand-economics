class RandomConsequence
  REGULAR = [
    # text, chaos, inflation
    # ─── Economic chaos ───────────────────────────────
    ["📈 Inflation spikes by 3% overnight",      1,  0.03],
    ["💸 A sudden tax on pulp is introduced",    1,  0.04],
    ["🏦 Bankers declare juice a volatile asset",1,  0.02],

    # ─── Environmental weirdness ──────────────────────
    ["🐀 Rats have unionized!",                 1,  0.00],
    ["☀️ Solar flares scorch your fruit",        1,  0.01],
    ["🌧️ Acid rain turns oranges neon green",   1,  0.02],

    # ─── Market ridicule ──────────────────────────────
    ["📉 Market analysts blame your pulp strategy",1,0.01],
    ["🤡 Rival clown stand undercuts prices",    1, -0.01],
    ["🎲 Gambler bets life savings on juice",    1,  0.00],

    # ─── Customer antics ──────────────────────────────
    ["😱 Customer faints after tasting Moonberry",                  1,  0.02],
    ["🎭 Flash mob reenacts Hamlet beside the register",            1,  0.00],
    ["🎲 Street gambler bets entire savings on your juice futures", 1,  0.03]
  ].freeze

  RARE = {
    eldritch:  ["🧮 Eldritch accountant audits reality!",      2, -0.01],
    riot:      ["🔥 Riot in the plaza! Juice carts toppled!", 3,  0.05],
    portal:    ["🌀 Portal opens—aliens critique your juice", 2,  0.03],
    ponzi:     ["🤑 Guru starts juice‑based Ponzi scheme",     4,  0.07],
    royalty:   ["👑 Monarch proclaims ‘Official Juice’",     -1, -0.02],
    snowglobe: ["❄️ Sudden snow‑globe blizzard!",             2,  0.00],
    audit:     ["🏛️ Surprise government audit!",               5, 0.00]
  }.freeze

   # ─── Economic boosters (good news!) ────────────────
  POSITIVE = [
    ["🕊️  Surprise peace treaty calms markets",        -2, -0.03],
    ["🍀 Lucky bumper crop floods supply",             -1, -0.04],
    ["🎉 Viral dance boosts consumer optimism",        -1, -0.02],
    ["🏅 Juice declared ‘Super‑food of the Year’",     -2, -0.01],
    ["🛠️  Government subsidy cuts production costs",  -3, -0.05],
    ["💡 Inventor unveils pulp‑free extractor",        -1, -0.03]
  ].freeze

  def self.pick
    roll = rand
    case roll
    # 0.5% chance → audit
    when 0.000...0.005 then build(:audit)
      
    # ---------- rare negatives (unchanged) ----------
    when 0.00...0.01 then build(:eldritch)
    when 0.01...0.02 then build(:riot)
    when 0.02...0.03 then build(:portal)
    when 0.03...0.04 then build(:ponzi)
    when 0.04...0.05 then build(:royalty)
    when 0.05...0.06 then build(:snowglobe)

    # ---------- *good* events 4 % chance -------------
    when 0.06...0.10
      text, chaos, infl = POSITIVE.sample
      [:booster, text, chaos, infl]

    # ---------- regular stuff ------------------------
    else
      text, chaos, infl = REGULAR.sample
      [:normal, text, chaos, infl]
    end
  end

  def self.build(key)
    text, chaos, infl = RARE.fetch(key)
    [key, text, chaos, infl]
  end
end
