#!/bin/bash
# statystyka.sh <katalog>
# Zlicza pliki według rozszerzenia 

set -u

if [ $# -ne 1 ] || [ ! -d "$1" ]; then
    printf 'Użycie: %s <katalog>\n' "${0##*/}" >&2
    exit 1
fi

dir=$1

declare -A ext_count=()      # rozszerzenie -> liczba plików
file_count=0
dir_count=0
max_size=-1
max_file=""

# Iterujemy po wszystkich elementach 

while IFS= read -r -d '' path; do
    if [ -d "$path" ]; then
        dir_count=$((dir_count + 1))
        continue
    fi
    [ -f "$path" ] || continue

    file_count=$((file_count + 1))

    name=${path##*/}
    if [[ $name == *.* && $name != .* ]]; then
        ext=${name##*.}
        if [ -z "$ext" ]; then
            ext="(brak)"
        fi
    else
        
        if [[ $name == .*.* ]]; then
            ext=${name##*.}
        else
            ext="(brak)"
        fi
    fi

    ext_count["$ext"]=$(( ${ext_count["$ext"]:-0} + 1 ))

    # rozmiar w bajtach
    size=$(stat -c %s -- "$path" 2>/dev/null) || continue
    if (( size > max_size )); then
        max_size=$size
        max_file=$path
    fi
done < <(find "$dir" -mindepth 1 -print0 2>/dev/null)

# ---- Wypisanie tabeli rozszerzeń, malejąco po liczbie ----
printf '%-20s %10s\n' "Rozszerzenie" "Liczba"
printf '%-20s %10s\n' "--------------------" "----------"

# Sortowanie: najpierw po liczbie malejąco, potem po nazwie rosnąco (stabilnie).
for ext in "${!ext_count[@]}"; do
    printf '%s\t%d\n' "$ext" "${ext_count[$ext]}"
done | sort -t $'\t' -k2,2nr -k1,1 | \
while IFS=$'\t' read -r ext cnt; do
    printf '%-20s %10d\n' "$ext" "$cnt"
done

# ---- Podsumowanie ----
printf '\n'
printf 'Pliki:            %d\n' "$file_count"
printf 'Katalogi:         %d\n' "$dir_count"
if [ "$file_count" -gt 0 ] && [ -n "$max_file" ]; then
    printf 'Największy plik:  %s (%d B)\n' "$max_file" "$max_size"
else
    printf 'Największy plik:  (brak)\n'
fi
