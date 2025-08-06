#!/bin/bash

# MerajutASA Platform - Diagram Generation Script
# This script automates the generation of all architecture diagrams
# Supports PlantUML and Mermaid diagram formats with multiple output formats

set -e

# Configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
DIAGRAMS_DIR="$PROJECT_ROOT/docs/architecture/diagrams"
SOURCE_DIR="$DIAGRAMS_DIR/source"
RENDERED_DIR="$DIAGRAMS_DIR/rendered"
TOOLS_DIR="$DIAGRAMS_DIR/tools"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Logging function
log() {
    echo -e "${BLUE}[$(date +'%Y-%m-%d %H:%M:%S')]${NC} $1"
}

error() {
    echo -e "${RED}[ERROR]${NC} $1" >&2
}

success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

# Check if Docker is available
check_docker() {
    if ! command -v docker &> /dev/null; then
        error "Docker is not installed or not in PATH"
        exit 1
    fi
    
    if ! docker info &> /dev/null; then
        error "Docker daemon is not running"
        exit 1
    fi
    
    success "Docker is available and running"
}

# Create directory structure
setup_directories() {
    log "Setting up directory structure..."
    
    # Create rendered directories
    mkdir -p "$RENDERED_DIR"/{png,svg,pdf,eps}
    mkdir -p "$RENDERED_DIR"/{sequence-diagrams,deployment-diagrams,stakeholder-diagrams}
    
    # Create subdirectories for each format
    for format in png svg pdf eps; do
        mkdir -p "$RENDERED_DIR/$format"/{sequence-diagrams,deployment-diagrams,stakeholder-diagrams}
    done
    
    success "Directory structure created"
}

# Start Docker services
start_services() {
    log "Starting diagram generation services..."
    
    cd "$TOOLS_DIR"
    
    # Start PlantUML services
    if [ -f "plantuml-docker.yml" ]; then
        log "Starting PlantUML services..."
        docker-compose -f plantuml-docker.yml up -d
        sleep 5
    fi
    
    # Start Mermaid services
    if [ -f "mermaid-cli.yml" ]; then
        log "Starting Mermaid services..."
        docker-compose -f mermaid-cli.yml up -d
        sleep 5
    fi
    
    success "Services started"
}

# Stop Docker services
stop_services() {
    log "Stopping diagram generation services..."
    
    cd "$TOOLS_DIR"
    
    # Stop all services
    if [ -f "plantuml-docker.yml" ]; then
        docker-compose -f plantuml-docker.yml down
    fi
    
    if [ -f "mermaid-cli.yml" ]; then
        docker-compose -f mermaid-cli.yml down
    fi
    
    success "Services stopped"
}

# Generate PlantUML diagrams
generate_plantuml() {
    local source_dir="$1"
    local output_format="$2"
    local output_dir="$3"
    
    log "Generating PlantUML diagrams from $source_dir in $output_format format..."
    
    # Find all .puml files
    find "$source_dir" -name "*.puml" -type f | while read -r puml_file; do
        local filename=$(basename "$puml_file" .puml)
        local relative_path=$(dirname "${puml_file#$SOURCE_DIR/}")
        local output_subdir="$output_dir/$relative_path"
        
        mkdir -p "$output_subdir"
        
        log "Processing: $filename"
        
        # Generate using PlantUML CLI container
        docker exec merajutasa-plantuml-cli java -jar /opt/plantuml.jar \
            -t$output_format \
            -o "/app/rendered/$output_format/$relative_path" \
            "/app/source/$relative_path/$filename.puml" 2>/dev/null || {
            error "Failed to generate $filename.$output_format"
            continue
        }
        
        success "Generated: $filename.$output_format"
    done
}

# Generate all PlantUML formats
generate_all_plantuml() {
    log "Generating all PlantUML diagrams..."
    
    # Check if PlantUML container is running
    if ! docker ps | grep -q "merajutasa-plantuml-cli"; then
        error "PlantUML CLI container is not running"
        return 1
    fi
    
    # Generate in different formats
    for format in png svg pdf eps; do
        generate_plantuml "$SOURCE_DIR" "$format" "$RENDERED_DIR/$format"
    done
    
    success "All PlantUML diagrams generated"
}

# Generate Mermaid diagrams (if any exist)
generate_mermaid() {
    local source_dir="$1"
    local output_format="$2"
    local output_dir="$3"
    
    log "Generating Mermaid diagrams from $source_dir in $output_format format..."
    
    # Find all .mmd files
    find "$source_dir" -name "*.mmd" -type f | while read -r mmd_file; do
        local filename=$(basename "$mmd_file" .mmd)
        local relative_path=$(dirname "${mmd_file#$SOURCE_DIR/}")
        local output_subdir="$output_dir/$relative_path"
        
        mkdir -p "$output_subdir"
        
        log "Processing: $filename"
        
        # Generate using Mermaid CLI container
        docker exec merajutasa-mermaid-cli mmdc \
            -i "/app/source/$relative_path/$filename.mmd" \
            -o "/app/rendered/$output_format/$relative_path/$filename.$output_format" \
            -t dark -b transparent 2>/dev/null || {
            error "Failed to generate $filename.$output_format"
            continue
        }
        
        success "Generated: $filename.$output_format"
    done
}

# Validate generated diagrams
validate_diagrams() {
    log "Validating generated diagrams..."
    
    local error_count=0
    
    # Check PNG files
    find "$RENDERED_DIR/png" -name "*.png" -type f | while read -r png_file; do
        if [ ! -s "$png_file" ]; then
            error "Empty PNG file: $png_file"
            ((error_count++))
        fi
    done
    
    # Check SVG files
    find "$RENDERED_DIR/svg" -name "*.svg" -type f | while read -r svg_file; do
        if [ ! -s "$svg_file" ]; then
            error "Empty SVG file: $svg_file"
            ((error_count++))
        fi
    done
    
    if [ $error_count -eq 0 ]; then
        success "All generated diagrams are valid"
    else
        warning "$error_count validation errors found"
    fi
}

# Generate diagram index
generate_index() {
    log "Generating diagram index..."
    
    local index_file="$RENDERED_DIR/README.md"
    
    cat > "$index_file" << 'EOF'
# MerajutASA Platform - Architecture Diagrams

This directory contains all rendered architecture diagrams for the MerajutASA platform.

## Generated Formats

- **PNG**: High-quality raster images for documentation and presentations
- **SVG**: Vector graphics for web display and scalable viewing
- **PDF**: Print-ready format for formal documentation
- **EPS**: Vector format for professional publishing

## Diagram Categories

### Sequence Diagrams
Process workflow documentation for platform operations:

EOF

    # Add sequence diagrams
    find "$RENDERED_DIR/png/sequence-diagrams" -name "*.png" -type f | sort | while read -r file; do
        local filename=$(basename "$file" .png)
        local title=$(echo "$filename" | sed 's/-/ /g' | sed 's/\b\w/\u&/g')
        echo "- [$title](png/sequence-diagrams/$filename.png)" >> "$index_file"
    done
    
    cat >> "$index_file" << 'EOF'

### Deployment Diagrams
Infrastructure and deployment architecture visualization:

EOF

    # Add deployment diagrams
    find "$RENDERED_DIR/png/deployment-diagrams" -name "*.png" -type f | sort | while read -r file; do
        local filename=$(basename "$file" .png)
        local title=$(echo "$filename" | sed 's/-/ /g' | sed 's/\b\w/\u&/g')
        echo "- [$title](png/deployment-diagrams/$filename.png)" >> "$index_file"
    done
    
    cat >> "$index_file" << 'EOF'

### Stakeholder Diagrams
Penta-helix stakeholder interaction and governance modeling:

EOF

    # Add stakeholder diagrams
    find "$RENDERED_DIR/png/stakeholder-diagrams" -name "*.png" -type f | sort | while read -r file; do
        local filename=$(basename "$file" .png)
        local title=$(echo "$filename" | sed 's/-/ /g' | sed 's/\b\w/\u&/g')
        echo "- [$title](png/stakeholder-diagrams/$filename.png)" >> "$index_file"
    done
    
    cat >> "$index_file" << 'EOF'

## Usage Instructions

### Viewing Diagrams
- Open PNG files for quick viewing
- Use SVG files for web integration
- Use PDF files for printing and formal documentation

### Updating Diagrams
To regenerate diagrams after source changes:
```bash
./scripts/generate-diagrams.sh --regenerate
```

### Custom Generation
To generate specific formats only:
```bash
./scripts/generate-diagrams.sh --format png
./scripts/generate-diagrams.sh --format svg
```

## Technical Details

### Generation Process
1. PlantUML source files (.puml) are processed using PlantUML CLI
2. Multiple output formats are generated simultaneously
3. Diagrams are organized by category and format
4. Validation ensures all files are properly generated

### Child Protection Focus
All diagrams incorporate child protection and safety considerations:
- Privacy-preserving data flows
- Secure stakeholder interactions
- Trauma-informed design principles
- Cultural sensitivity in stakeholder modeling

### Penta-Helix Integration
Stakeholder diagrams model the five-helix collaboration:
- **Government**: Policy and regulatory oversight
- **Business**: Corporate partnership and CSR
- **Academic**: Research and knowledge contribution
- **Community**: Grassroots engagement and local expertise
- **Media**: Awareness and communication amplification

---

*Generated on: $(date)*
*Platform: MerajutASA - Indonesian Child Welfare Platform*
*Domain: merajutasa.id*
EOF

    success "Diagram index generated: $index_file"
}

# Create diagram thumbnails
generate_thumbnails() {
    log "Generating diagram thumbnails..."
    
    local thumb_dir="$RENDERED_DIR/thumbnails"
    mkdir -p "$thumb_dir"
    
    # Generate thumbnails from PNG files
    find "$RENDERED_DIR/png" -name "*.png" -type f | while read -r png_file; do
        local relative_path="${png_file#$RENDERED_DIR/png/}"
        local thumb_path="$thumb_dir/$relative_path"
        local thumb_dir_path=$(dirname "$thumb_path")
        
        mkdir -p "$thumb_dir_path"
        
        # Use ImageMagick to create thumbnail (if available)
        if command -v convert &> /dev/null; then
            convert "$png_file" -resize 300x200 "$thumb_path" 2>/dev/null || {
                warning "Could not create thumbnail for $(basename "$png_file")"
            }
        else
            # Copy original if ImageMagick not available
            cp "$png_file" "$thumb_path"
        fi
    done
    
    success "Thumbnails generated"
}

# Main function
main() {
    log "Starting MerajutASA diagram generation process..."
    
    local regenerate=false
    local format_filter=""
    
    # Parse command line arguments
    while [[ $# -gt 0 ]]; do
        case $1 in
            --regenerate|-r)
                regenerate=true
                shift
                ;;
            --format|-f)
                format_filter="$2"
                shift 2
                ;;
            --stop|-s)
                stop_services
                exit 0
                ;;
            --help|-h)
                echo "Usage: $0 [OPTIONS]"
                echo "Options:"
                echo "  --regenerate, -r     Force regeneration of all diagrams"
                echo "  --format FORMAT, -f  Generate only specified format (png, svg, pdf, eps)"
                echo "  --stop, -s           Stop all diagram services"
                echo "  --help, -h           Show this help message"
                exit 0
                ;;
            *)
                error "Unknown option: $1"
                exit 1
                ;;
        esac
    done
    
    # Setup
    check_docker
    setup_directories
    start_services
    
    # Wait for services to be ready
    log "Waiting for services to be ready..."
    sleep 10
    
    # Generate diagrams
    if [ "$format_filter" ]; then
        log "Generating diagrams in $format_filter format only..."
        generate_plantuml "$SOURCE_DIR" "$format_filter" "$RENDERED_DIR/$format_filter"
    else
        generate_all_plantuml
    fi
    
    # Generate Mermaid diagrams if they exist
    if find "$SOURCE_DIR" -name "*.mmd" -type f | grep -q .; then
        log "Found Mermaid diagrams, generating..."
        for format in png svg pdf; do
            if [ -z "$format_filter" ] || [ "$format_filter" = "$format" ]; then
                generate_mermaid "$SOURCE_DIR" "$format" "$RENDERED_DIR/$format"
            fi
        done
    fi
    
    # Post-processing
    validate_diagrams
    generate_index
    generate_thumbnails
    
    # Cleanup
    if [ "$regenerate" = true ]; then
        log "Keeping services running for potential regeneration..."
    else
        stop_services
    fi
    
    success "Diagram generation completed successfully!"
    log "Generated diagrams are available in: $RENDERED_DIR"
    log "View the index at: $RENDERED_DIR/README.md"
}

# Run main function with all arguments
main "$@"
