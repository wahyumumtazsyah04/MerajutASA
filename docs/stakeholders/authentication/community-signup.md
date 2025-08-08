---
title: "Community Account Sign-Up"
summary: "Step-by-step guide for community members to create a secure account with MFA and child-safety alignment."
audience: ["community", "volunteers"]
stakeholder: ["community"]
owner: "@security-leads"
status: "approved"
version: "1.0.0"
last_reviewed: "2025-08-08"
tags: ["authentication", "onboarding", "child-safety"]
---

# Community Account Sign-Up

## Purpose
Enable community members to register safely with verified identity, MFA, and the least-privilege defaults to protect children and sensitive data.

## Scope & Audience
- Target: New community users and volunteers
- Excludes: Staff/admin provisioning (handled by internal IT)

## Key Facts (Grounded)
- Communication access is gated by role and auditing: see ../../architecture/security/communication-security.md#communication-access-management
- Security integration uses centralized identity and RBAC controls: see ../../architecture/security/communication-security.md#security-integration-architecture
- Access controls are enforced platform-wide: see ../../../SECURITY.md

## Registration Steps (Implementation)
1. Create account
   - Start from the Sign Up button in the portal and choose email or federated login (recommended where available).
   - Use a personal email you control long term; avoid shared inboxes.
2. Verify email
   - Enter the one-time verification code sent to your email.
3. Enable multi-factor authentication (MFA)
   - Choose authenticator app or hardware key. SMS/email are allowed only as backup methods.
4. Complete profile
   - Select interests (volunteering, donations, advocacy). Do not include any child PII.
5. Acknowledge safety policies
   - Read and accept safety and data privacy terms linked in your onboarding.
6. Role activation
   - Basic community role is active immediately. Volunteer roles requiring child contact become available only after background checks and mandatory training; see ../community/safety/child-protection.md.

## Accessibility & Child Safety
- MFA setup supports multiple factors and recovery codes.
- No child PII may be entered during sign-up.
- Volunteer features remain locked until safety prerequisites are met.

## Validation & Monitoring
- Successful sign-up shows a verified badge on your profile.
- Access attempts and role changes are logged per ../../../SECURITY.md.
- If MFA fails or you suspect account compromise, contact security immediately via ../../../SECURITY.md#emergency-contacts.

---

Last reviewed: 2025-08-08
