#!/usr/bin/env bash
# Build + deploy digital3.com.au to Cloudflare.
# Substitutes {{VERSION}} in index.html with the current date in Australia/Sydney.

set -euo pipefail

cd "$(dirname "$0")"

VERSION="v$(TZ=Australia/Sydney date +%Y.%m.%d)"
echo "Building with version: $VERSION"

rm -rf build
mkdir -p build
# Use awk for portable in-place templating (sed -i differs between BSD/GNU).
awk -v v="$VERSION" '{ gsub(/\{\{VERSION\}\}/, v); print }' index.html > build/index.html

echo "Deploying to Cloudflare..."
wrangler deploy

echo "Done. Live at https://digital3.com.au/"
