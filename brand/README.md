# CorreaX Brand Guidelines

<p align="center">
  <img src="logos/logo.svg" alt="CorreaX Logo" width="120">
</p>

<p align="center">
  <strong>Official Brand Guidelines v1.0</strong><br>
  <sub>Last updated: January 2026</sub>
</p>

---

## Table of Contents

1. [Brand Identity](#brand-identity)
2. [Logo](#logo)
3. [Colors](#colors)
4. [Typography](#typography)
5. [Voice & Tone](#voice--tone)
6. [Usage Guidelines](#usage-guidelines)
7. [Digital Assets](#digital-assets)
8. [Templates](#templates)
9. [Quick Reference](#quick-reference)

---

## Brand Identity

### Mission

CorreaX empowers the Correa family with unified, professional-grade tools for Azure infrastructure management and digital project development.

### Brand Attributes

| Attribute | Description |
| --------- | ----------- |
| **Professional** | Enterprise-quality design and documentation |
| **Trustworthy** | Consistent, reliable, and transparent |
| **Innovative** | Forward-thinking Azure and AI solutions |
| **Accessible** | Clear, approachable, and well-documented |

### Brand Names

| Form | Example | Usage |
| ---- | ------- | ----- |
| **Primary** | CorreaX | Headers, formal references, documentation |
| **Lowercase** | correax | URLs, domains, package names, file paths |
| **Abbreviated** | CX | Icons, favicons, tight spaces |

### Taglines

CorreaX uses **two taglines** depending on context:

| Tagline | Context | Tone |
| ------- | ------- | ---- |
| **AI That Learns How to Learn** | Brand identity, about pages, thought leadership, conferences, research | Conceptual, visionary |
| **Think. Build. Deploy.** | Product pages, GitHub READMEs, developer docs, tutorials, CTAs | Action-oriented, practical |

#### When to Use Each

**Conceptual contexts → "AI That Learns How to Learn"**
- Company overview and mission statements
- Meta-cognitive and Alex-related projects
- Presentations, keynotes, conference talks
- Social media bios
- Research papers and academic content

**Builder contexts → "Think. Build. Deploy."**
- Code repositories and README banners
- Developer tooling documentation
- Workshop and tutorial materials
- Product landing pages
- Technical blog posts

---

## Logo

### Primary Logo

<p align="center">
  <img src="logos/logo.svg" alt="CorreaX Logo" width="80">
</p>

The CorreaX logo combines two geometric elements:

- **C Arc**: Represents Correa and Cloud computing
- **X Chevrons**: Symbolizes transformation and excellence

### Logo Variants

| Variant | File | Use Case |
| ------- | ---- | -------- |
| Primary | `logos/logo.svg` | Default usage on all backgrounds |
| Favicon | `logos/favicon.svg` | Browser tabs, bookmarks |

### Clear Space

Always maintain clear space around the logo equal to the height of the "X" element. Never crowd the logo with text or other graphics.

```
    ┌─────────────────┐
    │                 │
    │   [  LOGO  ]    │  ← Minimum padding = logo height × 0.25
    │                 │
    └─────────────────┘
```

### Minimum Size

| Context | Minimum Width |
| ------- | ------------- |
| Print | 24px (0.25 inch) |
| Digital | 16px |
| Favicon | 16px × 16px |

### Logo Don'ts

| ❌ Don't | Why |
| -------- | --- |
| Stretch or distort | Maintains brand recognition |
| Change colors arbitrarily | Use only approved color variants |
| Add effects (shadows, outlines) | Preserves visual clarity |
| Place on busy backgrounds | Ensures legibility |
| Rotate or flip | Maintains intended orientation |
| Recreate or redraw | Use official assets only |

---

## Colors

### Primary Palette

These are the core brand colors. Use them consistently across all materials.

| Color | Hex | RGB | WCAG | Usage |
| ----- | --- | --- | ---- | ----- |
| **Azure Blue** | `#0078d4` | 0, 120, 212 | AA | Primary brand, CTAs, links |
| **Azure Dark** | `#005a9e` | 0, 90, 158 | AAA | Hover states, emphasis |
| **Azure Light** | `#00bcf2` | 0, 188, 242 | AA* | Accents, highlights |

*AA on dark backgrounds only

### Neutral Palette

| Color | Hex | Usage |
| ----- | --- | ----- |
| **Slate 950** | `#020617` | Dark backgrounds |
| **Slate 900** | `#0f172a` | Cards, panels |
| **Slate 800** | `#1e293b` | Elevated surfaces |
| **Slate 50** | `#f8fafc` | Light text on dark |
| **Slate 400** | `#94a3b8` | Secondary text |
| **Slate 500** | `#64748b` | Muted text, captions |

### Accent Colors

| Color | Hex | Usage |
| ----- | --- | ----- |
| **Violet** | `#7c3aed` | AI/Neural features, special highlights |
| **Emerald** | `#10b981` | Success states |
| **Amber** | `#f59e0b` | Warnings |
| **Red** | `#ef4444` | Errors, destructive actions |

### Color Accessibility

All text must meet WCAG 2.1 AA standards:

| Combination | Contrast Ratio | Status |
| ----------- | -------------- | ------ |
| Azure Blue on White | 4.5:1 | ✅ AA |
| Azure Dark on White | 7.2:1 | ✅ AAA |
| White on Azure Blue | 4.5:1 | ✅ AA |
| Slate 50 on Slate 950 | 18.1:1 | ✅ AAA |

### CSS Variables

```css
:root {
  /* Primary */
  --cx-primary: #0078d4;
  --cx-primary-dark: #005a9e;
  --cx-primary-light: #00bcf2;

  /* Neutrals */
  --cx-bg-dark: #020617;
  --cx-bg-surface: #0f172a;
  --cx-bg-elevated: #1e293b;
  --cx-text-primary: #f8fafc;
  --cx-text-secondary: #94a3b8;
  --cx-text-muted: #64748b;

  /* Accents */
  --cx-accent: #7c3aed;
  --cx-success: #10b981;
  --cx-warning: #f59e0b;
  --cx-error: #ef4444;
}
```

---

## Typography

### Font Stack

**Primary**: Segoe UI (Windows) / Inter (Web/Cross-platform)

```css
font-family: 'Segoe UI', 'Inter', system-ui, -apple-system, BlinkMacSystemFont, Roboto, 'Helvetica Neue', sans-serif;
```

### Type Scale

| Level | Size | Weight | Line Height | Usage |
| ----- | ---- | ------ | ----------- | ----- |
| Display | 72px | 700 | 1.1 | Hero banners |
| H1 | 48px | 700 | 1.2 | Page titles |
| H2 | 32px | 600 | 1.3 | Section headers |
| H3 | 24px | 600 | 1.4 | Subsections |
| Body | 16px | 400 | 1.5 | Paragraphs |
| Small | 14px | 400 | 1.5 | Captions, labels |
| Micro | 12px | 500 | 1.4 | Badges, tags |

### Font Weights

| Weight | Value | Usage |
| ------ | ----- | ----- |
| Regular | 400 | Body text, descriptions |
| Medium | 500 | Labels, navigation, emphasis |
| Semibold | 600 | Headings, buttons |
| Bold | 700 | Display text, strong emphasis |

---

## Voice & Tone

### Brand Voice

CorreaX communications are:

| Trait | Description | Example |
| ----- | ----------- | ------- |
| **Clear** | Direct and easy to understand | "Deploy to Azure" not "Initiate cloud resource provisioning" |
| **Professional** | Confident but not arrogant | "Built for enterprise" not "The best ever" |
| **Helpful** | Solution-oriented | "Try this instead" not "That's wrong" |
| **Technical** | Precise when needed | Use correct terminology for developers |

### Writing Guidelines

**Do:**
- Use active voice
- Lead with the benefit
- Be concise
- Use sentence case for headings

**Don't:**
- Use jargon without explanation
- Make unsupported claims
- Use ALL CAPS (except acronyms)
- End headings with punctuation

### Terminology

| Use | Don't Use |
| --- | --------- |
| Azure Blue | Microsoft Blue |
| CorreaX | Correax, CORREAX, Correa-X |
| Sign in | Log in, Login |
| Set up (verb) | Setup (noun only) |

---

## Usage Guidelines

### Logo Placement

**Headers**: Left-aligned or centered, never right-only

**Footers**: Centered, small (32px width recommended)

**Favicons**: Use `favicon.svg` for browser tabs

### Badge Colors (shields.io)

```markdown
<!-- Primary actions -->
![Action](https://img.shields.io/badge/Label-Value-0078d4)

<!-- Secondary info -->
![Info](https://img.shields.io/badge/Label-Value-005a9e)

<!-- Highlights -->
![Highlight](https://img.shields.io/badge/Label-Value-00bcf2)

<!-- Large buttons -->
![Button](https://img.shields.io/badge/Label-Value-0078d4?style=for-the-badge)
```

### Co-Branding

When displaying CorreaX alongside other brands:

1. Maintain equal visual weight
2. Use a divider (|, •, or spacing) between logos
3. Never modify either logo
4. Ensure adequate clear space for both

### Attribution

Always include copyright when using CorreaX assets:

```
© 2026 CorreaX
```

---

## Digital Assets

### Banners

| Asset | Dimensions | File | Usage |
| ----- | ---------- | ---- | ----- |
| Dark Banner | 1200×300 | `logos/banner.svg` | README headers (dark theme) |
| Light Banner | 1200×300 | `logos/banner-light.svg` | README headers (light theme) |
| Profile Banner | 1200×300 | `logos/banner-profile.svg` | Personal/project profiles |
| Catalyst Banner | 1200×300 | `logos/banner-catalyst.svg` | Example project banner |

### App Icons (PWA)

| Size | File | Platform |
| ---- | ---- | -------- |
| 72×72 | `icons/icon-72x72.svg` | Android home screen |
| 96×96 | `icons/icon-96x96.svg` | Android shortcut |
| 128×128 | `icons/icon-128x128.svg` | Chrome Web Store |
| 144×144 | `icons/icon-144x144.svg` | iOS/iPadOS |
| 152×152 | `icons/icon-152x152.svg` | iPad |
| 192×192 | `icons/icon-192x192.svg` | Android splash, PWA |
| 384×384 | `icons/icon-384x384.svg` | Large displays |
| 512×512 | `icons/icon-512x512.svg` | PWA manifest |

### File Structure

```
brand/
├── README.md                    # This guide
├── logos/
│   ├── logo.svg                 # Primary logo
│   ├── favicon.svg              # Browser favicon
│   ├── banner.svg               # Dark theme banner
│   ├── banner-light.svg         # Light theme banner
│   ├── banner-profile.svg       # Profile/project template
│   └── banner-catalyst.svg      # Example custom banner
└── icons/
    └── icon-{size}.svg          # PWA icons (8 sizes)
```

---

## Templates

### Create a Project Banner

Use `banner-profile.svg` as your template:

**Step 1**: Copy the template

```powershell
Copy-Item "brand/logos/banner-profile.svg" "brand/logos/banner-yourproject.svg"
```

**Step 2**: Edit these text elements (search by y-coordinate):

| Element | Find | Replace With |
| ------- | ---- | ------------ |
| Title | `y="135"` | Your project name |
| Subtitle | `y="180"` | Description or tagline |
| Keywords | `y="220"` | `KEYWORD1 • KEYWORD2 • KEYWORD3` |

**Step 3**: Example customization

```xml
<!-- Title -->
<text x="320" y="135" font-family="Segoe UI, system-ui, sans-serif"
      font-size="72" font-weight="700" fill="url(#nameGrad)"
      filter="url(#glow)">Your Project</text>

<!-- Subtitle -->
<text x="320" y="180" font-family="Segoe UI, system-ui, sans-serif"
      font-size="22" fill="#94a3b8" letter-spacing="1">A brief description here</text>

<!-- Keywords -->
<text x="320" y="220" font-family="Segoe UI, system-ui, sans-serif"
      font-size="18" fill="url(#accentTextGrad)"
      letter-spacing="1.5">TYPESCRIPT • AZURE • REACT</text>
```

### Example: Catalyst-BABY

<img src="logos/banner-catalyst.svg" alt="Catalyst-BABY Banner" width="600">

| Field | Value |
| ----- | ----- |
| Title | Catalyst-BABY |
| Subtitle | Cognitive Architecture for Meta-Cognitive AI Systems |
| Keywords | POWERSHELL • 945+ SYNAPSES • ETHICAL REASONING |

### README Template

```html
<!-- Header -->
<p align="center">
  <img src="brand/logos/banner-yourproject.svg" alt="Project Name" width="800"/>
</p>

<!-- Badges -->
<p align="center">
  <img src="https://img.shields.io/badge/Status-Active-0078d4" alt="Status"/>
  <img src="https://img.shields.io/badge/License-MIT-005a9e" alt="License"/>
</p>

<!-- Content goes here -->

<!-- Footer -->
<p align="center">
  <img src="brand/logos/logo.svg" alt="CorreaX" width="32"/>
</p>
<p align="center">
  <sub>© 2026 CorreaX</sub>
</p>
```

---

## Quick Reference

### Integration Checklist

**Required:**

- [ ] Add `brand/` folder to project root
- [ ] Add banner to README header
- [ ] Use brand colors for badges (`#0078d4`, `#005a9e`, `#00bcf2`)
- [ ] Add footer with logo and copyright

**Recommended:**

- [ ] Create custom project banner
- [ ] Apply CSS variables for consistency
- [ ] Use approved font stack

**For PWAs:**

- [ ] Add icons to manifest.json
- [ ] Set theme-color to `#0078d4`
- [ ] Add favicon link

### Color Quick Reference

| Purpose | Color | Hex |
| ------- | ----- | --- |
| Primary | Azure Blue | `#0078d4` |
| Hover/Dark | Azure Dark | `#005a9e` |
| Accent | Azure Light | `#00bcf2` |
| AI Feature | Violet | `#7c3aed` |
| Success | Emerald | `#10b981` |
| Warning | Amber | `#f59e0b` |
| Error | Red | `#ef4444` |

### SVG Gradients

Copy into your SVG `<defs>`:

```xml
<defs>
  <!-- Logo/Brand gradient -->
  <linearGradient id="logoGrad" x1="0%" y1="0%" x2="100%" y2="100%">
    <stop offset="0%" stop-color="#00bcf2"/>
    <stop offset="50%" stop-color="#0078d4"/>
    <stop offset="100%" stop-color="#005a9e"/>
  </linearGradient>

  <!-- Text gradient (light on dark) -->
  <linearGradient id="nameGrad" x1="0%" y1="0%" x2="100%" y2="0%">
    <stop offset="0%" stop-color="#f8fafc"/>
    <stop offset="50%" stop-color="#e2e8f0"/>
    <stop offset="100%" stop-color="#f8fafc"/>
  </linearGradient>

  <!-- Accent text gradient -->
  <linearGradient id="accentTextGrad" x1="0%" y1="0%" x2="100%" y2="0%">
    <stop offset="0%" stop-color="#00bcf2"/>
    <stop offset="50%" stop-color="#0078d4"/>
    <stop offset="100%" stop-color="#00bcf2"/>
  </linearGradient>

  <!-- Background gradient -->
  <linearGradient id="bgGrad" x1="0%" y1="0%" x2="100%" y2="100%">
    <stop offset="0%" stop-color="#020617"/>
    <stop offset="50%" stop-color="#0f172a"/>
    <stop offset="100%" stop-color="#1e293b"/>
  </linearGradient>
</defs>
```

---

## Contact

**Brand Questions**: Open an issue in the repository

**Asset Requests**: Use the templates provided or create a custom banner following the guidelines above.

---

<p align="center">
  <img src="logos/logo.svg" alt="CorreaX" width="32">
</p>
<p align="center">
  <sub>© 2026 CorreaX • Brand Guidelines v1.0</sub>
</p>
