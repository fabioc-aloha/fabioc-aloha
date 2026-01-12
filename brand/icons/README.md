# CorreaX App Icons

PWA and application icons for CorreaX projects.

---

## ✅ Quick Rules

| Rule | Spec |
| ------ | ------ |
| Background | White `#FFFFFF` + transparency |
| Compatibility | Must work on white layouts |
| Favicon | 64×64 recommended (32×32 min) |
| Format | SVG source + PNG exports at 2×/3× |
| Safe zone | 10% padding from edges |

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

| Property | Value | Notes |
| -------- | ----- | ----- |
| **Background** | White `#FFFFFF` | Required for white-background layouts |
| **Transparency** | Supported | PNG with alpha channel or SVG |
| Logo | Azure Blue CorreaX mark | Must contrast on white |
| Corner Radius | 12.5% of icon size | |
| Format | SVG (vector) + PNG exports | High-DPI PNG exports required |
| Safe Zone | 10% padding from edges | |

### Favicon Requirements (Critical)

| Property | Requirement | Why |
| -------- | ----------- | --- |
| **Minimum Size** | 32×32 PNG, 64×64 recommended | Prevents pixelation on high-DPI screens |
| **Format** | SVG + multi-size ICO | ICO contains 16, 32, 48px sizes |
| **Sharpness** | Pixel-aligned at small sizes | Avoids blurry edges at 16px |
| **Export** | PNG at 2× and 3× scale | Retina/high-DPI support |

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
  "background_color": "#ffffff"
}
```

### HTML Head

```html
<!-- High-Resolution Favicon (recommended: 64x64 for crispness) -->
<link rel="icon" type="image/svg+xml" href="/brand/logos/favicon.svg">
<link rel="icon" type="image/png" sizes="64x64" href="/brand/icons/favicon-64x64.png">
<link rel="icon" type="image/png" sizes="32x32" href="/brand/icons/favicon-32x32.png">

<!-- Apple Touch Icon (high-res) -->
<link rel="apple-touch-icon" sizes="180x180" href="/brand/icons/apple-touch-icon.png">

<!-- Theme Color -->
<meta name="theme-color" content="#0078d4">

<!-- Background Color (use white for compatibility) -->
<meta name="background-color" content="#ffffff">
```

---

## Related

- [Brand Guidelines](../README.md) — Full brand documentation
- [Logo Assets](../logos/README.md) — Logos and banners

---

<sub>© 2026 CorreaX</sub>
