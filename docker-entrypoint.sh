#!/bin/bash
set -e

# Fetch parameters from Parameter Store
export JWT_SECRET=$(aws ssm get-parameter --name "/kutt/jwt_secret" --with-decryption --query Parameter.Value --output text)
# export DB_PASSWORD=$(aws ssm get-parameter --name "/kutt/db_password" --with-decryption --query Parameter.Value --output text)
# export KUTT_BASE_URL=$(aws ssm get-parameter --name "/kutt/kutt_base_url" --with-decryption --query Parameter.Value --output text)
# export ADMIN_EMAIL=$(aws ssm get-parameter --name "/kutt/admin_email" --with-decryption --query Parameter.Value --output text)
# export ADMIN_PASSWORD=$(aws ssm get-parameter --name "/kutt/admin_password" --with-decryption --query Parameter.Value --output text)

# Database migration
npm run migrate

# Start the application
npm start
