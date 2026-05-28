# HANDOFF.md — Potters Bar Garage Website Comparison

**Date of analysis:** 15 May 2026
**Analyst:** Claude (Anthropic)
**Task:** Compare the original live site with a modernised static replacement, identifying strengths, weaknesses, missing images, and technical improvements.

---

## Sites Analysed

| | URL |
|---|---|
| **Original (live)** | https://pottersbargarage.co.uk/ |
| **Modernised (replacement)** | https://tarne75.github.io/pottersbargarage-alt/index.html |

---

## 1. Platform & Stack

| Aspect | Original | Modernised |
|---|---|---|
| Platform | WordPress (built by AppwithWeb) | Static HTML/CSS — no CMS |
| Copyright year | 2022 (outdated) | 2025 (current) |
| Hosting | Managed WordPress hosting | GitHub Pages |
| Plugin/theme dependencies | Yes — AppwithWeb ecosystem | None |
| Security surface | WordPress + plugins (update/vulnerability risk) | Minimal — no server-side code |

---

## 2. Pages / Site Structure

### Original site pages
- Home
- About
- Services *(dropdown links to individual SEO blog articles, not a unified services page)*
- Blog *(9 SEO-targeted articles — see Section 8)*
- Contact

### Modernised site pages
- Home (index.html)
- About (about.html)
- Services (services.html) — *single page, all 10 services as anchor-linked sections*
- Contact (contact.html)

> **Note:** The Blog section has been removed entirely in the modernised version. This is a trade-off — the original blog provides local SEO value (articles targeting Totteridge, Enfield, Barnet, Potters Bar EN6 keywords). Consider whether to reinstate a blog or equivalent SEO content before going live.

---

## 3. Navigation & Header

| Feature | Original | Modernised |
|---|---|---|
| Top utility bar | Phone + email as plain text only | Address, hours, phone (tel: link), email (mailto: link) — all clickable |
| Main nav | Home / About / Services dropdown / Blog / Contact | Home / About / Services dropdown / Contact |
| Services dropdown items | Generic — links to blog-style SEO articles | All 10 services listed, each anchor-linked to #section on services.html |
| Header CTAs | Single "Appointment" button | "Call Now" (tel: link) + "Book Appointment" buttons |
| Mobile nav | Hamburger toggle | Dedicated mobile nav block with all service sub-links listed |
| Breadcrumbs | None | Present on all inner pages (e.g. Home › About) |

---

## 4. Homepage Sections

| Section | Original | Modernised |
|---|---|---|
| Hero | Full-width banner, animated text in three lines, 2 CTAs | Clean hero with tagline, 2 CTAs, 3 stat badges (15+ yrs / 3 bays / 10 services) |
| Pricing cards | Car MOT £130, Bike MOT £100 | Same + third card for Electric & Hybrid |
| About intro | Standard welcome paragraph | Mechanic image (missing — see Section 6), 4 illustrated selling points, "Learn More" CTA |
| Services grid | 10 tiles with icon images, brief text — no links from tiles | 10 fully-linked cards with image, description, and "Learn more →" anchor link |
| Statistics / trust signals | None | Two stats bars: 15+ yrs / 3 bays / 10 services (hero) and 15+ yrs / 3 bays / 1,000+ customers / 10 services (mid-page) |
| Testimonials | 6 reviews, plain text, 2-column block, "Read All Reviews" → Google | Same 6 reviews with ★★★★★ stars, initials avatars, and "Google Review" source labels |
| CTA strip | "GET IN TOUCH" button | "Ready to Book?" strip with "Book Online" + phone number buttons |
| Location / map | None on homepage | "Find Us" section with address, hours table, contact links (no embedded map) |
| Footer | Single-column: about text, hours, social icons, contact, copyright | Three-column: about + social / Services links / Quick Links + Contact block |

---

## 5. Inner Pages

### About
| | Original | Modernised |
|---|---|---|
| Content | Single block, 4 icon badges, 1 CTA | Expanded copy, 4 selling points with fuller descriptions, stats badges, CTA strip, breadcrumb |

### Services
| | Original | Modernised |
|---|---|---|
| Structure | No unified services page — links to blog SEO articles | Dedicated page, 10 services as full-paragraph sections with named anchors (#mot, #servicing, #brakes, etc.) |

### Contact
| | Original | Modernised |
|---|---|---|
| Form fields | Name, Phone, Email, Car Reg, Message | First Name, Last Name, Email, Phone, **Service Required** (dropdown, 12 options), Vehicle Reg, **Preferred Date** (date picker), Additional Information |
| Spam protection | Google reCAPTCHA (present) | Not detected — **needs adding before go-live** |
| Map | None | None |

### Blog
| | Original | Modernised |
|---|---|---|
| Present | Yes — 9 articles | **Removed** |
| Article topics | Car Care & Assisted Living, Exhaust Repair, Car Servicing Totteridge N20, Exhaust Repair Enfield, MOT Totteridge, MOT Potters Bar EN6 2QS, Diagnostics Potters Bar EN6, Car Servicing Barnet EN4, Air Conditioning Potters Bar EN6 | N/A |

---

## 6. Missing Images

> *(The user is already aware images are missing — this section records exactly which images are absent and where.)*

### Modernised site — missing images (GitHub Pages repo gaps)
All images are referenced in the HTML with `<img>` tags and descriptive alt text, but the actual image files have not been uploaded to the repository. Images needed:

| Page | Image description (alt text) | Location in page |
|---|---|---|
| index.html | "Potters Bar Garage mechanic" | About section |
| index.html | "servicing" | Services card |
| index.html | "mot" | Services card |
| index.html | "diagnostics" | Services card |
| index.html | "brakes" | Services card |
| index.html | "batteries" | Services card |
| index.html | "aircon" | Services card |
| index.html | "exhausts" | Services card |
| index.html | "bodywork" | Services card |
| index.html | "wheel" | Services card |
| index.html | "electric" | Services card |
| about.html | (mechanic / workshop image implied by layout) | Story section |
| services.html | Likely one per service section | All 10 service sections |

The **logo image** is present and loads correctly on all pages.

### Original site — image status
Service tile icon images (technical-support, mechanic, diagnostic, service, Diagnostics, MoT, exhaust-pipe, battery, air-conditioning, disc-brake, body-repair, wheel-alignment, electric-car) are referenced from WordPress media library. These appear functional on the live site but would need to be migrated/replaced if/when the WordPress site is retired.

---

## 7. Technical Feature Comparison

| Feature | Original | Modernised |
|---|---|---|
| Clickable phone numbers (tel:) | ✗ Plain text | ✓ All instances |
| Clickable email (mailto:) | ✗ Plain text | ✓ All instances |
| Anchor-linked service sections | ✗ | ✓ #mot, #servicing, #brakes, etc. |
| Contact form service selector | ✗ | ✓ Dropdown, 12 options |
| Contact form date picker | ✗ | ✓ Preferred Date field |
| URL params to pre-fill booking type | ✗ | ✓ ?type=car-mot / ?type=bike-mot |
| Breadcrumb navigation | ✗ | ✓ On all inner pages |
| Statistics / social proof counters | ✗ | ✓ Multiple locations |
| Star ratings on testimonials | ✗ | ✓ ★★★★★ on all 6 reviews |
| Reviewer initials avatars | ✗ | ✓ |
| Google Review source attribution | ✗ | ✓ |
| reCAPTCHA / spam protection | ✓ Google reCAPTCHA | ✗ Not detected — needs adding |
| Accessibility widget | ✓ Third-party overlay | ✗ Not present |
| CMS / WordPress dependency | ✓ (risk) | ✗ None — static HTML |
| Blog / SEO articles | ✓ 9 articles | ✗ Removed |
| Working social media links | ✓ Facebook + Google links real | ✗ Both href="#" — placeholders only |
| Embedded map | ✗ | ✗ |
| Trade association badge/logo | Referenced in About ("Proud members") | ✗ Image missing |

---

## 8. SEO Considerations

The original site has 9 blog articles targeting local search terms:
- "MOT services in Potters Bar EN6 2QS"
- "Car Servicing in Totteridge N20"
- "Exhaust Repair in Enfield"
- "MOT Services in Totteridge"
- "Diagnostics in Potters Bar EN6"
- "Car Servicing Barnet EN4"
- "Air Conditioning Servicing in Potters Bar EN6"
- "Signs that Exhaust System Needs Repair"
- "Car Care and Assisted Living"

The modernised site removes these entirely. Before launching the replacement, consider:
1. Auditing whether any of these articles rank in Google Search Console.
2. Either migrating the articles as a blog or rewriting the content as static service/area landing pages.
3. Setting up 301 redirects from the old article URLs to relevant sections of the new site.

---

## 9. Overall Strengths & Weaknesses

### Original site
**Strengths**
- Live and functional with real working links
- Blog provides local SEO value (9 targeted articles)
- reCAPTCHA spam protection on contact form
- Third-party accessibility widget present
- Social media links are real and working
- Established Google Maps presence (link to Google Business)

**Weaknesses**
- Phone and email are plain text — not tappable on mobile
- No breadcrumb navigation
- Services "dropdown" links to blog articles, not a proper services page
- Contact form lacks service type selector and date preference
- Footer is minimal (single column)
- Copyright shows 2022
- No statistics, counters, or trust signals
- WordPress dependency — ongoing maintenance and security overhead
- Trailing hyphen in page `<title>` tag (minor SEO issue)

---

### Modernised site
**Strengths**
- Clickable tel: and mailto: links throughout
- Dedicated Services page with anchor-linked sections
- Dropdown nav lists all 10 services individually
- Richer contact form (service selector, date picker, pre-fill via URL params)
- Breadcrumbs on all inner pages
- Statistics bars and social proof counters
- Polished testimonial block with stars, avatars, and source labels
- No CMS/plugin overhead — fast, secure static HTML
- Mobile nav is more comprehensive
- Copyright updated to 2025
- Clean, consistent three-column footer
- URL parameters for pre-selecting booking type

**Weaknesses / Outstanding tasks before go-live**
- **All service images are missing** — highest priority
- Social media links are `href="#"` placeholders — need real URLs
- reCAPTCHA or equivalent spam protection missing from contact form
- Blog removed — SEO content gap needs addressing (see Section 8)
- No embedded Google Map anywhere
- Accessibility widget not present
- Trade association badge image missing (About page)
- Site currently hosted on GitHub Pages, not the live domain — DNS/hosting migration needed

---

## 10. Recommended Next Steps (Priority Order)

1. **Upload all missing images** to the GitHub Pages repository (service cards, mechanic photo, about page image, trade association badge).
2. **Fix social media links** — replace `href="#"` with real Facebook and Google Business URLs.
3. **Add spam protection** to the contact form (reCAPTCHA v3 or equivalent).
4. **SEO audit** — check Google Search Console for the original site; identify which blog articles rank before removing them.
5. **Plan blog/SEO content strategy** — either migrate articles, write new ones, or create area/service landing pages.
6. **Add an embedded Google Map** to the Contact page.
7. **Accessibility review** — consider re-adding an accessibility widget or conducting a manual WCAG audit.
8. **Set up 301 redirects** for all old WordPress URL paths before DNS cutover.
9. **Test contact form end-to-end** — confirm form submissions are delivered (GitHub Pages has no server-side processing; a service like Formspree, Netlify Forms, or EmailJS will be needed).
10. **DNS migration** — point pottersbargarage.co.uk to GitHub Pages (or preferred new host) once all above are resolved.

---

*End of HANDOFF.md*
