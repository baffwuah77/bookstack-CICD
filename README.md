# BookStack Deployment (Vault + GitHub Actions CI/CD)

This project automates BookStack deployment using GitHub Actions CI/CD and HashiCorp Vault.

## Features
- Secrets managed securely in Vault
- Docker image built with secrets injected as build args
- No secrets stored in docker-compose.yml or version control
- Vault secret path auto-initialized if missing

## Setup Instructions

1. Clone the repo and switch to your working branch
2. Ensure Vault is running and accessible at $VAULT_ADDR
3. Add your Vault token to GitHub secrets as `VAULT_TOKEN`
4. Add Vault address to GitHub secrets as `VAULT_ADDR`
5. Commit changes and push to GitHub to trigger the CI/CD workflow

## Vault Secret Path

- `secret/Dev-secret/bookstack`
- Required keys:
  - `app_url`
  - `db_host`
  - `db_database`
  - `db_username`
  - `db_password`
  - `mysql_database`
  - `mysql_user`
  - `mysql_password`
  - `mysql_root_password`

## CI/CD Flow (`.github/workflows/deploy-bookstack.yml`)

- Authenticate to Vault
- Initialize Vault path if missing
- Retrieve secrets and export as environment variables
- Build Docker image securely with build-args
- Deploy BookStack using docker-compose

## Deployment

After successful deployment, BookStack will be accessible at the URL defined in Vault's `app_url`.

## Security Notes

- No secrets are committed to version control
- Vault is the single source of truth for sensitive configuration
- Secrets are injected at build time only, never stored in the image layers permanently

## Manual Deployment Example

```bash
docker build \
  --build-arg APP_URL=... \
  --build-arg DB_HOST=... \
  --build-arg DB_DATABASE=... \
  --build-arg DB_USERNAME=... \
  --build-arg DB_PASSWORD=... \
  -t your-registry/bookstack:secure ./bookstack

docker-compose -f bookstack/docker-compose.yml up -d
