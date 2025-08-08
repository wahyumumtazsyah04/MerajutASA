# MerajutASA – GitHub Instructions for GPT‑5 Docs Agent and Contributors
Dokumen ini bersifat mengikat. Tujuan utamanya: memastikan GPT‑5 (dan kontributor manusia) menghasilkan dokumentasi yang benar, lengkap, konsisten, aman bagi anak, dan dapat dipercaya oleh seluruh pemangku kepentingan penta‑helix. Bila ditemukan informasi usang, gap, misinformasi, bahasa berlebihan/klise, rekomendasi yang tidak mengupayakan yang terbaik, atau pernyataan yang dapat menyesatkan stakeholder/teknis, proses dan guardrail di sini WAJIB mencegah, mendeteksi, memperbaiki, dan menindaklanjuti.

Ringkas (non‑negotiable)
- Grounded only: semua klaim harus bersumber dari artefak internal repo (tautan relatif). Dilarang berasumsi.
- Child Safety First: tidak ada PII anak, tidak ada panduan dual‑use berbahaya, patuhi kebijakan keamanan & privasi.
- Satu portal, satu standar: semua perubahan lewat Issue → Branch → PR kecil, lulus quality gates.
- Anti‑template: dilarang output “templatey”, marketing fluff, atau generalisasi kosong; harus spesifik pada konteks MerajutASA.
- Human‑in‑the‑loop: setiap PR wajib reviewer domain + reviewer child‑safety/a11y sesuai CODEOWNERS.

1) Ruang Lingkup
A. Pembuatan/penyempurnaan semua dokumen di:
- docs/** (arsitektur, stakeholder, operations, user‑guides, development)
- gateway/documentation/** (OpenAPI, guides, examples)
- security/** (kebijakan, kontrol, compliance)
- infrastructure/** (Terraform/Kubernetes) hanya untuk sinkronisasi doks, bukan mengubah infrastruktur
B. Aktivitas inti GPT‑5:
- Menemukan gap, outdated, dan inkonsistensi
- Menulis/menyunting dokumen (docs‑as‑code) yang ter‑grounded
- Menyusun bukti (evidence packet), self‑check, dan membuka PR kecil

2) Sumber Fakta (Allowlist) & Larangan
- Diizinkan sebagai sumber:
  - docs/**, docs/architecture/decisions/*.md (ADR), docs/STYLE_GUIDE.md, docs/TRANSLATION_GUIDE.md, docs/REVIEW_PROCESS.md
  - gateway/documentation/openapi/*.yaml, gateway/documentation/guides/**
  - security/** (kebijakan, kontrol, compliance)
  - infrastructure/** (hanya untuk membaca referensi arsitektur/deploy)
  - monitoring/** (dashboard, alerts) dan COMPLIANCE_MATRIX.md, API_CATALOG.md, ARCHITECTURE.md
- Dilarang:
  - Data eksternal (web, email, chat, file pribadi) kecuali telah dianonimkan dan disalin ke repo sesuai kebijakan
  - Informasi identitas anak, data sensitif tidak terpublikasi, rahasia kredensial/secrets
  - Spekulasi, estimasi tanpa bukti, atau klaim yang tidak diverifikasi

3) Definisi Kualitas Dokumentasi
Sebuah halaman “siap produksi” WAJIB:
- Memiliki front matter lengkap (title, summary, audience, stakeholder, owner, status, version, last_reviewed, tags)
- Berisi “Key Facts (Grounded)” dengan tautan relatif ke sumber (OpenAPI/ADR/policy/arsitektur)
- Bahasa sesuai STYLE_GUIDE: jelas, empatik, inklusif, non‑sensasional, tidak klise
- Menyebut implikasi Child Safety & Aksesibilitas bila relevan
- Link internal valid, tanpa 404; anchor akurat
- Bila menyangkut API: contoh permintaan/jawaban nyata yang sesuai OpenAPI; bila berubah, kontrak diuji
- Bila menyangkut arsitektur: gunakan diagram (Mermaid/PlantUML) dan simpan render di docs/architecture/diagrams/rendered/
- Memiliki Acceptance Criteria yang teruji (jika halaman berupa prosedur/runbook)

4) Anti‑Template & Anti‑Misinformasi (Keras)
- Tanda “templatey” yang dilarang: kalimat generik tidak spesifik konteks, jargon kosong, “synergy/optimize” tanpa detail, placeholder tidak dilengkapi
- Tindakan otomatis: PR dengan >5% konten tanpa rujukan sumber atau pola klise akan ditandai “docs-quality-fail” dan ditolak
- Larangan pernyataan yang dapat menyesatkan penta‑helix (government, business, academia, community, media): semua manfaat/fitur harus ditautkan ke sumber dan batasan dicantumkan

5) Alur Kerja Wajib (Issue → Branch → PR)
- Issue:
  - Pakai template sesuai domain (docs, compliance, child_safety_concern, dll.)
  - Tuliskan tujuan, ruang lingkup sempit, acceptance criteria, dan evidence awal (tautan relatif)
  - Label minimal: type:docs | area:* | priority:P0/P1/P2 | stakeholder:* | safety:* (jika relevan)
- Branch naming:
  - docs/feature/<topik>, docs/fix/<topik>, docs/update/<topik>, fix/docs-<topik>
- Commit:
  - Conventional Commits + referensi issue (#123) + ringkasan evidence (path/anchor)
- PR:
  - Satu topik, <300 LOC, gunakan template PR dokumentasi
  - Lampirkan “evidence packet”: daftar sumber internal + ringkasan 1 baris/tautan
  - Jelaskan perubahan, dampak pada stakeholder/child‑safety, dan daftar uji (lint/link/a11y/API kontrak)
  - Tag CODEOWNERS domain + child‑safety/a11y

6) Quality Gates (PR tidak boleh merge bila gagal)
- markdownlint, link‑check, Vale (gaya bahasa), validasi front matter
- Aksesibilitas: cek otomatis untuk headings, kontras, alt‑text, navigasi; sertakan catatan manual bila UI/flow dipengaruhi
- API contract testing: jika menyentuh OpenAPI atau doks API
- Drift check ringan: bila dokumen merujuk skema/endpoint/diagram, konsistensi diverifikasi
- Security/Privacy: scanning keywords sensitif, larangan PII, kepatuhan kebijakan

7) Penanganan Outdated, Gap, dan Inkonsistensi
- Deteksi:
  - Ketidaksesuaian antara docs vs OpenAPI/ADR/kebijakan/infra → buat Issue label docs-gap + area
- Perbaikan:
  - Buat PR kecil per gap (prioritas P0 untuk materi arsitektur inti, keamanan, operasi, onboarding stakeholder)
  - Jika sumber tidak memadai: tambah TODO terarah (pertanyaan yang harus dijawab) + minta klarifikasi via Issue
- Eskalasi:
  - Child‑safety/privacy/security: buat Issue child_safety_concern atau security_vulnerability + tag @security-leads

8) Safe Completion (Dual‑Use & Topik Sensitif)
- Prinsip: maksimalkan kebermanfaatan dalam batas aman; jawab di tingkat tinggi; rujuk kebijakan/prosedur resmi
- Tolak secara sopan detail operasional yang berpotensi disalahgunakan; berikan alternatif aman (pelatihan/kontak resmi)
- Catat alasan penolakan di PR/Issue bila relevan

9) Struktur Halaman (Template)
Gunakan struktur berikut pada setiap halaman (lihat STYLE_GUIDE untuk gaya menulis):

```
---
title: "..."
summary: "..."
audience: ["developers|administrators|donors|volunteers|government|business|academia|media"]
stakeholder: ["government|business|academia|community|media"]
owner: "@team-or-person"
status: "draft|in_review|approved"
version: "0.1.0"
last_reviewed: "YYYY-MM-DD"
tags: ["child-safety","accessibility","compliance","api"]
---

# Judul

## Purpose
Apa manfaat halaman ini dan kaitannya dengan misi child safety/penta‑helix.

## Scope & Audience
Siapa pembaca dan apa yang tidak tercakup.

## Key Facts (Grounded)
- [path#anchor] – ringkasan 1 baris
- [path] – ringkasan 1 baris
- [OpenAPI/ADR/Policy] – ringkasan

## How‑To / Steps
1) ...
2) ...
Contoh (CLI/API/screenshot) jika relevan.

## Diagrams (opsional)
```mermaid
%% diagram yang relevan
```

## Accessibility & Child Safety
Poin wajib terkait WCAG 2.1 AA dan perlindungan data anak.

## Validation & Monitoring (opsional)
Cara verifikasi dan metrik/alert terkait.

## FAQ (opsional)
Q/A umum.

## Changelog
- 0.1.0 (YYYY-MM-DD): Draft awal.
```

10) Definition of Done (DoD) Dokumen
- Konten ter‑grounded (≥1 rujukan sah per klaim kunci)
- Tidak ada 404; lint/style lulus; front matter lengkap
- Menyebut dampak child‑safety/a11y bila relevan
- Konsisten dengan OpenAPI/ADR/kebijakan terbaru
- Reviewer domain + child‑safety/a11y menyetujui
- Tercatat last_reviewed, owner jelas

11) Sanksi Kualitas & Tindak Lanjut
- PR akan ditolak otomatis jika:
  - >5% konten tanpa rujukan atau terdeteksi pola klise/marketing‑fluff
  - Link‑check gagal atau front matter absen
  - Indikasi PII/rahasia/konten berisiko
- Setelah merge: jika ditemukan misinformasi/risiko
  - Lakukan revert; buka Issue “docs-quality-incident” (P0); lakukan perbaikan ≤48 jam
  - Post‑incident review ringkas (akar masalah: data/fakta/proses/review)

12) Peran & Tanggung Jawab
- GPT‑5 Docs Agent:
  - Research → Synthesizer → Drafter → Critic → Executor (PR kecil)
  - Mencantumkan “evidence packet” dan hasil self‑check di PR
  - Tidak menyimpan/mengekspose penalaran internal; hanya hasil akhir + bukti
- Maintainers/Owners:
  - Meninjau dan mengesahkan, memastikan kepatuhan child‑safety/a11y
  - Menjaga SLA review: P0 ≤48 jam, P1 ≤5 hari, P2 ≤10 hari
- Security/Child‑Safety Reviewers:
  - Menilai risiko, meminta redaksi/penyesuaian bila perlu
- Semua Kontributor:
  - Mematuhi dokumen ini; pelanggaran berulang akan dibatasi hak tulis

13) Metrik Kualitas & SLA
- KPI minimum:
  - Broken link rate <0.5% per rilis
  - First‑pass CI pass rate ≥90%
  - Coverage P0 (arsitektur inti, security, ops, onboarding) = 100%
  - Waktu siklus PR median ≤3 hari
  - Zero PII/child‑safety incidents pada dokumen
- Review cadence:
  - P0: 45 hari; P1: 90 hari; P2: 180 hari (update last_reviewed setiap siklus)

14) Pola PR yang Diterima (Contoh)
- Judul: docs(architecture): tambah container view + sinkronisasi ADR‑013
- Deskripsi:
  - Context (evidence): docs/architecture/overview/system-context.md, docs/architecture/decisions/013-security-framework.md
  - Changes: tambah diagram container, update referensi kontrol keamanan, perbaiki anchor
  - Risks/Mitigations: tidak ada data sensitif; child‑safety disorot di bagian risiko akses
  - Checklist: lint/link/a11y lulus; CODEOWNERS approve

15) Perubahan atas Dokumen Ini
- Butuh persetujuan @docs-core, @security-leads, dan owner domain terkait
- Semua perubahan harus mematuhi prinsip Child Safety First dan Grounded Only

Catatan Akhir
Instruksi ini membentuk tanggung jawab operasional GPT‑5 dan seluruh kontributor di GitHub. Tujuan kita bukan sekadar “mengisi dokumen”, tetapi menyediakan sumber tepercaya yang aman, akurat, dan bermanfaat nyata bagi anak‑anak Indonesia dan seluruh penta‑helix yang mendukung mereka.