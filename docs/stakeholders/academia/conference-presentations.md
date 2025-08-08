---
title: "Conference Presentations (Academia)"
summary: "Safe and compliant preparation of talks, posters, and demos derived from MerajutASA research."
audience: ["academia","presenters","communications"]
stakeholder: ["academia"]
owner: "@academic-collab-lead"
status: "draft"
version: "0.1.0"
last_reviewed: "2025-08-08"
tags: ["child-safety","privacy","accessibility","communications"]
---

# Conference Presentations (Academia)

## Purpose
Ensure public presentations protect children’s privacy, align with ethics and accessibility, and reflect accurate, grounded content.

## Scope & Audience
- Applies to talks, posters, demos, and lightning talks.
- For faculty, students, and research staff.

## Key Facts (Grounded)
- Ethics & privacy controls – docs/stakeholders/academia/ethics-guidelines.md
- De‑identification & small‑cell rules – docs/stakeholders/academia/research-data-access.md#6-dataset-provisioning-patterns
- Accessibility – docs/architecture/decisions/014-accessibility-standards.md and docs/STYLE_GUIDE.md
- Security & lawful processing – docs/architecture/decisions/013-security-framework.md

## How‑To / Steps
1) Content selection
   - Use aggregates only; no microdata; remove identifiers from quotes/images.
2) Visuals and slides
   - Provide alt text in exported materials; ensure readable contrast and font sizes; avoid color‑only cues – ADR‑014.
3) Demo safety
   - Use synthetic/sandbox data; never live production data.
4) Review
   - Internal ethics/privacy + accessibility review; finalize acknowledgments and disclaimers – REVIEW_PROCESS.md, publication-guidelines.md.
5) Distribution
   - Post slide deck and poster in approved repositories; include README and license; provide Bahasa Indonesia abstract when applicable – TRANSLATION_GUIDE.md.

## Presenter Checklist
- [ ] No small cells or identifiable details in any visual/table
- [ ] Alt text/accessible exports; inclusive language
- [ ] Sandbox data for demos; no secrets in configs
- [ ] Acknowledgments and disclaimers included
- [ ] Internal reviews completed and logged

## Accessibility & Child Safety
- Avoid imagery that can stigmatize children/communities; blur or replace sensitive visuals; secure consent if ever using representative photos (prefer stock/illustrations).

## Changelog
- 0.1.0 (2025-08-08): Initial draft with grounded references to ethics, data access, accessibility, security, and review process.
