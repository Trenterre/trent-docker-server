# Docker Server Management Workspace

This workspace is set up to manage our on-site Docker server using a hybrid workflow of local file tracking (Git) and remote server interaction (SSH).

## Workflow Strategy
1. **Local Tracking (Git)**: We keep all our Docker Compose files, container configurations, environment templates, and deployment scripts tracked here locally.
2. **Remote Interaction (SSH)**: We use SSH to inspect the server, fetch current configurations, and deploy/restart containers.
3. **Secure Environment**: Secrets and environment-specific values are kept in local `.env` files and are never committed to version control.
