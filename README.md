# 🍊 Juice‑Stand Economics Simulator

A tongue‑in‑cheek Rails app that lets you run a neighbourhood juice stand
and watch the **economy implode** in real time.

**Live demo coming soon** — in the meantime, clone & run locally!

---

## Features

| Area                  | What happens                                                                                    |
| --------------------- | ----------------------------------------------------------------------------------------------- |
| **Sale simulation**   | Every sale triggers random consequences, bumps popularity, and nudges inflation & chaos.        |
| **Positive events**   | Rare “booster” events (peace treaty, bumper crop, viral dance…) calm chaos & reduce inflation.  |
| **Gov Audit**         | 0.5 % chance of a government audit per sale: freezes a juice’s sales for 30 s and spikes chaos. |
| **Happy Hour**        | Every hour for 15 minutes: 10 % off all juices, inflation eased, and chaos freezes on sales.    |
| **Scarcity engine**   | Juices drift into scarcity or recover, dynamically raising global prices & inflation.           |
| **Economy panel**     | Live chaos index, inflation %, rare‑event counter, and happy‑hour marker.                       |
| **Flash mayhem feed** | Turbo‑powered rolling log of riots, eldritch accountants, audits… keeps you on your toes.       |
| **Customers**         | Randomly generated names, moods & complaints keep you humble.                                   |

---

## Quick‑start

```bash
# Ruby 3.4 / Rails 7.1
git clone https://github.com/YOUR_USERNAME/juice-stand-economics.git
cd juice-stand-economics
bundle install
bin/rails db:setup  # loads seed data (12 juices, random economy)
bin/rails s         # http://localhost:3000
  # http://localhost:3000
```

## Roadmap / “help wanted”

📊 Market Event tracker (dedicated table + dashboard card)

😎 Dynamic customer satisfaction & repeat‑buyer stats

💥 Economy crash mode – trigger global recession after too many rare events

📱 PWA / full mobile responsiveness (works OK now, but needs polish)

PRs welcome! Feel free to file issues, propose features, or refactor
anything that smells anti‑Rails. Check docs/overview.md for architecture
notes.

## How it was built

Rails 7.1 + Turbo + Stimulus + Bootstrap

AI assistance (ChatGPT) used to craft the economy logic, scarcity
engine, positive boosters, Happy Hour & audit features.
