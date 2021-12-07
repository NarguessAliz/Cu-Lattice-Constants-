#!/bin/bash



for a in `seq 6 0.1 7`
do 
	sed "s/latticeconstant/${a}/g" cu.fcc.in > fcc.in
	pw.x <fcc.in> cu.fcc.out
	echo ${a} "," `cat cu.fcc.out|grep !|cut -d = -f 2| cut -d R -f 1`>>fcc
done
