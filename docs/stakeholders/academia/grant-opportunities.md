---
title: "Grant Opportunities (Academia)"
summary: "Internal process to identify, prepare, and submit safe, compliant grant proposals related to MerajutASA research and collaboration."
audience: ["academia","administrators","developers"]
stakeholder: ["academia"]
owner: "@academic-collab-lead"
status: "draft"
version: "0.1.0"
last_reviewed: "2025-08-08"
tags: ["child-safety","privacy","accessibility","compliance","funding"]
---

# Grant Opportunities (Academia)

## Purpose
Provide a grounded, repeatable workflow for evaluating and submitting grant proposals that involve MerajutASA data, APIs, or collaborations while upholding child safety, privacy, accessibility, and documentation standards.

## Scope & Audience
- Audience: university faculty, research administrators, and collaboration leads.
- Scope: research, training, infrastructure, and innovation grants; excludes any handling of raw sensitive child data outside approved enclaves.

## Key Facts (Grounded)
- Ethics & child protection apply across funding lifecycle – docs/stakeholders/academia/ethics-guidelines.md
- Only de‑identified or synthetic datasets for academic use – docs/stakeholders/academia/research-data-access.md
- Security-by-design and lawful processing baselines – docs/architecture/decisions/013-security-framework.md
- Accessibility requirements for deliverables and portals – docs/architecture/decisions/014-accessibility-standards.md and docs/STYLE_GUIDE.md
- Documentation-first and testing expectations for funded outputs – docs/architecture/decisions/011-documentation-platform.md and docs/architecture/decisions/012-testing-strategy.md
- Privacy by Design principles – docs/architecture/compliance/privacy-by-design.md

## How‑To / Steps
1) Opportunity triage
   - Confirm scope aligns with de‑identified research and sandbox APIs – research-data-access.md, api-documentation.md
   - Identify risks (privacy, security, child-safety) and mitigations – ethics-guidelines.md, decisions/013-security-framework.md

2) Concept note (documentation‑first)
   - Problem and outcomes; datasets and variables (minimization); methods and small‑cell protection – research-data-access.md#6-dataset-provisioning-patterns
   - Accessibility and localization plan – decisions/014-accessibility-standards.md, STYLE_GUIDE.md, TRANSLATION_GUIDE.md

3) Compliance reviews (parallel)
   - Ethics & Privacy: IRB plan, DPIA need and approach – ethics-guidelines.md; research-data-access.md#4-dpia
   - Security: enclave needs, repo controls, secrets handling – decisions/013-security-framework.md
   - Documentation QA: style/links/front matter – REVIEW_PROCESS.md, STYLE_GUIDE.md

4) Budget and resourcing
   - Include line items for compliance (IRB, DPIA), security controls, accessibility, documentation, and monitoring.
   - Identify data steward time and infrastructure for analysis within approved environments – research-data-access.md

5) Proposal assembly
   - Evidence packet: concept note, compliance checklists, letters of support, roles/responsibilities.
   - Draft deliverables and acceptance criteria aligned to internal standards – REVIEW_PROCESS.md

6) Internal approvals and submission
   - Record sign‑offs (Ethics/Privacy, Security, Documentation) – REVIEW_PROCESS.md
   - Submit via funder portal; track debrief dates and conditions.

7) Post‑award setup
   - Kickoff with review of obligations; set dashboards/metrics; create study workspace and credentials – research-data-access.md#7-api-access-contract-academic-v1

## Roles & Responsibilities
- Principal Investigator (PI): compliance ownership; deliverables and reporting.
- Co‑Investigators/Team: analysis within approved scope; code and docs hygiene.
- MerajutASA Data Steward: dataset provisioning; controls verification; audit trail – docs/architecture/compliance/audit-trail.md
- Security Admin: identity, repo, and environment controls – decisions/013-security-framework.md
- Accessibility/Docs Reviewer: ADR‑014, STYLE_GUIDE, and REVIEW_PROCESS adherence.

## Checklists
- Eligibility and scope
  - [ ] No raw sensitive child data outside approved enclaves
  - [ ] De‑identified/synthetic datasets or aggregates only
  - [ ] Sandbox APIs and least privilege scopes – api-documentation.md
- Compliance
  - [ ] Ethics/IRB plan and DPIA pathway documented – ethics-guidelines.md; research-data-access.md#4-dpia
  - [ ] Small‑cell rule (n<10) and generalization/suppression plan – research-data-access.md#6-dataset-provisioning-patterns
  - [ ] Accessibility plan (alt text, contrast, language) – decisions/014-accessibility-standards.md; STYLE_GUIDE.md
- Delivery
  - [ ] Documentation-first, tests, and repos structured per ADR‑011/012
  - [ ] Monitoring and audit trail commitments – audit-trail.md
  - [ ] Translation/localization where applicable – TRANSLATION_GUIDE.md

## Accessibility & Child Safety
- Use inclusive, non‑stigmatizing language in all narratives – STYLE_GUIDE.md
- Avoid images that could reveal identity; prefer abstracts/illustrations; secure consent if necessary – ethics-guidelines.md

## Validation & Monitoring
- Track grant KPIs via internal dashboards; store artifacts and reviews per REVIEW_PROCESS.md
- Log dataset/API access and exports; retain evidence packets – audit-trail.md; research-data-access.md#7-api-access-contract-academic-v1

## Related
- Publication requirements – docs/stakeholders/academia/publication-guidelines.md
- Student work standards – docs/stakeholders/academia/student-projects.md
- Conference materials – docs/stakeholders/academia/conference-presentations.md

## Changelog
- 0.1.0 (2025-08-08): Initial draft aligning to ethics, research data access, privacy-by-design, ADR‑011/012/013/014, and review process.
