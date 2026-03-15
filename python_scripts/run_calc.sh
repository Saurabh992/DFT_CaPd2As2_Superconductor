#!/bin/bash
# A script to run the full QE workflow
NPROC=8
NK=4
set -e  # stop if any command fails

# --- Step 1: Ground State Calculation (SCF) ---
echo "Step 1/7 : Running SCF Calculation..."
mpirun -np $NPROC pw.x < inputs/scf.in > outputs/scf.out
echo "SCF calculation finished."

# --- Step 2: NSCF Calculation for Bands --- 
echo "Step 2/7 : Running NSCF Calculation for Bands (K-path)..."
mpirun -np $NPROC pw.x -nk $NK < inputs/nscf_bands.in > outputs/nscf_bands.out
echo "NSCF calculation for Bands finished."

# --- Step 3: Bands Calculation ---
echo "Step 3/7 : Running Bands Calculation..."
mpirun -np $NPROC bands.x -nk $NK < inputs/bands.in > outputs/bands.out
echo "Bands calculation finished."

# --- Step 4: NSCF Calculation for DOS ---
echo "Step 4/7 : Running NSCF Calculation for DOS..."
mpirun -np $NPROC pw.x -nk  $NK < inputs/nscf_dos.in > outputs/nscf_dos.out
echo "NSCF calculation for DOS finished."

#Step 5: DOS Calculation ---
echo "Step 5/7 : Running DOS Calculation..."
mpirun -np $NPROC dos.x -nk $NK < inputs/dos.in > outputs/dos.out
echo "DOS Calculation finished"

#Step 6: PDOS Calculation ---
echo "Step 6/7 : Running Projections Calculation..."
mpirun -np $NPROC projwfc.x -nk $NK < inputs/projwfc.in > outputs/projwfc.out
echo "PDOS Calculation finished"

echo "All the Simulations successfully completed"
echo "All done ✅🎉"
