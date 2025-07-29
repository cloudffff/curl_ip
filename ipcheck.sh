#!/bin/bash

SOCKS_PORT=""
HTTP_PORT=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    -ps)
      SOCKS_PORT="$2"
      shift 2
      ;;
    -ph)
      HTTP_PORT="$2"
      shift 2
      ;;
    *)
      echo "استفاده درست:"
      echo "  ./server-info.sh -ps [SOCKS_PORT]"
      echo "  ./server-info.sh -ph [HTTP_PORT]"
      exit 1
      ;;
  esac
done

CURL_CMD="curl -s"

if [[ -n "$SOCKS_PORT" ]]; then
  CURL_CMD+=" --socks5 127.0.0.1:$SOCKS_PORT"
elif [[ -n "$HTTP_PORT" ]]; then
  CURL_CMD+=" -x http://127.0.0.1:$HTTP_PORT"
fi

ip=$($CURL_CMD https://api.ipify.org)
country=$(curl -sS "http://ip-api.com/json/$ip" | jq -r '.country')

echo "🌍 Server Location: $country"
echo "📡 Server IP: $ip"
