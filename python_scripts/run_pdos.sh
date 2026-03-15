#!/bin/bash
# A script to run the full QE workflow
NPROC=8
NK=4
set -e  # stop if any command fails

# --- Step 1: NSCF Calculation for DOS ---
echo "Step 1/5 : Running NSCF Calculation for DOS..."
mpirun -np $NPROC pw.x $NK < inputs/nscf_dos.in > outputs/nscf_dos.out
echo "NSCF calculation for DOS finished."

#Step 2: DOS Calculation ---
echo "Step 2/5 : Running DOS Calculation..."
mpirun -np $NPROC dos.x $NK < inputs/dos.in > outputs/dos.out
echo "DOS Calculation finished"

#Step 3: PDOS Calculation ---
echo "Step 3/5 : Running Projections Calculation..."
mpirun -np $NPROC projwfc.x $NK < inputs/projwfc.in > outputs/projwfc.out
echo "PDOS Calculation finished"

#Step 4: Post-Processing ---
echo "Step 4/5 : Post-processing..."
sumpdos.x capd2as2.pdos_atm*\(*\)_wfc*\(s\) > s_pdos.tot
sumpdos.x capd2as2.pdos_atm*\(*\)_wfc*\(p\) > p_pdos.tot
sumpdos.x capd2as2.pdos_atm*\(*\)_wfc*\(d\) > d_pdos.tot

echo "Step 5/5 : Plotting the PDOS..."
gnuplot scripts/plot.pdos
echo "Plotting script ran successfully, PDOS is Ready"
echo "All done ✅🎉"
