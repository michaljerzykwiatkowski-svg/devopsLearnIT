#!/usr/bin/env bash
# Użycie: ./generuj-konfig.sh <dev|stage|prod>

set -euo pipefail

if [[ $# -ne 1 ]]; then
    echo "Użycie: $0 <dev|stage|prod>" >&2
    exit 1
fi

ENV="$1"

case "$ENV" in
    dev)
        APP_NAME="moja-aplikacja"
        APP_PORT=3000
        DB_HOST="localhost"
        DB_NAME="app_dev"
        LOG_LEVEL="debug"
        REPLICAS=1
        ;;
    stage)
        APP_NAME="moja-aplikacja"
        APP_PORT=8080
        DB_HOST="stage-db.internal"
        DB_NAME="app_stage"
        LOG_LEVEL="info"
        REPLICAS=2
        ;;
    prod)
        APP_NAME="moja-aplikacja"
        APP_PORT=80
        DB_HOST="prod-db.internal"
        DB_NAME="app_prod"
        LOG_LEVEL="warn"
        REPLICAS=4
        ;;
    *)
        echo "Błąd: nieznane środowisko '$ENV'. Dozwolone: dev, stage, prod." >&2
        exit 1
        ;;
esac

# --- app.env: podstawiamy konkretne wartości (<<EOF, bez cudzysłowów) ---
cat > app.env <<EOF
# Wygenerowano dla środowiska: $ENV
APP_NAME=$APP_NAME
APP_PORT=$APP_PORT
APP_ENV=$ENV
DB_HOST=$DB_HOST
DB_NAME=$DB_NAME
LOG_LEVEL=$LOG_LEVEL
REPLICAS=$REPLICAS
EOF

# --- start.sh: zapisujemy $ dosłownie (<<'EOF', z cudzysłowami) ---
cat > start.sh <<'EOF'
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
EOF

chmod +x start.sh

echo "✅ Wygenerowano: app.env oraz start.sh (środowisko: $ENV)"
