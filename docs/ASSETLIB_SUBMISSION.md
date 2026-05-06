# Asset Library Submission Guide

This document contains everything you need to submit **Debug API** to the
Godot Asset Library at <https://godotengine.org/asset-library/asset>.

The form lives at **Asset Library → Upload Asset** (you need a Godot account).

---

## ⚠️ License correction

The form draft you started had **CC0 1.0 Universal** selected. CC0 explicitly
**waives** every right including attribution — anyone could ship the addon as
their own with no credit.

This repository now ships with **MIT License** (see `LICENSE`):

* free for any use, commercial or not,
* free to modify and redistribute,
* requires keeping the copyright notice in copies — *that's how you get
  credited automatically*.

When filling the form, change the **License** dropdown to **MIT License**.

---

## 📝 Form fields — copy/paste ready

### Asset Name

```
Debug API
```

> Tip: the form already has "DebugAPI" — switch to "Debug API" with a space,
> it reads better in the asset list and matches `addons/debug_api/plugin.cfg`.

### Description

Paste this verbatim. It uses Markdown lite — Godot's Asset Library renders
basic formatting.

```
Universal, scalable, production-ready debugging system for Godot 4.x.

Drop the addon, enable the plugin, and get 50+ built-in monitors (FPS, memory, GPU, draw calls, physics, scene tree, audio, network, system info, ...) with one line of code:

    DebugAPI.enable_monitor_preset("essential")

Or build your own panels with declarative widgets — bind a value to a TextWidget / ProgressWidget / GraphWidget / ConditionalWidget / TimerWidget / VectorWidget and it auto-refreshes. Smart-diff updates and per-widget rate limiting keep the panel under 1 ms/frame even with 50+ widgets active.

FEATURES
• 50+ built-in monitors organised in 12 categories (performance, memory, objects, rendering, physics, audio, display, system, time, input, scene, network)
• 8 named presets (minimal, essential, performance, memory, rendering, system, display, full)
• 7 built-in themes (Default, Dark, Light, Neon, Retro, Minimal, Solarized) + full custom
• 4 install modes: editor plugin (recommended), manual autoload, drop-in DebugBootstrap node, pure instance via preload
• Inspector-driven configuration via a DebugSettings resource
• 8 anchor presets (corners, edges, centre, free) with edge_margin and viewport-aware repositioning
• Optional title bar, collapsible sections, scrollable panels, custom font support, click-through
• Hotkeys via InputMap actions or raw keycodes; global toggle and export shortcuts
• TXT / JSON / CSV export with auto-detection by file extension; auto-export on interval
• Settings persistence: snapshot_settings() + save/load to .tres
• Zero-code config: drop res://debug_settings.tres and the API auto-applies it on _ready
• Headless-safe; runs on Forward+, Mobile and Compatibility renderers
• Multi-language documentation (English, Español, Français, Deutsch, Português) included
• Godot 4.0+ (tested on 4.4.1)

DOCUMENTATION
Full README with step-by-step tutorial, monitor catalogue, widget reference, theme gallery, configuration reference, hotkeys, export guide, performance notes, troubleshooting and complete API reference at the repository.

LICENSE
MIT — free for any use, attribution preserved via the copyright notice.
```

### Category

```
Tools
```

### License

```
MIT License
```

> **Change** from CC0 1.0 Universal — see the warning at the top of this file.

### Repository host

```
GitHub
```

### Repository URL

```
https://github.com/arugerdev/debug-api-godot
```

### Issues URL

```
https://github.com/arugerdev/debug-api-godot/issues
```

### Minimum Godot version

```
4.0
```

> Verified during development on Godot 4.4.1, but no 4.4-only APIs are used.
> If you want to be extra-safe with Asset Library users on 4.0/4.1/4.2/4.3,
> keep `4.0` so it appears for all of them.

### Asset Version

```
1.0
```

### Download Commit/URL

After pushing the v1.0 code to `main`, run:

```bash
git rev-parse HEAD
```

…or, on GitHub: open the repo → click the latest commit (top of the file
list) → the **40-character hash** in the URL (e.g.
`github.com/arugerdev/debug-api-godot/commit/<HASH>`).

Paste that 40-char hash into the form. Do **not** paste the short 7-char
version — the Asset Library expects the full hash.

If you'd rather host a pre-zipped release, switch the form's **download
provider** to *Custom* and paste the full URL of a GitHub Release ZIP.

### Icon URL

After committing the new files and pushing, host the icon via GitHub's raw
content URL:

```
https://raw.githubusercontent.com/arugerdev/debug-api-godot/main/addons/debug_api/icon.svg
```

> **Note**: the Asset Library form text says *(png|jpg)*. Although Godot
> renders SVG everywhere internally, **convert `icon.svg` to PNG** for the
> Asset Library form to be safe. See the *Generating PNGs* section below.

Recommended PNG path:

```
https://raw.githubusercontent.com/arugerdev/debug-api-godot/main/docs/branding/icon.png
```

### Preview images (3 recommended)

For each preview, click *Add preview → Enable*, set **Type = Image**, then:

| # | Image Link | Thumbnail Link |
|---|---|---|
| 1 | `https://raw.githubusercontent.com/arugerdev/debug-api-godot/main/docs/branding/preview-1-auto-monitors.png` | same URL or a 320×180 crop |
| 2 | `https://raw.githubusercontent.com/arugerdev/debug-api-godot/main/docs/branding/preview-2-themes.png` | same URL or a 320×180 crop |
| 3 | `https://raw.githubusercontent.com/arugerdev/debug-api-godot/main/docs/branding/preview-3-custom-panels.png` | same URL or a 320×180 crop |

If you have time, also capture **real screenshots** of the addon running in
your project (preset `full`, theme `neon`, with one custom panel visible) and
add them as a 4th and 5th preview. Real screenshots are always more
convincing than mockups.

---

## 🎨 Brand assets (already in the repo)

* `addons/debug_api/icon.svg` — plugin icon, used by Godot's plugin manager.
* `docs/branding/banner.svg` — wide repo header (1280 × 320).
* `docs/branding/preview-1-auto-monitors.svg` — full Asset Library preview
  showing the auto-panel + a code snippet.
* `docs/branding/preview-2-themes.svg` — 7-theme grid showcase.
* `docs/branding/preview-3-custom-panels.svg` — multi-panel showcase with
  custom widgets.

All artwork uses **Godot's default-blue (#478CBF)** as the primary tone with
**lime green (#5CDB95)** and **yellow (#FFEB3B)** accents matching the live
panel colours.

---

## 🛠️ Generating PNGs from the SVGs

The Asset Library form expects `.png` / `.jpg` URLs for icon and previews.
Convert each SVG once, commit the PNGs alongside the SVGs, and reference the
PNG URL from the form.

### Option A — Inkscape (free, cross-platform)

```bash
inkscape -o docs/branding/icon.png             -w 256  addons/debug_api/icon.svg
inkscape -o docs/branding/banner.png           -w 1280 docs/branding/banner.svg
inkscape -o docs/branding/preview-1.png        -w 1280 docs/branding/preview-1-auto-monitors.svg
inkscape -o docs/branding/preview-2.png        -w 1280 docs/branding/preview-2-themes.svg
inkscape -o docs/branding/preview-3.png        -w 1280 docs/branding/preview-3-custom-panels.svg
```

### Option B — `rsvg-convert` (libRSVG, smaller install)

```bash
rsvg-convert -w 256  addons/debug_api/icon.svg                            -o docs/branding/icon.png
rsvg-convert -w 1280 docs/branding/banner.svg                              -o docs/branding/banner.png
rsvg-convert -w 1280 docs/branding/preview-1-auto-monitors.svg             -o docs/branding/preview-1-auto-monitors.png
rsvg-convert -w 1280 docs/branding/preview-2-themes.svg                    -o docs/branding/preview-2-themes.png
rsvg-convert -w 1280 docs/branding/preview-3-custom-panels.svg             -o docs/branding/preview-3-custom-panels.png
```

### Option C — Online (no install)

Drag any SVG to <https://cloudconvert.com/svg-to-png>, set width 256 (icon)
or 1280 (banner / previews), download, commit.

### Option D — Take real screenshots

Even better than the SVG mockups: open one of the example scenes in Godot,
press F12 (or any screenshot tool), crop to 1280×720, save as PNG. Place
under `docs/branding/screenshots/` and use those URLs in the form.

---

## ✅ Pre-submission checklist

1. **Push everything to `main`** so the GitHub raw URLs work:
   ```bash
   git add -A
   git commit -m "v1.0 release: docs, branding, license"
   git tag v1.0.0
   git push origin main --tags
   ```
2. **Capture the commit hash**: `git rev-parse HEAD` → paste in form.
3. **Verify the raw URLs** by pasting one into a browser (you should see the
   PNG render, not the GitHub UI).
4. **Convert SVGs to PNGs** (see above) and commit them, otherwise the
   *Icon URL* and *Preview Image Link* fields will 404.
5. **Switch the License dropdown to MIT** — not CC0.
6. **Test the addon in a fresh Godot project** before submitting:
   * delete `.godot/`,
   * copy `addons/debug_api/`,
   * enable the plugin,
   * verify `DebugAPI.enable_monitor_preset("essential")` works.
7. **Submit**. Godot's Asset Library moderators will review within a few
   days. If they ask for changes, you edit the same form and resubmit.

---

## 📣 Post-submission tips

* **Pin a "v1.0.0" GitHub Release** with a ZIP archive — convenient for users
  who can't or won't clone with git. Use Inkscape or your screenshot tool to
  attach a couple of preview images directly to the release page too.
* **Announce on the Godot Discord** (`#showcase` channel) and Reddit
  (`r/godot`). Include the banner image and one preview.
* **Watch the issues tab**. The first week after submission usually surfaces
  setup glitches you didn't predict.
* **Tag future releases** as `v1.0.1`, `v1.1.0`, etc. — semver works fine
  with the Asset Library: just edit your asset and bump the *Asset Version*
  + *Download Commit* fields.

---

## 🔗 Asset Library guidelines (must read)

Godot's official guide for asset submitters:
<https://docs.godotengine.org/en/stable/community/asset_library/submitting_to_assetlib.html>

Key rules to keep in mind:

* The repository must contain a recognisable license file (`LICENSE` or
  `LICENSE.md`). ✅ done.
* The plugin folder must live at `addons/<plugin_name>/`. ✅ done.
* `plugin.cfg` must have correct `name`, `description`, `author`, `version`,
  `script`. ✅ done.
* The addon must not include unrelated project files (like a `project.godot`
  for a demo) inside `addons/<plugin_name>/`. ✅ examples live in
  `addons/debug_api/examples/`, which is fine.
