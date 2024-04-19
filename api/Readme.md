# Project Varanasi

## Overview

Project Varanasi is a structured application designed to provide a seamless experience for managing and accessing data through a RESTful API. This README outlines the file architecture, deployment procedures, common errors, and request flow within the project.

## File Architecture

```bash
api/
├── app/
│   ├── handlers/
│   │   ├── discovery_handler.go
│   │   └── other_handlers.go
│   ├── middleware/
│   │   └── auth_middleware.go
│   └── routes/
│       └── routes.go
├── config/
│   └── config.go
├── models/
│   ├── discovery.go
│   └── other_models.go
├── repository/
│   ├── discovery_repository.go
│   └── other_repositories.go
├── services/
│   ├── discovery_service.go
│   └── other_services.go
├── utils/
│   ├── errors.go
│   └── validation.go
├── main.go
└── go.mod
```

## Deployment

### Production

To deploy to production, use the following command:

```bash
gcloud app deploy app.yaml
```

### Development

For development deployments, utilize:

```bash
gcloud app deploy dev.yaml
```

## Common Errors and Solutions

1. Error: failed to listen: listen tcp4 :8080: bind: address already in use

Solution: This error occurs when the port is already in use. To resolve, kill the process using the port:

```bash
kill -9 $(lsof -t -i:8080)
```

## Request Flow

Requests follow this flow:

routes -> handler -> service -> repository -> external API

## Inspirations

1. https://www.behance.net/gallery/185376439/Music-Player-App-UI-Music-App-UI-Design-UIUX-Design?tracking_source=search_projects%7Cmusic+app+ui&l=121
