# SEO-HANDOFF.md — Potters Bar Garage

**Date:** 15 May 2026
**Context:** Notes from site migration analysis — original WordPress site (pottersbargarage.co.uk) vs. modernised static replacement (tarne75.github.io/pottersbargarage-alt/).
**Audience:** Engineer picking this up — no SEO background assumed, technical terminology used throughout.

---

## What SEO Is (Brief Primer)

SEO (Search Engine Optimisation) = improving the signals that Google's ranking algorithm uses to score your pages against user queries.

Googlebot crawls your site by following `<a href>` links, parses the HTML, and stores a representation in Google's index. When a user searches, the ranking algorithm scores all indexed pages against the query across ~200 signals and returns a sorted list. You are optimising your site as the data source it indexes.

Two broad signal categories:

- **On-page signals** — `<title>`, `<meta name="description">`, heading hierarchy, body text content, URL structure, internal linking, image alt text, page load speed, Core Web Vitals.
- **Off-page signals** — backlinks (other sites linking to you; treated as citations/trust votes), Google Business Profile (separate data source feeding Maps and local pack results).

---

## Current SEO State — Original Site

### What it has going for it

**9 blog articles targeting local long-tail queries.** These are the most SEO-relevant part of the existing site. Each article is a thin content page, but it targets a specific low-competition, high-intent local search query. Examples:

| Article title | Target query intent |
|---|---|
| MOT services in Potters Bar EN6 2QS | Local MOT booking, specific postcode |
| Car Servicing in Totteridge – N20 | Local servicing, adjacent area |
| Exhaust Repair in Enfield | Local exhaust repair, wider catchment |
| MOT Services in Totteridge | Local MOT, adjacent area |
| Diagnostics in Potters Bar – EN6 | Local diagnostics, specific postcode |
| Car Servicing – Barnet – EN4 | Local servicing, adjacent area |
| Air Conditioning Servicing in Potters Bar – EN6 | Local AC service, specific postcode |
| Signs that Exhaust System Needs Repair | Informational / awareness query |
| Car Care and Assisted Living | Niche informational query |

Users searching these queries are typically in the **decision phase** (ready to book), making them high-conversion traffic even at low volume.

**Google Business Profile** — the original site links to a Google Business Profile (`g.page/r/CZBtOzM9RdBCEAE`). This feeds Google Maps results and the local pack (the 3-result map block that appears above organic results for local service searches). This is separate from the website and survives a migration — but the website URL field in the profile needs updating post-cutover.

**Facebook page** — linked from footer. Social signals are weak ranking factors, but the presence of consistent NAP (Name, Address, Phone) data across platforms matters for local SEO trust signals.

### What it lacks

- No `sitemap.xml`
- No descriptive `robots.txt`
- `<title>` tag has a trailing hyphen (minor, cosmetic)
- Phone/email as plain text — not a ranking issue, but a UX/conversion issue
- No structured data / schema markup (see Section 5)
- Page speed likely impaired by WordPress + plugin overhead

---

## Current SEO State — Modernised Site

### Improvements over original

- Cleaner `<title>` tags (e.g. `"Potters Bar Garage — MOT, Servicing & Car Repairs in Hertfordshire"`)
- Static HTML served from GitHub Pages — faster load times → better Core Web Vitals → marginal ranking improvement
- Google uses **mobile-first indexing** (indexes the mobile version of your site); static HTML is typically leaner and faster on mobile than WordPress
- Anchor-linked service sections give each service a consistent, linkable URL fragment (`services.html#mot`)
- Breadcrumbs improve crawl path clarity for Googlebot

### SEO gaps introduced by the migration

- **All 9 blog articles removed** — any rankings those pages hold will be lost on cutover unless mitigated
- **No `sitemap.xml`** — not critical for a 4-page site, but good hygiene
- **No `robots.txt`**
- **No structured data / schema markup** (same as original — neither site has this)
- **Image alt text is generic** (`alt="servicing"`, `alt="mot"`) — missed opportunity for descriptive, keyword-relevant text
- **Social links are `href="#"` placeholders** — broken links are a minor crawl signal issue
- **No Google Analytics / Search Console integration visible** — no measurement in place

---

## Key Risk: The Blog Removal

This is the highest SEO risk in the migration. When the DNS cutover happens and the new site goes live:

1. Googlebot requests the old article URLs → gets HTTP 404 → removes them from the index
2. Any backlinks pointing to those URLs become dead references → link equity lost
3. Users who click those URLs in Google results land on a 404

The scale of the actual impact depends on whether those articles currently rank. **You do not know this without checking Google Search Console.** It could be negligible (articles never ranked, zero traffic) or meaningful (articles drive 30–40% of the site's organic visits).

**Action required before cutover: check Search Console.** See Section 6.

---

## 301 Redirect Strategy

HTTP 301 = "Moved Permanently". Googlebot follows the redirect, transfers most of the ranking signal (link equity) to the new target URL, and eventually drops the old URL from the index. It is not lossless — there is some decay on each hop — but it preserves the majority of value versus a 404.

### Proposed redirect map

| Old URL (WordPress) | New target | Notes |
|---|---|---|
| `/servicing-repairs/mot-services-in-potters-bar-en6-2qs/` | `/services.html#mot` | Best available match |
| `/servicing-repairs/car-servicing-in-totteridge-n20/` | `/services.html#servicing` | Area-specific — consider a dedicated page instead |
| `/servicing-repairs/exhaust-repair-in-enfield/` | `/services.html#exhausts` | Area-specific — consider a dedicated page instead |
| `/servicing-repairs/mot-services-in-totteridge/` | `/services.html#mot` | Area-specific — consider a dedicated page instead |
| `/servicing-repairs/diagnostics-in-potters-bar-en6/` | `/services.html#diagnostics` | Best available match |
| `/servicing-repairs/car-servicing-barnet-en4/` | `/services.html#servicing` | Area-specific — consider a dedicated page instead |
| `/servicing-repairs/air-conditioning-servicing-in-potters-bar-en6/` | `/services.html#aircon` | Best available match |
| `/servicing-repairs/signs-that-exhaust-system-needs-repair/` | `/services.html#exhausts` | Informational — consider blog reinstatement |
| `/servicing-repairs/car-care-and-assisted-living/` | `/index.html` | Niche — homepage is closest match |
| `/blog/` | `/services.html` | Blog index → Services |
| `/about/` | `/about.html` | Direct equivalent |
| `/contact/` | `/contact.html` | Direct equivalent |
| `/category/servicing-repairs/` | `/services.html` | WordPress category archive |

### Implementing redirects on GitHub Pages

GitHub Pages does not natively support server-side 301 redirects. Options:

**Option A — Migrate to Netlify or Cloudflare Pages (recommended)**
Both support a plain-text `_redirects` file (Netlify) or `_redirects` / `redirects` config (Cloudflare Pages) that issues proper HTTP 301s. Example Netlify `_redirects` file:

```
/servicing-repairs/mot-services-in-potters-bar-en6-2qs/   /services.html#mot   301
/servicing-repairs/diagnostics-in-potters-bar-en6/         /services.html#diagnostics   301
/about/                                                      /about.html   301
/contact/                                                    /contact.html   301
```

**Option B — Stay on GitHub Pages, use meta-refresh**
Add an HTML file at each old path with `<meta http-equiv="refresh" content="0; url=/services.html#mot">`. This is not a true HTTP 301 and Google treats it as a softer signal, but it is better than a 404. Labour-intensive for 13 paths.

**Option C — Handle redirects at the DNS/CDN layer**
If using Cloudflare as the DNS provider (common), Cloudflare's "Redirect Rules" (free tier supports up to 3 rules; paid supports bulk) can issue HTTP 301s before the request even hits the origin server.

---

## Structured Data / Schema Markup

Neither site currently uses structured data. This is a missed opportunity. Schema.org markup is JSON-LD embedded in `<script type="application/ld+json">` tags — it does not affect page rendering but gives Google a machine-readable description of your business, services, and reviews.

Recommended schema types for this site:

**LocalBusiness / AutoRepair** — tells Google this is a physical garage with a specific address, phone, and opening hours. Powers the Knowledge Panel and improves local pack eligibility.

```json
{
  "@context": "https://schema.org",
  "@type": "AutoRepair",
  "name": "Potters Bar Garage",
  "address": {
    "@type": "PostalAddress",
    "streetAddress": "Unit A, 12 Barnet Road",
    "addressLocality": "Potters Bar",
    "addressRegion": "Hertfordshire",
    "postalCode": "EN6 2QS",
    "addressCountry": "GB"
  },
  "telephone": "+441707644465",
  "email": "info@pbgarage.co.uk",
  "url": "https://pottersbargarage.co.uk",
  "openingHoursSpecification": [
    {
      "@type": "OpeningHoursSpecification",
      "dayOfWeek": ["Monday","Tuesday","Wednesday","Thursday","Friday"],
      "opens": "08:00",
      "closes": "18:00"
    },
    {
      "@type": "OpeningHoursSpecification",
      "dayOfWeek": "Saturday",
      "opens": "08:00",
      "closes": "13:00"
    }
  ]
}
```

**Review / AggregateRating** — marks up the testimonials already on the page. Can generate star ratings in search result snippets (rich results), which improve click-through rate.

**Service** — one block per service offered. Improves relevance for service-specific queries.

---

## Image Alt Text

Once images are added, replace the current generic alt text with descriptive strings. Google reads alt text as a content signal for the surrounding context.

| Current alt text | Suggested replacement |
|---|---|
| `alt="servicing"` | `alt="car servicing bay at Potters Bar Garage, Hertfordshire"` |
| `alt="mot"` | `alt="MOT testing lane at Potters Bar Garage"` |
| `alt="diagnostics"` | `alt="vehicle diagnostics equipment at Potters Bar Garage"` |
| `alt="brakes"` | `alt="brake disc and calliper inspection"` |
| `alt="batteries"` | `alt="car battery replacement service"` |
| `alt="aircon"` | `alt="air conditioning regas service"` |
| `alt="exhausts"` | `alt="car exhaust repair and replacement"` |
| `alt="bodywork"` | `alt="bodywork and respray in Potters Bar Garage bodyshop"` |
| `alt="wheel"` | `alt="4-wheel laser alignment using Hunter Pro Align machine"` |
| `alt="electric"` | `alt="electric and hybrid vehicle servicing"` |
| `alt="Potters Bar Garage mechanic"` | `alt="Potters Bar Garage mechanic working in the workshop"` |

---

## Sitemap and robots.txt

Both are trivial to add as static files in the repo root.

**sitemap.xml** — list all crawlable URLs:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="https://www.sitemaps.org/schemas/sitemap/0.9">
  <url><loc>https://pottersbargarage.co.uk/</loc><priority>1.0</priority></url>
  <url><loc>https://pottersbargarage.co.uk/about.html</loc><priority>0.8</priority></url>
  <url><loc>https://pottersbargarage.co.uk/services.html</loc><priority>0.9</priority></url>
  <url><loc>https://pottersbargarage.co.uk/contact.html</loc><priority>0.7</priority></url>
</urlset>
```

**robots.txt** — permissive default, point to sitemap:

```
User-agent: *
Allow: /
Sitemap: https://pottersbargarage.co.uk/sitemap.xml
```

Submit the sitemap URL in Google Search Console after cutover to prompt re-crawl.

---

## Google Business Profile

The existing Google Business Profile (Maps listing) is a separate data source from the website. It survives the DNS migration, but two things need updating post-cutover:

1. **Website URL field** — update from the WordPress URL to the new domain (same domain in this case, so only needed if hosting changes the canonical URL).
2. **Verify NAP consistency** — Name, Address, Phone must be identical across the website, Google Business Profile, and Facebook page. Inconsistencies reduce local search trust signals.

The profile also supports:
- **Posts** (like mini blog entries, appear in the Knowledge Panel) — low effort, marginal SEO benefit
- **Q&A** — seeding your own questions/answers improves the panel
- **Photos** — more photos = better engagement signals in Maps

---

## Recommended Next Steps (Priority Order)

### Pre-cutover (do before changing DNS)

1. **Check Google Search Console** on the existing domain.
   - Go to Search Console → Performance → Pages tab
   - Export the list of URLs that have received impressions/clicks in the last 3–6 months
   - This tells you which pages are actually earning traffic — only those need redirect attention
   - If the owner has never set up Search Console, do it now and wait 1–2 weeks before cutting over

2. **Decide on hosting platform** — GitHub Pages cannot issue HTTP 301s natively. Recommend migrating to Netlify or Cloudflare Pages (both free tier, both support `_redirects` config files, both deploy from a GitHub repo directly).

3. **Write the `_redirects` file** using the redirect map in Section 4, refined by the Search Console data from step 1.

4. **Add `sitemap.xml` and `robots.txt`** to the repo root (templates above).

5. **Add LocalBusiness schema markup** to `index.html` `<head>` (template in Section 5).

6. **Fix image alt text** — update once images are added (table in Section 7).

7. **Fix social media `href="#"` placeholders** — broken/self-links are a minor crawl signal issue.

### Post-cutover

8. **Submit sitemap in Google Search Console** for the new site (add new property if domain/URL changes).

9. **Monitor crawl errors** in Search Console for 2–4 weeks — watch for 404s on old URLs that weren't captured in the redirect map.

10. **Update Google Business Profile** website URL if applicable.

11. **Verify NAP consistency** across site, Google Business Profile, and Facebook.

### Medium-term (1–3 months post-launch)

12. **Consider reinstating 2–3 area/service landing pages** for the highest-traffic articles identified in step 1 — e.g. a static `/mot-potters-bar/` page. These do not need to be a blog; they can be clean service pages with local copy.

13. **Add AggregateRating schema markup** to the testimonials section — potential to generate star ratings in Google search snippets.

14. **Audit Core Web Vitals** using Google PageSpeed Insights (pagespeed.web.dev) once the new site is live on the real domain. Static HTML should score well but images need to be properly sized and served in modern formats (WebP preferred over JPEG/PNG for web).

15. **Consider adding `<meta name="description">` tags** to all pages if not already present — these appear as the snippet text in search results and directly affect click-through rate, though they are not a direct ranking signal.

---

## Quick Reference — Files to Add to Repo

```
/
├── robots.txt
├── sitemap.xml
├── _redirects          ← Netlify/Cloudflare Pages redirect rules (if migrating off GitHub Pages)
├── index.html          ← Add LocalBusiness schema in <head>
├── about.html
├── services.html
├── contact.html
└── images/             ← All missing service/mechanic images go here
```

---

*End of SEO-HANDOFF.md*
