#!/usr/local/bin/gnuplot -persist
reset #On réinitialise les paramètre de gnuplot.
set terminal png size 2000, 1000 #On définie la taille de la fenêtre à 2000 pixels de long sur 1000 pixels de large.
set output "h_png" #On indique que le fichier de sortie doit s'appeler h_png.
set title "Carte interpolée de l'altitude" #On définie "Carte interpolée de l'altitude" comme titre du graphique.
set title  font ",17" #On met la taille de la police à 17.
set xlabel "Longitude" #On définie "Longitude" comme nom de l'axe des abscisses.
set xlabel  font ",10" #On met la taille de la police à 10.
set ylabel "Latitude" #On définie "Latitude" comme nom de l'axe des ordonnées.
set ylabel  font ",10" #On met la taille de la police à 10.
set palette defined ( 10 "green", 20 "yellow", 30 "orange", 40 "red" ) #On déclare une palette de couleur allant d'un dégradé de vert au rouge.
set datafile separator ';' #On indique que le séparateur dans le fichier qui sera lu est ";".
plot 'altitude_6.csv' using 2:3:4 with circles fillstyle solid lc palette title "Altitude" #on utilise le dossier "altitude_6.csv" pour créer une carte interpolée : avec l'altitude en fonction de la longitude et de la latitude, qui utilisera des cercles remplis à l'aide des colonnes 2, 3 et 4 du fichier.
