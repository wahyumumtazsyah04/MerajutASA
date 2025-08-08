---
title: "Access Control Policy"
summary: "RBAC, least privilege, and review cadence for MerajutASA platform access."
audience: ["security","administrators","maintainers","devops"]
stakeholder: ["government","business","academia","community","media"]
owner: "@security-leads"
status: "in_review"
version: "1.0.0"
last_reviewed: "2025-08-08"
tags: ["security","policy","access-control","rbac","child-safety"]
---

## Purpose
Define consistent, auditable access control practices that minimize risk and protect children’s data.

## Scope & Audience
Applies to all identities (human and service), systems, environments, and datasets governed by MerajutASA.

## Key Facts (Grounded)
- Data sensitivity and handling: [security/policies/data-classification.md]
- Acceptable Use boundaries: [security/policies/acceptable-use.md]
- Security overview and incident process: [SECURITY.md]
- Architecture control references: [docs/architecture/compliance/security-controls.md]
- Ownership references: [.github/CODEOWNERS]

## Policy Requirements
1. Least Privilege: Grant the minimum permissions required to perform a task.
2. Role-Based Access Control (RBAC): Define roles aligned to duties; map identities to roles, not raw privileges.
3. Separation of Duties: No single identity should execute and approve high-risk changes end-to-end.
4. Strong Authentication: MFA required for privileged roles and administrative consoles.
5. Time-Bound Access: Use just-in-time elevation for exceptional tasks; auto-expire temporary grants.
6. Periodic Reviews: Access reviews at least quarterly; remove dormant and unnecessary accounts.
7. Service Accounts: Non-human identities scoped to specific resources; rotate credentials regularly; no shared accounts.
8. Auditability: All access changes traceable via issues/PRs/tickets with reviewer sign-off.

## Implementation Notes (Grounded)
- Map datasets to classifications in [security/policies/data-classification.md] and restrict access accordingly.
- Use ownership and review routing from [.github/CODEOWNERS] for sensitive areas.
- Document exceptions in PRs with mitigation and review dates.

## Accessibility & Child Safety
- Access requests must avoid sharing child PII in free-text; use IDs from safe environments only.
- Provide accessible request workflows and clear guidance for assistive technologies.

## Validation & Monitoring (optional)
- Periodic reconciliations of actual vs. intended access.
- Link with incident response in [SECURITY.md] for escalation pathways.

## Changelog
- 1.0.0 (2025-08-08): Initial access control policy grounded to internal sources.
