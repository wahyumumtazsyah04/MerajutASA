# Content Policy (Draft)

All content must be accurate, child-safe, and accessible. No identifiable information about children. 

## Related Policies
- Platform usage guidelines: security/policies/acceptable-use.md
- Privacy compliance: docs/architecture/compliance/privacy-by-design.md
- Accessibility requirements: accessibility-compliance.md

---
title: "Content Policy (Documentation)"
summary: "Accuracy, child safety, and accessibility rules for all documentation content."
audience: ["community","media","business","academia","government","developers"]
stakeholder: ["community"]
owner: "@docs-core"
status: "in_review"
version: "1.0.0"
last_reviewed: "2025-08-08"
tags: ["policy","child-safety","accessibility","grounding"]
---

# Content Policy

## Purpose
Ensure all docs are accurate, grounded to internal sources, child-safe, and accessible.

## Scope & Audience
All contributors producing or reviewing content under `docs/**`.

## Key Facts (Grounded)
- [docs/STYLE_GUIDE.md] — Writing and accessibility standards.
- [docs/REVIEW_PROCESS.md] — Required human reviews and gates.
- [docs/architecture/compliance/accessibility-compliance.md] — WCAG 2.1 AA implementation.
- [docs/architecture/compliance/privacy-by-design.md] — Privacy-by-design constraints.

## How-To / Steps
1) Cite internal sources for every material claim.
2) Add alt text, ensure contrast, validate headings and keyboard nav.
3) Avoid sensational or misleading language; keep facts testable.
4) Open an issue when facts are missing; do not guess.

## Accessibility & Child Safety
- Mandatory child-safety and accessibility checks on all PRs.

## Validation & Monitoring
- markdownlint, link-check, and style checks in CI; reviewer enforcement.

## Changelog
- 1.0.0 (2025-08-08): First complete content policy for docs.