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
path_atm=$(sed -n '2p' "path.conf")

$path_atm 
     
### Plot graphic
python3 <<EOF
import matplotlib.pyplot as plt
import numpy as np

# Data for plotting
wfae=np.loadtxt("AEWFNR0")
wfps=np.loadtxt("PSWFNR0")


# Creating the plot
plt.plot(wfae[:,0], wfae[:,1], label="all electron", color="red", linewidth=3)
plt.plot(wfps[:,0], wfps[:,1], linestyle='--', color="black", label="pseudopotential" , linewidth=2)

#legend
plt.legend(loc="upper right")

# Range
plt.xlim(0,7)

# Adding labels and title
plt.xlabel('radii (A)')
plt.ylabel('Radial s-orbital wave function')
plt.title('Radial s-orbital wavefunction for Pb atom')

# Save the plot as a PNG file
#plt.savefig('energy_total_length.png')

# Display the plot
plt.show()
EOF


python3 <<EOF
import matplotlib.pyplot as plt
import numpy as np

# Data for plotting
wfae=np.loadtxt("AEWFNR1")
wfps=np.loadtxt("PSWFNR1")


# Creating the plot
plt.plot(wfae[:,0], wfae[:,1], label="all electron", color="red", linewidth=3)
plt.plot(wfps[:,0], wfps[:,1], linestyle='--', color="black", label="pseudopotential" , linewidth=2)

#legend
plt.legend(loc="upper right")

# Range
plt.xlim(0,7)

# Adding labels and title
plt.xlabel('radii (A)')
plt.ylabel('Radial p-orbital wave function')
plt.title('Radial p-orbital wavefunction for Pb atom')

# Save the plot as a PNG file
#plt.savefig('energy_total_length.png')

# Display the plot
plt.show()
EOF

##### d-orbital
python3 <<EOF
import matplotlib.pyplot as plt
import numpy as np

# Data for plotting
wfae=np.loadtxt("AEWFNR2")
wfps=np.loadtxt("PSWFNR2")


# Creating the plot
plt.plot(wfae[:,0], wfae[:,1], label="all electron", color="red", linewidth=3)
plt.plot(wfps[:,0], wfps[:,1], linestyle='--', color="black", label="pseudopotential" , linewidth=2)

#legend
plt.legend(loc="upper right")

# Range
plt.xlim(0,7)

# Adding labels and title
plt.xlabel('radii (A)')
plt.ylabel('Radial p-orbital wave function')
plt.title('Radial p-orbital wavefunction for Pb atom')

# Save the plot as a PNG file
#plt.savefig('energy_total_length.png')

# Display the plot
plt.show()
EOF



##### Valence Charge 
python3 <<EOF
import matplotlib.pyplot as plt
import numpy as np

# Data for plotting
wfae=np.loadtxt("AECHARGE")
wfps=np.loadtxt("PSCHARGE")


# Creating the plot
plt.plot(wfae[:,0], wfae[:,1]+wfae[:,2]-wfae[:,3], label="all electron", color="red", linewidth=3)
plt.plot(wfps[:,0], wfps[:,1]+wfps[:,2]-wfps[:,3], linestyle='--', color="black", label="pseudopotential" , linewidth=2)

#legend
plt.legend(loc="upper right")

# Range
plt.xlim(0,7)

# Adding labels and title
plt.xlabel('radii (A)')
plt.ylabel('valence electronic density')
plt.title('valence electronic density for Pb atom')

# Save the plot as a PNG file
#plt.savefig('energy_total_length.png')

# Display the plot
plt.show()
EOF



