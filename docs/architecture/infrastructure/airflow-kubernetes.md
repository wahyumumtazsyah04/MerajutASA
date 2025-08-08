# Apache Airflow on Kubernetes Deployment Guide
## Data Pipeline Orchestration for Child Welfare Analytics

> **Mission**: Deploy and operate Apache Airflow on Amazon EKS to enable secure, scalable, and reliable data pipeline orchestration for child welfare analytics while maintaining the highest standards of child data protection, stakeholder privacy, and operational excellence.

---

## 🎯 Airflow Kubernetes Architecture Overview

### Child-Centered Data Pipeline Platform
Airflow deployment optimized for sensitive child welfare data processing and multi-stakeholder analytics:

```yaml
Deployment Principles:
  Child Safety First: All pipelines protect vulnerable children's data
  Privacy by Design: Default privacy controls in every workflow
  Stakeholder Focused: Analytics serving penta-helix collaboration
  
Security Integration:
  Zero Trust: Every pipeline execution verified and encrypted
  Audit Complete: Full traceability of child data processing
  Compliance First: Indonesian data sovereignty maintained
```

### Comprehensive Airflow on EKS Architecture

```mermaid
graph TB
    subgraph "🌐 External Access & Integration"
        A[🏛️ Government Systems]
        B[🏢 Business Partners]
        C[🎓 Academic Research]
        D[👥 Community Platforms]
        E[📰 Media Analytics]
    end
    
    subgraph "🔒 AWS Application Load Balancer"
        F[⚖️ ALB with WAF]
        G[🛡️ SSL/TLS Termination]
        H[🚨 DDoS Protection]
    end
    
    subgraph "🏗️ Amazon EKS Cluster"
        subgraph "📊 Airflow Control Plane"
            I[🧠 Airflow Scheduler]
            J[🌐 Airflow Webserver]
            K[📝 Airflow Triggerer]
        end
        
        subgraph "⚡ Airflow Workers"
            L[👷 Celery Workers]
            M[🔄 KubernetesExecutor Pods]
            N[🛡️ Child Data Processing Pods]
        end
        
        subgraph "🔗 Supporting Services"
            O[📨 Redis Message Broker]
            P[🗄️ PostgreSQL Metadata DB]
            Q[📊 Flower Monitoring]
        end
    end
    
    subgraph "🔐 Security & Secrets"
        R[🔑 AWS KMS]
        S[🏰 AWS Secrets Manager]
        T[🛡️ IAM Service Accounts]
        U[📋 Pod Security Standards]
    end
    
    subgraph "💾 Storage & Data"
        V[📁 Amazon EFS (DAGs)]
        W[🗃️ Amazon S3 (Logs/Data)]
        X[❄️ S3 Glacier (Archives)]
        Y[🔍 Amazon OpenSearch (Logs)]
    end
    
    subgraph "📈 Monitoring & Observability"
        Z[📊 CloudWatch Metrics]
        AA[🚨 AlertManager]
        BB[📱 SNS Notifications]
        CC[📋 Grafana Dashboards]
    end
    
    A --> F
    B --> F
    C --> F
    D --> F
    E --> F
    
    F --> I
    F --> J
    G --> K
    
    I --> L
    I --> M
    J --> N
    K --> O
    
    L --> P
    M --> P
    N --> Q
    
    R --> S
    S --> T
    T --> U
    
    I --> V
    J --> W
    K --> X
    L --> Y
    
    M --> Z
    N --> AA
    O --> BB
    P --> CC
    
    style A fill:#e8f5e8
    style I fill:#f3e5f5
    style R fill:#fff3e0
    style V fill:#ffebee
```

---

## 🏗️ Core Components Architecture

### 1. Airflow Control Plane

#### Scheduler Configuration
```yaml
Airflow Scheduler Deployment:
  Purpose: Task scheduling and workflow orchestration
  Replicas: 2 (High Availability)
  Resources:
    CPU: 2 cores
    Memory: 4Gi
    Storage: 10Gi SSD
  
  Child Safety Features:
    - Encrypted child data processing validation
    - Privacy-preserving task scheduling
    - Audit logging for all child data workflows
    - Emergency shutdown capabilities for data breaches
  
  Configuration:
    scheduler_heartbeat_sec: 5
    dag_dir_list_interval: 300
    child_process_timeout: 600
    parallelism: 32
    max_active_tasks_per_dag: 16
```

#### Webserver Configuration
```yaml
Airflow Webserver Deployment:
  Purpose: Web UI and API access
  Replicas: 2 (Load Balanced)
  Resources:
    CPU: 1 core
    Memory: 2Gi
    Storage: 5Gi SSD
  
  Security Features:
    - OAuth2 integration with AWS Cognito
    - Role-based access control (RBAC)
    - Child data view restrictions
    - Session encryption and management
  
  Child Protection Controls:
    - No child PII displayed in UI
    - Masked sensitive data in logs
    - Audit trail for all UI access
    - Emergency lockdown procedures
```

#### Triggerer Configuration
```yaml
Airflow Triggerer Deployment:
  Purpose: Deferrable task handling
  Replicas: 1
  Resources:
    CPU: 0.5 cores
    Memory: 1Gi
    Storage: 2Gi SSD
  
  Use Cases:
    - Long-running child data validation tasks
    - External system polling for updates
    - Scheduled compliance report generation
    - Real-time alert processing
```

### 2. Worker Execution Architecture

#### Celery Workers
```yaml
Celery Worker Configuration:
  Purpose: Distributed task execution
  Auto-scaling: 2-10 replicas based on queue depth
  Resources per Worker:
    CPU: 2 cores
    Memory: 4Gi
    Storage: 10Gi SSD
  
  Child Data Processing:
    - Dedicated workers for sensitive data
    - Encrypted inter-worker communication
    - Isolated processing environments
    - Complete audit logging
  
  Queue Configuration:
    default: General tasks
    child_data: Sensitive child information processing
    analytics: Stakeholder reporting and insights
    compliance: Regulatory and audit workflows
```

#### Kubernetes Executor Pods
```yaml
KubernetesExecutor Configuration:
  Purpose: Dynamic pod-based task execution
  Pod Templates:
    - child-data-processing-template
    - analytics-processing-template
    - compliance-reporting-template
  
  Resource Templates:
    Small Tasks:
      CPU: 0.5 cores
      Memory: 1Gi
    Medium Tasks:
      CPU: 1 core
      Memory: 2Gi
    Large Tasks:
      CPU: 4 cores
      Memory: 8Gi
  
  Security Templates:
    - Pod Security Standards: Restricted
    - Service Account: airflow-worker
    - Network Policies: Isolated
    - Volume Encryption: Enabled
```

### 3. Supporting Infrastructure

#### Redis Message Broker
```yaml
Redis Configuration:
  Purpose: Task queue and state management
  Deployment: Redis Sentinel (High Availability)
  Replicas: 3 (1 master, 2 replicas)
  Resources per Instance:
    CPU: 1 core
    Memory: 2Gi
    Storage: 10Gi SSD
  
  Security Features:
    - TLS encryption in transit
    - Authentication required
    - Network policy isolation
    - Automatic failover
  
  Child Data Protection:
    - No child data stored in Redis
    - Encrypted task metadata
    - Audit logging enabled
    - Emergency flush capabilities
```

#### PostgreSQL Metadata Database
```yaml
PostgreSQL Configuration:
  Service: Amazon RDS for PostgreSQL
  Version: PostgreSQL 15.x
  Instance: db.r6g.large (Multi-AZ)
  Storage: 100GB gp3 SSD with encryption
  
  High Availability:
    - Multi-AZ deployment
    - Automated backups (7-day retention)
    - Point-in-time recovery
    - Read replicas for reporting
  
  Security Features:
    - Encryption at rest (KMS)
    - Encryption in transit (SSL/TLS)
    - VPC isolation
    - Database parameter encryption
  
  Child Safety Controls:
    - No child PII in metadata
    - Audit logging for all access
    - Emergency shutdown procedures
    - Compliance reporting automation
```

---

## 🔐 Security Implementation

### 1. Encryption and Key Management

#### AWS KMS Integration
```yaml
Encryption Strategy:
  Data at Rest:
    - EBS volume encryption with customer-managed KMS keys
    - S3 bucket encryption with SSE-KMS
    - RDS encryption with dedicated key rotation
  
  Data in Transit:
    - TLS 1.3 for all communications
    - Pod-to-pod encryption with Istio
    - Database connections over SSL
  
  Child Data Specific:
    Key: child-data-encryption-key
    Rotation: Automatic every 90 days
    Access: Restricted to child-data-processing roles
    Audit: All key usage logged and monitored
```

#### Secrets Management
```yaml
AWS Secrets Manager Configuration:
  Secret Categories:
    Database Credentials:
      - airflow-metadata-db-credentials
      - analytics-db-readonly-credentials
    
    API Keys:
      - external-systems-api-keys
      - notification-service-tokens
    
    Child Data Access:
      - child-data-encryption-keys
      - emergency-access-credentials
  
  Access Control:
    - IAM role-based access
    - Time-limited access tokens
    - Automatic rotation enabled
    - Audit logging for all access
  
  Emergency Procedures:
    - Immediate secret rotation
    - Access revocation protocols
    - Incident response integration
    - Stakeholder notification system
```

### 2. Identity and Access Management

#### Service Account Configuration
```yaml
Kubernetes Service Accounts:
  airflow-scheduler:
    IAM Role: AirflowSchedulerRole
    Permissions:
      - S3 DAG bucket read access
      - KMS decrypt for workflow secrets
      - CloudWatch metrics write
  
  airflow-worker:
    IAM Role: AirflowWorkerRole
    Permissions:
      - S3 data bucket read/write
      - Secrets Manager read access
      - Child data processing permissions
  
  airflow-webserver:
    IAM Role: AirflowWebserverRole
    Permissions:
      - Cognito user authentication
      - CloudWatch logs write
      - Limited S3 log access
```

#### Role-Based Access Control (RBAC)
```yaml
Airflow RBAC Configuration:
  Roles:
    Admin:
      Users: Platform administrators
      Permissions: Full system access
      Child Data: Emergency access only
    
    Data Engineer:
      Users: Data pipeline developers
      Permissions: DAG management, task monitoring
      Child Data: Development environment only
    
    Analytics User:
      Users: Stakeholder analysts
      Permissions: View reports, limited DAG access
      Child Data: Aggregated data only
    
    Auditor:
      Users: Compliance reviewers
      Permissions: Read-only access to logs and reports
      Child Data: Audit trail access only
```

### 3. Network Security

#### VPC and Network Isolation
```yaml
Network Architecture:
  VPC Configuration:
    CIDR: 10.0.0.0/16
    Availability Zones: 3
    Subnets:
      Public: 10.0.1.0/24, 10.0.2.0/24, 10.0.3.0/24
      Private: 10.0.10.0/24, 10.0.20.0/24, 10.0.30.0/24
      Database: 10.0.100.0/24, 10.0.200.0/24, 10.0.300.0/24
  
  Security Groups:
    airflow-webserver-sg:
      Inbound: HTTPS (443) from ALB only
      Outbound: Database and Redis access
    
    airflow-scheduler-sg:
      Inbound: Internal communication only
      Outbound: Database, Redis, and S3 access
    
    airflow-worker-sg:
      Inbound: Internal communication only
      Outbound: Full outbound for data processing
```

#### Kubernetes Network Policies
```yaml
Network Policy Configuration:
  Child Data Processing Isolation:
    - Dedicated namespace: child-data-processing
    - No cross-namespace communication
    - Restricted external egress
    - Audit logging for all network traffic
  
  Analytics Processing:
    - Namespace: analytics-processing
    - Limited external API access
    - Encrypted inter-pod communication
    - Monitoring and alerting enabled
  
  Default Deny Policy:
    - All pods isolated by default
    - Explicit allow rules required
    - Continuous compliance monitoring
    - Emergency lockdown capabilities
```

---

## 💾 Storage Strategy

### 1. DAG Storage Architecture

#### Amazon EFS for DAGs
```yaml
EFS Configuration:
  File System: Airflow DAGs storage
  Performance Mode: General Purpose
  Encryption: Enabled with KMS
  Backup: Automatic daily backups
  
  Mount Configuration:
    Mount Path: /opt/airflow/dags
    Access Mode: ReadWriteMany
    Security: POSIX permissions with encryption
  
  Child Safety Features:
    - Version control integration
    - Approval workflow for DAG changes
    - Automated security scanning
    - Rollback capabilities for emergencies
```

#### DAG Development Workflow
```yaml
DAG Lifecycle Management:
  Development:
    - Local development environment
    - Child data anonymization for testing
    - Security scanning before commit
    - Peer review requirements
  
  Staging:
    - Isolated staging environment
    - Synthetic data for validation
    - Performance testing
    - Security compliance verification
  
  Production:
    - Automated deployment via GitOps
    - Blue-green deployment strategy
    - Real-time monitoring
    - Emergency rollback procedures
```

### 2. Data and Logs Storage

#### Amazon S3 Architecture
```yaml
S3 Bucket Strategy:
  airflow-logs-bucket:
    Purpose: Airflow task logs and audit trails
    Encryption: SSE-KMS with log-specific key
    Lifecycle: 90 days Standard, then Glacier
    Access: Read-only for auditors and admins
  
  airflow-data-staging:
    Purpose: Temporary data processing storage
    Encryption: SSE-KMS with data-specific key
    Lifecycle: 7 days then automatic deletion
    Access: Restricted to processing workflows
  
  child-data-archive:
    Purpose: Long-term child data archives
    Encryption: SSE-KMS with child-data-key
    Lifecycle: Immediate Glacier Deep Archive
    Access: Emergency access only with dual approval
```

#### Log Management Strategy
```yaml
Centralized Logging:
  Collection: Fluent Bit on each pod
  Aggregation: Amazon OpenSearch Service
  Retention: 1 year for audit compliance
  
  Log Categories:
    Application Logs:
      - Airflow scheduler/webserver logs
      - Worker execution logs
      - DAG processing logs
    
    Security Logs:
      - Authentication events
      - Authorization failures
      - Child data access logs
    
    Audit Logs:
      - All child data processing activities
      - Administrative actions
      - Emergency access events
  
  Child Data Protection:
    - Automatic PII scrubbing
    - Encrypted log transmission
    - Access control enforcement
    - Compliance reporting automation
```

---

## 📊 Monitoring and Observability

### 1. Metrics Collection

#### CloudWatch Integration
```yaml
Airflow Metrics:
  Scheduler Metrics:
    - scheduler_heartbeat
    - dag_processing_time
    - task_scheduler_lag
    - failed_dag_runs
  
  Worker Metrics:
    - active_workers
    - task_execution_time
    - task_success_rate
    - worker_cpu_usage
  
  Child Data Processing Metrics:
    - child_data_pipeline_success_rate
    - data_privacy_compliance_score
    - emergency_response_time
    - audit_log_completeness
```

#### Custom Metrics Dashboard
```yaml
Grafana Dashboard Configuration:
  Child Welfare Operations:
    - Real-time pipeline status
    - Child data processing health
    - Emergency response readiness
    - Compliance monitoring
  
  Stakeholder Analytics:
    - Government reporting pipeline status
    - Business partner data availability
    - Academic research data quality
    - Community engagement metrics
  
  Technical Operations:
    - System performance metrics
    - Resource utilization trends
    - Security event monitoring
    - Cost optimization insights
```

### 2. Alerting Strategy

#### Critical Alerts
```yaml
Emergency Response Alerts:
  Child Data Breach Detection:
    Trigger: Unauthorized access to child data
    Response: Immediate notification to security team
    Actions: Automatic system lockdown
  
  Pipeline Failure Critical Path:
    Trigger: Emergency response pipeline failure
    Response: On-call engineer notification
    Actions: Automatic failover initiation
  
  Compliance Violation:
    Trigger: Data sovereignty or privacy violation
    Response: Legal and compliance team notification
    Actions: Audit trail generation
```

#### Operational Alerts
```yaml
Performance Monitoring:
  High Resource Usage:
    Threshold: >80% CPU/Memory for 10 minutes
    Action: Auto-scaling trigger
  
  Long-Running Tasks:
    Threshold: Tasks running >4 hours
    Action: Investigation and potential termination
  
  Failed Task Rate:
    Threshold: >5% failure rate in 1 hour
    Action: Pipeline health investigation
```

---

## 🔄 Backup and Disaster Recovery

### 1. Backup Strategy

#### Automated Backup Configuration
```yaml
RDS Backups:
  Automated Backups: 7-day retention
  Manual Snapshots: Monthly with 1-year retention
  Point-in-time Recovery: Enabled
  Cross-region Backup: Enabled for disaster recovery
  
EFS Backups:
  Daily Backups: Automatic with 30-day retention
  Weekly Backups: Manual with 90-day retention
  Versioning: Enabled for DAG changes
  
S3 Backup:
  Cross-region Replication: Enabled
  Versioning: Enabled with lifecycle management
  Delete Protection: MFA required for child data
```

#### Child Data Protection Backups
```yaml
Child Data Backup Strategy:
  Frequency: Real-time replication + daily snapshots
  Encryption: Double encryption (application + storage)
  Geographic Distribution: Primary + secondary regions
  Access Control: Dual approval required
  
  Recovery Testing:
    Monthly: Automated recovery validation
    Quarterly: Full disaster recovery drill
    Annually: Complete system restoration test
```

### 2. Disaster Recovery Planning

#### Recovery Time Objectives (RTO)
```yaml
Service Tier Classification:
  Critical (Emergency Response):
    RTO: 15 minutes
    RPO: 5 minutes
    Services: Emergency alert pipelines
  
  High Priority (Daily Operations):
    RTO: 1 hour
    RPO: 1 hour
    Services: Core analytics and reporting
  
  Standard (Scheduled Reports):
    RTO: 4 hours
    RPO: 4 hours
    Services: Weekly/monthly reporting pipelines
```

#### Disaster Recovery Procedures
```yaml
Emergency Response Plan:
  Phase 1 - Assessment (0-15 minutes):
    - Identify scope and impact
    - Activate incident response team
    - Notify stakeholders
  
  Phase 2 - Isolation (15-30 minutes):
    - Isolate affected systems
    - Preserve evidence for investigation
    - Switch to backup systems
  
  Phase 3 - Recovery (30-120 minutes):
    - Restore from backups
    - Validate data integrity
    - Resume critical operations
  
  Phase 4 - Verification (2-4 hours):
    - Complete system validation
    - Stakeholder communication
    - Post-incident review
```

---

## 🚀 Implementation Guide

### 1. Prerequisites and Setup

#### Environment Preparation
```bash
# Install required tools
aws --version  # AWS CLI v2.0+
kubectl version  # kubectl v1.28+
helm version  # Helm v3.12+
eksctl version  # eksctl v0.147+

# Set up environment variables
export AWS_REGION=ap-southeast-1  # Jakarta region for data sovereignty
export CLUSTER_NAME=merajutasa-airflow-prod
export NAMESPACE=airflow-production
export CHILD_DATA_NAMESPACE=child-data-processing
```

#### Amazon EKS Cluster Setup
```yaml
# eksctl cluster configuration
apiVersion: eksctl.io/v1alpha5
kind: ClusterConfig

metadata:
  name: merajutasa-airflow-prod
  region: ap-southeast-1
  version: "1.28"

iam:
  withOIDC: true
  serviceAccounts:
  - metadata:
      name: airflow-scheduler
      namespace: airflow-production
    roleName: AirflowSchedulerRole
    roleOnly: true
    attachPolicyARNs:
    - arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy
    
  - metadata:
      name: airflow-worker
      namespace: airflow-production
    roleName: AirflowWorkerRole
    roleOnly: true
    attachPolicyARNs:
    - arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy

nodeGroups:
  - name: airflow-control-plane
    instanceType: m6i.large
    desiredCapacity: 2
    minSize: 2
    maxSize: 4
    labels:
      nodegroup-type: control-plane
      child-safety: enabled
    
  - name: airflow-workers
    instanceType: m6i.xlarge
    desiredCapacity: 3
    minSize: 2
    maxSize: 10
    labels:
      nodegroup-type: workers
      child-safety: enabled
    
addons:
  - name: vpc-cni
  - name: coredns
  - name: kube-proxy
  - name: aws-ebs-csi-driver
  - name: aws-efs-csi-driver

cloudWatch:
  clusterLogging:
    enableTypes: ["*"]
```

### 2. Step-by-Step Deployment

#### Step 1: Create EKS Cluster
```bash
# Create the EKS cluster
eksctl create cluster -f cluster-config.yaml

# Verify cluster creation
kubectl get nodes
kubectl get namespaces

# Expected output: 5 worker nodes across 3 AZs
# Validation: All nodes in Ready state
```

#### Step 2: Install and Configure Helm
```bash
# Add Airflow Helm repository
helm repo add apache-airflow https://airflow.apache.org
helm repo update

# Create namespaces
kubectl create namespace airflow-production
kubectl create namespace child-data-processing

# Verify namespace creation
kubectl get namespaces | grep -E "(airflow|child-data)"

# Expected output: Both namespaces created successfully
```

#### Step 3: Configure Storage Infrastructure
```bash
# Create EFS for DAG storage
aws efs create-file-system \
  --creation-token airflow-dags-$(date +%s) \
  --performance-mode generalPurpose \
  --encrypted \
  --tags Key=Name,Value=airflow-dags-storage \
         Key=Environment,Value=production \
         Key=ChildSafety,Value=enabled

# Get EFS file system ID
EFS_ID=$(aws efs describe-file-systems \
  --query 'FileSystems[?Name==`airflow-dags-storage`].FileSystemId' \
  --output text)

# Create S3 buckets for logs and data
aws s3 mb s3://merajutasa-airflow-logs-prod --region ap-southeast-1
aws s3 mb s3://merajutasa-airflow-data-staging --region ap-southeast-1

# Enable S3 bucket encryption
aws s3api put-bucket-encryption \
  --bucket merajutasa-airflow-logs-prod \
  --server-side-encryption-configuration \
  'Rules=[{ApplyServerSideEncryptionByDefault:{SSEAlgorithm=aws:kms}}]'

# Verification command
aws s3 ls | grep merajutasa-airflow
aws efs describe-file-systems --file-system-id $EFS_ID
```

#### Step 4: Deploy Airflow with Helm
```yaml
# values-production.yaml
---
# Airflow configuration
airflow:
  image:
    repository: apache/airflow
    tag: "2.7.2-python3.11"
  
  # Child safety and security configuration
  config:
    AIRFLOW__CORE__SECURITY: "strict"
    AIRFLOW__WEBSERVER__EXPOSE_CONFIG: "False"
    AIRFLOW__CORE__CHILD_DATA_PROTECTION: "enabled"
    AIRFLOW__LOGGING__REMOTE_LOGGING: "True"
    AIRFLOW__LOGGING__REMOTE_BASE_LOG_FOLDER: "s3://merajutasa-airflow-logs-prod"
    
  # Database configuration
  postgresql:
    enabled: false
  
  externalDatabase:
    type: postgres
    host: airflow-metadata-db.cluster-xxx.ap-southeast-1.rds.amazonaws.com
    port: 5432
    database: airflow_production
    user: airflow_admin
    passwordSecret: airflow-db-credentials
    passwordSecretKey: password
  
  # Redis configuration
  redis:
    enabled: false
  
  externalRedis:
    host: airflow-redis.cluster.ap-southeast-1.cache.amazonaws.com
    port: 6379
    passwordSecret: airflow-redis-credentials
    passwordSecretKey: password

# Scheduler configuration
scheduler:
  replicas: 2
  resources:
    requests:
      cpu: 1000m
      memory: 2Gi
    limits:
      cpu: 2000m
      memory: 4Gi
  
  # Child data processing configuration
  env:
    - name: CHILD_DATA_ENCRYPTION_KEY_ID
      valueFrom:
        secretKeyRef:
          name: child-data-encryption
          key: key-id
  
# Webserver configuration
webserver:
  replicas: 2
  resources:
    requests:
      cpu: 500m
      memory: 1Gi
    limits:
      cpu: 1000m
      memory: 2Gi
  
  # Security configuration
  defaultUser:
    enabled: false  # Use OAuth2 instead
  
# Worker configuration
workers:
  replicas: 3
  resources:
    requests:
      cpu: 1000m
      memory: 2Gi
    limits:
      cpu: 4000m
      memory: 8Gi
  
  # Child data processing capabilities
  env:
    - name: CHILD_DATA_PROCESSING_ENABLED
      value: "true"
    - name: AUDIT_LOGGING_ENABLED
      value: "true"

# DAG storage configuration
dags:
  persistence:
    enabled: true
    storageClassName: efs-sc
    size: 100Gi
    accessMode: ReadWriteMany

# Monitoring and logging
serviceMonitor:
  enabled: true
  
logs:
  persistence:
    enabled: false  # Using S3 for logs
```

```bash
# Deploy Airflow
helm install airflow apache-airflow/airflow \
  --namespace airflow-production \
  --values values-production.yaml \
  --timeout 10m

# Wait for deployment completion
kubectl wait --for=condition=available --timeout=600s \
  deployment/airflow-scheduler -n airflow-production

kubectl wait --for=condition=available --timeout=600s \
  deployment/airflow-webserver -n airflow-production

# Verification commands
kubectl get pods -n airflow-production
kubectl get services -n airflow-production

# Expected output: All pods Running, services created
```

#### Step 5: Configure Security and Access Controls
```bash
# Create secrets for database and Redis
kubectl create secret generic airflow-db-credentials \
  --from-literal=password='<SECURE_DATABASE_PASSWORD>' \
  -n airflow-production

kubectl create secret generic airflow-redis-credentials \
  --from-literal=password='<SECURE_REDIS_PASSWORD>' \
  -n airflow-production

# Create child data encryption secret
kubectl create secret generic child-data-encryption \
  --from-literal=key-id='arn:aws:kms:ap-southeast-1:ACCOUNT:key/KEY-ID' \
  -n airflow-production

# Apply network policies
kubectl apply -f - <<EOF
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: child-data-isolation
  namespace: child-data-processing
spec:
  podSelector: {}
  policyTypes:
  - Ingress
  - Egress
  ingress:
  - from:
    - namespaceSelector:
        matchLabels:
          name: airflow-production
    ports:
    - protocol: TCP
      port: 8080
  egress:
  - to:
    - namespaceSelector:
        matchLabels:
          name: airflow-production
    ports:
    - protocol: TCP
      port: 5432
EOF

# Verification command
kubectl get networkpolicies -n child-data-processing
```

### 3. Validation and Testing

#### Health Check Procedures
```bash
# Test 1: Verify Airflow components
echo "=== Airflow Component Health Check ==="
kubectl get pods -n airflow-production -o wide
kubectl describe service airflow-webserver -n airflow-production

# Expected: All pods Running, LoadBalancer service active

# Test 2: Database connectivity
echo "=== Database Connectivity Test ==="
kubectl exec -it deployment/airflow-scheduler -n airflow-production -- \
  airflow db check

# Expected: "Connection successful" message

# Test 3: DAG processing capability
echo "=== DAG Processing Test ==="
kubectl exec -it deployment/airflow-scheduler -n airflow-production -- \
  airflow dags list

# Expected: List of available DAGs (may be empty initially)

# Test 4: Worker task execution
echo "=== Worker Execution Test ==="
kubectl exec -it deployment/airflow-scheduler -n airflow-production -- \
  airflow tasks test example_bash_operator runme_0 2024-01-01

# Expected: Task execution successful message
```

#### Security Validation
```bash
# Test 1: Encryption verification
echo "=== Encryption Validation ==="
kubectl exec -it deployment/airflow-scheduler -n airflow-production -- \
  python -c "
import os
from cryptography.fernet import Fernet
print('Fernet key configured:', bool(os.environ.get('AIRFLOW__CORE__FERNET_KEY')))
"

# Expected: "Fernet key configured: True"

# Test 2: Network policy enforcement
echo "=== Network Policy Test ==="
kubectl run test-pod --rm -it --image=busybox -n default -- \
  wget -O- --timeout=5 airflow-webserver.airflow-production:8080 2>/dev/null

# Expected: Connection timeout (policy blocking access)

# Test 3: RBAC configuration
echo "=== RBAC Validation ==="
kubectl auth can-i get pods --as=system:serviceaccount:airflow-production:airflow-worker
kubectl auth can-i create secrets --as=system:serviceaccount:airflow-production:airflow-worker

# Expected: "yes" for pods, "no" for secrets
```

#### Child Data Protection Validation
```bash
# Test 1: Child data processing isolation
echo "=== Child Data Processing Isolation ==="
kubectl create job test-child-data-job --image=busybox \
  -n child-data-processing -- /bin/sh -c "
    echo 'Testing child data processing isolation'
    sleep 30
  "

kubectl wait --for=condition=complete job/test-child-data-job \
  -n child-data-processing --timeout=60s

kubectl logs job/test-child-data-job -n child-data-processing

# Expected: Job completes successfully in isolated namespace

# Test 2: Audit logging verification
echo "=== Audit Logging Test ==="
kubectl exec -it deployment/airflow-scheduler -n airflow-production -- \
  python -c "
import logging
logging.getLogger('airflow.child_data').info('Test child data access log')
print('Audit logging test completed')
"

# Check CloudWatch logs for the audit entry
aws logs filter-log-events \
  --log-group-name "/aws/eks/merajutasa-airflow-prod/cluster" \
  --filter-pattern "child_data" \
  --start-time $(date -d '5 minutes ago' +%s)000

# Expected: Audit log entry found in CloudWatch
```

### 4. Operational Procedures

#### Daily Operations Checklist
```yaml
Morning Health Check (09:00 WIB):
  - Verify all Airflow components running
  - Check overnight DAG execution status
  - Review child data processing logs
  - Validate security alerts (should be none)
  
  Commands:
    kubectl get pods -n airflow-production
    kubectl top nodes
    aws cloudwatch get-metric-statistics \
      --namespace AWS/EKS \
      --metric-name cluster_health
    
Evening Maintenance (22:00 WIB):
  - Review daily audit logs
  - Check backup completion status
  - Validate compliance metrics
  - Prepare next-day processing schedules
  
  Commands:
    kubectl logs deployment/airflow-scheduler -n airflow-production --since=24h
    aws s3 ls s3://merajutasa-airflow-logs-prod/ | tail -20
    aws rds describe-db-snapshots --query 'DBSnapshots[0].Status'
```

#### Emergency Response Procedures
```yaml
Child Data Breach Response:
  Immediate Actions (0-5 minutes):
    1. Execute emergency lockdown
    2. Isolate affected systems
    3. Notify security team
    
  Investigation (5-30 minutes):
    1. Preserve evidence
    2. Identify breach scope
    3. Contact legal team
    
  Recovery (30-120 minutes):
    1. Restore from clean backups
    2. Validate data integrity
    3. Resume operations
    
  Emergency Commands:
    # Emergency shutdown
    kubectl scale deployment airflow-scheduler --replicas=0 -n airflow-production
    kubectl scale deployment airflow-worker --replicas=0 -n airflow-production
    
    # Isolate networking
    kubectl apply -f emergency-network-policy.yaml
    
    # Backup current state
    kubectl get all -n airflow-production -o yaml > emergency-backup.yaml
```

---

## 👶 Child Safety and Accessibility

### Child Data Protection Measures

#### Privacy-Preserving Processing
```yaml
Data Anonymization Pipeline:
  Automatic PII Removal:
    - Child names replaced with secure identifiers
    - Location data aggregated to district level
    - Medical information encrypted with separate keys
    - Family details restricted to authorized personnel
  
  Differential Privacy:
    - Statistical noise added to aggregate queries
    - K-anonymity enforced for research datasets
    - L-diversity maintained for sensitive attributes
    - T-closeness preserved for distribution analysis
  
  Access Control Matrix:
    Government Users:
      - Aggregated statistics only
      - No individual child identification
      - Compliance reporting access
    
    Business Partners:
      - Impact metrics only
      - No child-specific data
      - CSR effectiveness measures
    
    Academic Researchers:
      - Anonymized datasets
      - Ethical review required
      - Publication approval workflow
    
    Community Volunteers:
      - Program-specific access only
      - No personal information
      - Activity-based permissions
    
    Media Representatives:
      - Success stories only
      - No child identification
      - Approved content library
```

#### Child Consent and Rights Management
```yaml
Age-Appropriate Controls:
  Children Under 13:
    - Guardian consent required
    - Minimal data collection
    - Enhanced privacy protections
    - Regular consent review
  
  Children 13-17:
    - Joint child-guardian consent
    - Age-appropriate explanations
    - Right to data portability
    - Regular privacy check-ins
  
  Young Adults 18+:
    - Full consent capability
    - Complete data control
    - Historical data review
    - Transition support services
  
Consent Management Pipeline:
  Initial Consent Collection:
    - Multi-language consent forms
    - Visual and audio explanations
    - Witness requirements for vulnerable children
    - Legal guardian verification
  
  Ongoing Consent Validation:
    - Annual consent renewal
    - Automated expiry notifications
    - Easy withdrawal mechanisms
    - Data deletion workflows
```

### Accessibility Implementation

#### Multi-Language Support
```yaml
Internationalization Features:
  Primary Languages:
    - Bahasa Indonesia (primary)
    - English (secondary)
    - Regional languages (Javanese, Sundanese, Balinese)
  
  Translation Pipeline:
    - Automated translation for interface elements
    - Human review for child-facing content
    - Cultural adaptation for local contexts
    - Regular translation quality audits
  
  Airflow UI Accessibility:
    - Screen reader compatibility
    - High contrast mode support
    - Keyboard navigation optimization
    - Font size adjustment options
```

#### Inclusive Design Principles
```yaml
Visual Accessibility:
  Color Accessibility:
    - WCAG 2.1 AA contrast compliance
    - Color-blind friendly palettes
    - Pattern and texture alternatives
    - High contrast dashboard themes
  
  Typography:
    - Dyslexia-friendly fonts available
    - Adjustable font sizes (12-24pt)
    - Sufficient line spacing (1.5x minimum)
    - Clear visual hierarchy
  
Cognitive Accessibility:
  Information Architecture:
    - Simple, consistent navigation
    - Clear progress indicators
    - Contextual help systems
    - Error prevention and recovery
  
  Language Simplification:
    - Plain language in user interfaces
    - Technical jargon explanations
    - Visual workflow diagrams
    - Step-by-step guided processes
```

---

## 📚 Cross-References and Integration

### Security Architecture Integration
This Airflow deployment integrates with the comprehensive security infrastructure:

- **[Data Protection Architecture](../security/data-protection.md)**: Implements child data encryption and privacy controls
- **[Network Security](../security/network-security.md)**: Utilizes VPC isolation and network policies
- **[Authentication Architecture](../security/authentication-architecture.md)**: Integrates with OAuth2 and RBAC systems
- **[Incident Response](../security/incident-response.md)**: Follows established security incident procedures

### Infrastructure Dependencies
- **[Kubernetes Architecture](./kubernetes-architecture.md)**: Built on established EKS foundation
- **[Monitoring Architecture](./monitoring-architecture.md)**: Integrates with platform-wide observability
- **[Storage Strategy](./storage-strategy.md)**: Utilizes established storage patterns and encryption
- **[Networking](./networking.md)**: Follows VPC and subnet architecture standards

### ADR Implementation
This implementation directly fulfills the requirements specified in:
- **[ADR-027: Data Pipeline Platform Selection](../decisions/027-data-pipeline-platform-selection.md)**: Complete Apache Airflow deployment

### Stakeholder Resources
- **[Government Stakeholder Guide](../../stakeholders/government/README.md)**: Regulatory compliance and reporting procedures
- **[Business Partnership Framework](../../stakeholders/business/README.md)**: CSR integration and analytics requirements
- **[Academic Collaboration Guidelines](../../stakeholders/academia/README.md)**: Research data access and ethical guidelines

---

## 📞 Support and Maintenance

### Technical Support
```yaml
Support Tiers:
  Level 1 - Basic Support:
    Response: 2-4 hours during business hours
    Scope: General questions, documentation
    Contact: airflow-support@merajutasa.id
  
  Level 2 - Production Issues:
    Response: 1 hour, 24/7
    Scope: Service interruptions, performance issues
    Contact: On-call rotation via PagerDuty
  
  Level 3 - Emergency Response:
    Response: 15 minutes, 24/7
    Scope: Child data security, compliance breaches
    Contact: Emergency hotline + security team
```

### Maintenance Windows
```yaml
Scheduled Maintenance:
  Weekly Maintenance:
    Schedule: Sundays 02:00-04:00 WIB
    Activities: Routine updates, log rotation
    Notification: 72 hours advance notice
  
  Monthly Maintenance:
    Schedule: First Sunday of month 02:00-06:00 WIB
    Activities: Security patches, dependency updates
    Notification: 1 week advance notice
  
  Quarterly Maintenance:
    Schedule: Scheduled with stakeholder input
    Activities: Major version updates, infrastructure changes
    Notification: 1 month advance notice
```

### Documentation Updates
This documentation is reviewed and updated according to:
- **Monthly**: Technical accuracy and operational procedures
- **Quarterly**: Architecture patterns and best practices  
- **Annually**: Complete review with stakeholder feedback
- **Emergency**: Security incidents or critical changes

**Last Reviewed**: 2025-08-08
**Next Review**: 2025-09-08
**Version**: 1.0.0
**Stakeholder**: Data Engineering Team, Security Team, Child Protection Officers

---

*This guide ensures Apache Airflow on Kubernetes serves our mission of protecting vulnerable children through secure, reliable, and scalable data pipeline orchestration, enabling evidence-based improvements to child welfare programs across Indonesia.*
