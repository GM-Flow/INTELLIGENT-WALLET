# Intelligent Wallet Backend API

Secure, production-ready authentication API for the Intelligent Wallet application - AI-Based Inflation Tracking and Fraud Prevention.

## Features

### Authentication & Security
- ✅ **User Registration** with email/username and strong password validation
- ✅ **Secure Password Hashing** using Argon2 (with bcrypt fallback)
- ✅ **JWT-based Authentication** with access and refresh tokens
- ✅ **Token Blacklisting** for secure logout
- ✅ **Account Lockout** after failed login attempts
- ✅ **Refresh Token Rotation** for enhanced security
- ✅ **Password Strength Validation** following industry best practices
- ✅ **CORS Support** for Flutter frontend

### Database
- ✅ **PostgreSQL** with SQLAlchemy ORM
- ✅ **Alembic Migrations** for schema management
- ✅ **Optimized Indexes** for performance
- ✅ **Cascade Deletes** for data integrity

### API Features
- ✅ **RESTful API** with FastAPI
- ✅ **OpenAPI Documentation** (Swagger UI)
- ✅ **Comprehensive Error Handling**
- ✅ **Request Validation** with Pydantic
- ✅ **Type Safety** throughout the codebase

## Tech Stack

- **FastAPI** - Modern, fast web framework
- **PostgreSQL** - Relational database
- **SQLAlchemy** - ORM and database toolkit
- **Alembic** - Database migration tool
- **JWT** (python-jose) - Token-based authentication
- **Argon2/Bcrypt** (passlib) - Password hashing
- **Pydantic** - Data validation

## Prerequisites

- Python 3.9+ (tested with Python 3.12)
- PostgreSQL 12+
- pip (Python package manager)

## Installation

### 1. Clone the Repository

```bash
cd intelligent_wallet_backend
```

### 2. Create Virtual Environment

```bash
# Windows
python -m venv venv
venv\Scripts\activate

# Linux/Mac
python3 -m venv venv
source venv/bin/activate
```

### 3. Install Dependencies

```bash
pip install -r requirements.txt
```

### 4. Set Up PostgreSQL Database

Create a PostgreSQL database:

```sql
CREATE DATABASE intelligent_wallet;
```

Or using psql command line:

```bash
createdb intelligent_wallet
```

### 5. Configure Environment Variables

Create a `.env` file in the `intelligent_wallet_backend` directory:

```env
# Database Configuration
DATABASE_URL=postgresql://username:password@localhost:5432/intelligent_wallet

# Environment
ENV=development

# JWT Configuration
# Generate a strong secret key: python -c "import secrets; print(secrets.token_urlsafe(32))"
JWT_SECRET_KEY=your-super-secret-jwt-key-change-in-production
ACCESS_TOKEN_EXPIRE_MINUTES=30
REFRESH_TOKEN_EXPIRE_DAYS=7

# Security Settings
MAX_LOGIN_ATTEMPTS=5
ACCOUNT_LOCKOUT_MINUTES=30

# CORS Configuration
# For Flutter web: http://localhost:8080,http://localhost:3000
# For production: https://yourdomain.com
# Use * for development only
CORS_ORIGINS=*
```

**⚠️ Important:** Generate a strong JWT secret key for production:

```bash
python -c "import secrets; print(secrets.token_urlsafe(32))"
```

### 6. Run Database Migrations

```bash
# Create initial migration
alembic revision --autogenerate -m "Initial migration"

# Apply migrations
alembic upgrade head
```

### 7. Run the Server

```bash
# Development mode with auto-reload
uvicorn app.main:app --reload --host 0.0.0.0 --port 8000

# Production mode
uvicorn app.main:app --host 0.0.0.0 --port 8000
```

The API will be available at:
- **API**: http://localhost:8000
- **Documentation**: http://localhost:8000/docs
- **Alternative Docs**: http://localhost:8000/redoc

## API Endpoints

### Authentication Endpoints

#### Register User
```http
POST /api/v1/auth/register
Content-Type: application/json

{
  "username": "johndoe",
  "email": "john@example.com",
  "password": "SecurePass123!",
  "name": "John Doe"
}
```

#### Login
```http
POST /api/v1/auth/login
Content-Type: application/x-www-form-urlencoded

username=johndoe&password=SecurePass123!
```

Response:
```json
{
  "access_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "refresh_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "token_type": "bearer",
  "expires_in": 1800
}
```

#### Refresh Token
```http
POST /api/v1/auth/refresh
Content-Type: application/json

{
  "refresh_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
}
```

#### Logout
```http
POST /api/v1/auth/logout
Authorization: Bearer <access_token>
```

#### Logout All Devices
```http
POST /api/v1/auth/logout-all
Authorization: Bearer <access_token>
```

#### Get Current User
```http
GET /api/v1/auth/me
Authorization: Bearer <access_token>
```

## Database Schema

### Users Table
- `id` - Primary key
- `username` - Unique username (3-50 chars)
- `email` - Unique email address
- `password_hash` - Argon2/Bcrypt hashed password
- `is_active` - Account status
- `is_verified` - Email verification status
- `created_at` - Account creation timestamp
- `updated_at` - Last update timestamp
- `last_login` - Last login timestamp
- `failed_login_attempts` - Failed login counter
- `locked_until` - Account lockout expiration

### Refresh Tokens Table
- `id` - Primary key
- `user_id` - Foreign key to users
- `token` - Refresh token string
- `expires_at` - Token expiration
- `is_revoked` - Revocation status
- `device_info` - Device/browser info
- `ip_address` - Client IP address

### Blacklisted Tokens Table
- `id` - Primary key
- `token_identifier` - JWT ID or token hash
- `expires_at` - Token expiration
- `blacklisted_at` - Blacklist timestamp

## Security Best Practices

### Password Requirements
- Minimum 8 characters
- At least one uppercase letter
- At least one lowercase letter
- At least one digit
- At least one special character
- Maximum 128 characters
- Not in common passwords list

### Token Security
- Access tokens expire in 30 minutes (configurable)
- Refresh tokens expire in 7 days (configurable)
- Tokens are blacklisted on logout
- Refresh token rotation on use
- JWT ID (jti) for token tracking

### Account Protection
- Account lockout after 5 failed attempts (configurable)
- 30-minute lockout duration (configurable)
- Failed attempt counter resets on successful login
- Account status checking on authentication

### Password Hashing
- **Argon2** (preferred) - Winner of Password Hashing Competition
  - Memory cost: 64 MB
  - Time cost: 3 iterations
  - Parallelism: 4 threads
- **Bcrypt** (fallback) - 12 rounds (4096 iterations)

## Development

### Running Tests

```bash
pytest
```

### Creating Migrations

```bash
# Auto-generate migration from model changes
alembic revision --autogenerate -m "Description of changes"

# Create empty migration
alembic revision -m "Description of changes"
```

### Applying Migrations

```bash
# Apply all pending migrations
alembic upgrade head

# Rollback one migration
alembic downgrade -1

# Rollback to specific revision
alembic downgrade <revision>
```

### Database Reset (Development Only)

```bash
# Drop all tables and recreate
alembic downgrade base
alembic upgrade head
```

## Project Structure

```
intelligent_wallet_backend/
├── app/
│   ├── __init__.py
│   ├── main.py                 # FastAPI application
│   ├── config.py               # Configuration settings
│   ├── database.py             # Database connection
│   ├── schemas.py              # Pydantic schemas
│   ├── models/                 # SQLAlchemy models
│   │   ├── user.py
│   │   ├── refresh_token.py
│   │   ├── blacklisted_token.py
│   │   └── transaction.py
│   ├── routers/                # API routes
│   │   ├── auth.py
│   │   ├── auth_dependencies.py
│   │   └── transactions.py
│   └── utils/                  # Utility functions
│       ├── hashing.py
│       └── jwt_handler.py
├── alembic/                    # Database migrations
│   ├── versions/
│   └── env.py
├── alembic.ini                  # Alembic configuration
├── requirements.txt             # Python dependencies
└── README.md                    # This file
```

## Integration with Flutter Frontend

### Example Flutter HTTP Client

```dart
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService {
  final String baseUrl = 'http://localhost:8000/api/v1';
  
  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: 'username=$email&password=$password',
    );
    
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Login failed');
    }
  }
  
  Future<Map<String, dynamic>> register({
    required String username,
    required String email,
    required String password,
    String? name,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/register'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'username': username,
        'email': email,
        'password': password,
        'name': name,
      }),
    );
    
    if (response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      throw Exception('Registration failed');
    }
  }
  
  Future<Map<String, dynamic>> getCurrentUser(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/auth/me'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );
    
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to get user');
    }
  }
}
```

## Production Deployment

### Environment Variables
- Set `ENV=production`
- Use strong `JWT_SECRET_KEY` (generate with secrets module)
- Configure `CORS_ORIGINS` with your frontend domain
- Use secure database credentials

### Security Checklist
- [ ] Change default JWT_SECRET_KEY
- [ ] Use HTTPS in production
- [ ] Configure CORS_ORIGINS properly
- [ ] Use strong database passwords
- [ ] Enable database SSL connections
- [ ] Set up proper logging
- [ ] Configure rate limiting (consider adding)
- [ ] Set up monitoring and alerts
- [ ] Regular security updates

### Docker Deployment (Optional)

Create a `Dockerfile`:

```dockerfile
FROM python:3.12-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]
```

## Troubleshooting

### Database Connection Issues
- Verify PostgreSQL is running: `pg_isready`
- Check DATABASE_URL format: `postgresql://user:pass@host:port/dbname`
- Ensure database exists: `psql -l`

### Migration Issues
- Check Alembic version: `alembic current`
- View migration history: `alembic history`
- Verify models are imported in `alembic/env.py`

### Authentication Issues
- Verify JWT_SECRET_KEY is set
- Check token expiration times
- Ensure tokens are sent in Authorization header: `Bearer <token>`

## License

This project is part of the Intelligent Wallet application.

## Support

For issues and questions, please refer to the project documentation or contact the development team.

