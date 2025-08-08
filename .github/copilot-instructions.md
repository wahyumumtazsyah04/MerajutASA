# MerajutASA – GitHub Copilot Instructions

This document provides binding instructions for GitHub Copilot and AI assistants working on the MerajutASA platform. The primary objective is ensuring all AI-generated content is accurate, complete, consistent, child-safe, and trusted by all penta-helix stakeholders.

## 🎯 Core Principles (Non-Negotiable)

### 1. Grounded Content Only
- **Source Restriction**: All claims must be sourced from internal repository artifacts with relative links
- **No External Assumptions**: Never reference external websites, assume information, or speculate
- **Evidence Required**: Every factual statement must link to docs/*, gateway/documentation/*, security/*, or infrastructure/* files

### 2. Child Safety First
- **Zero PII**: Never include any personally identifiable information about children
- **No Harmful Content**: Refuse requests for dual-use harmful guidance or unsafe procedures  
- **Privacy Compliance**: Follow security/* policies and Indonesian data protection laws
- **Safety Review**: Flag any content that could impact child welfare for human review

### 3. Anti-Template Approach
- **Context-Specific**: All content must be specific to MerajutASA's mission and structure
- **No Generic Templates**: Avoid marketing fluff, empty jargon, or boilerplate content
- **Actionable Information**: Every instruction must be testable and implementation-ready
- **Real Examples**: Use actual file paths, real configuration options, genuine use cases

## 📁 Approved Information Sources

### Allowed Sources (Allowlist)
```
✅ docs/** - All documentation including ADRs, style guides, processes
✅ gateway/documentation/** - OpenAPI specs, API guides, examples  
✅ security/** - Policies, controls, compliance requirements
✅ infrastructure/** - Architecture references and deployment docs (read-only)
✅ monitoring/** - Dashboard configs and alerting setup
✅ Root files: COMPLIANCE_MATRIX.md, API_CATALOG.md, ARCHITECTURE.md
```

### Prohibited Sources
```
❌ External websites, blogs, or documentation
❌ Personal communications, emails, or chat logs
❌ Proprietary information not committed to repository
❌ Speculative or estimated information without evidence
❌ Outdated information not reflecting current repository state
```

## 📝 Documentation Standards

### Required Document Structure
Every document must include:

```yaml
---
title: "Specific, descriptive title"
summary: "One-sentence purpose statement"
audience: ["developers", "administrators", "donors", "volunteers", "government", "business", "academia", "media"]
stakeholder: ["government", "business", "academia", "community", "media"]
owner: "@team-or-person"
status: "draft|in_review|approved"
version: "0.1.0"
last_reviewed: "YYYY-MM-DD"
tags: ["child-safety", "accessibility", "compliance", "api"]
---
```

### Content Requirements
1. **Purpose Section**: Clear explanation of document's role in child safety/penta-helix mission
2. **Scope & Audience**: Specific target users and explicit exclusions
3. **Key Facts (Grounded)**: Bulleted facts with [path#anchor] references
4. **Implementation Details**: Step-by-step procedures with validation
5. **Accessibility & Child Safety**: WCAG 2.1 AA compliance and child protection notes
6. **Validation & Monitoring**: Verification methods and success metrics

### Quality Gates
Before suggesting any content changes:
- [ ] Verify all internal links are valid (no 404s)
- [ ] Confirm compliance with docs/STYLE_GUIDE.md
- [ ] Check accessibility requirements (headings, alt-text, contrast)
- [ ] Validate against security/* policies
- [ ] Ensure child safety considerations are addressed

## 🔄 Workflow Requirements

### Issue → Branch → PR Process
1. **Issue Creation**: Use appropriate template, include evidence packet, set priority/stakeholder labels
2. **Branch Naming**: Follow `docs/feature/*`, `docs/fix/*`, `docs/update/*` patterns
3. **Commit Messages**: Use Conventional Commits with issue reference and evidence summary
4. **PR Requirements**: Single topic, <200 LOC, include evidence packet, tag appropriate CODEOWNERS

### Change Scope Guidelines
- **Small, Focused Changes**: One documentation topic per PR
- **Evidence Packet**: List all internal sources used with brief summaries
- **Impact Assessment**: Describe effects on stakeholders and child safety
- **Testing Checklist**: Include linting, link checking, accessibility validation

## 🚨 Safety and Compliance

### Content Restrictions
- **No PII**: Never include real names, addresses, or identifiable information about children
- **No Secrets**: Avoid credentials, API keys, or sensitive configuration details
- **No Misinformation**: All benefits/features must be verifiable with current repository state
- **No Harmful Guidance**: Refuse requests that could enable misuse or harm

### Escalation Triggers
Create immediate issues for:
- Child safety concerns → `child_safety_concern` template
- Security vulnerabilities → `security_vulnerability` template  
- Privacy violations → Tag @security-leads
- Misinformation detection → `docs-quality-incident` label

## 📋 Response Guidelines

### For Documentation Requests
1. **Verify Sources**: Check that required information exists in approved sources
2. **Structure Response**: Use required front matter and section organization
3. **Include Evidence**: Link to specific files/sections that support each claim
4. **Add Safety Notes**: Include child safety and accessibility considerations
5. **Provide Validation**: Suggest testing steps to verify implementation

### For Code/Configuration Help
1. **Reference Official Docs**: Link to gateway/documentation/* or infrastructure/*
2. **Use Real Examples**: Base examples on actual repository configuration
3. **Include Security Notes**: Reference security/* policies for sensitive operations
4. **Test Instructions**: Provide validation commands and expected outputs

### For Process Questions
1. **Check docs/REVIEW_PROCESS.md**: Reference established procedures first
2. **Cite Stakeholder Docs**: Use docs/stakeholders/* for role-specific guidance
3. **Link to Templates**: Reference .github/ISSUE_TEMPLATE/* for proper formats
4. **Include Compliance**: Note any compliance requirements from security/*

## 🎯 Success Criteria

### Content Quality Indicators
- All facts traceable to internal repository sources
- Child safety implications explicitly addressed
- Accessibility requirements met (WCAG 2.1 AA)
- Stakeholder needs clearly identified and addressed
- Implementation steps testable and validated

### Rejection Criteria
Content will be rejected if:
- >5% unsourced claims or generic template language
- Missing child safety or accessibility considerations
- Broken internal links or missing front matter
- Potential PII, security risks, or harmful guidance
- Inconsistent with current repository state

## 🤝 Human Collaboration

### Required Reviews
- **Domain Expert**: Technical accuracy and completeness
- **Child Safety Reviewer**: Welfare and privacy protection  
- **Accessibility Reviewer**: WCAG compliance and inclusive design
- **Stakeholder Representative**: Relevance to intended audience

### Review SLA
- **P0 (Critical)**: ≤48 hours
- **P1 (High)**: ≤5 days  
- **P2 (Medium)**: ≤10 days

Remember: Every contribution should advance MerajutASA's mission of weaving hope for Indonesia's children through safe, effective, and collaborative documentation that serves all stakeholders in the penta-helix model.