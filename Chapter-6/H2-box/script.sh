#!/bin/bash
LANG=en_US
#it should be en_US.UTF-8
#LC_NUMERIC=de_DE.UTF-8

#-------------------------------------------
#  Create by Dr. Carlos Maciel O. Bastos   |
#    Siesta Hands-on: Complete Guide       |
#                                          |
#            UnB - 18/10/2024              |
#-------------------------------------------

# variables
start=2.0
end=12.0
step=0.5

# for loop
for i in $(seq $start $step $end); do
    echo "................................"
    echo "Calculate box size $i ... wait"
    echo "--"
    # create the folder and copy the model files    
    mkdir "box_$i"
    cd "box_$i"/
    cp ../calc.fdf .
    cp ../H.vps .
    # Change the parameter in calc.fdf
    sed -i "s/XXX/$i/g" "calc.fdf"
    # run siesta
    mpirun -np 2 siesta < calc.fdf > calc.out
    # copy the total energy
    et=$( grep "Total =" "calc.out"|awk '{print " " $4}')
    echo "$i    $et">>../Etot.dat
    # leave
    cd ../
    echo "................................"
    echo " "	
    echo " "
done

### Plot graphic
python3 <<EOF
import matplotlib.pyplot as plt
import numpy as np

# Data for plotting
f=np.loadtxt("Etot.dat")
# Creating the plot
plt.plot(f[:,0], f[:,1], marker='o')

# Adding labels and title
plt.xlabel('Box Size (A)')
plt.ylabel('Total Energy (eV)')
plt.title('Dependence of Total Energy with Box size in H2 molecule')

# Save the plot as a PNG file
plt.savefig('energy_total_box_size.png')

# Display the plot
plt.show()
EOF


