# AlgoCode Analyzer

A lightweight static dashboard that fetches the AlgoCode course standings and lets you:

- Filter participants by group or by a text search.
- Toggle individual problems to recompute the solved count using only the selected subset.
- Export the filtered standings as a CSV that respects the current problem selection.

The site is published automatically to GitHub Pages via the included workflow (`.github/workflows/deploy.yml`).

## Local usage

Open `index.html` in any modern browser. The page fetches the data directly from `https://algocode.ru/standings_data/bp_fall_2025`.

> **Note**: If the remote endpoint rejects cross-origin requests, open the page from GitHub Pages (or another HTTPS origin) where CORS is permitted.
