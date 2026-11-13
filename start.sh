#!/usr/bin/env bash
# Skrypt uruchomieniowy – zmienne podstawiane dopiero w runtime.
set -euo pipefail

echo "Uruchamiam aplikację: ${APP_NAME} na porcie ${APP_PORT}"
echo "Środowisko: ${APP_ENV}, log level: ${LOG_LEVEL}"

# $1 to argument pozycyjny przekazany do start.sh (np. tryb pracy)
MODE="${1:-default}"
echo "Tryb: ${MODE}"

# Wczytaj konfigurację, jeśli istnieje
if [[ -f app.env ]]; then
    # shellcheck disable=SC1091
    source app.env
fi

echo "DB: ${DB_HOST}/${DB_NAME}, repliki: ${REPLICAS}"
