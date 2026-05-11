# Naming Conventions

## Git

### Branches

**Format:**

```
<type>/<issue-number>-<short-description>
```

| Rule         | Detail                                                             |
|--------------|--------------------------------------------------------------------|
| Issue number | **Required.** Min 4 digits. Pad with zeros: `0001`, `0042`, `0123` |
| Type         | `feature`, `fix`, `docs`, `refactor`, `test`, `chore`, `perf`      |
| Description  | kebab-case, lowercase, English, 3–5 words                          |

```bash
# ✅ Valid
feature/0001-user-authentication
fix/0042-database-connection-timeout
docs/0099-readme-update
chore/1234-update-dependencies

# ❌ Invalid
feature/new-feature          # missing issue number
fix/42-bug                   # issue number < 4 digits
feature/MyFeature            # not kebab-case
```

### Commit messages

See [Git Workflow Guide](git-workflow.md#commit-messages) for the full spec.

**Format:** `<type>(<scope>): <subject>`

Scopes are project-specific — defined in `docs/context/project.md`.

---

## Files & Folders

Use **kebab-case** for all file and folder names unless the language ecosystem dictates otherwise.

```
# ✅
user-authentication.service.ts
create-task.dto.ts
kanban-board.tsx

# ❌
UserAuthentication.service.ts
createTask.dto.ts
KanbanBoard.tsx        # exception: React components (see below)
```

**React / frontend components:** PascalCase file names are acceptable when the ecosystem convention requires it.

```
KanbanBoard.tsx
TaskCard.tsx
```

---

## TypeScript / JavaScript

### Classes

```typescript
// PascalCase
class UserAuthService {}
class TaskRepository {}
class CreateTaskDto {}
```

### Interfaces & Types

```typescript
// PascalCase
interface Task {
    id: string;
    title: string;
}

type TaskStatus = 'NEW' | 'IN_PROGRESS' | 'DONE';

type ApiResponse<T> = {
    data: T;
    error?: string;
};
```

### Functions & Methods

```typescript
// camelCase
function createDraft() {}
async function fetchTasks() {}

class Service {
    async handleTaskCreated() {}
}
```

### Variables

```typescript
// camelCase
const userName = 'John';
let taskCount = 0;

// Booleans: prefix with is / has / should
const isActive = true;
const hasPermission = false;
const shouldRetry = true;

// Arrays: plural
const tasks = [];
const users = [];
```

### Constants

```typescript
// UPPER_SNAKE_CASE for global/module-level constants
const MAX_RETRIES = 3;
const API_BASE_URL = 'https://api.example.com';

// camelCase for local constants
const maxRetries = 3;
```

### Enums

```typescript
// PascalCase name, UPPER_SNAKE_CASE or PascalCase values
enum TaskStatus {
    NEW = 'NEW',
    IN_PROGRESS = 'IN_PROGRESS',
    DONE = 'DONE',
}
```

### Event / handler names

```typescript
// Prefix handlers with "handle"
const handleClick = () => {};
const handleSubmit = (e: FormEvent) => {};
```

### Abbreviations in identifiers

Treat abbreviations as words — do not uppercase the entire abbreviation:

```typescript
// ✅
class ApiService {}
class HttpClient {}
const userId = '123';
const apiUrl = 'https://...';

// ❌
class APIService {}
class HTTPClient {}
const userID = '123';
```

### Magic numbers

Always name magic numbers:

```typescript
// ❌
setTimeout(() => {}, 3000);
if (status === 200) {}

// ✅
const RETRY_DELAY_MS = 3000;
const HTTP_OK = 200;
setTimeout(() => {}, RETRY_DELAY_MS);
if (status === HTTP_OK) {}
```

---

## Database

### Models / tables

Singular, PascalCase (Prisma / ORM convention):

```prisma
model Task {}
model User {}
model AuditLog {}
```

### Fields / columns

camelCase:

```prisma
model Task {
    id        String
    createdAt DateTime
    isActive  Boolean
    userId    String
}
```

---

## Environment Variables

UPPER_SNAKE_CASE, prefixed by category:

```bash
# Database
DATABASE_URL="postgresql://..."
DB_HOST="localhost"
DB_PORT="5432"

# Auth
JWT_SECRET="..."
JWT_EXPIRES_IN="1h"

# External services
GITHUB_TOKEN="ghp_..."
OPENAI_API_KEY="sk-..."

# App
NODE_ENV="production"
PORT="3000"
```

---

## API Endpoints

Lowercase, kebab-case, plural resource names:

```
GET    /tasks
GET    /tasks/:id
POST   /tasks
PATCH  /tasks/:id
DELETE /tasks/:id

# Nested
GET    /tasks/:id/comments
POST   /tasks/:id/comments

# Actions
POST   /tasks/:id/archive
```

Query parameters: camelCase:

```
GET /tasks?sortBy=createdAt&order=desc&perPage=20
```

---

## Tests

```
# File naming: *.spec.ts or *.test.ts
user-auth.service.spec.ts
kanban-board.test.tsx

# Describe blocks: what is being tested
describe('UserAuthService', () => {
    describe('login', () => {
        it('should return a JWT on valid credentials', () => {});
        it('should throw UnauthorizedException on wrong password', () => {});
    });
});
```
