# CLAUDE.md — Potters Bar Garage

## ⚠️ HARD RULE: Do not touch legacy/

The `legacy/` directory is a read-only archive of the original WordPress site.
**Never modify, delete, or overwrite any file under `legacy/` for any reason.**
This includes edits, sed replacements, reformatting, or any other change.
If a task would affect `legacy/`, stop and confirm with the user first.

---

## Project overview

Static GitHub Pages site replacing pottersbargarage.co.uk.

| | URL / Path |
|---|---|
| **Staging site** | https://tarne75.github.io/pottersbargarage-alt/ |
| **Local repo** | /Users/tarnewestcott/Development/pottersbargarage |
| **Legacy archive** | legacy/pottersbargarage.co.uk/ — READ ONLY |

## Key files

- `index.html`, `about.html`, `services.html`, `contact.html`, `vehicles.html` — the five live pages
- `css/style.css` — all styles
- `js/main.js` — mobile nav, Formspree AJAX, copyright year, scroll animations
- `DATA-FROM-SHEETS.md` — guide to managing the vehicles-for-sale Google Sheet
- `CLAUDE-TASKS-HANDOFF.md` — full task history and outstanding items

## Always update CLAUDE-TASKS-HANDOFF.md when finishing a session.
