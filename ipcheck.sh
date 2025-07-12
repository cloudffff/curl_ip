#!/bin/bash

# بررسی وجود curl
if ! command -v curl &> /dev/null; then
  echo "❌ curl نصب نیست. لطفاً ابتدا با دستور sudo apt install curl نصبش کن."
  exit 1
fi

# مقدار پیش‌فرض
USE_PROXY=false
PROXY_PORT=""

# بررسی آرگومان‌ها
while [[ $# -gt 0 ]]; do
  case "$1" in
    -p)
      USE_PROXY=true
      PROXY_PORT="$2"
      shift 2
      ;;
    *)
      echo "❌ آرگومان نامعتبر: $1"
      echo "✅ استفاده صحیح: $0 [-p PORT]"
      exit 1
      ;;
  esac
done

# تعریف فرمان curl
if $USE_PROXY; then
  if [[ -z "$PROXY_PORT" ]]; then
    echo "❌ پورت پروکسی وارد نشده است."
    exit 1
  fi
  CURL_CMD="curl -s --max-time 5 --proxy http://127.0.0.1:$PROXY_PORT --socks5-hostname 127.0.0.1:$PROXY_PORT"
else
  CURL_CMD="curl -s --max-time 5"
fi

# دریافت IP و کشور
ip=$($CURL_CMD https://ifconfig.co/)
country=$($CURL_CMD https://ifconfig.co/country)

# بررسی خطا
if [[ -z "$ip" || -z "$country" ]]; then
  echo "⚠️ خطا در دریافت اطلاعات. اتصال اینترنت یا پروکسی را بررسی کنید."
  exit 1
fi

# نمایش خروجی
echo "🌍 Server IP      : $ip"
echo "📍 Server Country : $country"
