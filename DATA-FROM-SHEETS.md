# Vehicles for Sale — Google Sheets Integration Guide

This guide explains how to manage the vehicles listed on `vehicles.html` using a Google Sheet as a simple database. No code changes are needed to add, update, or remove listings — just edit the sheet.

---

## How it works

`vehicles.html` fetches a published Google Sheet as CSV on page load. Each row in the sheet becomes a vehicle card. The page filters by type (All / Cars / Motorbikes) client-side. No API key is required.

---

## Step 1 — Create the Google Sheet

Create a sheet with the following columns (exact header names matter):

| type | year | make | model | mileage | price | description | image_url | status |
|---|---|---|---|---|---|---|---|---|
| Car | 2019 | Ford | Focus ST | 34000 | 9500 | Full service history. One owner. | https://... | Available |
| Motorbike | 2021 | Honda | CB500F | 8200 | 4995 | Excellent condition. 1 key. | https://... | Available |
| Car | 2017 | Vauxhall | Astra | 61000 | 6200 | MOT until Jan 2026. | | Sold |

### Column reference

| Column | Required | Notes |
|---|---|---|
| `type` | Yes | Must be exactly `Car` or `Motorbike` (case-sensitive) |
| `year` | Yes | Four-digit year, e.g. `2019` |
| `make` | Yes | Manufacturer, e.g. `Ford`, `Honda` |
| `model` | Yes | Model name, e.g. `Focus ST` |
| `mileage` | Yes | Numeric miles, e.g. `34000` — displayed as `34,000 miles` |
| `price` | Yes | Numeric price in GBP, e.g. `9500` — displayed as `£9,500` |
| `description` | Yes | Short description. Wrap in quotes if it contains commas. |
| `image_url` | No | Direct image URL (see image hosting note below). Leave blank for a placeholder. |
| `status` | Yes | `Available` or `Sold`. Sold vehicles show a SOLD badge and are excluded from the active count. |

---

## Step 2 — Host vehicle images

Google Sheets cannot host images directly. Options in rough order of simplicity:

1. **Google Drive** — Upload the image, right-click → Share → Anyone with the link, then use this URL format:
   - Share URL: `https://drive.google.com/file/d/FILE_ID/view`
   - **Correct image URL: `https://lh3.googleusercontent.com/d/FILE_ID`**
   - ⚠️ Do NOT use `https://drive.google.com/uc?export=view&id=FILE_ID` — Google now blocks that format on external sites (`cross-origin-resource-policy: same-site`)

2. **GitHub repo** — Place images in `images/vehicles/` and reference them as relative paths (e.g. `images/vehicles/ford-focus-2019.jpg`). Requires a code commit per new vehicle, so only worthwhile if images are already being handled in the repo.

3. **Any public image host** — Imgur, Cloudinary free tier, etc. Use the direct `.jpg`/`.png` URL.

---

## Step 3 — Publish the sheet as CSV

1. In Google Sheets, go to **File → Share → Publish to web**
2. Under "Link", select the correct sheet tab (not "Entire Document")
3. Change the format dropdown from "Web page" to **Comma-separated values (.csv)**
4. Click **Publish** and confirm
5. Copy the URL — it will look like:
   ```
   https://docs.google.com/spreadsheets/d/SHEET_ID/pub?gid=0&single=true&output=csv
   ```

---

## Step 4 — Wire the URL into vehicles.html

In `vehicles.html`, find this line near the top of the `<script>` block:

```js
const SHEET_CSV_URL = 'YOUR_GOOGLE_SHEET_CSV_URL_HERE';
```

Replace the placeholder string with your published CSV URL. This is a one-time setup.

---

## Managing listings day-to-day

| Action | What to do |
|---|---|
| Add a vehicle | Add a new row to the sheet |
| Remove a vehicle | Delete the row, or change `status` to `Sold` to keep it visible with a SOLD badge |
| Update a price or description | Edit the cell — changes appear on the site within a few minutes |
| Change an image | Update the `image_url` cell |
| Temporarily hide a listing | Leave the row but clear the `type` cell — the parser skips rows with an unrecognised type |

---

## Notes

- Google Sheets CSV is publicly readable with no API key once published to the web.
- The page fetches fresh data on every load. There is no cache to clear.
- GitHub Pages serves over HTTPS, which is required for the fetch to work.
- If the sheet is unpublished or the URL is wrong, the page shows a friendly error message and a prompt to call the garage.
- The CSV parser handles commas inside quoted fields (e.g. `"Long description, with a comma"`) correctly.
