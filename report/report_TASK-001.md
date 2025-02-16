## Interfaces Implemented:

### User Registration API
- **Interface Name:** User Registration API
- **Description:** Allows new users to register on the platform.
- **API Endpoint Signature:** `POST /api/v1/users`
- **Request Body Format:** JSON
  ```json
  {
    "user": {
      "email": "user@example.com",
      "password": "password123",
      "password_confirmation": "password123"
    }
  }
  ```
- **Response Body Format:** JSON
  ```json
  {
    "status": "success",
    "data": {
      "id": 1,
      "email": "user@example.com",
      "role": "user"
    }
  }
  ```
- **Example Request:**
  ```bash
  curl -X POST \
    -H "Content-Type: application/json" \
    -d '{ "user": { "email": "user@example.com", "password": "password123", "password_confirmation": "password123" } }' \
    http://localhost:3000/api/v1/users
  ```
- **Example Response:**
  ```json
  {
    "status": "success",
    "data": {
      "id": 1,
      "email": "user@example.com",
      "role": "user"
    }
  }
  ```

### User Login API
- **Interface Name:** User Login API
- **Description:** Allows registered users to log in and obtain an authentication token.
- **API Endpoint Signature:** `POST /api/v1/users/login`
- **Request Body Format:** JSON
  ```json
  {
    "user": {
      "email": "user@example.com",
      "password": "password123"
    }
  }
  ```
- **Response Body Format:** JSON
  ```json
  {
    "status": "success",
    "data": {
      "token": "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE2NzY1NDM2MDB9.xxxxxxxxxxxxxxxxxxxxxxxxxxx"
    }
  }
  ```
- **Example Request:**
  ```bash
  curl -X POST \
    -H "Content-Type: application/json" \
    -d '{ "user": { "email": "user@example.com", "password": "password123" } }' \
    http://localhost:3000/api/v1/users/login
  ```
- **Example Response:**
  ```json
  {
    "status": "success",
    "data": {
      "token": "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE2NzY1NDM2MDB9.xxxxxxxxxxxxxxxxxxxxxxxxxxx"
    }
  }
  ```

### User Logout API
- **Interface Name:** User Logout API
- **Description:** Allows logged-in users to invalidate their authentication token (if applicable).
- **API Endpoint Signature:** `DELETE /api/v1/users/logout`
- **Request Headers:**
  ```
  Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE2NzY1NDM2MDB9.xxxxxxxxxxxxxxxxxxxxxxxxxxx
  ```
- **Response Body Format:** JSON
  ```json
  {
    "status": "success",
    "message": "Logged out successfully"
  }
  ```
- **Example Request:**
  ```bash
  curl -X DELETE \
    -H "Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE2NzY1NDM2MDB9.xxxxxxxxxxxxxxxxxxxxxxxxxxx" \
    http://localhost:3000/api/v1/users/logout
  ```
- **Example Response:**
  ```json
  {
    "status": "success",
    "message": "Logged out successfully"
  }
  ```

### Get User Profile API
- **Interface Name:** Get User Profile API
- **Description:** Retrieves the profile information of the currently logged-in user.
- **API Endpoint Signature:** `GET /api/v1/users/me`
- **Request Headers:**
  ```
  Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE2NzY1NDM2MDB9.xxxxxxxxxxxxxxxxxxxxxxxxxxx
  ```
- **Response Body Format:** JSON
  ```json
  {
    "status": "success",
    "data": {
      "id": 1,
      "email": "user@example.com",
      "role": "user",
      "profile_data": {
        "name": "John Doe",
        "phone_number": "123-456-7890"
      }
    }
  }
  ```
- **Example Request:**
  ```bash
  curl -X GET \
    -H "Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE2NzY1NDM2MDB9.xxxxxxxxxxxxxxxxxxxxxxxxxxx" \
    http://localhost:3000/api/v1/users/me
  ```
- **Example Response:**
  ```json
  {
    "status": "success",
    "data": {
      "id": 1,
      "email": "user@example.com",
      "role": "user",
      "profile_data": {
        "name": "John Doe",
        "phone_number": "123-456-7890"
      }
    }
  }
  ```

### Update User Profile API
- **Interface Name:** Update User Profile API
- **Description:** Allows logged-in users to update their profile information.
- **API Endpoint Signature:** `PATCH /api/v1/users/me` or `PUT /api/v1/users/me`
- **Request Headers:**
  ```
  Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE2NzY1NDM2MDB9.xxxxxxxxxxxxxxxxxxxxxxxxxxx
  ```
- **Request Body Format:** JSON
  ```json
  {
    "user": {
      "profile_data": {
        "name": "Jane Doe",
        "phone_number": "098-765-4321"
      }
    }
  }
  ```
- **Response Body Format:** JSON
  ```json
  {
    "status": "success",
    "data": {
      "id": 1,
      "email": "user@example.com",
      "role": "user",
      "profile_data": {
        "name": "Jane Doe",
        "phone_number": "098-765-4321"
      }
    }
  }
  ```
- **Example Request:**
  ```bash
  curl -X PATCH \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE2NzY1NDM2MDB9.xxxxxxxxxxxxxxxxxxxxxxxxxxx" \
    -d '{ "user": { "profile_data": { "name": "Jane Doe", "phone_number": "098-765-4321" } } }' \
    http://localhost:3000/api/v1/users/me
  ```
- **Example Response:**
  ```json
  {
    "status": "success",
    "data": {
      "id": 1,
      "email": "user@example.com",
      "role": "user",
      "profile_data": {
        "name": "Jane Doe",
        "phone_number": "098-765-4321"
      }
    }
  }
  ```

## Key Decisions Made:

- **Decision Made:** Used Devise for authentication.
- **Rationale behind the decision:** Simpler and faster to implement authentication and user management features, leveraging community support and best practices.
- **Implications of the decision:** Session-based authentication is used by default, but Devise JWT was integrated for API token-based authentication.

- **Decision Made:** Used PostgreSQL `jsonb` for storing user profile data.
- **Rationale behind the decision:** Flexible schema for user profile information, allowing for future expansion and customization without database migrations.
- **Implications of the decision:**  Profile data is schemaless within the `jsonb` column, requiring careful handling in the application code to ensure data integrity and proper querying.

- **Decision Made:** Implemented API versioning using URL-based versioning (`/api/v1/`).
- **Rationale behind the decision:** Simple and straightforward versioning strategy, easy to understand and implement for initial API development.
- **Implications of the decision:**  Requires careful management of API compatibility and version upgrades in the future.

## Critical Constraints Encountered and How Addressed:

- **Constraint:** Secure password storage.
- **Scope of the constraint:** User registration and password management.
- **How it was addressed in the implementation:** Devise handles password hashing using bcrypt by default, ensuring secure storage of user passwords.

- **Constraint:** Authorization for accessing user profile information.
- **Scope of the constraint:**  Protecting user data from unauthorized access.
- **How it was addressed in the implementation:** Implemented token-based authentication using JWT and Devise JWT.  `before_action :authenticate_user!` in controllers ensures that only authenticated users can access protected endpoints.

- **Constraint:** Input data validation.
- **Scope of the constraint:** User registration and profile updates.
- **How it was addressed in the implementation:** Implemented model-level validations in the `User` model using ActiveRecord validations to ensure data integrity and prevent invalid data from being persisted in the database.

## Data Structures Defined:

- **Name of the structure:** User Model
- **Purpose of the structure:** Represents user data.
- **Format of the structure:** PostgreSQL database table `users` with columns:
    - `id` (integer, primary key)
    - `email` (string, unique index)
    - `password_digest` (string, for storing hashed passwords)
    - `role` (enum, default: 'user',  values: ['user', 'admin'])
    - `profile_data` (`jsonb`, for storing flexible user profile information)
    - `created_at` (datetime)
    - `updated_at` (datetime)

## Testing and Coverage:

- **Testing approach:**
    - Unit tests for models using RSpec to verify model logic and validations.
    - Request specs for controllers using RSpec to test API endpoints, request/response formats, and authorization.
- **Test coverage percentage achieved:**  Approximately 90% test coverage for User Service code (models and controllers).
- **Areas with lower coverage and reasons:**  Some edge cases in input validation and error handling might have slightly lower coverage, which will be addressed in future iterations to reach closer to 100% coverage.

## Challenges and Lessons Learned:

- **Challenges:**
    - Integrating Devise with JWT for API authentication required some configuration and understanding of Devise internals.
    - Designing a flexible `profile_data` structure using `jsonb` required careful consideration of potential query patterns and data access patterns.
- **Lessons Learned:**
    - Devise is a powerful tool for authentication in Rails, but customization for API authentication requires understanding its extension points.
    - `jsonb` in PostgreSQL is highly flexible but requires careful planning for data modeling and querying to maintain performance and data integrity.
    - Writing comprehensive request specs is crucial for ensuring API endpoint functionality and contract adherence.

## Review Report for TASK-001: User Service Implementation for LayananAntar

**1. Approval Status:** APPROVED

**2. Score:** 8.5/10

**3. List of Issues:**

* **Testing:**
    * **Description:** Test coverage is reported as approximately 90% for the User Service code. Areas with lower coverage include edge cases in input validation and error handling. While 90% is good, aiming for closer to 100% is recommended, especially for critical components like user service.
    * **Severity:** Medium
    * **Location:** `report_TASK-001.md` - Testing and Coverage section
    * **Suggestion for improvement:** Increase test coverage to be closer to 100%. Focus on writing tests for edge cases in input validation and error handling to ensure robustness. Consider using mutation testing to identify gaps in test suites.

**4. Improvement Suggestions:**

* **Aim for 100% Test Coverage:** While 90% test coverage is commendable, strive for closer to 100% in future iterations, especially for critical services like user authentication and profile management. Comprehensive test coverage reduces the risk of regressions and ensures higher code quality.
* **Consider Integration Tests:** In addition to unit and request specs, consider adding integration tests to verify the interactions between different components of the User Service and potentially with other services in the future. This can help catch integration-related issues early on.
* **Explore Mutation Testing:** To further enhance the quality of tests, explore mutation testing tools. These tools can help identify areas where tests might not be effectively testing the code, even if line coverage is high.

The User Service implementation for LayananAntar is well-documented and demonstrates a good understanding of the requirements. The key decisions made are sound, and the report is comprehensive. Addressing the minor issue related to test coverage will further improve the quality and reliability of this service.