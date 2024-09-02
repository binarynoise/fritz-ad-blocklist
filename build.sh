#!/bin/bash

set -euo pipefail

[[ -f .env ]] && source .env

if [[ -z $CLOUDFLARE_TOKEN ]]; then
    echo "CLOUDFLARE_TOKEN is not set"
    exit 1
fi

mkdir -p out

curl -Ssf -H "Authorization: Bearer $CLOUDFLARE_TOKEN" https://api.cloudflare.com/client/v4/radar/datasets/ranking_top_1000 | sort > out/top-1000.txt
curl -Ssf 'https://hblock.molinero.dev/hosts_domains.txt' | sort > out/hblock.txt

comm -12 out/top-1000.txt out/hblock.txt >out/top-ad-domains.txt
