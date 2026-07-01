#!/bin/bash
LOAD=$(uptime | awk '{print $10}' | sed 's/,//')
echo "${LOAD:-0}%"
