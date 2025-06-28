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
start=0.5
end=4.0
step=0.1

#Loop
for i in $(seq $start $step $end); do
    echo "................................"
    echo "Calculate length of atoms $i A ... wait"
    echo "--"
    # create the folder and copy the model files
    mkdir "length_$i"
    cd "length_$i"/
    cp ../calc.fdf .
    cp ../H.vps .

    z1=$(python3 -c "print(5.0 - ($i/ 2.0))")
    z2=$(python3 -c "print(5.0 + ($i/ 2.0))")

    sed -i "s/XXXX/$z1/g" "calc.fdf"
    sed -i "s/YYYY/$z2/g" "calc.fdf"
   
    mpirun -np 2 siesta <calc.fdf >calc.out 
    
    # copy the total energy
    et=$( grep "Total =" "calc.out"|awk '{print " " $4}')
    echo "$i    $et">>../Etot.dat
    # leave
    echo "................................"
    echo " "
    echo " "
    cd ../
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
plt.xlabel('Distance between atoms (A)')
plt.ylabel('Total Energy (eV)')
plt.title('Dependence of Total Energy with distance between atoms in H2 molecule')

# Save the plot as a PNG file
plt.savefig('energy_total_length.png')

# Display the plot
plt.show()
EOF



