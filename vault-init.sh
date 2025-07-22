#!/bin/bash
set -e

VAULT_ADDR="${VAULT_ADDR:-http://127.0.0.1:8200}"
VAULT_TOKEN="${VAULT_TOKEN}"

VAULT_PATH="secret/Dev-secret/bookstack"

echo "Checking if Vault path $VAULT_PATH exists..."
if ! vault kv get "$VAULT_PATH" > /dev/null 2>&1; then
  echo "Vault path $VAULT_PATH not found. Creating with default values..."
  vault kv put "$VAULT_PATH" \
    app_url="http://bookstack.example.com" \
    db_host="bookstack-db" \
    db_database="bookstack" \
    db_username="bookstack_user" \
    db_password="secure_password" \
    mysql_database="bookstack" \
    mysql_user="bookstack_user" \
    mysql_password="secure_password" \
    mysql_root_password="root_password"
else
  echo "Vault path $VAULT_PATH already exists. Skipping initialization."
fi
