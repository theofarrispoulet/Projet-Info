#!/usr/local/bin/gnuplot -persist
reset #On réinitialise les paramètre de gnuplot.
set terminal png size 2000, 1000 #On définie la taille de la fenêtre à 2000 pixels de long sur 1000 pixels de large.
set output "m_png" #On indique que le fichier de sortie doit s'appeler m_png.
set title "Carte interpolée de l'humidité" #On définie "Carte interpolée de l'humidité" comme titre du graphique.
set title  font ",17" #On met la taille de la police à 17.
set xlabel "Longitude" #On définie "Longitude" comme nom de l'axe des abscisses.
set xlabel  font ",10" #On met la taille de la police à 10.
set ylabel "Latitude" #On définie "Latitude" comme nom de l'axe des ordonnées.
set ylabel  font ",10" #On met la taille de la police à 10.
set palette defined ( 10 "turquoise", 20 "cyan", 30 "skyblue", 40 "blue" ) #On déclare une palette de couleur allant d'un dégradé de turquoise au bleu.
set datafile separator ';' #On indique que le séparateur dans le fichier qui sera lu est ";".
plot 'humidite_6.csv' using 2:3:4 with circles fillstyle solid lc palette title "Humidité" #on utilise le dossier "humidite_6.csv" pour créer une carte interpolée : avec la humdité en fonction de la longitude et de la latitude, qui utilisera des cercles remplis à l'aide des colonnes 2, 3 et 4 du fichier.
