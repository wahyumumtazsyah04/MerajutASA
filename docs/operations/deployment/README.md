# Deployment Documentation
## MerajutASA Platform Deployment Guide

> **Mission-Critical Deployment**: Production-grade deployment procedures for a social impact platform protecting vulnerable children, implementing zero-downtime deployments with comprehensive safety measures.

---

## 🎯 Deployment Philosophy

### Child-Safety First Deployment
All deployment procedures prioritize child safety and data protection:

```yaml
Deployment Principles:
  Safety First: No deployment compromises child data security
  Zero Downtime: Children and caregivers always have access
  Rollback Ready: Instant recovery from deployment issues
  Compliance Maintained: All deployments maintain regulatory compliance
  Stakeholder Continuity: Penta-helix stakeholders remain connected
  
Child Protection Guarantees:
  - Child data never exposed during deployments
  - Emergency access always available
  - Audit trails maintained throughout process
  - Compliance validation before going live
  - Child-facing features thoroughly tested
```

### Progressive Delivery Strategy
Following Google's DevOps Research and Assessment (DORA) best practices:

```mermaid
graph TD
    A[Development] --> B[Integration Testing]
    B --> C[Security Validation]
    C --> D[Staging Deployment]
    D --> E[UAT Validation]
    E --> F[Canary Deployment]
    F --> G[Production Rollout]
    G --> H[Post-Deployment Monitoring]
    
    F --> I[Rollback Trigger]
    I --> J[Immediate Rollback]
    
    H --> K[Success Validation]
    K --> L[Full Production]
```

---

## 🚀 Environment Strategy

### 1. Multi-Environment Architecture

#### Development Environment (dev.merajutasa.id)
```yaml
Environment: Development
Purpose: Feature development and initial testing
Domain: dev.merajutasa.id
Infrastructure:
  - Single-node Kubernetes cluster
  - PostgreSQL development instance
  - Redis single instance
  - File storage: Local S3-compatible storage
  
Configuration:
  Database:
    Host: dev-db.merajutasa.id
    Port: 5432
    SSL: Required
    Encryption: AES-256
    
  Security:
    SSL Certificates: Let's Encrypt (dev certificates)
    Authentication: OAuth 2.0 with test providers
    Data Protection: Full encryption (development keys)
    
  Monitoring:
    Logging: Development log aggregation
    Metrics: Basic Prometheus monitoring
    Alerting: Development team notifications
    
  Deployment:
    Method: Direct deployment from develop branch
    Automation: GitHub Actions workflow
    Rollback: Automated on failure
    Data: Synthetic test data only
```

#### Staging Environment (staging.merajutasa.id)
```yaml
Environment: Staging
Purpose: Pre-production validation and stakeholder testing
Domain: staging.merajutasa.id
Infrastructure:
  - Multi-node Kubernetes cluster (3 nodes)
  - PostgreSQL with read replicas
  - Redis cluster (3 nodes)
  - S3-compatible object storage
  
Configuration:
  Database:
    Host: staging-db.merajutasa.id
    Port: 5432
    SSL: Required
    Encryption: AES-256
    Backup: Daily automated backups
    
  Security:
    SSL Certificates: Production-grade certificates
    Authentication: OAuth 2.0 with staging providers
    Data Protection: Production-level encryption
    Penetration Testing: Weekly automated scans
    
  Monitoring:
    Logging: Full ELK stack deployment
    Metrics: Comprehensive Prometheus + Grafana
    Alerting: Stakeholder and development notifications
    Tracing: Jaeger distributed tracing
    
  Deployment:
    Method: Blue-green deployment
    Automation: GitHub Actions with approval gates
    Rollback: One-click rollback capability
    Data: Anonymized production data
```

#### Production Environment (www.merajutasa.id)
```yaml
Environment: Production
Purpose: Live platform serving children and stakeholders
Domain: www.merajutasa.id
Infrastructure:
  - High-availability Kubernetes cluster (5+ nodes)
  - PostgreSQL with high availability and read replicas
  - Redis cluster with sentinel (5 nodes)
  - Multi-region object storage with replication
  
Configuration:
  Database:
    Host: prod-db.merajutasa.id
    Port: 5432
    SSL: Required
    Encryption: AES-256 with HSM key management
    Backup: Continuous backup with point-in-time recovery
    
  Security:
    SSL Certificates: Extended validation certificates
    Authentication: OAuth 2.0 with production identity providers
    Data Protection: FIPS 140-2 Level 2 compliance
    Penetration Testing: Monthly professional assessments
    
  Monitoring:
    Logging: Enterprise ELK with long-term retention
    Metrics: Full observability stack with SLA monitoring
    Alerting: 24/7 incident response integration
    Tracing: Full distributed tracing with performance analysis
    
  Deployment:
    Method: Canary deployment with gradual rollout
    Automation: GitHub Actions with multiple approval gates
    Rollback: Instant rollback with data consistency checks
    Data: Live production data with full protection
```

---

## 🔧 Deployment Methods

### 1. Blue-Green Deployment

#### Overview
Zero-downtime deployment strategy maintaining two identical production environments:

```yaml
Blue-Green Strategy:
  Blue Environment: Current production environment
  Green Environment: New version deployment target
  
  Process Flow:
    1. Deploy new version to Green environment
    2. Run comprehensive testing on Green
    3. Switch load balancer from Blue to Green
    4. Monitor Green environment for issues
    5. Keep Blue as instant rollback option
    
  Benefits:
    - Zero downtime for users
    - Instant rollback capability
    - Full environment testing before switch
    - Reduced deployment risk
    
  Implementation:
    Load Balancer: AWS Application Load Balancer
    Orchestration: Kubernetes with Blue-Green operator
    Database: Shared with migration strategy
    Storage: Shared object storage
    
  Considerations:
    - Database schema compatibility
    - Shared data consistency
    - External service coordination
    - Resource cost (double environment)
```

#### Implementation Steps
```bash
# 1. Prepare Green Environment
kubectl create namespace merajutasa-green

# 2. Deploy application to Green
helm upgrade --install merajutasa-green ./helm/merajutasa \
  --namespace merajutasa-green \
  --values values-production.yaml \
  --set environment=green \
  --set image.tag=${NEW_VERSION}

# 3. Run health checks
kubectl rollout status deployment/web-app -n merajutasa-green
kubectl rollout status deployment/api-gateway -n merajutasa-green

# 4. Run comprehensive tests
./scripts/run-production-tests.sh green

# 5. Switch traffic (gradual)
./scripts/switch-traffic.sh --from blue --to green --percentage 10
sleep 300 # Monitor for 5 minutes
./scripts/switch-traffic.sh --from blue --to green --percentage 50
sleep 600 # Monitor for 10 minutes
./scripts/switch-traffic.sh --from blue --to green --percentage 100

# 6. Verify switch success
./scripts/verify-deployment.sh green

# 7. Clean up Blue environment (after validation period)
kubectl delete namespace merajutasa-blue
```

### 2. Canary Deployment

#### Overview
Progressive rollout strategy exposing new version to limited user percentage:

```yaml
Canary Strategy:
  Traffic Distribution:
    Phase 1: 5% of traffic to new version
    Phase 2: 25% of traffic (if Phase 1 successful)
    Phase 3: 50% of traffic (if Phase 2 successful)
    Phase 4: 100% of traffic (full rollout)
    
  Success Criteria:
    Error Rate: <0.1% increase from baseline
    Response Time: <10% degradation from baseline
    Child Safety Alerts: Zero tolerance
    Stakeholder Feedback: Positive validation
    
  Monitoring Period:
    Phase 1: 30 minutes minimum
    Phase 2: 2 hours minimum
    Phase 3: 24 hours minimum
    Phase 4: 72 hours monitoring
    
  Rollback Triggers:
    - Error rate spike >1%
    - Response time degradation >50%
    - Any child safety incident
    - Database connection failures
    - External service failures
```

#### Implementation Configuration
```yaml
# Istio VirtualService for Canary
apiVersion: networking.istio.io/v1beta1
kind: VirtualService
metadata:
  name: merajutasa-canary
  namespace: merajutasa
spec:
  hosts:
  - www.merajutasa.id
  http:
  - match:
    - headers:
        canary:
          exact: "true"
    route:
    - destination:
        host: merajutasa-web-app
        subset: canary
      weight: 100
  - route:
    - destination:
        host: merajutasa-web-app
        subset: stable
      weight: 95
    - destination:
        host: merajutasa-web-app
        subset: canary
      weight: 5
```

### 3. Rolling Deployment

#### Overview
Gradual replacement strategy for non-critical updates:

```yaml
Rolling Strategy:
  Update Strategy: RollingUpdate
  Max Unavailable: 25%
  Max Surge: 25%
  
  Process:
    1. Create new replica with updated version
    2. Wait for new replica to be ready
    3. Terminate one old replica
    4. Repeat until all replicas updated
    
  Use Cases:
    - Configuration updates
    - Minor bug fixes
    - Non-breaking feature updates
    - Internal tool updates
    
  Monitoring:
    - Pod readiness probes
    - Application health checks
    - Resource utilization
    - User experience metrics
```

---

## 📋 Pre-Deployment Checklist

### 1. Security Validation

#### Child Data Protection Verification
```yaml
Security Checklist:
  ✅ Data Encryption:
    - Verify encryption at rest (AES-256)
    - Confirm encryption in transit (TLS 1.3)
    - Validate key management (HSM integration)
    - Test encrypted backup integrity
    
  ✅ Access Controls:
    - Validate role-based access control (RBAC)
    - Test multi-factor authentication (MFA)
    - Verify session management security
    - Confirm audit logging functionality
    
  ✅ Compliance Validation:
    - GDPR compliance verification
    - UNICEF child protection standards check
    - Data retention policy validation
    - Privacy policy implementation check
    
  ✅ Vulnerability Assessment:
    - Container image security scan
    - Dependency vulnerability check
    - Infrastructure security validation
    - Penetration testing results review
```

### 2. Performance Validation

#### Load Testing Requirements
```yaml
Performance Checklist:
  ✅ Load Testing:
    - Normal load: 1000 concurrent users
    - Peak load: 5000 concurrent users
    - Stress test: 10000 concurrent users
    - Spike test: 2x normal load in 1 minute
    
  ✅ Response Time Requirements:
    - Page load time: <2 seconds
    - API response time: <500ms
    - Database query time: <100ms
    - File upload time: <30 seconds for 10MB
    
  ✅ Resource Utilization:
    - CPU utilization: <70% under normal load
    - Memory utilization: <80% under peak load
    - Network bandwidth: <60% of available capacity
    - Storage I/O: <80% of IOPS capacity
    
  ✅ Scalability Validation:
    - Auto-scaling trigger testing
    - Horizontal scaling validation
    - Database connection pooling
    - Cache hit ratio optimization
```

### 3. Functionality Validation

#### Critical Path Testing
```yaml
Functionality Checklist:
  ✅ Child Management:
    - Child profile creation and encryption
    - Guardian consent workflow
    - Case history tracking
    - Data privacy controls
    
  ✅ Stakeholder Portals:
    - Government dashboard functionality
    - Business partnership features
    - Academic research tools
    - Media communication features
    
  ✅ Core Platform Features:
    - User authentication and authorization
    - Data search and filtering
    - Report generation
    - Notification delivery
    
  ✅ Integration Testing:
    - External API connectivity
    - Payment gateway integration
    - Email service functionality
    - SMS notification service
```

---

## 🏗️ Infrastructure Deployment

### 1. Kubernetes Cluster Setup

#### Production Cluster Configuration
```yaml
# cluster-config.yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: cluster-config
  namespace: kube-system
data:
  cluster-name: "merajutasa-production"
  region: "us-east-1"
  node-groups: |
    - name: system-nodes
      instance-type: t3.large
      min-size: 3
      max-size: 5
      desired-size: 3
      
    - name: application-nodes
      instance-type: m5.xlarge
      min-size: 3
      max-size: 10
      desired-size: 5
      
    - name: memory-optimized-nodes
      instance-type: r5.large
      min-size: 2
      max-size: 5
      desired-size: 2
```

#### Node Group Specifications
```yaml
System Nodes (Control Plane):
  Purpose: Kubernetes system components
  Instance Type: t3.large (2 vCPU, 8GB RAM)
  Storage: 50GB EBS gp3
  Networking: Enhanced networking enabled
  
  Components:
    - kube-dns
    - ingress-nginx
    - cert-manager
    - prometheus-operator
    
Application Nodes (Workloads):
  Purpose: MerajutASA application services
  Instance Type: m5.xlarge (4 vCPU, 16GB RAM)
  Storage: 100GB EBS gp3
  Networking: Enhanced networking enabled
  
  Components:
    - Web applications
    - API services
    - Background workers
    - Caching services
    
Memory-Optimized Nodes (Data):
  Purpose: Database and in-memory services
  Instance Type: r5.large (2 vCPU, 16GB RAM)
  Storage: 200GB EBS gp3
  Networking: 10 Gbps networking
  
  Components:
    - Redis clusters
    - Elasticsearch
    - In-memory databases
    - Data processing services
```

### 2. Database Deployment

#### PostgreSQL High Availability Setup
```yaml
# postgresql-ha.yaml
apiVersion: postgresql.cnpg.io/v1
kind: Cluster
metadata:
  name: merajutasa-postgres
  namespace: database
spec:
  instances: 3
  primaryUpdateStrategy: unsupervised
  
  postgresql:
    parameters:
      max_connections: "200"
      shared_buffers: "256MB"
      effective_cache_size: "1GB"
      maintenance_work_mem: "64MB"
      checkpoint_completion_target: "0.9"
      wal_buffers: "16MB"
      default_statistics_target: "100"
      random_page_cost: "1.1"
      effective_io_concurrency: "200"
      
  bootstrap:
    initdb:
      database: merajutasa
      owner: merajutasa_app
      secret:
        name: postgres-credentials
        
  storage:
    size: 500Gi
    storageClass: fast-ssd
    
  monitoring:
    enabled: true
    
  backup:
    barmanObjectStore:
      destinationPath: "s3://merajutasa-backups/postgres"
      s3Credentials:
        accessKeyId:
          name: backup-credentials
          key: ACCESS_KEY_ID
        secretAccessKey:
          name: backup-credentials
          key: SECRET_ACCESS_KEY
      wal:
        retention: "7d"
      data:
        retention: "30d"
```

#### Database Security Configuration
```sql
-- Child data protection setup
CREATE EXTENSION IF NOT EXISTS pgcrypto;
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Encryption key management
CREATE TABLE encryption_keys (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    key_name VARCHAR(255) UNIQUE NOT NULL,
    encrypted_key BYTEA NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    rotated_at TIMESTAMP,
    status VARCHAR(50) DEFAULT 'active'
);

-- Audit log table for child data access
CREATE TABLE audit_log (
    id BIGSERIAL PRIMARY KEY,
    user_id UUID NOT NULL,
    action VARCHAR(100) NOT NULL,
    resource_type VARCHAR(100) NOT NULL,
    resource_id UUID,
    details JSONB,
    ip_address INET,
    user_agent TEXT,
    created_at TIMESTAMP DEFAULT NOW()
);

-- Row-level security for child data
ALTER TABLE children ENABLE ROW LEVEL SECURITY;

-- Child data access policy
CREATE POLICY child_data_access ON children
    FOR ALL
    TO merajutasa_app
    USING (
        has_child_access_permission(current_user_id(), id)
    );
```

### 3. Application Deployment

#### Helm Chart Structure
```yaml
# Chart.yaml
apiVersion: v2
name: merajutasa
description: MerajutASA Platform Helm Chart
type: application
version: 1.0.0
appVersion: "1.0.0"

dependencies:
  - name: postgresql
    version: 12.1.2
    repository: https://charts.bitnami.com/bitnami
    condition: postgresql.enabled
    
  - name: redis
    version: 17.4.3
    repository: https://charts.bitnami.com/bitnami
    condition: redis.enabled
    
  - name: nginx-ingress
    version: 4.4.0
    repository: https://kubernetes.github.io/ingress-nginx
    condition: ingress.enabled
```

#### Application Deployment Configuration
```yaml
# values-production.yaml
global:
  environment: production
  domain: merajutasa.id
  
image:
  registry: ghcr.io
  repository: merajutasa/platform
  tag: "1.0.0"
  pullPolicy: Always
  
replicas:
  web: 3
  api: 5
  worker: 2
  
resources:
  web:
    requests:
      memory: "512Mi"
      cpu: "250m"
    limits:
      memory: "1Gi"
      cpu: "500m"
      
  api:
    requests:
      memory: "1Gi"
      cpu: "500m"
    limits:
      memory: "2Gi"
      cpu: "1000m"
      
security:
  podSecurityPolicy:
    enabled: true
  networkPolicy:
    enabled: true
  secretManagement:
    provider: "external-secrets"
    
monitoring:
  prometheus:
    enabled: true
  grafana:
    enabled: true
  jaeger:
    enabled: true
    
backup:
  enabled: true
  schedule: "0 2 * * *"
  retention: "30d"
```

---

## 🔄 CI/CD Pipeline

### 1. GitHub Actions Workflow

#### Production Deployment Workflow
```yaml
# .github/workflows/production-deploy.yml
name: Production Deployment

on:
  push:
    branches: [main]
    tags: ['v*']
  workflow_dispatch:
    inputs:
      environment:
        description: 'Deployment environment'
        required: true
        default: 'staging'
        type: choice
        options:
        - staging
        - production

env:
  REGISTRY: ghcr.io
  IMAGE_NAME: merajutasa/platform
  HELM_VERSION: 3.10.0
  KUBECTL_VERSION: 1.25.0

jobs:
  security-scan:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v4
        
      - name: Run Trivy vulnerability scanner
        uses: aquasecurity/trivy-action@master
        with:
          scan-type: 'fs'
          format: 'sarif'
          output: 'trivy-results.sarif'
          
      - name: Upload security scan results
        uses: github/codeql-action/upload-sarif@v2
        with:
          sarif_file: 'trivy-results.sarif'

  build-and-test:
    runs-on: ubuntu-latest
    needs: [security-scan]
    
    services:
      postgres:
        image: postgres:14
        env:
          POSTGRES_PASSWORD: test_password
          POSTGRES_DB: test_db
        options: >-
          --health-cmd pg_isready
          --health-interval 10s
          --health-timeout 5s
          --health-retries 5
          
      redis:
        image: redis:7
        options: >-
          --health-cmd "redis-cli ping"
          --health-interval 10s
          --health-timeout 5s
          --health-retries 5
    
    steps:
      - name: Checkout code
        uses: actions/checkout@v4
        
      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: '18'
          cache: 'npm'
          
      - name: Install dependencies
        run: npm ci
        
      - name: Run type checking
        run: npm run type-check
        
      - name: Run linting
        run: npm run lint
        
      - name: Run unit tests
        run: npm run test:unit
        env:
          DATABASE_URL: postgresql://postgres:test_password@localhost:5432/test_db
          REDIS_URL: redis://localhost:6379
          
      - name: Run integration tests
        run: npm run test:integration
        env:
          DATABASE_URL: postgresql://postgres:test_password@localhost:5432/test_db
          REDIS_URL: redis://localhost:6379
          
      - name: Generate test coverage
        run: npm run test:coverage
        
      - name: Upload coverage to Codecov
        uses: codecov/codecov-action@v3
        with:
          file: ./coverage/lcov.info

  build-images:
    runs-on: ubuntu-latest
    needs: [build-and-test]
    
    outputs:
      image-digest: ${{ steps.build.outputs.digest }}
      image-tag: ${{ steps.meta.outputs.tags }}
    
    steps:
      - name: Checkout code
        uses: actions/checkout@v4
        
      - name: Set up Docker Buildx
        uses: docker/setup-buildx-action@v3
        
      - name: Login to Container Registry
        uses: docker/login-action@v3
        with:
          registry: ${{ env.REGISTRY }}
          username: ${{ github.actor }}
          password: ${{ secrets.GITHUB_TOKEN }}
          
      - name: Extract metadata
        id: meta
        uses: docker/metadata-action@v5
        with:
          images: ${{ env.REGISTRY }}/${{ env.IMAGE_NAME }}
          tags: |
            type=ref,event=branch
            type=ref,event=pr
            type=semver,pattern={{version}}
            type=semver,pattern={{major}}.{{minor}}
            type=sha,prefix={{branch}}-
            
      - name: Build and push Docker image
        id: build
        uses: docker/build-push-action@v5
        with:
          context: .
          platforms: linux/amd64,linux/arm64
          push: true
          tags: ${{ steps.meta.outputs.tags }}
          labels: ${{ steps.meta.outputs.labels }}
          cache-from: type=gha
          cache-to: type=gha,mode=max

  deploy-staging:
    runs-on: ubuntu-latest
    needs: [build-images]
    if: github.ref == 'refs/heads/main' || github.event.inputs.environment == 'staging'
    environment: staging
    
    steps:
      - name: Checkout code
        uses: actions/checkout@v4
        
      - name: Setup Helm
        uses: azure/setup-helm@v3
        with:
          version: ${{ env.HELM_VERSION }}
          
      - name: Setup kubectl
        uses: azure/setup-kubectl@v3
        with:
          version: ${{ env.KUBECTL_VERSION }}
          
      - name: Configure AWS credentials
        uses: aws-actions/configure-aws-credentials@v4
        with:
          aws-access-key-id: ${{ secrets.AWS_ACCESS_KEY_ID }}
          aws-secret-access-key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
          aws-region: us-east-1
          
      - name: Update kubeconfig
        run: |
          aws eks update-kubeconfig --name merajutasa-staging --region us-east-1
          
      - name: Deploy to staging
        run: |
          helm upgrade --install merajutasa ./helm/merajutasa \
            --namespace merajutasa-staging \
            --create-namespace \
            --values ./helm/values-staging.yaml \
            --set image.tag=${{ needs.build-images.outputs.image-tag }} \
            --wait --timeout=300s
            
      - name: Run post-deployment tests
        run: |
          kubectl wait --for=condition=ready pod -l app.kubernetes.io/name=merajutasa \
            -n merajutasa-staging --timeout=300s
          ./scripts/health-check.sh staging.merajutasa.id
          
      - name: Run smoke tests
        run: |
          npm run test:smoke -- --baseUrl=https://staging.merajutasa.id

  deploy-production:
    runs-on: ubuntu-latest
    needs: [build-images, deploy-staging]
    if: startsWith(github.ref, 'refs/tags/v') || github.event.inputs.environment == 'production'
    environment: production
    
    steps:
      - name: Checkout code
        uses: actions/checkout@v4
        
      - name: Setup Helm
        uses: azure/setup-helm@v3
        with:
          version: ${{ env.HELM_VERSION }}
          
      - name: Setup kubectl
        uses: azure/setup-kubectl@v3
        with:
          version: ${{ env.KUBECTL_VERSION }}
          
      - name: Configure AWS credentials
        uses: aws-actions/configure-aws-credentials@v4
        with:
          aws-access-key-id: ${{ secrets.AWS_ACCESS_KEY_ID_PROD }}
          aws-secret-access-key: ${{ secrets.AWS_SECRET_ACCESS_KEY_PROD }}
          aws-region: us-east-1
          
      - name: Update kubeconfig
        run: |
          aws eks update-kubeconfig --name merajutasa-production --region us-east-1
          
      - name: Pre-deployment backup
        run: |
          kubectl create job backup-pre-deploy-$(date +%s) \
            --from=cronjob/database-backup \
            -n merajutasa
            
      - name: Deploy to production (Blue-Green)
        run: |
          # Deploy to Green environment
          helm upgrade --install merajutasa-green ./helm/merajutasa \
            --namespace merajutasa-green \
            --create-namespace \
            --values ./helm/values-production.yaml \
            --set image.tag=${{ needs.build-images.outputs.image-tag }} \
            --set environment=green \
            --wait --timeout=600s
            
      - name: Run production validation tests
        run: |
          kubectl wait --for=condition=ready pod -l app.kubernetes.io/name=merajutasa \
            -n merajutasa-green --timeout=600s
          ./scripts/production-validation.sh green
          
      - name: Switch traffic to Green
        run: |
          ./scripts/blue-green-switch.sh --target green --gradual
          
      - name: Monitor Green deployment
        run: |
          ./scripts/monitor-deployment.sh --environment green --duration 1800
          
      - name: Complete Blue-Green switch
        run: |
          ./scripts/blue-green-complete.sh --new green --old blue
          
      - name: Post-deployment verification
        run: |
          ./scripts/post-deployment-check.sh production
          kubectl get pods -n merajutasa-green
          ./scripts/health-check.sh www.merajutasa.id

  notify-stakeholders:
    runs-on: ubuntu-latest
    needs: [deploy-production]
    if: success()
    
    steps:
      - name: Notify deployment success
        uses: 8398a7/action-slack@v3
        with:
          status: success
          fields: repo,message,commit,author,action,eventName,ref,workflow
          text: "✅ MerajutASA Production Deployment Successful"
        env:
          SLACK_WEBHOOK_URL: ${{ secrets.SLACK_WEBHOOK_URL }}
          
      - name: Update status page
        run: |
          curl -X POST "${{ secrets.STATUS_PAGE_WEBHOOK }}" \
            -H "Content-Type: application/json" \
            -d '{"status": "operational", "message": "Deployment completed successfully"}'
```

### 2. Deployment Scripts

#### Health Check Script
```bash
#!/bin/bash
# scripts/health-check.sh

set -euo pipefail

DOMAIN=${1:-"www.merajutasa.id"}
MAX_RETRIES=30
RETRY_INTERVAL=10

echo "🏥 Starting health check for $DOMAIN"

# Function to check endpoint health
check_endpoint() {
    local endpoint=$1
    local expected_status=${2:-200}
    
    echo "Checking $endpoint (expecting $expected_status)"
    
    response=$(curl -s -o /dev/null -w "%{http_code}" "$endpoint" || echo "000")
    
    if [[ "$response" == "$expected_status" ]]; then
        echo "✅ $endpoint is healthy (status: $response)"
        return 0
    else
        echo "❌ $endpoint is unhealthy (status: $response)"
        return 1
    fi
}

# Critical endpoints to check
ENDPOINTS=(
    "https://$DOMAIN/health"
    "https://$DOMAIN/api/health"
    "https://$DOMAIN/api/v1/health"
    "https://$DOMAIN"
)

echo "🔍 Checking critical endpoints..."

for retry in $(seq 1 $MAX_RETRIES); do
    echo "Attempt $retry/$MAX_RETRIES"
    
    all_healthy=true
    
    for endpoint in "${ENDPOINTS[@]}"; do
        if ! check_endpoint "$endpoint"; then
            all_healthy=false
            break
        fi
    done
    
    if $all_healthy; then
        echo "🎉 All endpoints are healthy!"
        exit 0
    fi
    
    if [[ $retry -lt $MAX_RETRIES ]]; then
        echo "⏳ Waiting $RETRY_INTERVAL seconds before retry..."
        sleep $RETRY_INTERVAL
    fi
done

echo "💥 Health check failed after $MAX_RETRIES attempts"
exit 1
```

#### Blue-Green Switch Script
```bash
#!/bin/bash
# scripts/blue-green-switch.sh

set -euo pipefail

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --target)
            TARGET_ENV="$2"
            shift 2
            ;;
        --gradual)
            GRADUAL_SWITCH=true
            shift
            ;;
        --immediate)
            GRADUAL_SWITCH=false
            shift
            ;;
        *)
            echo "Unknown option: $1"
            exit 1
            ;;
    esac
done

TARGET_ENV=${TARGET_ENV:-"green"}
GRADUAL_SWITCH=${GRADUAL_SWITCH:-true}

echo "🔄 Starting Blue-Green deployment switch to $TARGET_ENV"

if [[ "$TARGET_ENV" == "green" ]]; then
    OLD_ENV="blue"
    NEW_ENV="green"
else
    OLD_ENV="green"
    NEW_ENV="blue"
fi

# Function to update traffic distribution
update_traffic() {
    local new_weight=$1
    local old_weight=$((100 - new_weight))
    
    echo "📊 Updating traffic: $NEW_ENV=$new_weight%, $OLD_ENV=$old_weight%"
    
    # Update Istio VirtualService
    kubectl patch virtualservice merajutasa-vs -n merajutasa --type='merge' -p="
    spec:
      http:
      - route:
        - destination:
            host: merajutasa-$NEW_ENV
          weight: $new_weight
        - destination:
            host: merajutasa-$OLD_ENV
          weight: $old_weight
    "
    
    # Wait for configuration to propagate
    sleep 30
    
    # Verify traffic distribution
    ./scripts/verify-traffic.sh --new-env "$NEW_ENV" --expected-weight "$new_weight"
}

# Function to monitor metrics during switch
monitor_metrics() {
    local duration=${1:-300}
    
    echo "📈 Monitoring metrics for $duration seconds..."
    
    # Monitor error rate
    error_rate=$(kubectl exec -n monitoring deployment/prometheus -- \
        promtool query instant 'rate(http_requests_total{status=~"5.."}[5m]) / rate(http_requests_total[5m])' | \
        grep -o '[0-9.]\+' | head -1)
    
    # Monitor response time
    response_time=$(kubectl exec -n monitoring deployment/prometheus -- \
        promtool query instant 'histogram_quantile(0.95, rate(http_request_duration_seconds_bucket[5m]))' | \
        grep -o '[0-9.]\+' | head -1)
    
    echo "Current error rate: ${error_rate:-0}%"
    echo "95th percentile response time: ${response_time:-0}s"
    
    # Check if metrics are within acceptable thresholds
    if (( $(echo "$error_rate > 0.01" | bc -l) )); then
        echo "❌ Error rate too high: $error_rate%"
        return 1
    fi
    
    if (( $(echo "$response_time > 2.0" | bc -l) )); then
        echo "❌ Response time too high: ${response_time}s"
        return 1
    fi
    
    echo "✅ Metrics within acceptable thresholds"
    return 0
}

# Function to rollback on failure
rollback() {
    echo "🔙 Rolling back to $OLD_ENV..."
    update_traffic 0
    echo "💥 Rollback completed"
    exit 1
}

# Set up rollback on failure
trap rollback ERR

echo "🚀 Starting traffic switch to $NEW_ENV environment"

if [[ "$GRADUAL_SWITCH" == "true" ]]; then
    # Gradual traffic switching
    traffic_stages=(5 10 25 50 75 100)
    
    for weight in "${traffic_stages[@]}"; do
        echo "📈 Switching $weight% traffic to $NEW_ENV..."
        update_traffic "$weight"
        
        # Monitor for issues
        if ! monitor_metrics 300; then
            echo "❌ Issues detected at $weight% traffic, rolling back..."
            rollback
        fi
        
        echo "✅ $weight% traffic switch successful"
        
        # Progressive wait times (longer waits for higher traffic percentages)
        if [[ "$weight" -lt 100 ]]; then
            wait_time=$((weight * 6))  # 30s for 5%, 300s for 50%, etc.
            echo "⏳ Waiting $wait_time seconds before next stage..."
            sleep "$wait_time"
        fi
    done
else
    # Immediate switch
    echo "⚡ Performing immediate traffic switch to $NEW_ENV..."
    update_traffic 100
    
    # Monitor for issues
    if ! monitor_metrics 600; then
        echo "❌ Issues detected after immediate switch, rolling back..."
        rollback
    fi
fi

echo "🎉 Traffic switch to $NEW_ENV completed successfully!"

# Final verification
echo "🔍 Running final verification..."
./scripts/health-check.sh www.merajutasa.id

echo "✅ Blue-Green deployment switch completed successfully!"
```

---

## 📊 Monitoring and Alerting

### 1. Deployment Monitoring

#### Key Metrics to Monitor
```yaml
Deployment Metrics:
  Application Metrics:
    - HTTP request rate and latency
    - Error rate and status codes
    - Database connection pool usage
    - Memory and CPU utilization
    
  Infrastructure Metrics:
    - Kubernetes pod status and readiness
    - Node resource utilization
    - Network connectivity and throughput
    - Storage usage and I/O performance
    
  Business Metrics:
    - Child data access patterns
    - Stakeholder portal usage
    - Feature adoption rates
    - User satisfaction scores
    
  Security Metrics:
    - Authentication failure rates
    - Authorization violations
    - Data access audit events
    - Security scan results
```

#### Grafana Dashboard Configuration
```json
{
  "dashboard": {
    "title": "MerajutASA Deployment Monitoring",
    "panels": [
      {
        "title": "Deployment Status",
        "type": "stat",
        "targets": [
          {
            "expr": "up{job=\"kubernetes-pods\",app=\"merajutasa\"}",
            "legendFormat": "Pod Availability"
          }
        ]
      },
      {
        "title": "HTTP Request Rate",
        "type": "graph",
        "targets": [
          {
            "expr": "rate(http_requests_total{app=\"merajutasa\"}[5m])",
            "legendFormat": "Requests/sec"
          }
        ]
      },
      {
        "title": "Error Rate",
        "type": "graph",
        "targets": [
          {
            "expr": "rate(http_requests_total{app=\"merajutasa\",status=~\"5..\"}[5m]) / rate(http_requests_total{app=\"merajutasa\"}[5m])",
            "legendFormat": "Error Rate %"
          }
        ]
      },
      {
        "title": "Response Time",
        "type": "graph",
        "targets": [
          {
            "expr": "histogram_quantile(0.95, rate(http_request_duration_seconds_bucket{app=\"merajutasa\"}[5m]))",
            "legendFormat": "95th Percentile"
          }
        ]
      }
    ]
  }
}
```

### 2. Alerting Configuration

#### Critical Alerts
```yaml
# prometheus-alerts.yaml
groups:
  - name: merajutasa-deployment
    rules:
      - alert: DeploymentFailed
        expr: kube_deployment_status_replicas_available / kube_deployment_spec_replicas < 0.8
        for: 5m
        labels:
          severity: critical
          component: deployment
        annotations:
          summary: "MerajutASA deployment has failed"
          description: "Less than 80% of pods are available for {{ $labels.deployment }}"
          
      - alert: HighErrorRate
        expr: rate(http_requests_total{status=~"5.."}[5m]) / rate(http_requests_total[5m]) > 0.01
        for: 2m
        labels:
          severity: critical
          component: application
        annotations:
          summary: "High error rate detected"
          description: "Error rate is {{ $value | humanizePercentage }} for the last 5 minutes"
          
      - alert: DatabaseConnectionFailure
        expr: up{job="postgres-exporter"} == 0
        for: 1m
        labels:
          severity: critical
          component: database
        annotations:
          summary: "Database connection failure"
          description: "Cannot connect to PostgreSQL database"
          
      - alert: ChildDataAccessAnomaly
        expr: increase(child_data_access_total[1h]) > 1000
        for: 0m
        labels:
          severity: warning
          component: security
        annotations:
          summary: "Unusual child data access pattern detected"
          description: "Unusual spike in child data access: {{ $value }} accesses in the last hour"
```

---

## 🔙 Rollback Procedures

### 1. Automatic Rollback

#### Rollback Triggers
```yaml
Automatic Rollback Conditions:
  Performance Degradation:
    - Error rate > 1% for 5 minutes
    - Response time > 5 seconds for 5 minutes
    - Database connectivity < 90% for 2 minutes
    
  Security Incidents:
    - Authentication failure rate spike
    - Unauthorized data access attempts
    - Security scan vulnerability detection
    
  Functionality Issues:
    - Critical API endpoint failures
    - Child data encryption errors
    - Stakeholder portal unavailability
    
  Infrastructure Problems:
    - Pod crash loop detected
    - Resource exhaustion alerts
    - Network connectivity issues
```

#### Rollback Implementation
```bash
#!/bin/bash
# scripts/automatic-rollback.sh

set -euo pipefail

NAMESPACE=${1:-"merajutasa"}
PREVIOUS_VERSION=${2:-""}

echo "🔙 Starting automatic rollback for namespace: $NAMESPACE"

# Get current and previous revisions
if [[ -z "$PREVIOUS_VERSION" ]]; then
    PREVIOUS_VERSION=$(helm history $NAMESPACE -n $NAMESPACE -o json | \
        jq -r '.[1].revision // "1"')
fi

echo "📋 Rolling back to revision: $PREVIOUS_VERSION"

# Perform rollback
helm rollback $NAMESPACE $PREVIOUS_VERSION -n $NAMESPACE --wait --timeout=300s

# Verify rollback success
echo "✅ Verifying rollback..."
kubectl rollout status deployment -n $NAMESPACE --timeout=300s

# Run health checks
./scripts/health-check.sh www.merajutasa.id

# Notify stakeholders
curl -X POST "$SLACK_WEBHOOK_URL" \
    -H "Content-Type: application/json" \
    -d "{
        \"text\": \"🔙 Automatic rollback completed for MerajutASA platform\",
        \"attachments\": [{
            \"color\": \"warning\",
            \"fields\": [{
                \"title\": \"Namespace\",
                \"value\": \"$NAMESPACE\",
                \"short\": true
            }, {
                \"title\": \"Rolled back to\",
                \"value\": \"Revision $PREVIOUS_VERSION\",
                \"short\": true
            }]
        }]
    }"

echo "✅ Automatic rollback completed successfully"
```

### 2. Manual Rollback

#### Emergency Rollback Procedure
```bash
# Emergency rollback commands

# 1. Quick rollback using Helm
helm rollback merajutasa -n merajutasa

# 2. Immediate traffic switch in Blue-Green
./scripts/blue-green-switch.sh --target blue --immediate

# 3. Database rollback (if needed)
kubectl exec -n database postgres-0 -- \
    psql -U postgres -d merajutasa -c \
    "SELECT pg_restore_point('emergency_rollback_$(date +%s)');"

# 4. Force pod restart
kubectl rollout restart deployment -n merajutasa

# 5. Verify system health
./scripts/health-check.sh www.merajutasa.id
```

---

## 📈 Post-Deployment Validation

### 1. Validation Checklist

#### Comprehensive Post-Deployment Tests
```yaml
Post-Deployment Validation:
  ✅ Application Health:
    - All pods running and ready
    - Health endpoints responding
    - Database connectivity verified
    - External service integrations working
    
  ✅ Performance Validation:
    - Response times within SLA
    - Throughput meets requirements
    - Resource utilization normal
    - Cache hit rates optimized
    
  ✅ Security Verification:
    - SSL certificates valid
    - Authentication systems functional
    - Data encryption validated
    - Audit logging active
    
  ✅ Functionality Testing:
    - Critical user journeys working
    - Data integrity maintained
    - Feature flags configured
    - Stakeholder portals accessible
    
  ✅ Compliance Validation:
    - GDPR compliance maintained
    - Child protection measures active
    - Data retention policies enforced
    - Audit trails complete
```

### 2. Success Metrics

#### Deployment Success Criteria
```yaml
Success Metrics:
  Technical Metrics:
    - Zero data loss during deployment
    - <5 minutes total downtime (if any)
    - Error rate <0.1% within 1 hour
    - Response time <2 seconds average
    
  Business Metrics:
    - All stakeholder portals accessible
    - Child data protection maintained
    - User sessions preserved
    - Feature availability >99.9%
    
  Operational Metrics:
    - Monitoring and alerting functional
    - Backup systems operational
    - Security scans passing
    - Documentation updated
```

---

## 📞 Support and Escalation

### 1. Deployment Support Team

#### Contact Information
```yaml
Support Contacts:
  Primary On-Call Engineer:
    - Phone: +1-XXX-XXX-XXXX
    - Slack: @oncall-engineer
    - Email: oncall@merajutasa.id
    
  Infrastructure Team:
    - Slack: #infrastructure-team
    - Email: infrastructure@merajutasa.id
    - Escalation: +1-XXX-XXX-XXXX
    
  Security Team:
    - Phone: +1-XXX-XXX-XXXX (24/7)
    - Email: security@merajutasa.id
    - Incident: security-incident@merajutasa.id
    
  Child Safety Officer:
    - Phone: +1-XXX-XXX-XXXX (24/7)
    - Email: safety@merajutasa.id
    - Emergency: child-emergency@merajutasa.id
```

### 2. Escalation Procedures

#### Incident Response
```yaml
Escalation Levels:
  Level 1 - Development Team (0-15 minutes):
    - Initial response and assessment
    - Basic troubleshooting and fixes
    - Documentation of issues
    
  Level 2 - Infrastructure Team (15-30 minutes):
    - Infrastructure-related issues
    - Database and networking problems
    - Rollback decision and execution
    
  Level 3 - Security Team (immediate):
    - Security incidents or breaches
    - Child data protection issues
    - Compliance violations
    
  Level 4 - Executive Team (30+ minutes):
    - Platform-wide outages
    - Data loss incidents
    - Legal or regulatory issues
```

---

## 📚 Additional Resources

### 1. Documentation Links
- **[Infrastructure Documentation](../infrastructure/README.md)** - Complete infrastructure setup
- **[Security Guidelines](../../SECURITY.md)** - Security policies and procedures
- **[Monitoring Guide](../operations/monitoring/README.md)** - Monitoring and alerting setup
- **[API Documentation](../api/README.md)** - API deployment considerations

### 2. External Resources
- **[Kubernetes Deployment Strategies](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/)** - Official documentation
- **[Helm Best Practices](https://helm.sh/docs/chart_best_practices/)** - Chart development guidelines
- **[GitOps Principles](https://www.gitops.tech/)** - GitOps implementation guidance
- **[DORA Metrics](https://cloud.google.com/blog/products/devops-sre/using-the-four-keys-to-measure-your-devops-performance)** - DevOps performance measurement

### 3. Tools and Scripts
- **Deployment Scripts**: Available in `/scripts/deployment/`
- **Health Check Tools**: Available in `/scripts/monitoring/`
- **Rollback Utilities**: Available in `/scripts/rollback/`
- **Validation Scripts**: Available in `/scripts/validation/`

---

## 🏆 Deployment Excellence

### 1. Continuous Improvement

#### Deployment Metrics Tracking
```yaml
Metrics Collection:
  DORA Metrics:
    - Deployment frequency: Target daily deployments
    - Lead time for changes: <24 hours
    - Mean time to recovery: <1 hour
    - Change failure rate: <5%
    
  Custom Metrics:
    - Child data protection incidents: Zero tolerance
    - Stakeholder satisfaction: >95%
    - Compliance audit pass rate: 100%
    - Security scan pass rate: 100%
```

### 2. Best Practices Summary

#### Deployment Excellence Principles
```yaml
Excellence Principles:
  Child Safety First:
    - Every deployment protects child welfare
    - Zero compromise on data protection
    - Emergency access always available
    
  Stakeholder Focus:
    - Minimal disruption to users
    - Clear communication during deployments
    - Quick issue resolution
    
  Technical Excellence:
    - Automated testing and validation
    - Infrastructure as code
    - Comprehensive monitoring
    - Proactive issue detection
    
  Continuous Learning:
    - Post-deployment reviews
    - Process improvement
    - Knowledge sharing
    - Documentation updates
```

---

> **Deployment Commitment**: Every deployment of the MerajutASA platform prioritizes child safety, stakeholder continuity, and technical excellence. Our progressive delivery approach ensures that we can quickly respond to issues while maintaining the highest standards of security and compliance for vulnerable populations.

---

*This deployment documentation ensures that the MerajutASA platform can be reliably deployed, monitored, and maintained while protecting the children and families it serves.*
