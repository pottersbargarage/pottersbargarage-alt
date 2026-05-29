# HANDOFF.md — Potters Bar Garage Website Modernisation

**Original analysis date:** 15 May 2026  
**Last updated:** 29 May 2026  
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

### ✅ Google Maps embed
Real embed URL added to the Contact page map iframe:
`https://www.google.com/maps/embed?pb=!1m18!...` (12 Barnet Rd, Potters Bar EN6 2QS).

---

## Outstanding Items (pre-go-live)

### 1. Accessibility widget — AccessiYes (CookieYes)
- **Tool:** AccessiYes via CookieYes — https://www.cookieyes.com/product/accessibility-widget/create-for-free/
- **Status:** Deferred — requires registration with the live domain URL. Do not register until DNS is pointed at the new site.
- **Action:** Register, copy the embed script snippet, add it to `<head>` on all four pages.

### 2. Spam protection on contact form
- **Status:** Deferred — to be done alongside or after Formspree is confirmed working.
- **Recommended approach:** ALTCHA (https://altcha.org) — however, ALTCHA requires a server-side challenge endpoint. For a static site on GitHub Pages this means using ALTCHA's hosted challenge API or switching to a client-side honeypot approach.
- **Simpler alternative:** Formspree has built-in spam filtering on paid plans. May be sufficient without adding a separate widget.

### 3. SEO / blog content strategy
- The original site has 9 blog articles targeting local search terms (Potters Bar, Totteridge, Enfield, Barnet). These have been removed from the modernised site.
- **Action before DNS cutover:**
  1. Check Google Search Console on the original site — identify which articles rank.
  2. Decide: migrate as blog, rewrite as static landing pages, or accept the SEO gap.
  3. Set up 301 redirects from old WordPress URLs to relevant sections of the new site.

### 4. DNS migration
- Currently on GitHub Pages under tarne75's account. When ready to go live:
  1. Add `CNAME` file to the repo containing `pottersbargarage.co.uk`.
  2. Update DNS: point `@` and `www` to GitHub Pages IPs (185.199.108–111.153).
  3. Enable HTTPS in GitHub Pages settings (auto via Let's Encrypt).
  4. Ensure WordPress hosting is not cancelled until all redirects are confirmed working.

### 5. Cleanup
- Delete `download-images.html` from the repo — it was a helper file for sourcing the service images, not part of the live site.

### 6. Trade association badge
- About page references membership but the badge image (`trade-badge.png`) needs confirming it displays correctly. Check on live site after DNS migration.

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
├── css/
│   └── style.css
├── js/
│   └── main.js
└── images/
    ├── logo.png
    ├── mechanic.png
    ├── trade-badge.png
    ├── favicon.*
    ├── icon-*.png          (10 service icons)
    └── service-*.jpg/png   (10 service illustrative images)
```

---

*End of HANDOFF.md*
