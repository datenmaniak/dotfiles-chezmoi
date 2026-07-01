#!/bin/bash
if command -v sensors &>/dev/null; then
    TEMP=$(sensors | grep 'Package id 0' | awk '{print $4}' | sed 's/+//' | head -1)
    echo "${TEMP:-N/A}"
else
    echo "N/A"
fi
