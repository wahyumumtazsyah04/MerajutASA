#!/bin/bash

# MerajutASA Platform - Mermaid Batch Processing Script
# This script processes all Mermaid diagrams in batch mode

set -e

# Configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
DIAGRAMS_DIR="$PROJECT_ROOT/docs/architecture/diagrams"
SOURCE_DIR="$DIAGRAMS_DIR/source"
RENDERED_DIR="$DIAGRAMS_DIR/rendered"
CONFIG_FILE="$DIAGRAMS_DIR/tools/mermaid-config.json"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Logging functions
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

# Process single Mermaid file
process_mermaid_file() {
    local input_file="$1"
    local output_format="$2"
    local output_dir="$3"
    
    local filename=$(basename "$input_file" .mmd)
    local relative_path=$(dirname "${input_file#$SOURCE_DIR/}")
    local output_subdir="$output_dir/$relative_path"
    local output_file="$output_subdir/$filename.$output_format"
    
    # Create output directory
    mkdir -p "$output_subdir"
    
    log "Processing: $filename -> $output_format"
    
    # Check if Mermaid CLI container is running
    if docker ps | grep -q "merajutasa-mermaid-cli"; then
        # Use Docker container
        docker exec merajutasa-mermaid-cli mmdc \
            -i "/app/source/$relative_path/$filename.mmd" \
            -o "/app/rendered/$output_format/$relative_path/$filename.$output_format" \
            -t dark -b transparent \
            -c /app/config.json 2>/dev/null || {
            error "Failed to process $filename with Docker"
            return 1
        }
    elif command -v mmdc &> /dev/null; then
        # Use local Mermaid CLI
        mmdc \
            -i "$input_file" \
            -o "$output_file" \
            -t dark -b transparent \
            -c "$CONFIG_FILE" 2>/dev/null || {
            error "Failed to process $filename with local CLI"
            return 1
        }
    else
        warning "Neither Docker container nor local Mermaid CLI available for $filename"
        return 1
    fi
    
    success "Generated: $filename.$output_format"
    return 0
}

# Process all Mermaid files
process_all_mermaid() {
    local output_format="$1"
    local output_dir="$2"
    
    log "Processing all Mermaid files to $output_format format..."
    
    local processed_count=0
    local failed_count=0
    
    # Find all .mmd files
    while IFS= read -r -d '' mmd_file; do
        if process_mermaid_file "$mmd_file" "$output_format" "$output_dir"; then
            ((processed_count++))
        else
            ((failed_count++))
        fi
    done < <(find "$SOURCE_DIR" -name "*.mmd" -type f -print0)
    
    if [ $processed_count -gt 0 ]; then
        success "Processed $processed_count Mermaid diagrams"
    fi
    
    if [ $failed_count -gt 0 ]; then
        warning "$failed_count diagrams failed to process"
    fi
    
    return $failed_count
}

# Generate all formats
generate_all_formats() {
    log "Generating Mermaid diagrams in all formats..."
    
    local formats=("png" "svg" "pdf")
    local total_failures=0
    
    for format in "${formats[@]}"; do
        local output_dir="$RENDERED_DIR/$format"
        mkdir -p "$output_dir"
        
        process_all_mermaid "$format" "$output_dir"
        total_failures=$((total_failures + $?))
    done
    
    if [ $total_failures -eq 0 ]; then
        success "All Mermaid diagrams generated successfully"
    else
        warning "Some diagrams failed to generate (total failures: $total_failures)"
    fi
    
    return $total_failures
}

# Validate Mermaid files
validate_mermaid_files() {
    log "Validating Mermaid source files..."
    
    local validation_errors=0
    
    while IFS= read -r -d '' mmd_file; do
        # Basic syntax validation
        if ! grep -q "^[[:space:]]*graph\|^[[:space:]]*flowchart\|^[[:space:]]*sequenceDiagram\|^[[:space:]]*classDiagram\|^[[:space:]]*stateDiagram\|^[[:space:]]*erDiagram\|^[[:space:]]*journey\|^[[:space:]]*gantt\|^[[:space:]]*pie\|^[[:space:]]*gitGraph" "$mmd_file"; then
            warning "File may not be a valid Mermaid diagram: $(basename "$mmd_file")"
            ((validation_errors++))
        fi
        
        # Check for common syntax issues
        if grep -q "---" "$mmd_file" && ! grep -q "^[[:space:]]*---" "$mmd_file"; then
            warning "Potential YAML frontmatter issue in: $(basename "$mmd_file")"
        fi
    done < <(find "$SOURCE_DIR" -name "*.mmd" -type f -print0)
    
    if [ $validation_errors -eq 0 ]; then
        success "All Mermaid files validated successfully"
    else
        warning "$validation_errors validation warnings found"
    fi
    
    return $validation_errors
}

# Create Mermaid diagram examples
create_examples() {
    log "Creating Mermaid diagram examples..."
    
    local examples_dir="$SOURCE_DIR/examples"
    mkdir -p "$examples_dir"
    
    # Create a simple flowchart example
    cat > "$examples_dir/simple-flowchart.mmd" << 'EOF'
flowchart TD
    A[Start] --> B{Decision}
    B -->|Yes| C[Process A]
    B -->|No| D[Process B]
    C --> E[End]
    D --> E
    
    style A fill:#2ECC71
    style E fill:#E74C3C
    style B fill:#3498DB
EOF

    # Create a sequence diagram example
    cat > "$examples_dir/simple-sequence.mmd" << 'EOF'
sequenceDiagram
    participant A as User
    participant B as System
    participant C as Database
    
    A->>B: Request Data
    B->>C: Query
    C-->>B: Result
    B-->>A: Response
    
    Note over A,C: Child Protection Process
EOF

    # Create a class diagram example
    cat > "$examples_dir/simple-class.mmd" << 'EOF'
classDiagram
    class Child {
        +String id
        +String name
        +Date birthDate
        +String guardianInfo
        +getAge()
        +updateGuardian()
    }
    
    class Case {
        +String caseId
        +String status
        +Date createdDate
        +assignWorker()
        +updateStatus()
    }
    
    Child ||--o{ Case : has
EOF

    success "Created Mermaid diagram examples in $examples_dir"
}

# Clean up generated files
cleanup() {
    log "Cleaning up generated Mermaid files..."
    
    # Remove generated files but keep source
    find "$RENDERED_DIR" -name "*.png" -o -name "*.svg" -o -name "*.pdf" | \
    grep -E "\.(png|svg|pdf)$" | \
    while read -r file; do
        if [[ $(basename "$(dirname "$file")") =~ ^(png|svg|pdf)$ ]]; then
            rm -f "$file"
            log "Removed: $(basename "$file")"
        fi
    done
    
    success "Cleanup completed"
}

# Main function
main() {
    log "Starting Mermaid batch processing..."
    
    local command="$1"
    local format="$2"
    
    case "$command" in
        "generate"|"")
            if [ -n "$format" ]; then
                log "Generating $format format only..."
                process_all_mermaid "$format" "$RENDERED_DIR/$format"
            else
                generate_all_formats
            fi
            ;;
        "validate")
            validate_mermaid_files
            ;;
        "examples")
            create_examples
            ;;
        "cleanup")
            cleanup
            ;;
        "help"|"-h"|"--help")
            echo "Mermaid Batch Processing Script"
            echo "Usage: $0 [COMMAND] [FORMAT]"
            echo ""
            echo "Commands:"
            echo "  generate [format]  Generate diagrams (default: all formats)"
            echo "  validate          Validate Mermaid source files"
            echo "  examples          Create example Mermaid diagrams"
            echo "  cleanup           Remove generated files"
            echo "  help              Show this help message"
            echo ""
            echo "Formats:"
            echo "  png               Generate PNG images"
            echo "  svg               Generate SVG vectors"
            echo "  pdf               Generate PDF documents"
            echo ""
            echo "Examples:"
            echo "  $0                Generate all formats"
            echo "  $0 generate png   Generate PNG only"
            echo "  $0 validate       Validate source files"
            ;;
        *)
            error "Unknown command: $command"
            echo "Use '$0 help' for usage information"
            exit 1
            ;;
    esac
}

# Run main function with all arguments
main "$@"
