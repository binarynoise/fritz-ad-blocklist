#!/bin/bash

set -euo pipefail

# shellcheck disable=SC1091
[[ -f .env ]] && source .env

if [[ -z $CLOUDFLARE_TOKEN ]]; then
    echo "CLOUDFLARE_TOKEN is not set"
    exit 1
fi

mkdir -p out

curl -Ssf -H "Authorization: Bearer $CLOUDFLARE_TOKEN" https://api.cloudflare.com/client/v4/radar/datasets/ranking_top_10000 | sort >out/top.txt
curl -Ssf 'https://pgl.yoyo.org/adservers/serverlist.php?hostformat=plaintext&mimetype=plaintext' | sort >out/ad-domains.txt

comm -12 out/top.txt out/ad-domains.txt >out/top-ad-domains.txt
