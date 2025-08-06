# MerajutASA Platform - Architecture Diagrams

This directory contains the rendered architecture diagrams for the MerajutASA platform.

## Directory Structure

```
rendered/
├── png/                    # PNG format diagrams
├── svg/                    # SVG format diagrams  
├── pdf/                    # PDF format diagrams
├── eps/                    # EPS format diagrams (if generated)
└── thumbnails/             # Thumbnail versions
```

## Diagram Categories

### Sequence Diagrams (`source/sequence-diagrams/`)
- **user-registration.puml** - User registration and onboarding workflow
- **donation-processing.puml** - Donation processing and tracking system
- **content-publication.puml** - Content creation and publication workflow
- **stakeholder-collaboration.puml** - Multi-stakeholder coordination processes
- **emergency-response.puml** - Emergency response and crisis management

### Deployment Diagrams (`source/deployment-diagrams/`)
- **kubernetes-architecture.puml** - Kubernetes infrastructure and deployment
- **network-topology.puml** - Network architecture and security zones
- **data-flow.puml** - Data flow and processing architecture
- **security-zones.puml** - Security architecture and access control

### Stakeholder Diagrams (`source/stakeholder-diagrams/`)
- **collaboration-model.puml** - Penta-helix stakeholder ecosystem
- **governance-structure.puml** - Governance hierarchy and decision-making
- **communication-flows.puml** - Information flow and communication channels
- **impact-measurement.puml** - Impact tracking and measurement framework

## Generation Instructions

### Prerequisites
- Docker and Docker Compose installed
- PlantUML source files in `source/` directory

### Generate All Diagrams
```bash
# Linux/macOS
./scripts/generate-diagrams.sh

# Windows PowerShell
.\scripts\generate-diagrams.ps1
```

### Generate Specific Format
```bash
# Generate PNG only
./scripts/generate-diagrams.sh --format png

# Generate SVG only
.\scripts\generate-diagrams.ps1 -Format svg
```

### Regenerate After Changes
```bash
# Keep services running for quick regeneration
./scripts/generate-diagrams.sh --regenerate
```

## Key Features

### Child Protection Focus
All diagrams incorporate comprehensive child protection considerations:
- Privacy-preserving data flows
- Secure stakeholder interactions
- Trauma-informed design principles
- Cultural sensitivity in processes

### Penta-Helix Integration
Stakeholder diagrams model the five-helix collaboration framework:
- **Government**: Policy oversight and regulatory compliance
- **Business**: Corporate partnerships and CSR initiatives
- **Academic**: Research collaboration and knowledge sharing
- **Community**: Grassroots engagement and local expertise
- **Media**: Public awareness and communication amplification

### Indonesian Context
All diagrams are designed with Indonesian infrastructure and cultural considerations:
- Multi-language support capabilities
- Regional infrastructure adaptation
- Cultural sensitivity in stakeholder interactions
- Local partnership integration patterns

## Technical Implementation

### PlantUML C4 Model
All diagrams use the C4 model approach for architectural documentation:
- **Level 1**: System Context - High-level stakeholder interactions
- **Level 2**: Container - Major system components and relationships
- **Level 3**: Component - Detailed internal structure (where applicable)
- **Level 4**: Code - Implementation details (in separate documentation)

### Automation Features
- Docker-based diagram generation
- Multiple output format support
- Batch processing capabilities
- Validation and quality assurance
- Automatic index generation

## Usage Guidelines

### For Developers
- Use PNG files for development documentation
- Reference SVG files in web applications
- Include diagrams in code documentation

### For Stakeholders
- Use PNG files for presentations and reports
- Reference PDF files for formal documentation
- Share SVG files for interactive web viewing

### For Documentation
- Embed PNG files in markdown documentation
- Use SVG files for responsive web documentation
- Include PDF files in formal reports and proposals

---

**Platform**: MerajutASA - Indonesian Child Welfare Platform  
**Domain**: merajutasa.id  
**Architecture**: Multi-stakeholder penta-helix collaboration model  
**Focus**: Child protection and welfare through integrated stakeholder engagement
