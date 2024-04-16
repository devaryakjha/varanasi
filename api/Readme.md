## Deploy to App Engine

### Production

```bash
gcloud app deploy app.yaml
```

### Development

```bash
gcloud app deploy app-dev.yaml
```

## Common errors and their fixes

1. failed to listen: listen tcp4 :8080: bind: address already in use
   ```bash
    kill -9 $(lsof -t -i:8080)
   ```
