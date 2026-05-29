# Potters Bar Garage — Modernised Website

A static HTML/CSS replacement for [pottersbargarage.co.uk](https://pottersbargarage.co.uk), currently staging at [tarne75.github.io/pottersbargarage-alt](https://tarne75.github.io/pottersbargarage-alt/index.html).

## What this is

The original site runs on WordPress (built by AppwithWeb) and carries the usual CMS overhead: plugin dependencies, security update cycles, a 2022 copyright footer, and phone/email displayed as plain text with no tap-to-call. This repo is a clean-sheet rebuild as a four-page static site — no CMS, no server-side code, no dependencies beyond a Google Font and Formspree for the contact form.

## Pages

| File | Page |
|---|---|
| `index.html` | Home — hero, pricing cards, about intro, all 10 service cards, testimonials, stats, CTA, find us |
| `about.html` | About — expanded story, selling points, stats, CTA strip |
| `services.html` | Services — all 10 services as anchor-linked sections with illustrative images |
| `contact.html` | Contact & Booking — Formspree form, contact details, Google Maps embed |

## Improvements over the original

- All phone numbers and email addresses are tappable (`tel:` / `mailto:`) throughout
- Dedicated Services page with anchor links (`#mot`, `#servicing`, `#brakes`, etc.) — the original has no unified services page
- Richer contact form: service type dropdown (12 options), preferred date picker, pre-fill via URL params (`?type=car-mot`)
- Breadcrumb navigation on all inner pages
- Statistics bars and social proof counters
- Testimonial block with ★★★★★ stars, initials avatars, and Google Review attribution
- Real social links (Facebook, Google Business) in footer across all pages
- Embedded Google Map on the Contact page
- Three-column footer replacing the original minimal single-column layout
- No WordPress/plugin dependency — faster, more secure, zero maintenance overhead

## Stack

- Plain HTML5 + CSS custom properties (no framework)
- Google Fonts (Open Sans)
- [Formspree](https://formspree.io) for contact form submission (`/f/xwvndkow`)
- GitHub Pages hosting (staging); target host: pottersbargarage.co.uk

## Outstanding before go-live

- **Accessibility widget** — AccessiYes (CookieYes) — register once the site is live at the real domain
- **Spam protection** — Formspree's built-in filtering or ALTCHA
- **SEO/blog** — original site has 9 locally-targeted blog articles; audit Google Search Console before DNS cutover and set up 301 redirects
- **DNS migration** — add `CNAME`, update DNS records, enable HTTPS via GitHub Pages

See `CLAUDE-TASKS-HANDOFF.md` for full detail on all outstanding items and technical notes.
