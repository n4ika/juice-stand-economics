# 🍊 Juice‑Stand Economics Simulator

A tongue‑in‑cheek Rails app that lets you run a neighbourhood juice stand
and watch the **economy implode** in real time.

**Live demo coming soon** — in the meantime, clone & run locally!

---

## Features

| Area                  | What happens                                                                             |
| --------------------- | ---------------------------------------------------------------------------------------- |
| **Sale simulation**   | Every sale triggers random consequences, bumps popularity, and nudges inflation & chaos. |
| **Scarcity engine**   | Juices drift into scarcity or recover, dynamically raising global prices & inflation.    |
| **Economy panel**     | Live chaos index, inflation %, rare‑event counter.                                       |
| **Flash mayhem feed** | Turbo‑powered rolling log of riots, eldritch accountants, clown competitors…             |
| **Customers**         | Randomly generated names, moods & complaints keep you humble.                            |

---

## Quick‑start

```bash
# Ruby 3.4 / Rails 7.1
git clone https://github.com/YOUR_USERNAME/juice-stand-economics.git
cd juice-stand-economics
bundle install
bin/rails db:setup  # loads seed data (12 juices, random economy)
bin/rails s         # http://localhost:3000
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
engine & consequence generator.
