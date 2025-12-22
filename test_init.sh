#!/bin/bash
set -euo pipefail

echo "--- STARTING INIT.SH ---"
./init.sh
echo

echo "--- TESTING RESULTS ---"

# Sucht nach dem gegebenen Bild
IMAGE=$(ls *.jpg *.png 2>/dev/null | head -n 1 || true)

if [[ -z "$IMAGE" ]]; then
  echo "TEST FAILED: No image found"
  exit 1
fi

RESULT_FILE="${IMAGE%.*}.json"

# Überprüft, ob die Resultat Datei überhaupt existiert
if [[ ! -f "$RESULT_FILE" ]]; then
  echo "TEST FAILED: Result file not found: $RESULT_FILE"
  exit 1
fi

# Überprüft, ob die Resultat Datei nicht leer ist
if [[ ! -s "$RESULT_FILE" ]]; then
  echo "TEST FAILED: Result file doesnt contain anything"
  exit 1
fi

echo "TEST PASSED"
echo "Created Result File: $RESULT_FILE"