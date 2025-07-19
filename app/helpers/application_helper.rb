module ApplicationHelper
  def mayhem_class(consequence)
    case consequence
    # ── HIGH danger & chaos ───────────────────────────
    when /Riot|Ponzi|🔥|🤑/i
      "text-danger fw-bold"

    # ── Cosmic / eldritch / portal weirdness ─────────
    when /Eldritch|Portal|Snowglobe|🧮|🌀|❄️/i
      "text-warning fst-italic"

    # ── Royal decree (positive) ──────────────────────
    when /Monarch|Official Juice|👑/i
      "text-success fw-bold"
      
      # NEW: positive boosters
    when /peace|bumper crop|viral dance|super‑food|subsidy|extractor/i
      "text-success"
    else
      ""
    end
  end
end
