---
title: "Academic Collaboration Framework"
summary: "How academia partners collaborate with MerajutASA within the penta-helix model: roles, governance, mechanisms, cadence, and compliance."
audience: ["academia","administrators"]
stakeholder: ["academia"]
owner: "@academic-collab-lead"
status: "draft"
version: "0.1.0"
last_reviewed: "2025-08-08"
tags: ["child-safety","accessibility","compliance","governance"]
---

# Academic Collaboration Framework

## Purpose
Define a safe, effective, and compliant framework for university and research partners to collaborate with MerajutASA, aligned to the platform’s multi‑stakeholder model and child‑safety mission.

## Scope & Audience
- Audience: academic leaders (deans/centers), faculty, PIs, students, research admins.
- Scope: research projects, student engagements, publications, grant pursuits, and knowledge transfer using de‑identified data and sandbox APIs.

## Key Facts (Grounded)
- Parent framework and stakeholder governance – see ../collaboration-framework.md and ../governance-model.md
- Ethics & child protection – see ./ethics-guidelines.md
- Data access & de‑identification – see ./research-data-access.md and ./data-anonymization.md
- API usage – see ./api-documentation.md
- Documentation, style, translation, reviews – see ../../STYLE_GUIDE.md, ../../TRANSLATION_GUIDE.md, ../../REVIEW_PROCESS.md, ADR‑011 ../../api/decisions/011-documentation-platform.md
- Security & accessibility baselines – ADR‑013 ../../api/decisions/013-security-framework.md, ADR‑014 ../../api/decisions/014-accessibility-standards.md
- Privacy by Design & auditability – ../../architecture/compliance/privacy-by-design.md, ../../architecture/compliance/audit-trail.md

## Collaboration model
- Principles: child‑first, evidence‑based, privacy‑preserving, documentation‑first, accessibility by default.
- Modes: research collaboration, student projects, grant proposals, shared publications and conference dissemination.

## Roles & responsibilities
- Academic Collaboration Lead: overall coordination; ensures compliance with ethics, security, and documentation standards.
- Principal Investigator (PI): scientific leadership; IRB/DUA compliance; deliverables.
- Data Steward (MerajutASA): dataset provisioning; de‑identification patterns; access monitoring.
- Ethics & Privacy Liaison: IRB coordination; DPIA guidance; review of dissemination materials.
- Security Admin: identities, repository controls, enclaves; incident response alignment.
- Accessibility/Docs Reviewer: ADR‑014 checks; style and translation reviews.

## Working groups (cross‑functional)
- Research Design WG
  - Scope: study design, variables (minimization), methods transparency.
  - References: ./research-data-access.md, ADR‑012 ../../api/decisions/012-testing-strategy.md.
- Data Access & Stewardship WG
  - Scope: dataset readiness, codebooks, transformations, small‑cell controls.
  - References: ./research-data-access.md#6-dataset-provisioning-patterns, ./data-anonymization.md.
- Publications & Dissemination WG
  - Scope: manuscripts, posters, slides, plain‑language summaries; accessibility checks.
  - References: ./publication-guidelines.md, ADR‑014, ../../STYLE_GUIDE.md, ../../TRANSLATION_GUIDE.md.
- Student Engagement WG
  - Scope: capstones, theses, practicums; sandbox access; supervision and reviews.
  - References: ./student-projects.md, ./api-documentation.md.
- Grants & Partnerships WG
  - Scope: funding triage, compliance resourcing, deliverable acceptance criteria.
  - References: ./grant-opportunities.md, ADR‑011/012.

## Coordination cadence
- Weekly: WG stand‑ups (30‑45 min) – blockers, decisions needed, small‑cell/ethics checks in progress. Log in WG notes per ../../REVIEW_PROCESS.md.
- Monthly: Academic Collaboration Council (60‑90 min) – portfolio status, risk review (privacy/security), accessibility and documentation metrics.
- Quarterly: Stakeholder summit (half day) – impact review, lessons learned, roadmap; aligned with ../collaboration-framework.md.

## How‑To / Steps
1) Propose
   - Submit concept (purpose, variables, risks/mitigations) – ./research-data-access.md.
2) Approve
   - Ethics (IRB), Privacy (DPIA need), Security (enclave/repo), Docs (style/translation) – ./ethics-guidelines.md, ADR‑013/014, ../../REVIEW_PROCESS.md.
3) Provision
   - Study workspace, credentials, dataset seeding, monitoring – ./research-data-access.md#7-api-access-contract-academic-v1, ../../architecture/compliance/audit-trail.md.
4) Execute
   - Documentation‑first; tests as applicable; regular WG check‑ins – ADR‑011/012.
5) Disseminate
   - Follow ./publication-guidelines.md and ./conference-presentations.md; ensure accessibility and small‑cell rules.
6) Close
   - Revoke access; archive approvals/logs; publish summaries in Bahasa Indonesia – ./publication-guidelines.md, ../../TRANSLATION_GUIDE.md.

## Deliverables & acceptance
- Evidence packet per ../../REVIEW_PROCESS.md with ethics/DUA refs, small‑cell analysis, accessibility checks, and links to codebooks/methods.
- Acceptance criteria: compliant outputs (no microdata), accessibility pass (ADR‑014), security/privacy sign‑offs (ADR‑013), style/translation adherence.

## Accessibility & Child Safety
- Inclusive, non‑stigmatizing language; alt text and high contrast; avoid imagery that could reveal identities.
- Escalate any discovered risk of harm per ./ethics-guidelines.md.

## Validation & Monitoring
- Immutable access logs and anomaly alerts – ../../architecture/compliance/audit-trail.md.
- Periodic review of WG metrics and documentation health – ADR‑011; ../../REVIEW_PROCESS.md.

## Related
- Parent: ../collaboration-framework.md, ../communication-protocols.md, ../governance-model.md
- Academia: ./research-data-access.md, ./data-anonymization.md, ./publication-guidelines.md, ./student-projects.md, ./grant-opportunities.md, ./conference-presentations.md

## Changelog
- 0.1.0 (2025-08-08): Initial draft grounded to parent framework, ethics, data access, ADR‑011/012/013/014, privacy-by-design, audit trail, style, translation, and review process.
