# Set terminal and output
set terminal pdfcairo enhanced font "Arial,25" size 8,8
set output "energy_bands.pdf"

# Title and axis labels
#set title "Advanced Data Visualization Example" font ",16"
set ylabel "Energy (eV)" font "Arial,28" #offset -0.1,0
set xlabel "" font "Arial,28"

# Ranges and scales
#set xrange [0:20]
set yrange [-20:20]
#set logscale y 10  # Set log scale for y-axis

# Grid settings
#set grid xtics ytics mxtics mytics
#set mxtics 5  # Minor grid on x-axis
#set mytics 5  # Minor grid on y-axis

# Tics and formatting
set xtics ( "{/Symbol G}" 0.0 ,  "K" 0.889234 ,  "M" 1.333852 ,  "{/Symbol G}" 2.103952 )  font "Arial,28"
set ytics format "%.0f" font "Arial,28" 
set grid xtics front#set no key 

# Annotations
#set label "Critical point" at 10, 100 front font ",12" textcolor rgb "red"
set arrow from 0.0,0.0 to 2.103952 ,0.0 nohead dt 2 lc rgb "dark-gray" lw 4 back
set arrow from 0.889234 ,graph 0 to 0.889234,graph 1 nohead dt 2 lc rgb "dark-gray" lw 4 back
set arrow from 1.333852 ,graph 0 to 1.333852,graph 1 nohead dt 2 lc rgb "dark-gray" lw 4 back

# Color palette and colorbar (useful for pm3d plots)
#set palette defined (0 "blue", 1 "green", 2 "yellow", 3 "red")
#set colorbox vertical user origin 0.9, 0.2 size 0.03, 0.6
#set cblabel "Colorbar (units)" font ",12"

# Multiplot (e.g., additional smaller plots in the same figure)
#set multiplot layout 1,1 title "Multiplot with Color Palette" font ",14"
#unset multiplot

# Line styles
set style line 1 lc rgb "#1f77b4" lt 1 lw 3 pt 7 ps 1.5   # Solid blue line with points
#set style line 2 lc rgb "#ff7f0e" lt 2 lw 2 pt 5 ps 1.5   # Dashed orange line
#set style line 3 lc rgb "#2ca02c" lt 3 lw 2               # Solid green line

# Plot commands
plot "bands.dat" using 1:2 with lines ls 1 title "" 
