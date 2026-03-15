#!/bin/bash
# A script to run the full QE workflow
NPROC=8
NK=4
set -e  # stop if any command fails

# --- Step 1: Ground State Calculation (SCF) ---
echo "Step 1/4 : Running SCF Calculation..."
mpirun -np $NPROC pw.x < inputs/scf.in > outputs/scf.out
echo "SCF calculation finished."

# --- Step 2: NSCF Calculation for Bands ---
echo "Step 2/4 : Running NSCF Calculation for Bands (K-path)..."
mpirun -np $NPROC pw.x -nk $NK < inputs/nscf_bands.in > outputs/nscf_bands.out
echo "NSCF calculation for Bands finished."

# --- Step 3: Bands Calculation ---
echo "Step 3/4 : Running Bands Calculation..."
mpirun -np $NPROC bands.x -nk $NK < inputs/bands.in > outputs/bands.out
echo "Bands calculation finished."

# --- Step 4: Post-processing and Plotting ---
echo "Step 4/4 : Plotting the Bands Structure..."
gnuplot scripts/plot.bands
echo "Plotting script ran successfully, Band Structure Plot is ready"
echo "All done ✅🎉"
