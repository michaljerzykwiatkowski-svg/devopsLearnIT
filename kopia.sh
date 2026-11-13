#!/bin/bash
# kopia.sh — tworzy archiwum tar.gz katalogu i weryfikuje jego integralność.
# Użycie: ./kopia.sh <katalog-źródłowy> [katalog-docelowy]
set -euo pipefail

# --- 1. Argumenty ---------------------------------------------------------
if [ $# -lt 1 ] || [ $# -gt 2 ]; then
    echo "Użycie: $0 <katalog-źródłowy> [katalog-docelowy]" >&2
    echo "  katalog-docelowy domyślnie: \$HOME/kopie" >&2
    exit 1
fi

SRC_RAW="$1"
DST="${2:-$HOME/kopie}"

# --- 2. Walidacja źródła --------------------------------------------------
if [ ! -d "$SRC_RAW" ]; then
    echo "Błąd: '$SRC_RAW' nie jest istniejącym katalogiem." >&2
    exit 2
fi

# Ścieżka bezwzględna bez końcowego slasha — żeby basename/dirname były poprawne
SRC="$(readlink -f "$SRC_RAW")"
BASE="$(basename "$SRC")"
PARENT="$(dirname "$SRC")"

# --- 3. Katalog docelowy (tworzony w razie potrzeby) ----------------------
mkdir -p "$DST"

# --- 4. Nazwa archiwum + obsługa kolizji ---------------------------------
# Wymagany format: nazwa-RRRRMM-DD-HHMM.tar.gz
# Dwa szybkie uruchomienia w tej samej minucie dałyby tę samą nazwę —
# dlatego przy kolizji doklejamy licznik: -1, -2, ...
STAMP="$(date +%Y%m%d-%H%M)"
ARCHIVE="$DST/${BASE}-${STAMP}.tar.gz"
n=1
while [ -e "$ARCHIVE" ]; do
    ARCHIVE="$DST/${BASE}-${STAMP}-${n}.tar.gz"
    n=$((n + 1))
done

# --- 5. Pakowanie ---------------------------------------------------------
# -C PARENT BASE: do archiwum trafia katalog BASE bez ścieżki bezwzględnej
tar -czf "$ARCHIVE" -C "$PARENT" "$BASE"

# --- 6. Rozmiar -----------------------------------------------------------
SIZE="$(du -h "$ARCHIVE" | cut -f1)"
echo "Utworzono archiwum: $ARCHIVE (rozmiar: $SIZE)"

# --- 7. Weryfikacja integralności ----------------------------------------
if tar -tzf "$ARCHIVE" >/dev/null 2>&1; then
    echo "Weryfikacja: OK — tar -tzf przeszedł pomyślnie."
else
    echo "Błąd: weryfikacja archiwum nie powiodła się." >&2
    exit 3
fi
