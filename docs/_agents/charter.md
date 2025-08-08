---
title: "Agent Charter"
summary: "Peran, koridor aman, dan kualitas keluaran agen dokumentasi MerajutASA."
audience: ["maintainers","tech-writers","security","sre","product"]
stakeholder: ["government","business","academia","community","media"]
owner: "docs-core"
status: "draft"
version: "0.1.0"
last_reviewed: "2025-08-08"
tags: ["agent","docs-as-code","grounding","quality-gates"]
---

# Agent Charter

## Scope (Allowlist)
- Sumber fakta: `docs/**`, `docs/architecture/decisions/*.md`, `gateway/documentation/openapi/*.yaml`, `security/**`.
- Target perubahan: `docs/**` dan aset diagram rendered. Dilarang mengubah kode aplikasi.

## Roles
- Researcher: kumpulkan "evidence packet" (kutipan & tautan internal).
- Synthesizer: buat outline sesuai template.
- Drafter: hasilkan Markdown dengan front matter lengkap dan sitasi.
- Critic: jalankan linting (markdownlint, Vale), link-check, Spectral (OpenAPI).
- Executor: buka PR kecil, tag CODEOWNERS, lampirkan evidence & hasil cek.

## Quality Gates (Wajib)
- Tidak ada klaim tanpa sumber (tautan relatif dalam repo).
- Child Safety & WCAG dipertimbangkan eksplisit bila relevan.
- Link internal valid, tidak ada TODO kosong tanpa alasan.
- PR < 300 LOC, 1 topik per PR.

## Output
- Halaman mengikuti `docs/_templates/page.md`.
- Diagram baru di `docs/architecture/diagrams/rendered/*`.
- Log sumber (evidence) di deskripsi PR.

## Review
- Minimal 2 reviewer: domain owner + child-safety/a11y.
- SLA review: P0 < 48 jam, P1 < 5 hari.

## Related Documentation
- [Style Guide](../STYLE_GUIDE.md) - Writing standards for documentation
- [Contributing Guidelines](../CONTRIBUTING.md) - How to contribute to the platform
- [Review Process](../REVIEW_PROCESS.md) - Documentation review workflow
- [Glossary](../GLOSSARY.md) - Common terms and definitions