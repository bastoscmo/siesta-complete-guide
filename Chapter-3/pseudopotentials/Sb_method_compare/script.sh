#!/bin/bash
LANG=en_US
#it should be en_US.UTF-8
#LC_NUMERIC=de_DE.UTF-8

#-------------------------------------------
#  Create by Dr. Carlos Maciel O. Bastos   | 
#    Siesta: Complete Guide                |
#                                          |
#            UnB - 18/10/2024              |
#-------------------------------------------


# variables
list=("tm2" "hsc" "ker")
path_atm=$(sed -n '2p' "path.conf")

rm -r tm2 hsc ker

#Loop
for item in "${list[@]}"; do
    echo "................................"
    echo "Create the folders $item and copy the files"
    echo "--"
    # create the folder and copy the model files
    mkdir "$item"
    cd "$item"/
    cp ../INP_model INP
    if [ "$item" = "tm2" ]; then
    	sed -i "s/XXX/tm2 /g" "INP"
    elif [ "$item" = "hsc" ]; then
    	sed -i "s/XXX/hsc /g" "INP"
    elif [ "$item" = "ker" ]; then
    	sed -i "s/XXX/ker /g" "INP"
    fi
    
    $path_atm 
     
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

wfae =np.loadtxt("ker/AEWFNR0")
wfker=np.loadtxt("ker/PSWFNR0")
wfhsc=np.loadtxt("hsc/PSWFNR0")
wftm2=np.loadtxt("tm2/PSWFNR0")


# Creating the plot
plt.plot(wfae[:,0], wfae[:,1], label="All electron", color="red", linewidth=3)
plt.plot(wfker[:,0], wfker[:,1], label="ker", color="magenta", linewidth=2)
plt.plot(wfhsc[:,0], wfhsc[:,1], label="hsc", color="blue", linewidth=2)
plt.plot(wftm2[:,0], wftm2[:,1], linestyle='--', color="black", label="tm2" , linewidth=2)

#legend
plt.legend(loc="upper right")

# Range
plt.xlim(0,7)

# Adding labels and title
plt.xlabel('radii (A)')
plt.ylabel('Radial s-orbital wave function')
plt.title('Radial s-orbital wavefunction for Sb  atom')

# Save the plot as a PNG file
#plt.savefig('energy_total_length.png')

# Display the plot
plt.show()
EOF


### Plot graphic
python3 <<EOF
import matplotlib.pyplot as plt
import numpy as np

# Data for plotting

wfae =np.loadtxt("ker/AEWFNR1")
wfker=np.loadtxt("ker/PSWFNR1")
wfhsc=np.loadtxt("hsc/PSWFNR1")
wftm2=np.loadtxt("tm2/PSWFNR1")


# Creating the plot
plt.plot(wfae[:,0], wfae[:,1], label="All electron", color="red", linewidth=3)
plt.plot(wfker[:,0], wfker[:,1], label="ker", color="magenta", linewidth=2)
plt.plot(wfhsc[:,0], wfhsc[:,1], label="hsc", color="blue", linewidth=2)
plt.plot(wftm2[:,0], wftm2[:,1], linestyle='--', color="black", label="tm2" , linewidth=2)

#legend
plt.legend(loc="upper right")

# Range
plt.xlim(0,7)

# Adding labels and title
plt.xlabel('radii (A)')
plt.ylabel('Radial s-orbital wave function')
plt.title('Radial s-orbital wavefunction for Sb  atom')

# Save the plot as a PNG file
#plt.savefig('energy_total_length.png')

# Display the plot
plt.show()
EOF

### Plot graphic density
python3 <<EOF
import matplotlib.pyplot as plt
import numpy as np

# Data for plotting
dae =np.loadtxt("ker/AECHARGE")
dker=np.loadtxt("ker/PSCHARGE")
dhsc=np.loadtxt("hsc/PSCHARGE")
dtm2=np.loadtxt("tm2/PSCHARGE")


# Creating the plot
plt.plot(dae[:,0], dae[:,1]+dae[:,2]-dae[:,3], label="all-electron", color="red", linewidth=3)
plt.plot(dker[:,0],  dker[:,1]+dker[:,2]-dker[:,3], label="ker", color="magenta", linewidth=2)
plt.plot(dhsc[:,0],  dhsc[:,1]+dhsc[:,2]-dhsc[:,3], color="blue", label="hsc" , linewidth=2)
plt.plot(dtm2[:,0],  dtm2[:,1]+dtm2[:,2]-dtm2[:,3], linestyle='--', color="black", label="tm2" , linewidth=2)

#legend
plt.legend(loc="upper right")

# Range
plt.xlim(0,7)

# Adding labels and title
plt.xlabel('radii (A)')
plt.ylabel('Electronic Density')
plt.title('Electronic Density for As atom')

# Save the plot as a PNG file
#plt.savefig('energy_total_length.png')

# Display the plot
plt.show()
EOF

