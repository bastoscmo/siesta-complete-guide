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

#Loop
for i in "SZ" "DZ" "SZP" "DZP" ; do
    echo "................................"
    echo "Calculate with $i basis size ... wait"
    echo "--"
    # create the folder and copy the model files
    mkdir "$i"
    cd "$i"/
    cp ../run.fdf .
    cp ../Si.psf .

    sed -i "s/XXX/$i/g" "run.fdf"
    start_time=$(date +%s) 

    mpirun -np 2 siesta run.fdf --out run.out
    
    end_time=$(date +%s)

    # copy the total energy
    et=$( grep "Total =" "run.out"|awk '{print " " $4}')
    echo " $et">>../Etot.dat
    # leave
	duration=$((end_time - start_time))

    echo "======= Calculation Time: $duration seconds ====== "
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
plt.plot(f, marker='o')

x=[0,1,2,3]
labels=["SZ","DZ", "SZP", "DZP"]

for i in range(len(x)):
    plt.text(x[i],f[i], labels[i], fontsize=11, ha='right', va='bottom')

# Adding labels and title
plt.xlabel('Basis set sequence SZ DZ SZP DZP')
plt.ylabel('Total Energy (eV)')
plt.title('Dependence of Total Energy with basis set size')

# Save the plot as a PNG file
plt.savefig('energy_total_basis.png')

# Display the plot
plt.show()
EOF



