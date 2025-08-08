---
title: "Publication Guidelines (Academia)"
summary: "Rules and workflow for safe, privacy-preserving, accessible academic publications using MerajutASA data."
audience: ["academia","developers","administrators"]
stakeholder: ["academia"]
owner: "@academic-collab-lead"
status: "draft"
version: "0.1.0"
last_reviewed: "2025-08-08"
tags: ["child-safety","privacy","accessibility","compliance","docs"]
---

# Publication Guidelines (Academia)

Purpose: set clear, child-safe, and privacy-preserving rules for publishing academic outputs that use MerajutASA data, systems, or collaborations. These guidelines align with platform governance, ethics, accessibility, security, and documentation standards.

—

## Scope and audience
- Applies to: university faculty, students, research staff, and collaborators producing manuscripts, theses, conference papers/posters, technical reports, datasets, and code artifacts.
- In scope outputs: text, figures/tables, appendices/supplements, code repositories, and data descriptors derived from MerajutASA activities.

Internal references (must read before drafting):
- Research Ethics & Child Protection Guidelines (Academia) → `./ethics-guidelines.md`
- Research Data Access for Academia → `./research-data-access.md`
- Academic API Documentation (v1) → `./api-documentation.md`
- Data Anonymization for Academic Use → `./data-anonymization.md`
- Student Projects (Academia) → `./student-projects.md`
- Documentation Style Guide → `../../STYLE_GUIDE.md`
- Translation & Localization Guide → `../../TRANSLATION_GUIDE.md`
- Documentation Review Process → `../../REVIEW_PROCESS.md`
- ADR-011 Documentation Platform → `../../api/decisions/011-documentation-platform.md`
- ADR-012 Testing Strategy → `../../api/decisions/012-testing-strategy.md`
- ADR-013 Security Framework → `../../api/decisions/013-security-framework.md`
- ADR-014 Accessibility Standards → `../../api/decisions/014-accessibility-standards.md`
- ADR-015 Internationalization Framework → `../../api/decisions/015-internationalization-framework.md`

—

## Publication types and positioning

Accepted categories
- Peer‑reviewed journal articles (empirical, methodological, reviews)
- Conference papers and posters (academic or practitioner)
- Technical reports, white papers, policy briefs
- Theses and dissertations (under institutional policies)
- Data descriptors (for approved de‑identified datasets) and reproducibility reports

Positioning statements (include one in the Acknowledgments)
- “This work was conducted in collaboration with MerajutASA under approved research protocols and data governance.”
- “Findings reflect the authors’ analysis; they do not represent official positions of MerajutASA or partner institutions.”

—

## Ethics, privacy, and child safety (required)
Must comply with:
- Ethics and child protection controls → `./ethics-guidelines.md`
- Data governance, minimization, and DPIA essentials → `./research-data-access.md#4-dpia-data-protection-impact-assessment-essentials`
- Security-by-design and lawful processing baselines → `../../api/decisions/013-security-framework.md`

Author responsibilities
- Confirm IRB/Komite Etik approval ID and DUA ID in the manuscript’s methods/ethics section.
- Describe de-identification and small-cell protections used (no n<10; generalization/suppression as applicable) → `./research-data-access.md#6-dataset-provisioning-patterns`.
- Remove or mask residual identifiers in qualitative excerpts; obtain consent for any quotes per `./ethics-guidelines.md`.

Prohibited
- Attempts to re-identify individuals or facilities.
- Publishing row-level or linkable quasi-identifier combinations.
- Sharing raw extracts outside approved enclaves or repositories.

—

## Accessibility and inclusion
Follow accessibility and localization standards end-to-end:
- Content accessibility per ADR‑014 (WCAG 2.1 AA) → `../../api/decisions/014-accessibility-standards.md`
- Inclusive language and person-first terminology → `../../STYLE_GUIDE.md`
- Bilingual or localized abstracts when applicable; use translation workflow → `../../TRANSLATION_GUIDE.md`
- Provide alt text for figures; ensure sufficient color contrast; avoid color-only encodings.

—

## Methods transparency and reproducibility
- Document datasets, variables, and transformations; include codebook links when available → `./api-documentation.md` and `./research-data-access.md#3-access-workflow-documentation-first`.
- Provide analysis code when feasible; include tests or notebooks aligned with ADR‑012 → `../../api/decisions/012-testing-strategy.md`.
- Supply model cards/data sheets for ML or datasets (stored within approved enclaves or redacted public repos per security framework) → `../../api/decisions/013-security-framework.md`.

—

## Figures, tables, and small‑cell rules
- Aggregate outputs only; suppress or generalize small cells (n<10) → `./research-data-access.md#6-dataset-provisioning-patterns`.
- Round or bin sensitive metrics; avoid unit record disclosure risk.
- For maps/geo outputs, use appropriate generalization (e.g., province-level) and blur rare combinations.

—

## Authorship, contributions, and acknowledgments
- Use a contributorship statement (e.g., CRediT-style roles) in line with our Style Guide → `../../STYLE_GUIDE.md`.
- Acknowledge MerajutASA data stewards and participating communities when applicable.
- Disclose funding sources and conflicts of interest transparently.

—

## Pre‑submission checklist (must pass)
- [ ] IRB/Komite Etik approval referenced; DUA ID included → `./ethics-guidelines.md`, `./research-data-access.md`
- [ ] De‑identification described; small‑cell safeguards verified
- [ ] Security and privacy review completed (see Security Framework) → `../../api/decisions/013-security-framework.md`
- [ ] Accessibility pass (alt text, contrast, headings) → `../../api/decisions/014-accessibility-standards.md`
- [ ] Style and tone compliant; inclusive language check → `../../STYLE_GUIDE.md`
- [ ] Translation plan complete (if applicable) → `../../TRANSLATION_GUIDE.md`
- [ ] All figures/tables free of prohibited detail; bins/rounding applied
- [ ] Code and artifacts placed in approved locations; secrets absent; licenses set

—

## Internal review and approval workflow
These steps precede any external submission or public posting → `../../REVIEW_PROCESS.md`.

1) Evidence packet preparation
   - Manuscript draft (PDF/Doc), figures/tables, supplements
   - Methods appendix with data governance summary and small‑cell analysis
   - Links to code/notebooks (internal or redacted public)

2) Required reviews (parallel)
   - Ethics & Privacy: confirm compliance with `./ethics-guidelines.md` and DPIA notes in `./research-data-access.md`
   - Security: verify no sensitive disclosures; repository settings consistent with ADR‑013
   - Accessibility & Language: ADR‑014 checks; inclusive language; localization plan
   - Documentation QA: formatting/style compliance; references consistency per ADR‑011 and Style Guide

3) Approvals and sign‑off
   - Sign‑offs recorded as part of the review log → `../../REVIEW_PROCESS.md`
   - Any conditions for submission are documented and tracked to closure

—

## Post‑publication obligations
- Send citation and final versions to data‑academic and ethics liaisons noted in `./research-data-access.md`.
- Provide a plain‑language summary for stakeholders in Bahasa Indonesia.
- Log published artifacts and links for analytics and knowledge base updates (per ADR‑011).
- Monitor and correct errata; coordinate retractions if privacy risks are later discovered.

—

## Templates and resources
- Manuscript checklist (this section) – copy into your project docs
- Figure/table anonymization guide – see `./research-data-access.md#6-dataset-provisioning-patterns`
- Accessibility quick check – see ADR‑014 and `../../STYLE_GUIDE.md`
- Documentation publication conventions – ADR‑011 and `../../REVIEW_PROCESS.md`

—

## Open questions / gaps
- Data anonymization cookbook (academia) is referenced across pages; if not yet published, raise a docs‑gap issue and coordinate with Data Steward to finalize thresholds and examples.

—

Last updated: YYYY‑MM‑DD
Owner: Academic Collaboration Lead (with Ethics, Security, Documentation)
