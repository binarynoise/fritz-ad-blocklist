#!/bin/bash

set -euo pipefail

[[ -f .env ]] && source .env

if [[ -z $CLOUDFLARE_TOKEN ]]; then
    echo "CLOUDFLARE_TOKEN is not set"
    exit 1
fi

mkdir -p out

comm -12 \
    <(
        curl -Ssf -H "Authorization: Bearer $CLOUDFLARE_TOKEN" https://api.cloudflare.com/client/v4/radar/datasets/ranking_top_1000 |
            sort
    ) \
    <(
        curl -Ssf 'https://hblock.molinero.dev/hosts_domains.txt' |
            sort
    ) \
    >out/top-ad-domains.txt
