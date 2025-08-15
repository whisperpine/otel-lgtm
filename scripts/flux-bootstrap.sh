#!/bin/sh

# Purpose: bootstrap flux with a given cluster name
# Usage: sh path/to/flux-bootstrap.sh CLUSTER_NAME
# Dependencies: flux
# Date: 2025-08-14
# Author: Yusong

# Prerequesuites: env var GITHUB_TOKEN is exported to current shell session.
# GITHUB_TOKEN is the PAT (personal access token) with proper permissions.
# Refer to: https://fluxcd.io/flux/installation/bootstrap/github/#github-organization

bootstrap() {
  flux bootstrap github \
    --owner=whisperpine \
    --repository=otel-lgtm \
    --path=./clusters/"$1" \
    --branch=main \
    --token-auth \
    --personal \
    --reconcile
}

if [ -z "$1" ]; then
  echo "Usage: sh $0 CLUSTER_NAME"
  echo "For example:"
  echo "sh $0 dev"
  exit
fi

bootstrap "$1"
