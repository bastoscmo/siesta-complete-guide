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
list=("LDA" "PBE" "PBE_rel")
path_atm=$(sed -n '2p' "path.conf")



#Loop
for item in "${list[@]}"; do
    echo "................................"
    echo "Create the folders $item and copy the files"
    echo "--"
    # create the folder and copy the model files
    mkdir "$item"
    cd "$item"/
    cp ../INP_model INP
    if [ "$item" = "LDA" ]; then
    	sed -i "s/XXX/ca /g" "INP"
    elif [ "$item" = "PBE" ]; then
    	sed -i "s/XXX/pb /g" "INP"
    elif [ "$item" = "PBE_rel" ]; then
    	sed -i "s/XXX/pbr/g" "INP"
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
wflda=np.loadtxt("LDA/AEWFNR0")
wfpbe=np.loadtxt("PBE/AEWFNR0")
wfpber=np.loadtxt("PBE_rel/AEWFNR0")


# Creating the plot
plt.plot(wflda[:,0], wflda[:,1], label="LDA", color="red", linewidth=3)
plt.plot(wfpbe[:,0], wfpbe[:,1], label="PBE", color="blue", linewidth=2)
plt.plot(wfpber[:,0], wfpber[:,1], linestyle='--', color="black", label="PBE rel." , linewidth=2)

#legend
plt.legend(loc="upper right")

# Range
plt.xlim(0,7)

# Adding labels and title
plt.xlabel('radii (A)')
plt.ylabel('Radial s-orbital wave function')
plt.title('Radial s-orbiital wavefunction for As atom using all-electrons calculation')

# Save the plot as a PNG file
#plt.savefig('energy_total_length.png')

# Display the plot
plt.show()
EOF


### Plot graphic p orbital
python3 <<EOF
import matplotlib.pyplot as plt
import numpy as np

# Data for plotting
wflda=np.loadtxt("LDA/AEWFNR1")
wfpbe=np.loadtxt("PBE/AEWFNR1")
wfpber=np.loadtxt("PBE_rel/AEWFNR1")


# Creating the plot
plt.plot(wflda[:,0], wflda[:,1], label="LDA", color="red", linewidth=3)
plt.plot(wfpbe[:,0], wfpbe[:,1], label="PBE", color="blue", linewidth=2)
plt.plot(wfpber[:,0], wfpber[:,1], linestyle='--', color="black", label="PBE rel." , linewidth=2)

#legend
plt.legend(loc="upper right")

# Range
plt.xlim(0,7)

# Adding labels and title
plt.xlabel('radii (A)')
plt.ylabel('Radial p-orbital wave function')
plt.title('Radial p-orbiital wavefunction for As atom using all-electrons calculation')

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
wflda=np.loadtxt("LDA/AECHARGE")
wfpbe=np.loadtxt("PBE/AECHARGE")
wfpber=np.loadtxt("PBE_rel/AECHARGE")


# Creating the plot
plt.plot(wflda[:,0], wflda[:,1]+wflda[:,2]-wflda[:,3], label="LDA-val", color="red", linewidth=3)
plt.plot(wfpbe[:,0],  wfpbe[:,1]+wfpbe[:,2]-wfpbe[:,3], label="PBE-val", color="blue", linewidth=2)
plt.plot(wfpber[:,0],  wfpber[:,1]+wfpber[:,2]-wfpber[:,3], linestyle='--', color="black", label="PBE rel.-val" , linewidth=2)
plt.plot(wflda[:,0], wflda[:,3], label="LDA-total", color="red", linewidth=3)
plt.plot(wfpbe[:,0], wfpbe[:,3], label="PBE-total", color="blue", linewidth=2)
plt.plot(wfpber[:,0],wfpber[:,3], linestyle='--', color="black", label="PBE rel.-total" , linewidth=2)

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


### Plot graphic density spin
python3 <<EOF
import matplotlib.pyplot as plt
import numpy as np

# Data for plotting
wflda=np.loadtxt("LDA/AECHARGE")
wfpbe=np.loadtxt("PBE/AECHARGE")
wfpber=np.loadtxt("PBE_rel/AECHARGE")


# Creating the plot
#plt.plot(wfpber[:,0], -wfpber[:,1]+wfpber[:,3], label="pbr - spin up", color="blue", linewidth=2)
#plt.plot(wfpber[:,0], -wfpber[:,3]+wfpber[:,2], color="red", label="pbr - spin down" , linewidth=2)

plt.plot(wfpber[:,0], wfpber[:,1], label="pbr - spin up", color="blue", linewidth=2)
plt.plot(wfpber[:,0], -wfpber[:,2], color="red", label="pbr - spin down" , linewidth=2)

#legend
plt.legend(loc="upper right")

# Range
plt.xlim(0,7)
plt.ylim(-40,40)
# Adding labels and title
plt.xlabel('radii (A)')
plt.ylabel('Spin electronic density')
plt.title('Spin electronic density for As atom')

# Save the plot as a PNG file
#plt.savefig('energy_total_length.png')

# Display the plot
plt.show()
EOF

