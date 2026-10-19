# AlgoCode Analyzer

A lightweight static dashboard that fetches the AlgoCode course standings and lets you:

- Filter participants by group or by a text search.
- Toggle the must-have problems from the first two contests to recompute the solved count using only the selected subset.
- Export the filtered standings as a CSV that respects the current problem selection.

The site is published automatically to GitHub Pages via the included workflow (`.github/workflows/deploy.yml`).

## Local usage

Open `index.html` in any modern browser. By default, the page looks for a same-origin snapshot at `standings_data/bp_2026.json` and falls back to the live endpoint (`https://algocode.ru/standings_data/bp_2026/`) if the cached copy is missing. The displayed standings include only the 2025 must-have problem letters for the first two 2026 contests: C++ (3250) and Поиски (3261).

If the live endpoint blocks cross-origin requests, the UI will continue using the cached snapshot and surface an error in the status banner. When both sources fail, the app now bundles a tiny sample dataset so you can still interact with the interface while tracking down the data issue.

## Updating the cached snapshot

Use the helper script to refresh the local snapshot:

```bash
./scripts/fetch-standings.sh
```

The script downloads the latest standings into `standings_data/bp_2026.json`, which is the file that GitHub Pages will serve alongside the site. The helper refuses to overwrite the snapshot with an empty file so failed downloads don't blank the published data. You can point the script at an alternate output directory by passing a path argument, e.g. `./scripts/fetch-standings.sh public/standings_data`.

> The repository includes a 2026 snapshot. Refresh it before relying on the latest numbers.

## Problem filter presets

The UI can load reusable problem selections from `standings_data/problem_filter_presets.json`. Each entry in the array is a preset with a `label` and an optional `description`. Presets support the following fields:

| Field | Purpose |
| --- | --- |
| `id` | Unique identifier (used internally for re-applying the preset). |
| `label` | Human-friendly name shown in the "Problem preset" dropdown. |
| `description` | Optional tooltip text for the dropdown option. |
| `select` | Starting mode: use `"all"` to begin with every problem selected, `"none"` (or omit the field) to start empty. |
| `contests` | Array of contest identifiers whose problems should be enabled. |
| `problems` | Array of problem identifiers (any of `id`, `short`, `problemCode`) to enable. |
| `excludeContests` | Array of contest identifiers to disable after the initial selection. |
| `excludeProblems` | Array of problem identifiers to disable after the initial selection. |

Example preset file:

```json
[
  {
    "id": "all-problems",
    "label": "All problems",
    "description": "Selects every problem in the dataset.",
    "select": "all"
  },
  {
    "id": "cpp-focus",
    "label": "C++ focus",
    "description": "Selects two tasks from the 2026 C++ contest.",
    "select": "none",
    "contests": ["3250"],
    "problems": ["3250::A", "3250::C"]
  }
]
```

Drop new presets into the JSON file, refresh the page, and the dropdown will list them for quick application.

## Deployment pipeline

The GitHub Actions workflow fetches a fresh snapshot during each deployment and publishes both `index.html` and the JSON data to GitHub Pages. If the remote fetch fails, the job falls back to any existing repository snapshot so that the site always ships with at least one data source.
