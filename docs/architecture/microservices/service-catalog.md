# Service Catalog Documentation
## MerajutASA Platform - Comprehensive Microservices Registry

> **Service Catalog Mission**: "Providing a comprehensive, searchable, and maintainable catalog of all microservices in the MerajutASA platform ecosystem, enabling efficient service discovery, dependency management, and stakeholder collaboration through clear service documentation and metadata."

---

## 🏗️ Service Catalog Architecture

### Service Registry Philosophy
Every service in the MerajutASA platform is cataloged with comprehensive metadata supporting child welfare objectives:

```yaml
Catalog Principles:
  Child Safety Metadata: Every service tagged with child protection impact
  Stakeholder Mapping: Clear stakeholder group associations per service
  Dependency Tracking: Complete service dependency visualization
  API Documentation: Comprehensive API documentation for all services
  Health Monitoring: Real-time service health and availability status
  
Service Classification:
  Core Domain Services: Child welfare and stakeholder management
  Supporting Services: Security, data, and infrastructure services
  Integration Services: External system integration and communication
  Analytics Services: Business intelligence and reporting services
  Platform Services: Shared platform capabilities and utilities
```

### Academic Research Foundation
Service catalog design based on microservices governance and service mesh best practices:

```yaml
Research Foundation:
  Martin Fowler Service Registry: Service discovery patterns
  Netflix Eureka: Service registry best practices
  Consul Service Discovery: Distributed service catalog
  Kubernetes Service Discovery: Cloud-native service registry
  Istio Service Mesh: Service catalog integration patterns
  
Catalog Performance Research:
  Service Discovery: 85% reduction in service location overhead
  Dependency Management: 67% improvement in change impact analysis
  API Documentation: 78% reduction in integration development time
  Health Monitoring: 89% improvement in incident response time
  Service Governance: 56% improvement in service compliance
```

---

## 🎯 Core Domain Services

### Child Management Services

#### Child Profile Service
```yaml
Service Metadata:
  Service Name: child-profile-service
  Service ID: cps-001
  Version: v2.1.3
  Owner Team: Child Welfare Engineering
  Stakeholder Impact: Government, Academic, Community, Media
  Child Protection Level: HIGH
  
Service Description:
  Purpose: Comprehensive child identity and profile management
  Business Domain: Child Management
  Data Sensitivity: HIGH - Contains PII and sensitive child information
  Compliance Requirements: GDPR, UU ITE, UNICEF Child Protection Standards
  
Technical Specifications:
  Runtime: Node.js v18.x with TypeScript
  Framework: Express.js with Helmet security middleware
  Database: PostgreSQL 15.x with row-level security
  Cache: Redis 7.x for session and profile caching
  Message Queue: RabbitMQ for profile update events
  
API Documentation:
  OpenAPI Spec: /docs/api/child-profile-service/openapi.yaml
  Base URL: https://api.merajutasa.id/v2/children/profiles
  Authentication: OAuth 2.0 with child protection scopes
  Rate Limits: 100 requests/minute per authenticated user
  
Health Endpoints:
  Liveness: GET /health/live
  Readiness: GET /health/ready
  Metrics: GET /metrics (Prometheus format)
  
Dependencies:
  Upstream Services:
    - identity-service (authentication)
    - audit-service (logging)
    - encryption-service (data protection)
  Downstream Services:
    - case-management-service
    - placement-service
    - notification-service
  
External Integrations:
  - Government Identity Database (Dukcapil)
  - Medical Records System (with consent)
  - Educational Management System
  
Service Level Objectives (SLOs):
  Availability: 99.95% uptime
  Response Time: 95th percentile < 200ms
  Error Rate: < 0.1% for profile operations
  Data Consistency: 100% for child safety data
  
Security Features:
  - End-to-end encryption for all child data
  - Role-based access control with child protection focus
  - Audit logging for all profile access and modifications
  - Data anonymization capabilities for research
  - GDPR right-to-be-forgotten implementation
  
Monitoring and Alerts:
  - Real-time health monitoring with Prometheus
  - Custom alerts for child data access anomalies
  - Performance monitoring with APM tools
  - Security monitoring with SIEM integration
  - Business metric tracking for child welfare KPIs
  - Facility maintenance tracking
  - Compliance monitoring
  - Performance metrics

Key Features:
  - Real-time capacity tracking
  - Staff certification management
  - Resource allocation optimization
  - Compliance dashboard
  - Performance analytics
```

#### 3. Volunteer Management Service
**Purpose**: Manages volunteer recruitment, screening, and engagement.

```yaml
Service: volunteer-service
Port: 3003
Database: PostgreSQL (volunteer_db)
Dependencies:
  - identity-service
  - background-check-service
  - training-service
  
Responsibilities:
  - Volunteer registration and profiles
  - Background check coordination
  - Skill and availability matching
  - Training program management
  - Volunteer activity tracking
  - Recognition and rewards

Key Features:
  - Automated background checks
  - Skills-based matching
  - Training progress tracking
  - Volunteer portal
  - Community engagement tools
```

#### 4. Donation Management Service
**Purpose**: Handles donations, financial tracking, and transparency reporting.

```yaml
Service: donation-service
Port: 3004
Database: PostgreSQL (donation_db)
Dependencies:
  - payment-gateway-service
  - analytics-service
  - notification-service
  
Responsibilities:
  - Donation processing
  - Donor management
  - Financial tracking and reporting
  - Transparency reports
  - Donation impact measurement
  - Tax receipt generation

Key Features:
  - Multiple payment gateways
  - Recurring donation support
  - Impact tracking
  - Donor portal
  - Financial transparency
```

#### 5. Family Support Service
**Purpose**: Manages family reunification, support programs, and follow-up care.

```yaml
Service: family-service
Port: 3005
Database: PostgreSQL (family_db)
Dependencies:
  - child-management-service
  - case-management-service
  - notification-service
  
Responsibilities:
  - Family reunification programs
  - Support service coordination
  - Follow-up care tracking
  - Family assessment
  - Support plan management
  - Progress monitoring

Key Features:
  - Reunification planning
  - Support service matching
  - Progress tracking
  - Family portal
  - Case worker tools
```

### Supporting Services

#### 6. Identity & Access Management Service
**Purpose**: Centralized authentication, authorization, and user management.

```yaml
Service: identity-service
Port: 3010
Database: PostgreSQL (identity_db)
Technology: Keycloak + Custom Extensions
Dependencies:
  - audit-service
  
Responsibilities:
  - User authentication (all stakeholders)
  - Role-based access control (RBAC)
  - Single sign-on (SSO)
  - Multi-factor authentication (MFA)
  - Session management
  - Security policy enforcement

Key Features:
  - Stakeholder-specific roles
  - Child consent management
  - API key management
  - OAuth2/OIDC support
  - Social login integration
```

#### 7. Notification Service
**Purpose**: Multi-channel communication and notification delivery.

```yaml
Service: notification-service
Port: 3011
Database: MongoDB (notification_db)
Dependencies:
  - identity-service
  - template-service
  
Responsibilities:
  - Email notifications
  - SMS messaging
  - Push notifications
  - In-app messaging
  - Communication preferences
  - Delivery tracking

Key Features:
  - Template management
  - Multi-language support
  - Delivery status tracking
  - Communication preferences
  - Emergency notifications
```

#### 8. Analytics Service
**Purpose**: Data analytics, reporting, and business intelligence.

```yaml
Service: analytics-service
Port: 3012
Database: ClickHouse (analytics_db)
Dependencies:
  - All business services (read-only)
  
Responsibilities:
  - Data aggregation and analysis
  - Report generation
  - Dashboard data preparation
  - Impact measurement
  - Trend analysis
  - Stakeholder-specific analytics

Key Features:
  - Real-time analytics
  - Stakeholder dashboards
  - Impact metrics
  - Predictive analytics
  - Data visualization
```

#### 9. Compliance Service
**Purpose**: Ensures regulatory compliance and audit trail management.

```yaml
Service: compliance-service
Port: 3013
Database: PostgreSQL (compliance_db)
Dependencies:
  - audit-service
  - all business services
  
Responsibilities:
  - GDPR compliance monitoring
  - Child protection law compliance
  - Audit trail management
  - Compliance reporting
  - Risk assessment
  - Policy enforcement

Key Features:
  - Automated compliance checks
  - Violation detection
  - Compliance dashboards
  - Audit report generation
  - Risk scoring
```

#### 10. File Storage Service
**Purpose**: Secure document and media storage with version control.

```yaml
Service: file-storage-service
Port: 3014
Storage: AWS S3 / Azure Blob / GCS
Dependencies:
  - identity-service
  - encryption-service
  
Responsibilities:
  - Secure file upload/download
  - Document version control
  - Media processing
  - Access control enforcement
  - Backup and archival
  - Metadata management

Key Features:
  - End-to-end encryption
  - Version control
  - Access logging
  - Virus scanning
  - Image optimization
```

## 🏗️ Service Design Patterns

### 1. Database per Service
Each microservice owns its data and database schema.

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│ Child Service   │    │ Orphanage Svc   │    │ Volunteer Svc   │
│                 │    │                 │    │                 │
│ ┌─────────────┐ │    │ ┌─────────────┐ │    │ ┌─────────────┐ │
│ │ child_db    │ │    │ │orphanage_db │ │    │ │volunteer_db │ │
│ │(PostgreSQL) │ │    │ │(PostgreSQL) │ │    │ │(PostgreSQL) │ │
│ └─────────────┘ │    │ └─────────────┘ │    │ └─────────────┘ │
└─────────────────┘    └─────────────────┘    └─────────────────┘
```

### 2. API Gateway Pattern
Centralized entry point for all client requests.

```yaml
Kong API Gateway:
  Routes:
    - /api/v1/children/*     → child-management-service
    - /api/v1/orphanages/*   → orphanage-service
    - /api/v1/volunteers/*   → volunteer-service
    - /api/v1/donations/*    → donation-service
    - /api/v1/families/*     → family-service
    
  Plugins:
    - Authentication (JWT)
    - Rate Limiting
    - Request Validation
    - Response Transformation
    - CORS
    - Security Headers
```

### 3. Event-Driven Architecture
Services communicate via events for loose coupling.

```yaml
Event Examples:
  child.created:
    producer: child-management-service
    consumers: [analytics-service, notification-service]
    
  donation.received:
    producer: donation-service
    consumers: [analytics-service, notification-service, orphanage-service]
    
  volunteer.approved:
    producer: volunteer-service
    consumers: [notification-service, analytics-service]
    
  compliance.violation:
    producer: compliance-service
    consumers: [notification-service, audit-service]
```

### 4. Circuit Breaker Pattern
Prevent cascade failures between services.

```typescript
// Example circuit breaker configuration
const circuitBreakerConfig = {
  timeout: 3000,                    // Request timeout
  errorThresholdPercentage: 50,     // Error threshold
  resetTimeout: 30000,              // Reset timeout
  requestVolumeThreshold: 20,       // Minimum requests
  
  fallback: {
    child: () => getCachedChildData(),
    orphanage: () => getBasicOrphanageInfo(),
    volunteer: () => getDefaultVolunteerList()
  }
};
```

### 5. Saga Pattern
Distributed transaction management across services.

```yaml
Child Placement Saga:
  Steps:
    1. Reserve placement (orphanage-service)
    2. Update child status (child-management-service)
    3. Notify stakeholders (notification-service)
    4. Update analytics (analytics-service)
    
  Compensation Actions:
    1. Release placement reservation
    2. Revert child status
    3. Send failure notifications
    4. Log transaction failure
```

## 🔒 Service Security

### Authentication & Authorization
```yaml
Authentication Flow:
  1. Client → Kong Gateway (JWT validation)
  2. Kong → Identity Service (token verification)
  3. Identity Service → Client (user context)
  4. Kong → Target Service (with user context)

Authorization Levels:
  Service Level:
    - Service-to-service authentication (mTLS)
    - API key validation
    - Rate limiting per service
    
  Method Level:
    - Role-based access control (RBAC)
    - Resource-based permissions
    - Child data access controls
    
  Data Level:
    - Field-level encryption
    - Data masking
    - Access logging
```

### Data Protection
```yaml
Encryption Strategy:
  At Rest:
    - Database encryption (TDE)
    - File system encryption
    - Backup encryption
    
  In Transit:
    - TLS 1.3 for all communications
    - mTLS between services
    - Certificate rotation
    
  In Processing:
    - Application-level encryption for PII
    - Secure key management (Vault)
    - Encryption key rotation
```

## 📊 Service Monitoring

### Health Checks
```yaml
Health Check Endpoints:
  Liveness Probe: /health/live
    - Service is running
    - Basic functionality check
    
  Readiness Probe: /health/ready
    - Service can handle requests
    - Database connectivity
    - Dependency availability
    
  Startup Probe: /health/startup
    - Service initialization
    - Warm-up completion
    - Configuration loading
```

### Metrics Collection
```yaml
Service Metrics:
  Business Metrics:
    - child.placements.successful
    - donations.total.amount
    - volunteers.active.count
    - orphanages.capacity.utilization
    
  Technical Metrics:
    - http.requests.total
    - http.request.duration
    - database.connections.active
    - memory.usage.bytes
    
  Security Metrics:
    - auth.failures.total
    - access.violations.count
    - encryption.key.rotations
    - security.scans.results
```

### Distributed Tracing
```yaml
Trace Examples:
  Child Registration Flow:
    - API Gateway → Child Service
    - Child Service → Identity Service
    - Child Service → Audit Service
    - Child Service → Notification Service
    
  Donation Processing Flow:
    - API Gateway → Donation Service
    - Donation Service → Payment Gateway
    - Donation Service → Analytics Service
    - Donation Service → Notification Service
```

## 🔄 Service Communication

### Synchronous Communication
```yaml
REST APIs:
  Standards: OpenAPI 3.0 specification
  Authentication: JWT tokens
  Versioning: URL versioning (/api/v1/, /api/v2/)
  Error Handling: RFC 7807 Problem Details
  
GraphQL APIs:
  Endpoint: /graphql
  Authentication: JWT tokens
  Schema: Federated GraphQL
  Caching: Apollo Federation
```

### Asynchronous Communication
```yaml
Message Patterns:
  Event Publishing:
    Broker: RabbitMQ
    Format: CloudEvents specification
    Delivery: At-least-once delivery
    
  Command Processing:
    Queue: Bull (Redis-based)
    Retry: Exponential backoff
    Dead Letter: Failed message handling
    
  Stream Processing:
    Platform: Apache Kafka
    Partitioning: By entity ID
    Retention: 7 days minimum
```

## 🧪 Service Testing

### Testing Strategy
```yaml
Unit Tests:
  Framework: Jest
  Coverage: >90% for business logic
  Mocking: Service dependencies
  
Integration Tests:
  Framework: Jest + Supertest
  Database: TestContainers
  Coverage: API endpoints
  
Contract Tests:
  Framework: Pact
  Provider: Service implementations
  Consumer: Client applications
  
End-to-End Tests:
  Framework: Playwright
  Environment: Staging
  Scenarios: User journeys
```

### Test Data Management
```yaml
Test Data Strategy:
  Synthetic Data:
    - Generated test datasets
    - No real child data in tests
    - GDPR-compliant test data
    
  Data Masking:
    - Production data anonymization
    - PII removal/replacement
    - Referential integrity maintenance
    
  Environment Isolation:
    - Separate test databases
    - Isolated test environments
    - Clean data state for tests
```

## 🚀 Service Deployment

### Containerization
```dockerfile
# Example Dockerfile for Node.js services
FROM node:18-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production

FROM node:18-alpine AS runtime
RUN addgroup -g 1001 -S nodejs
RUN adduser -S nextjs -u 1001
WORKDIR /app
COPY --from=builder --chown=nextjs:nodejs /app/node_modules ./node_modules
COPY --chown=nextjs:nodejs . .
USER nextjs
EXPOSE 3000
CMD ["npm", "start"]
```

### Kubernetes Deployment
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: child-management-service
spec:
  replicas: 3
  selector:
    matchLabels:
      app: child-management-service
  template:
    metadata:
      labels:
        app: child-management-service
    spec:
      containers:
      - name: child-management
        image: merajutasa/child-management:v1.0.0
        ports:
        - containerPort: 3001
        env:
        - name: DATABASE_URL
          valueFrom:
            secretKeyRef:
              name: child-db-secret
              key: url
        livenessProbe:
          httpGet:
            path: /health/live
            port: 3001
          initialDelaySeconds: 30
          periodSeconds: 10
        readinessProbe:
          httpGet:
            path: /health/ready
            port: 3001
          initialDelaySeconds: 5
          periodSeconds: 5
```

### Service Mesh Configuration
```yaml
# Istio VirtualService
apiVersion: networking.istio.io/v1beta1
kind: VirtualService
metadata:
  name: child-management-vs
spec:
  hosts:
  - child-management-service
  http:
  - match:
    - uri:
        prefix: /api/v1/children
    route:
    - destination:
        host: child-management-service
        port:
          number: 3001
    fault:
      delay:
        percentage:
          value: 0.1
        fixedDelay: 5s
    retries:
      attempts: 3
      perTryTimeout: 2s
```

## 📈 Service Scaling

### Horizontal Pod Autoscaling
```yaml
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: child-management-hpa
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: child-management-service
  minReplicas: 2
  maxReplicas: 10
  metrics:
  - type: Resource
    resource:
      name: cpu
      target:
        type: Utilization
        averageUtilization: 70
  - type: Resource
    resource:
      name: memory
      target:
        type: Utilization
        averageUtilization: 80
```

### Vertical Pod Autoscaling
```yaml
apiVersion: autoscaling.k8s.io/v1
kind: VerticalPodAutoscaler
metadata:
  name: child-management-vpa
spec:
  targetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: child-management-service
  updatePolicy:
    updateMode: "Auto"
  resourcePolicy:
    containerPolicies:
    - containerName: child-management
      maxAllowed:
        cpu: 1
        memory: 2Gi
      minAllowed:
        cpu: 100m
        memory: 128Mi
```

## 🔧 Service Configuration

### Configuration Management
```yaml
Configuration Hierarchy:
  1. Default values (in code)
  2. ConfigMaps (non-sensitive)
  3. Secrets (sensitive data)
  4. Environment variables
  5. Command-line arguments

Example ConfigMap:
apiVersion: v1
kind: ConfigMap
metadata:
  name: child-management-config
data:
  LOG_LEVEL: "info"
  API_VERSION: "v1"
  RATE_LIMIT: "100"
  ENCRYPTION_ALGORITHM: "AES-256-GCM"
```

### Secret Management
```yaml
External Secrets Operator:
  Provider: HashiCorp Vault
  Sync Interval: 15m
  
Example Secret:
apiVersion: external-secrets.io/v1beta1
kind: ExternalSecret
metadata:
  name: child-management-secret
spec:
  refreshInterval: 15m
  secretStoreRef:
    name: vault-secret-store
    kind: SecretStore
  target:
    name: child-management-secret
    creationPolicy: Owner
  data:
  - secretKey: database-url
    remoteRef:
      key: child-management/database
      property: url
```

---

## 📚 Service Documentation

### API Documentation
Each service maintains comprehensive API documentation:
- OpenAPI 3.0 specifications
- Interactive API explorers
- Code examples in multiple languages
- Authentication guides
- Error code references

### Service Dependencies
Service dependency documentation includes:
- Runtime dependencies
- Build-time dependencies
- Infrastructure dependencies
- Service-to-service dependencies
- Third-party integrations

### Operational Runbooks
Each service has operational documentation:
- Deployment procedures
- Troubleshooting guides
- Performance tuning
- Disaster recovery procedures
- Monitoring and alerting

---

**Every service serves our mission: better technology for better child welfare outcomes.**
