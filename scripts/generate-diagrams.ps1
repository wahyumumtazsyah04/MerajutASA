# MerajutASA Platform - Diagram Generation Script (PowerShell)
# This script automates the generation of all architecture diagrams
# Supports PlantUML and Mermaid diagram formats with multiple output formats

param(
    [switch]$Regenerate,
    [string]$Format,
    [switch]$Stop,
    [switch]$Help
)

# Configuration
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$ProjectRoot = Split-Path -Parent $ScriptDir
$DiagramsDir = Join-Path $ProjectRoot "docs\architecture\diagrams"
$SourceDir = Join-Path $DiagramsDir "source"
$RenderedDir = Join-Path $DiagramsDir "rendered"
$ToolsDir = Join-Path $DiagramsDir "tools"

# Colors for output
function Write-ColorOutput {
    param(
        [string]$Message,
        [string]$Color = "White"
    )
    
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    
    switch ($Color) {
        "Red" { Write-Host "[$timestamp] $Message" -ForegroundColor Red }
        "Green" { Write-Host "[$timestamp] $Message" -ForegroundColor Green }
        "Yellow" { Write-Host "[$timestamp] $Message" -ForegroundColor Yellow }
        "Blue" { Write-Host "[$timestamp] $Message" -ForegroundColor Blue }
        default { Write-Host "[$timestamp] $Message" -ForegroundColor White }
    }
}

function Write-Log { param([string]$Message) Write-ColorOutput $Message "Blue" }
function Write-Error { param([string]$Message) Write-ColorOutput "ERROR: $Message" "Red" }
function Write-Success { param([string]$Message) Write-ColorOutput "SUCCESS: $Message" "Green" }
function Write-Warning { param([string]$Message) Write-ColorOutput "WARNING: $Message" "Yellow" }

# Show help
if ($Help) {
    Write-Host "MerajutASA Diagram Generation Script"
    Write-Host "Usage: .\generate-diagrams.ps1 [OPTIONS]"
    Write-Host ""
    Write-Host "Options:"
    Write-Host "  -Regenerate          Force regeneration of all diagrams"
    Write-Host "  -Format <format>     Generate only specified format (png, svg, pdf, eps)"
    Write-Host "  -Stop                Stop all diagram services"
    Write-Host "  -Help                Show this help message"
    Write-Host ""
    Write-Host "Examples:"
    Write-Host "  .\generate-diagrams.ps1                    # Generate all diagrams"
    Write-Host "  .\generate-diagrams.ps1 -Format png        # Generate PNG only"
    Write-Host "  .\generate-diagrams.ps1 -Regenerate        # Force regeneration"
    Write-Host "  .\generate-diagrams.ps1 -Stop              # Stop services"
    exit 0
}

# Check if Docker is available
function Test-Docker {
    Write-Log "Checking Docker availability..."
    
    try {
        $dockerVersion = docker --version 2>$null
        if ($LASTEXITCODE -ne 0) {
            throw "Docker command failed"
        }
        
        $dockerInfo = docker info 2>$null
        if ($LASTEXITCODE -ne 0) {
            throw "Docker daemon not running"
        }
        
        Write-Success "Docker is available and running"
        return $true
    }
    catch {
        Write-Error "Docker is not installed or not running"
        return $false
    }
}

# Create directory structure
function Initialize-Directories {
    Write-Log "Setting up directory structure..."
    
    # Create rendered directories
    $directories = @(
        "$RenderedDir",
        "$RenderedDir\png",
        "$RenderedDir\svg", 
        "$RenderedDir\pdf",
        "$RenderedDir\eps",
        "$RenderedDir\sequence-diagrams",
        "$RenderedDir\deployment-diagrams",
        "$RenderedDir\stakeholder-diagrams"
    )
    
    # Create subdirectories for each format
    $formats = @("png", "svg", "pdf", "eps")
    $categories = @("sequence-diagrams", "deployment-diagrams", "stakeholder-diagrams")
    
    foreach ($format in $formats) {
        foreach ($category in $categories) {
            $directories += "$RenderedDir\$format\$category"
        }
    }
    
    foreach ($dir in $directories) {
        if (!(Test-Path $dir)) {
            New-Item -ItemType Directory -Path $dir -Force | Out-Null
        }
    }
    
    Write-Success "Directory structure created"
}

# Start Docker services
function Start-Services {
    Write-Log "Starting diagram generation services..."
    
    Push-Location $ToolsDir
    
    try {
        # Start PlantUML services
        if (Test-Path "plantuml-docker.yml") {
            Write-Log "Starting PlantUML services..."
            docker-compose -f plantuml-docker.yml up -d
            if ($LASTEXITCODE -eq 0) {
                Start-Sleep -Seconds 5
            }
        }
        
        # Start Mermaid services
        if (Test-Path "mermaid-cli.yml") {
            Write-Log "Starting Mermaid services..."
            docker-compose -f mermaid-cli.yml up -d
            if ($LASTEXITCODE -eq 0) {
                Start-Sleep -Seconds 5
            }
        }
        
        Write-Success "Services started"
    }
    finally {
        Pop-Location
    }
}

# Stop Docker services
function Stop-Services {
    Write-Log "Stopping diagram generation services..."
    
    Push-Location $ToolsDir
    
    try {
        # Stop all services
        if (Test-Path "plantuml-docker.yml") {
            docker-compose -f plantuml-docker.yml down
        }
        
        if (Test-Path "mermaid-cli.yml") {
            docker-compose -f mermaid-cli.yml down
        }
        
        Write-Success "Services stopped"
    }
    finally {
        Pop-Location
    }
}

# Generate PlantUML diagrams
function Invoke-PlantUMLGeneration {
    param(
        [string]$SourcePath,
        [string]$OutputFormat,
        [string]$OutputPath
    )
    
    Write-Log "Generating PlantUML diagrams from $SourcePath in $OutputFormat format..."
    
    # Find all .puml files
    $pumlFiles = Get-ChildItem -Path $SourcePath -Filter "*.puml" -Recurse
    
    foreach ($pumlFile in $pumlFiles) {
        $filename = [System.IO.Path]::GetFileNameWithoutExtension($pumlFile.Name)
        $relativePath = $pumlFile.DirectoryName.Replace($SourceDir, "").TrimStart("\")
        $outputSubdir = Join-Path $OutputPath $relativePath
        
        if (!(Test-Path $outputSubdir)) {
            New-Item -ItemType Directory -Path $outputSubdir -Force | Out-Null
        }
        
        Write-Log "Processing: $filename"
        
        # Convert Windows paths to Unix-style for Docker
        $dockerSourcePath = "/app/source/$($relativePath.Replace('\', '/'))/$($filename).puml"
        $dockerOutputPath = "/app/rendered/$OutputFormat/$($relativePath.Replace('\', '/'))"
        
        try {
            # Generate using PlantUML CLI container
            $result = docker exec merajutasa-plantuml-cli java -jar /opt/plantuml.jar -t$OutputFormat -o $dockerOutputPath $dockerSourcePath 2>$null
            
            if ($LASTEXITCODE -eq 0) {
                Write-Success "Generated: $filename.$OutputFormat"
            } else {
                Write-Error "Failed to generate $filename.$OutputFormat"
            }
        }
        catch {
            Write-Error "Failed to generate $filename.$OutputFormat - $_"
        }
    }
}

# Generate all PlantUML formats
function Invoke-AllPlantUMLGeneration {
    Write-Log "Generating all PlantUML diagrams..."
    
    # Check if PlantUML container is running
    $containerStatus = docker ps --filter "name=merajutasa-plantuml-cli" --format "{{.Names}}" 2>$null
    
    if (-not $containerStatus) {
        Write-Error "PlantUML CLI container is not running"
        return
    }
    
    # Generate in different formats
    $formats = @("png", "svg", "pdf", "eps")
    
    foreach ($format in $formats) {
        if (-not $Format -or $Format -eq $format) {
            Invoke-PlantUMLGeneration -SourcePath $SourceDir -OutputFormat $format -OutputPath "$RenderedDir\$format"
        }
    }
    
    Write-Success "All PlantUML diagrams generated"
}

# Validate generated diagrams
function Test-GeneratedDiagrams {
    Write-Log "Validating generated diagrams..."
    
    $errorCount = 0
    
    # Check PNG files
    $pngFiles = Get-ChildItem -Path "$RenderedDir\png" -Filter "*.png" -Recurse
    foreach ($pngFile in $pngFiles) {
        if ($pngFile.Length -eq 0) {
            Write-Error "Empty PNG file: $($pngFile.FullName)"
            $errorCount++
        }
    }
    
    # Check SVG files
    $svgFiles = Get-ChildItem -Path "$RenderedDir\svg" -Filter "*.svg" -Recurse
    foreach ($svgFile in $svgFiles) {
        if ($svgFile.Length -eq 0) {
            Write-Error "Empty SVG file: $($svgFile.FullName)"
            $errorCount++
        }
    }
    
    if ($errorCount -eq 0) {
        Write-Success "All generated diagrams are valid"
    } else {
        Write-Warning "$errorCount validation errors found"
    }
}

# Generate diagram index
function New-DiagramIndex {
    Write-Log "Generating diagram index..."
    
    $indexFile = Join-Path $RenderedDir "README.md"
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    
    $indexContent = @"
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

"@

    # Add sequence diagrams
    $sequencePngs = Get-ChildItem -Path "$RenderedDir\png\sequence-diagrams" -Filter "*.png" -ErrorAction SilentlyContinue | Sort-Object Name
    foreach ($file in $sequencePngs) {
        $filename = [System.IO.Path]::GetFileNameWithoutExtension($file.Name)
        $title = (Get-Culture).TextInfo.ToTitleCase($filename.Replace('-', ' '))
        $indexContent += "`n- [$title](png/sequence-diagrams/$($file.Name))"
    }
    
    $indexContent += @"

### Deployment Diagrams
Infrastructure and deployment architecture visualization:

"@

    # Add deployment diagrams
    $deploymentPngs = Get-ChildItem -Path "$RenderedDir\png\deployment-diagrams" -Filter "*.png" -ErrorAction SilentlyContinue | Sort-Object Name
    foreach ($file in $deploymentPngs) {
        $filename = [System.IO.Path]::GetFileNameWithoutExtension($file.Name)
        $title = (Get-Culture).TextInfo.ToTitleCase($filename.Replace('-', ' '))
        $indexContent += "`n- [$title](png/deployment-diagrams/$($file.Name))"
    }
    
    $indexContent += @"

### Stakeholder Diagrams
Penta-helix stakeholder interaction and governance modeling:

"@

    # Add stakeholder diagrams
    $stakeholderPngs = Get-ChildItem -Path "$RenderedDir\png\stakeholder-diagrams" -Filter "*.png" -ErrorAction SilentlyContinue | Sort-Object Name
    foreach ($file in $stakeholderPngs) {
        $filename = [System.IO.Path]::GetFileNameWithoutExtension($file.Name)
        $title = (Get-Culture).TextInfo.ToTitleCase($filename.Replace('-', ' '))
        $indexContent += "`n- [$title](png/stakeholder-diagrams/$($file.Name))"
    }
    
    $indexContent += @"

## Usage Instructions

### Viewing Diagrams
- Open PNG files for quick viewing
- Use SVG files for web integration
- Use PDF files for printing and formal documentation

### Updating Diagrams
To regenerate diagrams after source changes:
``````powershell
.\scripts\generate-diagrams.ps1 -Regenerate
``````

### Custom Generation
To generate specific formats only:
``````powershell
.\scripts\generate-diagrams.ps1 -Format png
.\scripts\generate-diagrams.ps1 -Format svg
``````

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

*Generated on: $timestamp*
*Platform: MerajutASA - Indonesian Child Welfare Platform*
*Domain: merajutasa.id*
"@

    Set-Content -Path $indexFile -Value $indexContent -Encoding UTF8
    Write-Success "Diagram index generated: $indexFile"
}

# Main execution
function Invoke-Main {
    Write-Log "Starting MerajutASA diagram generation process..."
    
    # Handle stop request
    if ($Stop) {
        Stop-Services
        return
    }
    
    # Setup
    if (-not (Test-Docker)) {
        return
    }
    
    Initialize-Directories
    Start-Services
    
    # Wait for services to be ready
    Write-Log "Waiting for services to be ready..."
    Start-Sleep -Seconds 10
    
    # Generate diagrams
    if ($Format) {
        Write-Log "Generating diagrams in $Format format only..."
        Invoke-PlantUMLGeneration -SourcePath $SourceDir -OutputFormat $Format -OutputPath "$RenderedDir\$Format"
    } else {
        Invoke-AllPlantUMLGeneration
    }
    
    # Generate Mermaid diagrams if they exist
    $mermaidFiles = Get-ChildItem -Path $SourceDir -Filter "*.mmd" -Recurse
    if ($mermaidFiles.Count -gt 0) {
        Write-Log "Found Mermaid diagrams, generating..."
        # Note: Mermaid generation would be implemented similarly to PlantUML
        Write-Warning "Mermaid generation not yet implemented in PowerShell version"
    }
    
    # Post-processing
    Test-GeneratedDiagrams
    New-DiagramIndex
    
    # Cleanup
    if (-not $Regenerate) {
        Stop-Services
    } else {
        Write-Log "Keeping services running for potential regeneration..."
    }
    
    Write-Success "Diagram generation completed successfully!"
    Write-Log "Generated diagrams are available in: $RenderedDir"
    Write-Log "View the index at: $RenderedDir\README.md"
}

# Execute main function
Invoke-Main
