# AlgoCode Analyzer

A lightweight static dashboard that fetches the AlgoCode course standings and lets you:

- Filter participants by group or by a text search.
- Toggle individual problems to recompute the solved count using only the selected subset.
- Export the filtered standings as a CSV that respects the current problem selection.

The site is published automatically to GitHub Pages via the included workflow (`.github/workflows/deploy.yml`).

## Local usage

Open `index.html` in any modern browser. By default, the page looks for a same-origin snapshot at `standings_data/bp_fall_2025.json` and falls back to the live endpoint (`https://algocode.ru/standings_data/bp_fall_2025`) if the cached copy is missing.

If the live endpoint blocks cross-origin requests, the UI will continue using the cached snapshot and surface an error in the status banner.

## Updating the cached snapshot

Use the helper script to refresh the local snapshot:

```bash
./scripts/fetch-standings.sh
```

The script downloads the latest standings into `standings_data/bp_fall_2025.json`, which is the file that GitHub Pages will serve alongside the site. You can point the script at an alternate output directory by passing a path argument, e.g. `./scripts/fetch-standings.sh public/standings_data`.

> The repository includes a tiny sample dataset so the UI works offline—be sure to refresh it before relying on the numbers.

## Deployment pipeline

The GitHub Actions workflow fetches a fresh snapshot during each deployment and publishes both `index.html` and the JSON data to GitHub Pages. If the remote fetch fails, the job falls back to any existing repository snapshot so that the site always ships with at least one data source.
