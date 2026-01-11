# CorreaX App Icons

PWA and application icons for CorreaX projects.

---

## Icon Inventory

| Size | File | Platform | Use Case |
| ---- | ---- | -------- | -------- |
| 72×72 | `icon-72x72.svg` | Android | Home screen (legacy) |
| 96×96 | `icon-96x96.svg` | Android | Shortcut icon |
| 128×128 | `icon-128x128.svg` | Chrome | Web Store listing |
| 144×144 | `icon-144x144.svg` | iOS | Home screen |
| 152×152 | `icon-152x152.svg` | iPad | Touch icon |
| 192×192 | `icon-192x192.svg` | Android/PWA | Splash screen, manifest |
| 384×384 | `icon-384x384.svg` | All | High-DPI displays |
| 512×512 | `icon-512x512.svg` | PWA | Manifest, splash |

---

## Design Specifications

| Property | Value |
| -------- | ----- |
| Background | Azure Blue `#0078d4` |
| Logo | White CorreaX mark |
| Corner Radius | 12.5% of icon size |
| Format | SVG (vector) |
| Safe Zone | 10% padding from edges |

---

## Implementation

### PWA Manifest

```json
{
  "name": "CorreaX",
  "icons": [
    { "src": "/brand/icons/icon-192x192.svg", "sizes": "192x192", "type": "image/svg+xml" },
    { "src": "/brand/icons/icon-512x512.svg", "sizes": "512x512", "type": "image/svg+xml" }
  ],
  "theme_color": "#0078d4",
  "background_color": "#020617"
}
```

### HTML Head

```html
<!-- Favicon -->
<link rel="icon" type="image/svg+xml" href="/brand/logos/favicon.svg">

<!-- Apple Touch Icon -->
<link rel="apple-touch-icon" href="/brand/icons/icon-192x192.svg">

<!-- Theme Color -->
<meta name="theme-color" content="#0078d4">
```

---

## Related

- [Brand Guidelines](../README.md) — Full brand documentation
- [Logo Assets](../logos/README.md) — Logos and banners

---

<sub>© 2026 CorreaX</sub>
