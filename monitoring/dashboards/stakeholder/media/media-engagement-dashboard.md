---
title: "Media Engagement Dashboard"
summary: "Stakeholder-facing view of media impact metrics without PII."
audience: ["media","leadership","developers"]
stakeholder: ["media"]
owner: "@docs-core"
status: "in_review"
version: "1.0.0"
last_reviewed: "2025-08-08"
tags: ["dashboard","metrics","child-safety","accessibility"]
---

## Purpose
Provide an aggregate, privacy-preserving view of media impact to support storytelling and decision-making.

## Scope & Audience
- For media partners and leadership requiring high-level impact signals.
- Excludes any PII or drill-down to individuals.

## Key Facts (Grounded)
- [monitoring/analytics/metrics/media.yaml] — Authoritative metric keys and definitions.
- [docs/architecture/compliance/privacy-by-design.md] — Privacy constraints (no PII; aggregation only).
- [docs/architecture/compliance/accessibility-compliance.md] — WCAG 2.1 AA for color/contrast and captions.

## How-To / Steps
1) Source metrics from the catalog in `monitoring/analytics/metrics/media.yaml`.
2) Render charts with high-contrast palettes and alt text for images.
3) Validate against the policies referenced above before publishing.

## Accessibility & Child Safety
- High-contrast color choices; captions/alt text for all visuals; keyboard-accessible embeds.
- Strict aggregation; zero collection/display of children’s PII.

## Validation & Monitoring
- Document chart queries and transformations.
- Perform link-check and accessibility checks before publishing.

## Changelog
- 1.0.0 (2025-08-08): First complete dashboard page.
