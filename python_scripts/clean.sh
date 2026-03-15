#!/bin/bash

# Fail fast if any step fails
set -e

# ========== CLEAN OLD RUN DATA ==========
echo "[1] Cleaning old output files..."
rm -rf *.save */*.save
rm -f *.wfc*
rm -f outputs/*.out
rm -f outputs/*.dat*
rm -f outputs/*.gnu
rm -f outputs/*.png
echo "Done ✅"
echo ""
