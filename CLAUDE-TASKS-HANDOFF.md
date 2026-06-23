# HANDOFF.md — Potters Bar Garage Website Modernisation

**Original analysis date:** 15 May 2026  
**Last updated:** 23 June 2026  
**Analyst:** Claude (Anthropic)  
**Task:** Modernise pottersbargarage.co.uk as a static GitHub Pages site, then migrate to the live domain.

---

## Sites

| | URL |
|---|---|
| **Original (live WordPress)** | https://pottersbargarage.co.uk/ |
| **Modernised (staging)** | https://tarne75.github.io/pottersbargarage-alt/index.html |
| **Local repo** | /Users/tarnewestcott/Development/pottersbargarage |

---

## Completed Items

### ✅ Core site build
Four-page static HTML/CSS site replacing the original WordPress installation:
- `index.html` — Home
- `about.html` — About
- `services.html` — All 10 services as anchor-linked sections
- `contact.html` — Contact & booking form

### ✅ Service images (all 10)
Large illustrative images (sourced from original WordPress site) wired into both the homepage service grid cards (`service-card-img`, top of card) and the services page full cards (`service-full-img`, right side). Images stored in `images/`:

| Filename | Service |
|---|---|
| service-servicing.jpg | Servicing |
| service-mot.png | MOT Testing |
| service-diagnostics.jpg | Diagnostics |
| service-brakes.png | Brakes |
| service-batteries.png | Batteries |
| service-aircon.png | Air Conditioning |
| service-exhausts.png | Exhausts |
| service-bodywork.png | Bodywork |
| service-wheel.png | Wheel Alignment |
| service-electric.jpg | Electric & Hybrid |

### ✅ Icon visibility
- `mechanic.png` (dark line-art on transparent background) — `filter: brightness(0) invert(1)` applied on both index.html and about.html.
- All `.service-icon` and `.service-full-icon` dark green gradient backgrounds restored; `filter: brightness(0) invert(1)` applied via CSS to all icon `<img>` elements so white icons display correctly.

### ✅ Social media links
All four pages (index, about, services, contact) have real, working social links in the footer:
- Facebook: https://www.facebook.com/pottersbar.garage
- Google Business: https://maps.app.goo.gl/TgL2Riq4MoCbw6Hv9

### ✅ Contact form — Formspree
Form `action` wired to `https://formspree.io/f/xwvndkow`. The `name="email"` field is recognised automatically by Formspree for reply threading. First submission will trigger a Formspree verification email — ensure the account is confirmed.

### ✅ Contact form — AJAX submission handler (main.js)
The original submit handler was calling `e.preventDefault()` and faking success without sending data. Fixed with a proper `fetch()` to Formspree using `Accept: application/json`, with loading/success/error button states and a 5-second auto-reset on success.

### ✅ Google Maps embed
Real embed URL added to the Contact page map iframe:
`https://www.google.com/maps/embed?pb=!1m18!...` (12 Barnet Rd, Potters Bar EN6 2QS).

### ✅ Vehicles for Sale page (`vehicles.html`)
New fifth page added to the site with full site chrome. Driven by a published Google Sheet CSV — no code change needed to add/update/remove listings. Key details:
- Google Sheet columns: `type`, `year`, `make`, `model`, `mileage`, `price`, `description`, `image_url`, `status`
- `SHEET_CSV_URL` config constant at top of inline `<script>` block
- `GRID_COLUMNS = 2` config constant controls grid layout
- Custom CSV parser handles quoted fields containing commas
- Image error handler uses JS event listeners (not inline `onerror`) to avoid SVG-double-quote breakage
- Enquire button links to `contact.html?vehicle=<title>` which pre-fills the message textarea
- See `DATA-FROM-SHEETS.md` for full day-to-day editing guide

### ✅ Google Drive image hosting note
`https://drive.google.com/uc?export=view&id=FILE_ID` is broken for GitHub Pages — Google redirects to `drive.usercontent.google.com` which serves `cross-origin-resource-policy: same-site`. Use `https://lh3.googleusercontent.com/d/FILE_ID` instead (returns `access-control-allow-origin: *`). Documented in `DATA-FROM-SHEETS.md`.

### ✅ "Vehicles for Sale" added to nav on all pages
Primary nav and mobile nav updated on all five pages.

### ✅ Vehicle enquiry pre-fill on contact form
`contact.html` reads `?vehicle=` URL param on load and pre-fills the message textarea with an enquiry template, then scrolls the form into view.

### ✅ Dynamic copyright year
`main.js` now sets the current year on all `<span data-copyright-year>` elements at DOMContentLoaded. Footer on all five pages uses this.

### ✅ Legacy site archived (`legacy/`)
Full mirror of https://pottersbargarage.co.uk downloaded to `legacy/pottersbargarage.co.uk/`. 528 files total — all 29 HTML pages, all 38+ images (including WordPress-CDN images fetched with Referer header), CSS, JS, fonts. Zero failures.
- Script: `legacy/download.sh` (wget mirror + curl loop with Referer header)
- Browser fallback: `legacy/download-images.html`
- **Pending:** commit with `git add legacy/ && git commit -m "Add legacy site mirror from pottersbargarage.co.uk" && git push` (must be run from your own terminal — SSH key not available in the sandbox)

### ✅ Full copy-edit and spell-check pass (23 June 2026)
Swept all five pages for UK English, grammar, spelling, and cross-page consistency. Changes made:

| File | Change |
|---|---|
| `index.html` | "approved diagnostics tools" → "approved diagnostic tools" |
| `about.html` | "air-conditioning" → "air conditioning" (hyphen inconsistency) |
| `about.html` | "market-honest pricing" → "market-rate pricing" (non-standard phrase) |
| `about.html` | Mobile nav — added missing Batteries and Wheel Alignment links |
| `services.html` | "Comprehensive auto care" → "Comprehensive vehicle care" (American English) |
| `contact.html` | "open most weekdays" → "open every weekday" (factual inaccuracy) |
| `contact.html` | Mobile nav — added missing Batteries and Wheel Alignment links |

Note: testimonial text was not altered — those are verbatim customer quotes.

---

## Outstanding Items (pre-go-live)

### 1. Commit the legacy site mirror
- **Action (from your terminal):**
  ```bash
  cd /Users/tarnewestcott/Development/pottersbargarage
  git add legacy/
  git commit -m "Add legacy site mirror from pottersbargarage.co.uk"
  git push
  ```
- **Why terminal:** SSH key is not available in the Claude sandbox; all pushes must be done locally.

### 2. Accessibility widget — AccessiYes (CookieYes)
- **Tool:** AccessiYes via CookieYes — https://www.cookieyes.com/product/accessibility-widget/create-for-free/
- **Status:** Deferred — requires registration with the live domain URL. Do not register until DNS is pointed at the new site.
- **Action:** Register, copy the embed script snippet, add it to `<head>` on all five pages.

### 3. Spam protection on contact form
- **Status:** Deferred — to be done alongside or after Formspree is confirmed working in production.
- **Recommended approach:** ALTCHA (https://altcha.org) — however, ALTCHA requires a server-side challenge endpoint. For a static site on GitHub Pages this means using ALTCHA's hosted challenge API or switching to a client-side honeypot approach.
- **Simpler alternative:** Formspree has built-in spam filtering on paid plans. May be sufficient without adding a separate widget.

### 4. SEO / blog content strategy
- The original site has 9 blog articles targeting local search terms (Potters Bar, Totteridge, Enfield, Barnet). These have been removed from the modernised site.
- **Action before DNS cutover:**
  1. Check Google Search Console on the original site — identify which articles rank.
  2. Decide: migrate as blog, rewrite as static landing pages, or accept the SEO gap.
  3. Set up 301 redirects from old WordPress URLs to relevant sections of the new site.

### 5. DNS migration
- Currently on GitHub Pages under tarne75's account. When ready to go live:
  1. Add `CNAME` file to the repo containing `pottersbargarage.co.uk`.
  2. Update DNS: point `@` and `www` to GitHub Pages IPs (185.199.108–111.153).
  3. Enable HTTPS in GitHub Pages settings (auto via Let's Encrypt).
  4. Ensure WordPress hosting is not cancelled until all redirects are confirmed working.

### 6. Cleanup
- Delete `download-images.html` from the repo root — it was a helper file for sourcing service images, not part of the live site.

### 7. Trade association badge
- About page references membership but the badge image (`trade-badge.png`) needs confirming it displays correctly. Check on live site after DNS migration.

### 8. Contact form — Motorbike Servicing option missing
- The service dropdown has "Servicing (Car)" but no "Servicing (Motorbike)" option, even though motorbike servicing is offered. Consider adding before launch.

---

## Technical Notes

- **Git lock files:** The sandbox environment cannot remove `.git/HEAD.lock` or `.git/index.lock` — if these appear after Claude stages files, run `rm .git/HEAD.lock .git/index.lock` from your own terminal before committing.
- **WordPress blocks programmatic downloads:** The original site's CDN returns 415 for all curl/wget/python requests regardless of headers. Use browser right-click to download any additional original assets.
- **IntersectionObserver animations:** Service cards start at `opacity: 0` and animate in on scroll. If images appear invisible during testing, scroll the page to trigger the observer.
- **Formspree free tier limits:** 50 submissions/month. Upgrade if volume exceeds this after launch.

---

## File Structure

```
pottersbargarage/
├── index.html
├── about.html
├── services.html
├── contact.html
├── vehicles.html               ← new; Google Sheet-driven listings page
├── DATA-FROM-SHEETS.md         ← guide to managing vehicle listings
├── css/
│   └── style.css
├── js/
│   └── main.js
├── images/
│   ├── logo.png
│   ├── mechanic.png
│   ├── trade-badge.png
│   ├── favicon.*
│   ├── icon-*.png              (10 service icons)
│   └── service-*.jpg/png       (10 service illustrative images)
└── legacy/
    ├── download.sh             ← mirror script (wget + curl with Referer)
    ├── download-images.html    ← browser fallback for manual image saving
    └── pottersbargarage.co.uk/ ← full site mirror (528 files)
```

---

*End of HANDOFF.md*
