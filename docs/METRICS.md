---
title: "Documentation Metrics"
summary: "How we measure documentation quality and effectiveness for MerajutASA"
audience: ["developers", "contributors", "maintainers"]
stakeholder: ["government", "business", "academia", "community", "media"]
owner: "@wahyumumtazsyah04"
status: "approved"
last_reviewed: "2025-08-08"
tags: ["metrics", "quality", "documentation"]
---

# Documentation Metrics

This page defines a small, actionable set of metrics to monitor the health and effectiveness of our documentation. Metrics are grounded in our internal processes and automated checks.

## Goals
- Maintain accurate, accessible, child‑safe documentation.
- Reduce review/merge friction and broken links.
- Keep content fresh and aligned with stakeholders.

## Core metrics
- Lint/style compliance: 0 markdownlint errors on PRs.
- Link integrity: <0.5% broken links across docs/ and security/.
- Review SLA: median PR doc review time ≤ 5 business days (see docs/REVIEW_PROCESS.md).
- Freshness: ≥ 80% pages with last_reviewed ≤ 180 days.
- Structure health: 0 missing required files; 0 empty critical dirs (see CI summary).

## How we measure
- CI workflow: .github/workflows/agent-structure-check.yml
  - Verifies required files; warns on optional files and empty dirs.
  - Blocks placeholder/template language in docs/ and security/.
- Review process: docs/REVIEW_PROCESS.md
  - Tracks turnaround and quality gates during PRs.
- Style guide: docs/STYLE_GUIDE.md
  - Editorial standards measured via linters.

## Review cadence
- Weekly: CI summary review for warnings/errors; fix promptly.
- Monthly: Freshness audit (update last_reviewed where content is validated).
- Quarterly: Stakeholder alignment check with stakeholder documentation.

## Links
- Review Process: docs/REVIEW_PROCESS.md
- Style Guide: docs/STYLE_GUIDE.md
- Maintenance: docs/MAINTENANCE.md
- Architecture Decisions: docs/architecture/decisions/
