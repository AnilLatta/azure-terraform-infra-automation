#!/usr/bin/env bash
# ==============================================================================
# Enterprise Terraform Deployment & Drift Verification Script
# Author: Anil Kumar
# ==============================================================================
set -euo pipefail

ENV="${1:-prod}"
TARGET_DIR="environments/${ENV}"

echo "=========================================================="
echo "🚀 Initializing Terraform Deployment for Environment: ${ENV}"
echo "=========================================================="

cd "${TARGET_DIR}"

echo "1. Validating Terraform syntax and formatting..."
terraform fmt -check
terraform init -upgrade
terraform validate

echo "2. Generating execution plan & drift check..."
terraform plan -out=tfplan -input=false

echo "3. Plan generated successfully!"
echo "To apply, run: terraform apply tfplan"
