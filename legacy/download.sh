#!/usr/bin/env bash
# =============================================================================
# legacy/download.sh — Mirror pottersbargarage.co.uk into legacy/
#
# Run from the repo root:
#   cd /Users/tarnewestcott/Development/pottersbargarage
#   bash legacy/download.sh
#
# What it does:
#   Step 1 — wget --mirror crawls all HTML pages, CSS, JS and any images
#             it can reach without a Referer header.
#   Step 2 — curl loop downloads every known image explicitly, with the
#             Referer header the WordPress CDN requires.
#   Step 3 — Reports any images that still failed and writes failed-images.txt.
#             Open legacy/download-images.html in a browser to save those manually.
#
# After a successful run:
#   git add legacy/
#   git commit -m "Add legacy site mirror from pottersbargarage.co.uk"
#   git push
# =============================================================================

set -euo pipefail

BASE="https://pottersbargarage.co.uk"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"   # .../pottersbargarage/legacy/
SITE_DIR="$SCRIPT_DIR/pottersbargarage.co.uk" # Web root inside legacy/
UA="Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36"

echo "============================================"
echo " Potters Bar Garage — Legacy Site Mirror"
echo " Destination: $SCRIPT_DIR"
echo "============================================"
echo ""

# ── Step 1: Mirror HTML, CSS, JS ────────────────────────────────────────────
echo "==> Step 1: Crawling HTML pages and assets..."
echo "    (This may take a few minutes)"
echo ""

wget \
  --mirror \
  --page-requisites \
  --no-parent \
  --convert-links \
  --adjust-extension \
  --directory-prefix="$SCRIPT_DIR" \
  --user-agent="$UA" \
  --header="Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,*/*;q=0.8" \
  --header="Accept-Language: en-GB,en;q=0.9" \
  --header="Referer: https://pottersbargarage.co.uk/" \
  --wait=0.5 \
  --random-wait \
  --limit-rate=800k \
  --no-check-certificate \
  --reject "wp-login*,wp-admin*,xmlrpc*,wp-json*,feed*,*replytocom*,*?p=*,*?page_id=*" \
  --exclude-domains "fonts.googleapis.com,fonts.gstatic.com,www.google.com,maps.googleapis.com" \
  "$BASE/" \
  2>&1 | tee "$SCRIPT_DIR/download.log"

echo ""
echo "==> Step 1 complete."
echo ""

# ── Step 2: Explicit image download with Referer header ─────────────────────
# WordPress CDN blocks image requests without a valid Referer.
# All image paths are listed here verbatim from the XML sitemaps.
echo "==> Step 2: Downloading known images explicitly..."
echo ""

IMAGES=(
  # ── Homepage service icons ──
  "wp-content/uploads/elementor/thumbs/technical-support-2-po30b5fetw725dex3vrvqbxkqmy4zipe2n73c1oupg.png"
  "wp-content/uploads/elementor/thumbs/mechanic-2-po30cm2dgm747jagkiizlyne07qoykicxvqa7jit10.png"
  "wp-content/uploads/elementor/thumbs/diagnostic-2-po30d4v59awunqj5iqniztwlvx618ikzogrzt2qxkk.png"
  "wp-content/uploads/elementor/thumbs/service-1-po30dtaybdpy7ed0zxay09mffo8qntll1074wesf2w.png"
  "wp-content/uploads/elementor/thumbs/Diagnostics-1-po30eex8okjjmfhmhond3m613ja6kuzerz7axrwd3s.png"
  "wp-content/uploads/elementor/thumbs/MoT-1-po30eynuo3ake8oyaf6j1z6pkmkw2i5ruowi0l33h4.png"
  "wp-content/uploads/elementor/thumbs/exhaust-pipe-1-po30fiegnm1l61wa35pp0c7e1pvlk5c4xelp3e9tug.png"
  "wp-content/uploads/elementor/thumbs/battery-1-po30g4yl7mwgwoziffgqo6igayseovtp0i9cm1cdp4.png"
  "wp-content/uploads/elementor/thumbs/air-conditioning-1-po30gqkvktq2bq43x6t5rj21yttulx7irh9inegbq0.png"
  "wp-content/uploads/elementor/thumbs/disc-brake-2-1-po30h5mam6anhhi9hdb6vf9fgzrq12v85jpabtu0yg.png"
  "wp-content/uploads/elementor/thumbs/body-repair-1-po30hs6f675j84lhtn28j9khq8oj5tcs8ncxugwkt4.png"
  "wp-content/uploads/elementor/thumbs/wheel-alignment-1-1-po30ibx15pwjzxstmdlehml67bz8ngj5bd24xa3b6g.png"
  "wp-content/uploads/elementor/thumbs/electric-car-1-po30j36cnwxvcmp877dkzxpjfi8vuojd33z7uayw60.png"
  "wp-content/uploads/2022/04/Trade-association.png"
  # ── About page ──
  "wp-content/uploads/2022/04/mechanic-1-1.png"
  "wp-content/uploads/2022/04/dollar.png"
  "wp-content/uploads/2022/04/shield.png"
  "wp-content/uploads/2022/04/stopwatch.png"
  # ── Services page ──
  "wp-content/uploads/elementor/thumbs/Servicing-1-po30xbgi9qag4qfis32rweo6blz9jszc45ml9wyx14.jpg"
  "wp-content/uploads/elementor/thumbs/maxim-hopman-s4d_ESS0ylA-unsplash-1-1-po30tqom9fe5y5mko1evwt60xtlz99s3yg92j09upk.jpg"
  "wp-content/uploads/2022/04/7-2.png"
  "wp-content/uploads/elementor/thumbs/8-1-pn09lbe8gmgsuj7se0y5ra0kg14epxezutxjh6b3eo.png"
  "wp-content/uploads/elementor/thumbs/5-2-pn09l7mvpabnk3d8zzbnhayq2hmxv502ibblk2go3k.png"
  "wp-content/uploads/elementor/thumbs/9-pn09lv4ug57tmcf46rhbpn18x4f47klcxjmqjzhts0.png"
  "wp-content/uploads/2022/04/4-2.png"
  "wp-content/uploads/elementor/thumbs/updated-1-pn09lrdhot2obwkksputfnzejkxncs6fl10smvnegw.png"
  "wp-content/uploads/elementor/thumbs/up-pn09lojz4aytd2oo96mxq6p0rfbjpov8kn2c71rkzk.png"
  "wp-content/uploads/elementor/thumbs/chuttersnap-xJLsHl0hIik-unsplash-2-po30wgfu073zhlokt7o344hypw85hsk6zw3kfs8wqg.jpg"
  # ── Individual service pages ──
  "wp-content/uploads/elementor/thumbs/9-pn09lv4ug57je1qz0q53g348q770kmlrmsvtq4dsjo.png"
  "wp-content/uploads/elementor/thumbs/4-2-pn09lh19lmo8jwbgb21owoobtf4id61skv3jiyyp50.png"
  "wp-content/uploads/elementor/thumbs/5-2-pn09l7mvpabdbsp3txzf7r1pvkeu870h7kkoq7cmv8.png"
  "wp-content/uploads/elementor/thumbs/updated-1-pn09lrdhot2e3lwfmoil642ecnpjpu6uaa9vt0jd8k.png"
  "wp-content/uploads/elementor/thumbs/maxim-hopman-s4d_ESS0ylA-unsplash-1-pmx7jychybnhbin8so2aaczu80y5kf3d95xhwkqx1g.jpg"
  "wp-content/uploads/elementor/thumbs/chuttersnap-xJLsHl0hIik-unsplash-1-pn0btjw9uiannxzxp66gtz71q6f94uyjx7xqem891g.jpg"
  "wp-content/uploads/elementor/thumbs/8-1-pn09lbe8gmgim8jn7zlxhq3k93wb2zfek36mnb726c.png"
  "wp-content/uploads/elementor/thumbs/7-2-pn09kwctf9vxgh5hnt3wdtw6qxyfntrp60quyvtcxw.png"
  "wp-content/uploads/elementor/thumbs/Servicing-pmx6u3sa0c9m1k6xqhtmpvti4kcrw2h3p82ssn2o5g.jpg"
  "wp-content/uploads/elementor/thumbs/up-pn09lojz4ayj4s0j35apgms0ki3g2qvn9wbfd6njr8.png"
  # ── Elementor plugin placeholder ──
  "wp-content/plugins/elementor/assets/images/placeholder.png"
)

FAILED=()
OK=0
SKIPPED=0

for IMG_PATH in "${IMAGES[@]}"; do
  FULL_URL="$BASE/$IMG_PATH"
  LOCAL_PATH="$SITE_DIR/$IMG_PATH"

  if [ -f "$LOCAL_PATH" ]; then
    echo "  [skip] $IMG_PATH"
    SKIPPED=$((SKIPPED + 1))
    continue
  fi

  mkdir -p "$(dirname "$LOCAL_PATH")"

  HTTP_CODE=$(curl -s -o "$LOCAL_PATH" -w "%{http_code}" \
    --max-time 30 \
    -L \
    -A "$UA" \
    -H "Referer: $BASE/" \
    -H "Accept: image/avif,image/webp,image/apng,image/svg+xml,image/*,*/*;q=0.8" \
    -H "Accept-Language: en-GB,en;q=0.9" \
    -H "Sec-Fetch-Dest: image" \
    -H "Sec-Fetch-Mode: no-cors" \
    -H "Sec-Fetch-Site: same-origin" \
    "$FULL_URL" 2>/dev/null || echo "000")

  if [ "$HTTP_CODE" = "200" ]; then
    SIZE=$(wc -c < "$LOCAL_PATH")
    echo "  [ok]   $IMG_PATH  (${SIZE} bytes)"
    OK=$((OK + 1))
  else
    echo "  [fail] $IMG_PATH  (HTTP $HTTP_CODE)"
    rm -f "$LOCAL_PATH"
    FAILED+=("$FULL_URL")
  fi
done

# ── Step 3: Report ───────────────────────────────────────────────────────────
echo ""
echo "============================================"
echo " Summary"
echo "============================================"
echo " Images downloaded : $OK"
echo " Images skipped    : $SKIPPED  (already existed)"
echo " Images failed     : ${#FAILED[@]}"

if [ ${#FAILED[@]} -gt 0 ]; then
  echo ""
  echo " The following images could not be downloaded:"
  printf '   %s\n' "${FAILED[@]}"
  printf '%s\n' "${FAILED[@]}" > "$SCRIPT_DIR/failed-images.txt"
  echo ""
  echo " => Open legacy/download-images.html in your browser to save them manually."
  echo "    Then re-run this script — it will skip already-downloaded files."
fi

echo ""
echo "==> Done. To commit everything:"
echo "    git add legacy/"
echo "    git commit -m 'Add legacy site mirror from pottersbargarage.co.uk'"
echo "    git push"
echo ""
