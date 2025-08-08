# Development Guide
## MerajutASA Platform Development

Welcome to the MerajutASA Platform development documentation. This guide provides comprehensive information for developers contributing to our child welfare platform, from initial setup to deployment.

## 🎯 Development Philosophy

### Core Principles

#### 1. Child Safety First
- **Privacy by Design**: Every feature must protect child data from the ground up
- **Secure by Default**: Security configurations should be the default, not optional
- **Minimal Data Collection**: Only collect data that is absolutely necessary
- **Transparent Processing**: Clear audit trails for all child data interactions

#### 2. Code Quality Standards
- **Type Safety**: TypeScript for all new code to prevent runtime errors
- **Test Coverage**: Minimum 90% test coverage for business logic
- **Security Scanning**: Automated security vulnerability detection
- **Code Review**: All code changes require peer review

#### 3. Accessibility & Inclusion
- **WCAG 2.1 AA Compliance**: All interfaces must meet accessibility standards
- **Multi-language Support**: Platform designed for internationalization
- **Device Diversity**: Support for various devices and connection speeds
- **User-Centered Design**: Stakeholder-specific interface optimization

#### 4. Performance & Scalability
- **Mobile-First**: Optimize for mobile devices and slow connections
- **Progressive Enhancement**: Features work without JavaScript
- **Lazy Loading**: Load resources only when needed
- **Caching Strategy**: Multi-layer caching for optimal performance

## 🛠️ Technology Stack

### Backend Development
```yaml
Primary Language: TypeScript (Node.js)
Framework: Express.js with TypeScript
Database: PostgreSQL with Prisma ORM
Authentication: JWT with refresh tokens
API Documentation: OpenAPI 3.0 (Swagger)
Testing: Jest + Supertest
Validation: Zod for runtime type checking
Security: Helmet, CORS, rate limiting

Development Tools:
- ESLint + Prettier for code formatting
- Husky for Git hooks
- Conventional Commits for commit messages
- SonarQube for code quality analysis
- Docker for containerization
```

### Frontend Development
```yaml
Web Application:
  Framework: React 18 with TypeScript
  Routing: React Router v6
  State Management: Redux Toolkit + RTK Query
  UI Library: Material-UI (MUI) v5
  Styling: Emotion (CSS-in-JS)
  Testing: Jest + React Testing Library
  Build Tool: Vite
  Accessibility: react-axe for a11y testing

Mobile Applications:
  Framework: React Native with TypeScript
  Navigation: React Navigation v6
  State Management: Redux Toolkit
  UI Components: React Native Elements
  Testing: Jest + Detox (E2E)
  Build Tool: Metro bundler
  Platform: iOS and Android

Shared Libraries:
  Component Library: Storybook documentation
  Design System: Design tokens with Figma
  Utilities: Shared TypeScript utilities
  Icons: Custom icon library
  Internationalization: react-i18next
```

### Infrastructure & DevOps
```yaml
Containerization: Docker + Docker Compose
Orchestration: Kubernetes
Service Mesh: Istio
API Gateway: Kong
Infrastructure as Code: Terraform
Configuration Management: Helm charts
Monitoring: Prometheus + Grafana
Logging: ELK Stack (Elasticsearch, Logstash, Kibana)
Tracing: Jaeger for distributed tracing
CI/CD: GitHub Actions
Cloud Providers: Multi-cloud (AWS, Azure, GCP)
```

## 🚀 Development Environment Setup

### Prerequisites
```bash
# Required Software
Node.js >= 18.0.0
npm >= 8.0.0
Docker >= 20.10.0
Docker Compose >= 2.0.0
Git >= 2.30.0

# Optional but Recommended
Visual Studio Code with extensions:
- TypeScript and JavaScript Language Features
- ESLint
- Prettier
- GitLens
- Docker
- Kubernetes
- Thunder Client (for API testing)
```

### Local Development Setup

#### 1. Repository Setup
```bash
# Clone the repository
git clone https://github.com/MerajutASA/platform.git
cd platform

# Install dependencies for all services
npm run install:all

# Copy environment configuration
cp .env.example .env.local

# Set up Git hooks
npm run setup:hooks
```

#### 2. Database Setup
```bash
# Start PostgreSQL with Docker
docker-compose up -d postgres

# Run database migrations
npm run db:migrate

# Seed development data
npm run db:seed

# Optional: Set up test database
npm run db:setup:test
```

#### 3. Environment Configuration
```bash
# .env.local configuration
DATABASE_URL="postgresql://merajutasa:dev_password@localhost:5432/merajutasa_dev"
REDIS_URL="redis://localhost:6379"
JWT_SECRET="your-super-secret-jwt-key-for-development"
ENCRYPTION_KEY="your-32-character-encryption-key"

# Child protection settings
CHILD_DATA_ENCRYPTION_ENABLED=true
AUDIT_LOG_ENABLED=true
GDPR_COMPLIANCE_MODE=true

# External services (development)
EMAIL_SERVICE_API_KEY="test-key"
SMS_SERVICE_API_KEY="test-key"
PAYMENT_GATEWAY_API_KEY="test-key"
```

#### 4. Development Services
```bash
# Start all services in development mode
npm run dev

# Or start services individually
npm run dev:backend      # Backend API services
npm run dev:frontend     # Web application
npm run dev:mobile       # Mobile development server
npm run dev:docs         # Documentation site

# Background services
npm run dev:workers      # Background job processors
npm run dev:analytics    # Analytics service
npm run dev:notifications # Notification service
```

### Development Workflow

#### Branch Strategy
```
Main Branches:
- main: Production-ready code
- develop: Integration branch for features
- staging: Pre-production testing

Feature Branches:
- feature/child-profile-encryption
- feature/volunteer-matching-algorithm
- bugfix/donation-processing-error
- hotfix/security-vulnerability-fix

Release Branches:
- release/v1.2.0
- release/v1.3.0-beta
```

#### Commit Convention
```bash
# Conventional Commits format
<type>[optional scope]: <description>

# Examples
feat(child-mgmt): add encrypted profile storage
fix(auth): resolve JWT token expiration issue
docs(api): update authentication endpoints
test(volunteer): add unit tests for matching service
security(data): implement additional PII encryption
```

#### Code Review Process
```yaml
Review Requirements:
- At least 2 reviewers for production code
- Security review for authentication/authorization changes
- Accessibility review for UI changes
- Performance review for database changes

Review Checklist:
- Code follows style guidelines
- Tests cover new functionality
- Documentation is updated
- Security considerations addressed
- Performance impact evaluated
- Accessibility requirements met
```

## 🧪 Testing Strategy

### Testing Pyramid

#### Unit Tests (70% of tests)
```typescript
// Example unit test for child data encryption
describe('ChildDataEncryption', () => {
  describe('encryptPersonalInfo', () => {
    it('should encrypt child PII data', async () => {
      const childData = {
        name: 'Test Child',
        dateOfBirth: '2010-01-01',
        medicalInfo: 'No known allergies'
      };

      const encrypted = await encryptPersonalInfo(childData);
      
      expect(encrypted.encryptedData).toBeDefined();
      expect(encrypted.encryptionKeyId).toBeDefined();
      expect(encrypted.dataClassification).toBe('CONFIDENTIAL');
    });

    it('should not store unencrypted PII', async () => {
      const childData = { name: 'Test Child' };
      const encrypted = await encryptPersonalInfo(childData);
      
      expect(encrypted.encryptedData).not.toContain('Test Child');
    });
  });
});
```

#### Integration Tests (20% of tests)
```typescript
// Example integration test for API endpoints
describe('Child Management API', () => {
  beforeEach(async () => {
    await setupTestDatabase();
    await createTestUser();
  });

  describe('POST /api/v1/children', () => {
    it('should create child profile with proper encryption', async () => {
      const response = await request(app)
        .post('/api/v1/children')
        .set('Authorization', `Bearer ${testToken}`)
        .send({
          name: 'Test Child',
          dateOfBirth: '2010-01-01',
          guardianConsent: true
        })
        .expect(201);

      expect(response.body.id).toBeDefined();
      expect(response.body.encryptedData).toBeDefined();
      expect(response.body.name).toBeUndefined(); // No plaintext PII
    });
  });
});
```

#### End-to-End Tests (10% of tests)
```typescript
// Example E2E test for critical user journeys
describe('Child Registration Flow', () => {
  it('should complete full child registration with proper safeguards', async () => {
    // Navigate to registration page
    await page.goto('/children/register');
    
    // Fill required information
    await page.fill('[data-testid="child-name"]', 'Test Child');
    await page.fill('[data-testid="date-of-birth"]', '01/01/2010');
    
    // Verify consent requirements
    await expect(page.locator('[data-testid="guardian-consent"]')).toBeVisible();
    await page.check('[data-testid="guardian-consent"]');
    
    // Submit and verify encryption
    await page.click('[data-testid="submit-button"]');
    await expect(page.locator('[data-testid="success-message"]')).toBeVisible();
    
    // Verify data was encrypted (API call)
    const response = await page.evaluate(() => fetch('/api/v1/audit/last-action'));
    const audit = await response.json();
    expect(audit.dataEncrypted).toBe(true);
  });
});
```

### Test Data Management
```yaml
Test Data Strategy:
  Synthetic Data:
    - Generated realistic but fake data
    - No real child information ever used
    - Automated data generation scripts
    - Consistent test scenarios

  Data Factories:
    - User factory (different stakeholder types)
    - Child factory (age-appropriate test data)
    - Orphanage factory (various capacity/location)
    - Volunteer factory (different skill sets)

  Database Seeding:
    - Minimal seed data for development
    - Comprehensive seed data for testing
    - Performance test data sets
    - Security test scenarios

  Data Cleanup:
    - Automatic cleanup after tests
    - Isolated test environments
    - No cross-contamination between tests
    - Secure disposal of test data
```

## 🔒 Security Development

### Security Requirements

#### Authentication & Authorization
```typescript
// Example secure authentication implementation
export class AuthenticationService {
  async authenticateUser(credentials: LoginCredentials): Promise<AuthResult> {
    // Rate limiting
    await this.checkRateLimit(credentials.email);
    
    // Secure password verification
    const user = await this.findUserByEmail(credentials.email);
    if (!user || !await this.verifyPassword(credentials.password, user.hashedPassword)) {
      // Log failed attempt
      await this.auditService.logFailedLogin(credentials.email);
      throw new UnauthorizedError('Invalid credentials');
    }
    
    // Multi-factor authentication
    if (user.mfaEnabled) {
      await this.verifyMFA(credentials.mfaToken, user.mfaSecret);
    }
    
    // Generate secure tokens
    const tokens = await this.generateTokens(user);
    
    // Log successful authentication
    await this.auditService.logSuccessfulLogin(user.id);
    
    return { user: this.sanitizeUser(user), tokens };
  }
}
```

#### Data Protection
```typescript
// Example data encryption implementation
export class DataEncryptionService {
  async encryptChildData(data: ChildPersonalInfo): Promise<EncryptedData> {
    // Generate unique encryption key for this record
    const dataKey = await this.generateDataEncryptionKey();
    
    // Encrypt the data
    const encryptedData = await this.encrypt(JSON.stringify(data), dataKey);
    
    // Encrypt the data key with master key
    const encryptedDataKey = await this.encryptDataKey(dataKey);
    
    // Store with metadata
    return {
      encryptedData,
      encryptedDataKey,
      algorithm: 'AES-256-GCM',
      keyVersion: await this.getCurrentKeyVersion(),
      dataClassification: 'CONFIDENTIAL',
      createdAt: new Date(),
      accessRequirements: ['GUARDIAN_CONSENT', 'LEGITIMATE_INTEREST']
    };
  }
}
```

#### Input Validation
```typescript
// Example input validation with Zod
import { z } from 'zod';

export const ChildRegistrationSchema = z.object({
  personalInfo: z.object({
    name: z.string()
      .min(1, 'Name is required')
      .max(100, 'Name too long')
      .regex(/^[a-zA-Z\s]+$/, 'Name contains invalid characters'),
    
    dateOfBirth: z.string()
      .datetime()
      .refine(date => {
        const age = new Date().getFullYear() - new Date(date).getFullYear();
        return age >= 0 && age <= 18;
      }, 'Invalid age for child registration'),
    
    medicalInfo: z.string()
      .max(1000, 'Medical information too long')
      .optional()
  }),
  
  guardianConsent: z.boolean()
    .refine(consent => consent === true, 'Guardian consent is required'),
  
  dataProcessingConsent: z.object({
    essential: z.literal(true),
    analytics: z.boolean().default(false),
    marketing: z.boolean().default(false)
  })
});
```

### Security Testing
```yaml
Security Test Categories:
  Authentication Tests:
    - Password strength validation
    - Multi-factor authentication
    - Session management
    - Token security

  Authorization Tests:
    - Role-based access control
    - Resource-level permissions
    - Privilege escalation prevention
    - Cross-user data access

  Data Protection Tests:
    - Encryption at rest
    - Encryption in transit
    - Key management
    - Data masking

  Input Validation Tests:
    - SQL injection prevention
    - XSS protection
    - CSRF protection
    - Input sanitization

  Infrastructure Security:
    - Container security scanning
    - Dependency vulnerability scanning
    - Network security testing
    - Configuration validation
```

## 📱 Frontend Development

### Component Architecture

#### Design System
```typescript
// Example component following design system
import { styled } from '@mui/material/styles';
import { Button, ButtonProps } from '@mui/material';

interface ChildSafeButtonProps extends ButtonProps {
  confirmationRequired?: boolean;
  dataCategory?: 'public' | 'internal' | 'confidential';
  auditAction?: string;
}

const StyledChildSafeButton = styled(Button)<ChildSafeButtonProps>(
  ({ theme, dataCategory }) => ({
    // Visual indicators for data sensitivity
    borderLeft: dataCategory === 'confidential' 
      ? `4px solid ${theme.palette.error.main}`
      : dataCategory === 'internal'
      ? `4px solid ${theme.palette.warning.main}`
      : 'none',
    
    // Accessibility enhancements
    '&:focus': {
      outline: `2px solid ${theme.palette.primary.main}`,
      outlineOffset: '2px'
    }
  })
);

export const ChildSafeButton: React.FC<ChildSafeButtonProps> = ({
  children,
  confirmationRequired,
  dataCategory = 'public',
  auditAction,
  onClick,
  ...props
}) => {
  const handleClick = async (event: React.MouseEvent) => {
    // Confirmation for sensitive actions
    if (confirmationRequired) {
      const confirmed = await showConfirmationDialog({
        title: 'Confirm Action',
        message: 'This action involves child data. Are you sure?',
        dataCategory
      });
      
      if (!confirmed) return;
    }
    
    // Audit logging
    if (auditAction) {
      await auditService.logAction({
        action: auditAction,
        component: 'ChildSafeButton',
        dataCategory,
        timestamp: new Date()
      });
    }
    
    onClick?.(event);
  };
  
  return (
    <StyledChildSafeButton
      {...props}
      dataCategory={dataCategory}
      onClick={handleClick}
      aria-label={`${children} ${dataCategory !== 'public' ? `(${dataCategory} data)` : ''}`}
    >
      {children}
    </StyledChildSafeButton>
  );
};
```

#### State Management
```typescript
// Example Redux slice for child management
import { createSlice, createAsyncThunk } from '@reduxjs/toolkit';

interface ChildState {
  children: EncryptedChildRecord[];
  selectedChild: string | null;
  loading: boolean;
  error: string | null;
  filters: ChildFilters;
  permissions: ChildPermissions;
}

export const fetchChildren = createAsyncThunk(
  'children/fetchChildren',
  async (filters: ChildFilters, { rejectWithValue }) => {
    try {
      // Security check: verify permissions
      const permissions = await authService.checkPermissions('child:read');
      if (!permissions.granted) {
        throw new Error('Insufficient permissions');
      }
      
      // Audit log
      await auditService.logDataAccess({
        action: 'children:fetch',
        filters: sanitizeFilters(filters),
        userId: permissions.userId
      });
      
      // Fetch encrypted data
      const response = await childService.fetchChildren(filters);
      return response.data;
    } catch (error) {
      return rejectWithValue(error.message);
    }
  }
);

const childSlice = createSlice({
  name: 'children',
  initialState,
  reducers: {
    setSelectedChild: (state, action) => {
      state.selectedChild = action.payload;
      // Log selection for audit
      auditService.logSelection({
        childId: action.payload,
        timestamp: new Date()
      });
    },
    
    clearSensitiveData: (state) => {
      // Clear sensitive data when user session ends
      state.children = [];
      state.selectedChild = null;
    }
  },
  
  extraReducers: (builder) => {
    builder
      .addCase(fetchChildren.pending, (state) => {
        state.loading = true;
        state.error = null;
      })
      .addCase(fetchChildren.fulfilled, (state, action) => {
        state.loading = false;
        state.children = action.payload;
      })
      .addCase(fetchChildren.rejected, (state, action) => {
        state.loading = false;
        state.error = action.payload as string;
        // Log error for monitoring
        errorService.logError({
          component: 'childSlice',
          action: 'fetchChildren',
          error: action.payload
        });
      });
  }
});
```

### Accessibility Implementation
```typescript
// Example accessible form component
export const AccessibleChildForm: React.FC<ChildFormProps> = ({ onSubmit }) => {
  const [formData, setFormData] = useState<ChildFormData>({});
  const [errors, setErrors] = useState<FormErrors>({});
  const [announcements, setAnnouncements] = useState<string[]>([]);

  // Screen reader announcements
  const announce = (message: string) => {
    setAnnouncements(prev => [...prev, message]);
    setTimeout(() => {
      setAnnouncements(prev => prev.slice(1));
    }, 1000);
  };

  const handleSubmit = async (event: React.FormEvent) => {
    event.preventDefault();
    
    // Validate form
    const validationResult = await validateChildForm(formData);
    if (!validationResult.valid) {
      setErrors(validationResult.errors);
      announce(`Form has ${Object.keys(validationResult.errors).length} errors`);
      
      // Focus first error field
      const firstErrorField = document.querySelector('[data-error="true"]');
      (firstErrorField as HTMLElement)?.focus();
      return;
    }
    
    announce('Submitting child information...');
    await onSubmit(formData);
    announce('Child information submitted successfully');
  };

  return (
    <form onSubmit={handleSubmit} noValidate>
      {/* Screen reader announcements */}
      <div aria-live="polite" aria-atomic="true" className="sr-only">
        {announcements.map((message, index) => (
          <div key={index}>{message}</div>
        ))}
      </div>
      
      {/* Form fields with proper labeling */}
      <TextField
        label="Child's Name"
        value={formData.name || ''}
        onChange={(e) => setFormData(prev => ({ ...prev, name: e.target.value }))}
        error={!!errors.name}
        helperText={errors.name}
        required
        aria-describedby={errors.name ? 'name-error' : undefined}
        data-error={!!errors.name}
        inputProps={{
          'aria-label': 'Child\'s full name',
          maxLength: 100
        }}
      />
      
      {/* Submit button with loading state */}
      <Button
        type="submit"
        disabled={loading}
        aria-describedby="submit-description"
      >
        {loading ? 'Submitting...' : 'Submit Child Information'}
      </Button>
      
      <div id="submit-description" className="sr-only">
        This will securely store the child's information with encryption
      </div>
    </form>
  );
};
```

## 🏗️ Backend Development

### API Design Principles

#### RESTful API Structure
```typescript
// Example controller with security and validation
export class ChildController {
  constructor(
    private childService: ChildService,
    private auditService: AuditService,
    private authService: AuthService
  ) {}
  
  @Route('POST', '/api/v1/children')
  @Middleware([authenticate, authorize('child:create'), rateLimit, validateInput])
  async createChild(req: AuthenticatedRequest, res: Response): Promise<void> {
    try {
      // Validate input
      const validatedData = ChildRegistrationSchema.parse(req.body);
      
      // Check permissions
      const permissions = await this.authService.checkChildPermissions(
        req.user.id,
        'create',
        validatedData
      );
      
      if (!permissions.granted) {
        await this.auditService.logUnauthorizedAccess({
          userId: req.user.id,
          action: 'child:create',
          reason: permissions.reason
        });
        
        res.status(403).json({
          error: 'Insufficient permissions',
          code: 'PERMISSION_DENIED'
        });
        return;
      }
      
      // Create child record
      const child = await this.childService.createChild(validatedData, req.user);
      
      // Audit log
      await this.auditService.logChildCreation({
        childId: child.id,
        createdBy: req.user.id,
        dataClassification: 'CONFIDENTIAL',
        timestamp: new Date()
      });
      
      // Return sanitized response (no PII)
      res.status(201).json({
        id: child.id,
        status: 'created',
        encryptionStatus: 'encrypted',
        createdAt: child.createdAt
      });
      
    } catch (error) {
      if (error instanceof ZodError) {
        res.status(400).json({
          error: 'Invalid input data',
          details: error.issues
        });
        return;
      }
      
      // Log error and return generic response
      await this.auditService.logError({
        action: 'child:create',
        error: error.message,
        userId: req.user.id
      });
      
      res.status(500).json({
        error: 'Internal server error',
        code: 'INTERNAL_ERROR'
      });
    }
  }
}
```

#### Database Patterns
```typescript
// Example repository pattern with encryption
export class ChildRepository {
  constructor(
    private db: PrismaClient,
    private encryptionService: EncryptionService,
    private auditService: AuditService
  ) {}
  
  async create(data: ChildCreateData): Promise<ChildRecord> {
    return await this.db.$transaction(async (tx) => {
      // Encrypt sensitive data
      const encryptedPersonalInfo = await this.encryptionService.encryptChildData({
        name: data.name,
        dateOfBirth: data.dateOfBirth,
        medicalInfo: data.medicalInfo
      });
      
      // Create main record
      const child = await tx.child.create({
        data: {
          id: generateUuid(),
          encryptedPersonalInfo: encryptedPersonalInfo.encryptedData,
          encryptionKeyId: encryptedPersonalInfo.keyId,
          dataClassification: 'CONFIDENTIAL',
          guardianConsentAt: data.guardianConsentAt,
          createdAt: new Date(),
          updatedAt: new Date()
        }
      });
      
      // Create audit record
      await tx.auditLog.create({
        data: {
          entityType: 'CHILD',
          entityId: child.id,
          action: 'CREATE',
          userId: data.createdBy,
          dataAccessed: ['personalInfo'],
          timestamp: new Date()
        }
      });
      
      return child;
    });
  }
  
  async findById(id: string, userId: string): Promise<ChildRecord | null> {
    // Check access permissions
    const hasAccess = await this.checkDataAccess(id, userId);
    if (!hasAccess) {
      throw new ForbiddenError('No access to this child record');
    }
    
    // Fetch encrypted record
    const child = await this.db.child.findUnique({
      where: { id },
      include: {
        placements: true,
        caseHistory: true
      }
    });
    
    if (!child) return null;
    
    // Log data access
    await this.auditService.logDataAccess({
      entityType: 'CHILD',
      entityId: id,
      userId,
      fieldsAccessed: ['id', 'placements', 'caseHistory'],
      timestamp: new Date()
    });
    
    return child;
  }
  
  private async checkDataAccess(childId: string, userId: string): Promise<boolean> {
    // Implement role-based access control
    const userRoles = await this.getUserRoles(userId);
    const childPermissions = await this.getChildPermissions(childId);
    
    return this.evaluateAccess(userRoles, childPermissions);
  }
}
```

### Error Handling
```typescript
// Centralized error handling middleware
export const errorHandler = (
  error: Error,
  req: Request,
  res: Response,
  next: NextFunction
): void => {
  // Log error details
  logger.error('Request error:', {
    error: error.message,
    stack: error.stack,
    url: req.url,
    method: req.method,
    userId: req.user?.id,
    timestamp: new Date().toISOString()
  });
  
  // Child safety priority errors
  if (error instanceof ChildSafetyError) {
    // Immediate notification to safety team
    notificationService.sendUrgentAlert({
      type: 'CHILD_SAFETY',
      message: error.message,
      context: {
        userId: req.user?.id,
        url: req.url,
        timestamp: new Date()
      }
    });
    
    res.status(200).json({
      error: 'Request processed',
      message: 'Thank you for your concern. Appropriate authorities have been notified.'
    });
    return;
  }
  
  // Security-related errors
  if (error instanceof SecurityError) {
    // Log security incident
    auditService.logSecurityIncident({
      type: error.type,
      severity: error.severity,
      userId: req.user?.id,
      ip: req.ip,
      userAgent: req.get('User-Agent'),
      timestamp: new Date()
    });
    
    res.status(403).json({
      error: 'Access denied',
      code: 'SECURITY_VIOLATION'
    });
    return;
  }
  
  // Validation errors
  if (error instanceof ValidationError) {
    res.status(400).json({
      error: 'Invalid request data',
      details: error.details,
      code: 'VALIDATION_ERROR'
    });
    return;
  }
  
  // Generic error response (no sensitive info)
  res.status(500).json({
    error: 'Internal server error',
    code: 'INTERNAL_ERROR',
    timestamp: new Date().toISOString()
  });
};
```

## 📊 Performance Optimization

### Database Optimization
```sql
-- Example optimized queries with proper indexing
-- Index for child searches with privacy considerations
CREATE INDEX CONCURRENTLY idx_child_search_encrypted 
ON children (orphanage_id, status, created_at) 
WHERE deleted_at IS NULL;

-- Partial index for active volunteers
CREATE INDEX CONCURRENTLY idx_volunteers_active 
ON volunteers (skill_tags, availability, location) 
WHERE status = 'ACTIVE' AND background_check_status = 'APPROVED';

-- Composite index for donation analytics
CREATE INDEX CONCURRENTLY idx_donations_analytics 
ON donations (created_at, amount, donation_type, orphanage_id) 
WHERE status = 'COMPLETED';
```

### Caching Strategy
```typescript
// Example multi-layer caching implementation
export class CacheService {
  constructor(
    private redis: Redis,
    private memoryCache: NodeCache
  ) {}
  
  async get<T>(key: string, dataClassification: DataClassification): Promise<T | null> {
    // L1: Memory cache (for non-sensitive data only)
    if (dataClassification === 'PUBLIC') {
      const memoryCached = this.memoryCache.get<T>(key);
      if (memoryCached) return memoryCached;
    }
    
    // L2: Redis cache (encrypted for sensitive data)
    const redisCached = await this.redis.get(key);
    if (redisCached) {
      const parsed = JSON.parse(redisCached);
      
      // Decrypt if sensitive data
      if (parsed.encrypted) {
        const decrypted = await this.encryptionService.decrypt(parsed.data);
        return JSON.parse(decrypted);
      }
      
      // Store in memory cache for public data
      if (dataClassification === 'PUBLIC') {
        this.memoryCache.set(key, parsed, 300); // 5 minutes
      }
      
      return parsed;
    }
    
    return null;
  }
  
  async set<T>(
    key: string, 
    value: T, 
    ttl: number,
    dataClassification: DataClassification
  ): Promise<void> {
    let dataToCache = value;
    let cacheEntry: any = value;
    
    // Encrypt sensitive data
    if (dataClassification !== 'PUBLIC') {
      const encrypted = await this.encryptionService.encrypt(JSON.stringify(value));
      cacheEntry = { encrypted: true, data: encrypted };
    }
    
    // Store in Redis
    await this.redis.setex(key, ttl, JSON.stringify(cacheEntry));
    
    // Store in memory cache for public data only
    if (dataClassification === 'PUBLIC') {
      this.memoryCache.set(key, value, ttl);
    }
  }
}
```

## 📚 Documentation Standards

### Code Documentation
```typescript
/**
 * Encrypts child personal information for secure storage.
 * 
 * This function implements our privacy-by-design approach for child data protection.
 * All personally identifiable information (PII) is encrypted using AES-256-GCM
 * with unique data encryption keys (DEKs) that are themselves encrypted with
 * our master key encryption key (KEK).
 * 
 * @param data - Child personal information to encrypt
 * @param data.name - Child's full name (required)
 * @param data.dateOfBirth - Child's birth date in ISO format (required)
 * @param data.medicalInfo - Medical information (optional)
 * @param data.emergencyContact - Emergency contact details (optional)
 * 
 * @returns Promise resolving to encrypted data package
 * @returns encryptedData - Base64 encoded encrypted payload
 * @returns keyId - Reference to the encryption key used
 * @returns algorithm - Encryption algorithm identifier
 * @returns dataClassification - Data sensitivity classification
 * 
 * @throws {ValidationError} When required fields are missing
 * @throws {EncryptionError} When encryption process fails
 * 
 * @example
 * ```typescript
 * const childData = {
 *   name: "Anna Smith",
 *   dateOfBirth: "2010-05-15T00:00:00.000Z",
 *   medicalInfo: "No known allergies"
 * };
 * 
 * const encrypted = await encryptChildPersonalInfo(childData);
 * console.log(encrypted.dataClassification); // "CONFIDENTIAL"
 * ```
 * 
 * @security
 * - Uses AES-256-GCM for authenticated encryption
 * - Unique DEK per record prevents cross-record attacks
 * - Key rotation supported through keyId versioning
 * - Complies with GDPR encryption requirements
 * 
 * @audit
 * This function automatically logs encryption events to the audit trail
 * including key usage, data classification, and processing timestamps.
 */
export async function encryptChildPersonalInfo(
  data: ChildPersonalInfo
): Promise<EncryptedChildData> {
  // Implementation...
}
```

### API Documentation
```yaml
# OpenAPI specification example
paths:
  /api/v1/children:
    post:
      summary: Create new child record
      description: |
        Creates a new child record with encrypted personal information.
        
        **Security Notice**: This endpoint handles sensitive child data and requires
        elevated permissions. All personal information is encrypted at rest and
        access is logged for audit purposes.
        
        **Child Safety**: Creating a child record triggers our child protection
        protocols including consent verification and guardian notification.
        
      security:
        - BearerAuth: []
        - Permissions: ['child:create']
        
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/ChildCreateRequest'
            examples:
              basic_registration:
                summary: Basic child registration
                value:
                  personalInfo:
                    name: "Anna Smith"
                    dateOfBirth: "2010-05-15T00:00:00.000Z"
                  guardianConsent: true
                  dataProcessingConsent:
                    essential: true
                    analytics: false
                    
      responses:
        '201':
          description: Child record created successfully
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ChildCreateResponse'
                
        '400':
          description: Invalid request data
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/ValidationError'
                
        '403':
          description: Insufficient permissions
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/PermissionError'
                
      x-audit-requirements:
        - Log all access attempts
        - Record data classification levels
        - Track consent status changes
        
      x-child-safety:
        - Requires guardian consent verification
        - Triggers safety protocol activation
        - Enables automatic monitoring
```

## 🚀 Deployment & DevOps

### Container Configuration
```dockerfile
# Multi-stage production Dockerfile
FROM node:18-alpine AS dependencies
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production && npm cache clean --force

FROM node:18-alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build
RUN npm run test:ci

FROM node:18-alpine AS runtime
# Security: Create non-root user
RUN addgroup -g 1001 -S nodejs && \
    adduser -S nodeuser -u 1001

# Security: Install security updates
RUN apk upgrade --no-cache && \
    apk add --no-cache dumb-init

WORKDIR /app

# Copy built application
COPY --from=dependencies --chown=nodeuser:nodejs /app/node_modules ./node_modules
COPY --from=build --chown=nodeuser:nodejs /app/dist ./dist
COPY --from=build --chown=nodeuser:nodejs /app/package*.json ./

# Security: Switch to non-root user
USER nodeuser

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD node healthcheck.js

# Use dumb-init for proper signal handling
ENTRYPOINT ["dumb-init", "--"]
CMD ["node", "dist/server.js"]

EXPOSE 3000
```

### CI/CD Pipeline
```yaml
# GitHub Actions workflow for child-management service
name: Child Management Service CI/CD

on:
  push:
    branches: [main, develop]
    paths: ['backend/child-management/**']
  pull_request:
    branches: [main]
    paths: ['backend/child-management/**']

env:
  SERVICE_NAME: child-management
  REGISTRY: ghcr.io
  IMAGE_NAME: merajutasa/child-management

jobs:
  security-scan:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      
      - name: Run Trivy vulnerability scanner
        uses: aquasecurity/trivy-action@master
        with:
          scan-type: 'fs'
          scan-ref: 'backend/child-management'
          format: 'sarif'
          output: 'trivy-results.sarif'
          
      - name: Upload Trivy scan results
        uses: github/codeql-action/upload-sarif@v2
        with:
          sarif_file: 'trivy-results.sarif'

  test:
    runs-on: ubuntu-latest
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
    
    steps:
      - uses: actions/checkout@v4
      
      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: '18'
          cache: 'npm'
          cache-dependency-path: backend/child-management/package-lock.json
          
      - name: Install dependencies
        working-directory: backend/child-management
        run: npm ci
        
      - name: Run linting
        working-directory: backend/child-management
        run: npm run lint
        
      - name: Run type checking
        working-directory: backend/child-management
        run: npm run type-check
        
      - name: Run unit tests
        working-directory: backend/child-management
        run: npm run test:unit
        env:
          DATABASE_URL: postgresql://postgres:test_password@localhost:5432/test_db
          
      - name: Run integration tests
        working-directory: backend/child-management
        run: npm run test:integration
        env:
          DATABASE_URL: postgresql://postgres:test_password@localhost:5432/test_db
          
      - name: Check test coverage
        working-directory: backend/child-management
        run: npm run test:coverage
        
      - name: Upload coverage reports
        uses: codecov/codecov-action@v3
        with:
          file: backend/child-management/coverage/lcov.info
          flags: child-management

  build:
    needs: [security-scan, test]
    runs-on: ubuntu-latest
    outputs:
      image-digest: ${{ steps.build.outputs.digest }}
      
    steps:
      - uses: actions/checkout@v4
      
      - name: Set up Docker Buildx
        uses: docker/setup-buildx-action@v3
        
      - name: Log in to Container Registry
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
            type=sha,prefix={{branch}}-
            type=raw,value=latest,enable={{is_default_branch}}
            
      - name: Build and push Docker image
        id: build
        uses: docker/build-push-action@v5
        with:
          context: backend/child-management
          platforms: linux/amd64,linux/arm64
          push: true
          tags: ${{ steps.meta.outputs.tags }}
          labels: ${{ steps.meta.outputs.labels }}
          cache-from: type=gha
          cache-to: type=gha,mode=max

  deploy-staging:
    if: github.ref == 'refs/heads/develop'
    needs: build
    runs-on: ubuntu-latest
    environment: staging
    
    steps:
      - uses: actions/checkout@v4
      
      - name: Configure kubectl
        uses: azure/k8s-set-context@v3
        with:
          method: kubeconfig
          kubeconfig: ${{ secrets.KUBE_CONFIG }}
          
      - name: Deploy to staging
        run: |
          # Update deployment with new image
          kubectl set image deployment/${{ env.SERVICE_NAME }} \
            ${{ env.SERVICE_NAME }}=${{ env.REGISTRY }}/${{ env.IMAGE_NAME }}:develop-${{ github.sha }} \
            -n staging
            
          # Wait for rollout
          kubectl rollout status deployment/${{ env.SERVICE_NAME }} -n staging
          
          # Run smoke tests
          kubectl run smoke-test-${{ github.run_id }} \
            --image=${{ env.REGISTRY }}/${{ env.IMAGE_NAME }}:develop-${{ github.sha }} \
            --restart=Never \
            --rm -i \
            -n staging \
            -- npm run test:smoke

  deploy-production:
    if: github.ref == 'refs/heads/main'
    needs: build
    runs-on: ubuntu-latest
    environment: production
    
    steps:
      - uses: actions/checkout@v4
      
      - name: Configure kubectl
        uses: azure/k8s-set-context@v3
        with:
          method: kubeconfig
          kubeconfig: ${{ secrets.PROD_KUBE_CONFIG }}
          
      - name: Deploy to production
        run: |
          # Blue-green deployment strategy
          kubectl apply -f k8s/production/ -n production
          
          # Update deployment with new image
          kubectl set image deployment/${{ env.SERVICE_NAME }} \
            ${{ env.SERVICE_NAME }}=${{ env.REGISTRY }}/${{ env.IMAGE_NAME }}:main-${{ github.sha }} \
            -n production
            
          # Wait for rollout
          kubectl rollout status deployment/${{ env.SERVICE_NAME }} -n production
          
          # Health check
          kubectl run health-check-${{ github.run_id }} \
            --image=curlimages/curl \
            --restart=Never \
            --rm -i \
            -n production \
            -- curl -f http://${{ env.SERVICE_NAME }}:3000/health
```

---

## 📞 Developer Support

### Getting Help
- **Technical Questions**: dev-support@merajutasa.id
- **Security Issues**: security@merajutasa.id  
- **Code Review Help**: code-review@merajutasa.id
- **Architecture Decisions**: architecture@merajutasa.id

### Development Resources
- **[API Documentation](../API_CATALOG.md)** - Complete API reference
- **[Architecture Guide](../architecture/README.md)** - System design documentation
- **[Security Guidelines](../security/README.md)** - Security best practices
- **[Deployment Guide](../operations/deployment/README.md)** - Deployment procedures

### Community
- **[GitHub Discussions](https://github.com/MerajutASA/platform/discussions)** - Community Q&A
- **[Developer Slack](https://merajutasa-dev.slack.com)** - Real-time communication
- **[Monthly Dev Meetups](events/dev-meetups.md)** - Regular developer gatherings
- **[Code Review Board](code-review/README.md)** - Collaborative code improvement

---

**Code with purpose. Every line serves our mission: better technology for better child welfare outcomes.**
