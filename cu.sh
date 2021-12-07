#!/bin/bash


for a in `seq 4 0.1 5` 
do
in=cu.sc.in.$a
out=cu.sc.out.$a
cat  << EOF > $in


&control
    calculation='scf'
    restart_mode='from_scratch',
    pseudo_dir = '/Users/narguess/dft/psp',
    outdir='tmp/'
    prefix='cu'
    tstress = .true.
    tprnfor = .true.
 /
 &system
    ibrav = 1,
    celldm(1) =$a ,
    nat= 1,
    ntyp= 1,
    ecutwfc = 25.0,
    ecutrho = 300.0,
    occupations='smearing',
    smearing='gaussian',
    degauss=0.02,
 /
 &electrons
    conv_thr = 1.0e-8
    
 /
ATOMIC_SPECIES
 Cu 63.55 Cu.pbe-dn-rrkjus_psl.1.0.0.UPF 
ATOMIC_POSITIONS
 Cu 0.0 0.0 0.0
K_POINTS (automatic)
 10 10 10  0 0 0
EOF

pw.x < $in > $out
echo ${a} "," `cat $out | grep ! |cut -d = -f 2|cut -d R -f 1` >> ../esc



done 



for b in `seq 6 0.1 7.3` 
do
in=cu.sc.in.$b
out=cu.sc.out.$b
cat  << EOF > $in


&control
    calculation='scf'
    restart_mode='from_scratch',
    pseudo_dir = '/Users/narguess/dft/psp',
    outdir='tmp/'
    prefix='cu'
    tstress = .true.
    tprnfor = .true.
 /
 &system
    ibrav = 2,
    celldm(1) =$b ,
    nat= 1,
    ntyp= 1,
    ecutwfc = 25.0,
    ecutrho = 300.0,
    occupations='smearing',
    smearing='gaussian',
    degauss=0.02,
 /
 &electrons
    conv_thr = 1.0e-8
    
 /
ATOMIC_SPECIES
 Cu 63.55 Cu.pbe-dn-rrkjus_psl.1.0.0.UPF 
ATOMIC_POSITIONS
 Cu 0.0 0.0 0.0
K_POINTS (automatic)
 10 10 10  0 0 0
EOF

pw.x < $in > $out
echo ${b} "," `cat $out | grep ! |cut -d = -f 2|cut -d R -f 1` >> ../efcc


done 


for c in `seq 5 0.1 6` 
do
in=cu.bcc.in.$c
out=cu.bcc.out.$c
cat  << EOF > $in


&control
    calculation='scf'
    restart_mode='from_scratch',
    pseudo_dir = '/Users/narguess/dft/psp',
    outdir='tmp/'
    prefix='cu'
    tstress = .true.
    tprnfor = .true.
 /
 &system
    ibrav = 3,
    celldm(1) =$c ,
    nat= 1,
    ntyp= 1,
    ecutwfc = 25.0,
    ecutrho = 300.0,
    occupations='smearing',
    smearing='gaussian',
    degauss=0.02,
 /
 &electrons
    conv_thr = 1.0e-8
    
 /
ATOMIC_SPECIES
 Cu 63.55 Cu.pbe-dn-rrkjus_psl.1.0.0.UPF 
ATOMIC_POSITIONS
 Cu 0.0 0.0 0.0
K_POINTS (automatic)
 10 10 10  0 0 0
EOF

pw.x < $in > $out
echo ${c} "," `cat $out | grep ! |cut -d = -f 2|cut -d R -f 1` >> ../ebcc


done 


paste esc ebcc efcc > cu.dat
