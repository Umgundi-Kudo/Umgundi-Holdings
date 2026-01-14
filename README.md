# Umgundi-Holdings

This README documents the setup and structure of the Umgundi-Holdings application.

## Getting Started

Things you may want to cover:

- Ruby version
- System dependencies
- Configuration
- Database creation
- Database initialization
- How to run the test suite
- Services (job queues, cache servers, search engines, etc.)
- Deployment instructions

---

## Entity Relationship Diagram (Week 1)

The ERD below represents the database structure for the KudoKart application.
It explicitly shows the relationships between users and kudos using directional arrows.
The diagram was derived directly from the Rails schema to ensure accuracy.

```mermaid
erDiagram
    USER ||--o{ KUDO : sends
    USER ||--o{ KUDO : receives

    USER {
        uuid id PK
        varchar username
        varchar email
        varchar password_digest
        boolean email_verified
        timestamp created_at
        timestamp updated_at
    }

    KUDO {
        uuid id PK
        text message
        varchar category
        uuid sender_id FK
        uuid receiver_id FK
        timestamp created_at
        timestamp updated_at
    }
---

## Environment Variables (Week 2)

Week 2 focuses on the **Kudo Creation Form (UI)** and user interaction only.

No new environment variables were introduced in Week 2.

The Kudo creation feature relies on:
- Existing authentication state (logged-in user)
- Existing database configuration
- Existing mailer and ngrok configuration from Week 1

All required environment variables are already defined in Week 1, including:

- `GMAIL_USERNAME`
- `GMAIL_PASSWORD`
- `DATABASE_URL` (optional, depending on setup)

No additional `.env` changes are required to support:
- Selecting a recipient
- Selecting a category
- Submitting a kudo message
- Preventing users from sending kudos to themselves (handled via model validation)

