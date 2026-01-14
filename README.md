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
