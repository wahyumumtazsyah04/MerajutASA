---
title: "Student Projects (Academia)"
summary: "Standards and workflow for safe, ethical student projects using MerajutASA datasets, APIs, or collaborations."
audience: ["academia","students","supervisors"]
stakeholder: ["academia"]
owner: "@academic-collab-lead"
status: "draft"
version: "0.1.0"
last_reviewed: "2025-08-08"
tags: ["child-safety","privacy","accessibility","education"]
---

# Student Projects (Academia)

## Purpose
Enable supervised student learning while upholding child safety, privacy, and documentation standards.

## Scope & Audience
- Audience: undergraduate/graduate students, supervisors, and coordinators.
- Scope: capstones, theses, practicums, course projects using de‑identified data or sandbox APIs.

## Key Facts (Grounded)
- Use de‑identified/synthetic datasets and sandbox APIs – see docs/stakeholders/academia/research-data-access.md
- Ethics and child protection apply to all student work – see docs/stakeholders/academia/ethics-guidelines.md
- API usage and limits follow academic v1 – see docs/stakeholders/academia/api-documentation.md
- Accessibility and localization – see docs/architecture/decisions/014-accessibility-standards.md and docs/STYLE_GUIDE.md

## How‑To / Steps
1) Registration and scope
   - File a short proposal describing purpose, variables, and outputs; supervisor approval required.
2) Access and environment
   - Use sandbox credentials and approved datasets; no raw sensitive data – research-data-access.md
3) Data handling
   - Apply small‑cell rule (n<10); generalize/suppress; no re‑identification attempts – research-data-access.md#6-dataset-provisioning-patterns
4) Development standards
   - Follow documentation-first and testing basics aligned with ADR‑012 – docs/architecture/decisions/012-testing-strategy.md
5) Review and sign‑off
   - Supervisor checks ethics, privacy, accessibility, and documentation quality – REVIEW_PROCESS.md
6) Publication and sharing
   - Use publication-guidelines.md; share code without secrets; provide README and LICENSE; consider bilingual abstracts.

## Templates
- Proposal one-pager (purpose, datasets, variables, outputs, risks, mitigations)
- Review checklist (ethics/privacy, small-cell, accessibility, style)
- README seed aligned to STYLE_GUIDE.md

## Accessibility & Child Safety
- Inclusive language; alt text; color contrast; no stigmatizing content – decisions/014-accessibility-standards.md, STYLE_GUIDE.md
- Duty of care: escalate discovered harm risks per ethics-guidelines.md

## Validation & Monitoring
- Use logs/metrics from sandbox APIs; keep evidence packet with submission – REVIEW_PROCESS.md

## Changelog
- 0.1.0 (2025-08-08): Initial draft grounded to research-data-access, ethics-guidelines, api-documentation, ADR‑012/014.
