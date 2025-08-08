---
title: "Data Anonymization for Academic Use"
summary: "Approved de-identification techniques, thresholds, and review steps for academic analysis and publication using MerajutASA data."
audience: ["academia","developers","administrators"]
stakeholder: ["academia"]
owner: "@academic-collab-lead"
status: "draft"
version: "0.1.0"
last_reviewed: "2025-08-08"
tags: ["child-safety","privacy","accessibility","compliance"]
---

# Data Anonymization for Academic Use

## Purpose
Provide a safe, privacy-preserving pathway for researchers to analyze and publish findings using MerajutASA data, aligned with ethics, security, accessibility, and documentation standards.

## Scope & Audience
- Audience: university faculty, students, and research staff working with de‑identified datasets.
- Scope: preprocessing, transformation, validation, and review of de‑identified outputs before submission or publication.

## Key Facts (Grounded)
- Small‑cell rule (n<10) and de‑identification patterns are required for research datasets – see Research Data Access → docs/stakeholders/academia/research-data-access.md#6-dataset-provisioning-patterns
- Data minimization and de‑identification techniques (pseudonymization, generalization, suppression, noise) – see docs/stakeholders/academia/ethics-guidelines.md
- Privacy‑by‑design principles (purpose limitation, storage minimization) – see docs/architecture/compliance/privacy-by-design.md
- Security baselines and lawful processing – see docs/architecture/decisions/013-security-framework.md
- Accessibility for materials/artifacts – see docs/architecture/decisions/014-accessibility-standards.md

## How‑To / Steps
1) Define purpose and variables
   - Document intended use and variables; justify necessity (minimization) – ethics-guidelines.md
2) Prepare de‑identified extract
   - Use steward-approved pipelines per Research Data Access – research-data-access.md#3-access-workflow-documentation-first
3) Apply de‑identification techniques (see next section)
   - Pseudonymize IDs; generalize sensitive attributes; suppress small cells
4) Validate outputs
   - Verify no small cells (n<10) in any table/figure; re‑bin or suppress as needed – research-data-access.md#6-dataset-provisioning-patterns
5) Document transformations
   - Update codebook/provenance and note applied transformations – research-data-access.md
6) Internal reviews (parallel)
   - Ethics/Privacy, Security, Accessibility & Language, Documentation QA – REVIEW_PROCESS.md
7) Archive evidence
   - Keep analysis notes and review sign‑offs with submission package – REVIEW_PROCESS.md

## Techniques (approved)
- Pseudonymization
  - Replace direct identifiers with stable tokens for analysis only – ethics-guidelines.md
- Generalization
  - Reduce precision (e.g., bins or ranges) for quasi‑identifiers – ethics-guidelines.md
- Suppression
  - Remove values or entire rows that risk re‑identification; enforce n<10 – research-data-access.md#6-dataset-provisioning-patterns
- Noise/perturbation
  - Add bounded noise to aggregates to reduce linkage risk – ethics-guidelines.md
- Differential privacy (optional)
  - Apply when feasible for published aggregates; keep parameters and privacy budget internal – research-data-access.md

Notes
- Do not publish row‑level data or linkable quasi‑identifier combos.
- For geographic data, publish at an aggregated level consistent with re‑identification risk controls – research-data-access.md#6-dataset-provisioning-patterns

## Output controls
- Tables/Figures: suppress or re‑bin small cells; avoid residual identifiers in qualitative excerpts – ethics-guidelines.md
- Code/Artifacts: store within approved locations; exclude secrets; follow security framework – decisions/013-security-framework.md
- Accessibility: alt text for figures, sufficient contrast, semantic headings – decisions/014-accessibility-standards.md

## Validation & Monitoring
- Pre‑publication checklist completion – publication-guidelines.md
- Logs and monitoring for dataset access and exports – research-data-access.md#7-api-access-contract-academic-v1 and docs/architecture/compliance/audit-trail.md
- Review evidence retained per REVIEW_PROCESS.md

## FAQ
Q: Can I publish microdata samples?
A: No. Only aggregates and appropriately de‑identified summaries are permitted – research-data-access.md.

Q: What threshold should I use for small‑cell suppression?
A: n<10 as stated in research-data-access.md; when in doubt, generalize further.

## Changelog
- 0.1.0 (2025-08-08): Initial draft aligned to ethics, research data access, privacy-by-design, and ADR‑013/014.
