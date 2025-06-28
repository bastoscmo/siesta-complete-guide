#!/bin/bash
LANG=en_US
#it should be en_US.UTF-8
#LC_NUMERIC=de_DE.UTF-8

#-------------------------------------------
#  Create by Dr. Carlos Maciel O. Bastos   | 
#    Siesta Hands-on: Complete Guide       |
#                                          |
#            UnB - 01/12/2024              |
#-------------------------------------------


# variables
list=("2" "4" "6" "8" "10" )

#Loop
for i in "${list[@]}";do
    echo "................................"
    echo "Calculate energy cutoff $i  ... wait"
    echo "--"
    # create the folder and copy the model files
    mkdir "ec_$i"
    cd "ec_$i"/
    cp ../calc.fdf .
    cp ../Si.vps .


    sed -i "s/XXX/$i/g" "calc.fdf"
   
    start_time=$(date +%s)
    mpirun -np 2 siesta calc.fdf --out calc.out 
    end_time=$(date +%s)
    duration=$((end_time - start_time))
    
    # copy the total energy
    lat=$(  head -n 1  Si-diamond.XV | awk '{print $2}' )
    et=$( grep "Total =" "calc.out"|awk '{print " " $4}')
    echo "$i    $et">>../Etot.dat
    echo "$i    $lat">>../Lattice.dat
    # leave
    echo "======= Calculation Time: $duration seconds ====== "
    echo "................................"
    echo " "
    echo " "
    cd ../
done
    # leave


### Plot graphic
python3 <<EOF
import matplotlib.pyplot as plt
import numpy as np

# Data for plotting
f=np.loadtxt("Etot.dat")
# Creating the plot
plt.plot(f[:,0], f[:,1], marker='o')

# Adding labels and title
plt.xlabel('K-point grid [n n n]')
plt.ylabel('Total Energy (eV)')
plt.title('Convergence of Total Energy with k-point grid')

# Display the plot
plt.show()
EOF


### Plot graphic
python3 <<EOF
import matplotlib.pyplot as plt
import numpy as np

# Data for plotting
f=np.loadtxt("Lattice.dat")
# Creating the plot
plt.plot(f[:,0], f[:,1], marker='o')

# Adding labels and title
plt.xlabel('k-point grid [n n n]')
plt.ylabel('Lattice (A)')
plt.title('Convergence of Lattice with k-point grid')

# Display the plot
plt.show()
EOF






