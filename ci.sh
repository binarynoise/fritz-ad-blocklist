#!/bin/bash

set -euo pipefail
GIT_USERNAME="github-actions[bot]"
GIT_EMAIL="github-actions[bot]@users.noreply.github.com"

./build.sh

git fetch origin data:data
rm -rf nested
git clone . nested
cd nested
git fetch origin data:data
git checkout data

cp ../out/top-ad-domains.txt .

git config --local user.name "$GIT_USERNAME"
git config --local user.email "$GIT_EMAIL"
git add top-ad-domains.txt
git commit -m "Update top-ad-domains.txt" || true
git push origin data

cd ..
git push origin data
rm -rf nested
