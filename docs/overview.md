# Architecture Overview

`Juice‑Stand Economics` is intentionally simple:

## Domain models

- **Juice** – flavour, price, popularity, `scarcity_level`
- **Customer** – name, mood, complaint
- **Transaction** – joins Juice & Customer, logs consequence text
- **Economy** – singleton, tracks chaos, inflation, rare_event_count
- **(Planned) MarketEvent** – macro shocks (scarcity spikes, economy crashes)

## Services

- **RandomConsequence** – returns `[event_type, text, chaos_Δ, inflation_Δ]`
- **ScarcityEngine** – probabilistic tick; returns `:spike`, `:recovery`, nil
- **RandomCustomer** – generates diverse names / moods / complaints

## Front‑end

Turbo Frames + Turbo Streams; Stimulus controller `flash_controller`
handles auto‑dismiss.

### Running locally

```bash
bundle install
bin/rails db:setup   # loads seed data & random economy
bin/rails s
open http://localhost:3000
```
