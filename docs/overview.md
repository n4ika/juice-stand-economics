# Architecture Overview

`Juice‑Stand Economics` is intentionally simple:

## Models

- **Juice** – flavour, price, popularity, `scarcity_level`
- **Customer** – name, mood, complaint
- **Transaction** – joins Juice & Customer, logs consequence text
- **Economy** – singleton, tracks chaos, inflation, rare_event_count
- **(Planned) MarketEvent** – macro shocks (scarcity spikes, economy crashes)

## Services

- **RandomConsequence** → `[event_type, text, chaos_Δ, inflation_Δ]`  
  • regular chaos/inflation events  
  • rare _negative_ events (riots, eldritch, portal…)  
  • rare _positive_ boosters (peace treaty, bumper crop…)  
  • 0.5% `:audit` event to trigger government audit

- **ScarcityEngine** → probabilistic tick (10% per sale)  
  • gentle drift → scarcity_level (0…100)  
  • initial spike more likely at 5%

- **HappyHour** → active 15 mins each hour  
  • once per window, eases inflation & global prices (-2%, -10%)  
  • freezes chaos bump on sales

- **RandomCustomer** → generates diverse names/moods/complaints

## Front‑end

- Turbo Frames + Turbo Streams
- Stimulus `flash_controller` for auto‑dismiss
- Fixed‑height scroll panels for mayhem & complaints feeds

### Running locally

```bash
bundle install
bin/rails db:setup   # loads seed data & random economy
bin/rails s
open http://localhost:3000
```
