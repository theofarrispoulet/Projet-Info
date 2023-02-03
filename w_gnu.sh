#!/usr/local/bin/gnuplot -persist
reset #On réinitialise les paramètre de gnuplot.
set terminal png size 2000, 1000 #On définie la taille de la fenêtre à 2000 pixels de long sur 1000 pixels de large.
#set grid layerdefault   lt 0 linecolor 0 linewidth 0.500,  lt 0 linecolor 0 linewidth 0.500 #On créer un cadrillage sous forme de pointillées.
set output "w_png" #On indique que le fichier de sortie doit s'appeler w_png.
set title "Carte des vecteurs du vent" #On définie "Carte interpolée de l'altitude" comme titre du graphique.
set title  font ",17" #On met la taille de la police à 17.
set xlabel "Longitude" #On définie "Longitude" comme nom de l'axe des abscisses.
set xlabel  font ",10" #On met la taille de la police à 10.
set ylabel "Latitude" #On définie "Latitude" comme nom de l'axe des ordonnées.
set ylabel  font ",10" #On met la taille de la police à 10.
Shadecolor_a = "#4d79ff" #On déclare une variable contenant la couleur bleu.
set datafile separator ';' #On indique que le séparateur dans le fichier qui sera lu est ";".
plot 'vent_5.csv' using 2:3:($4*cos($5/180*pi)):($4*sin($5/180*pi)) with vectors lw 2.5 lc rgb Shadecolor_a title "Vecteur du vent" #on utilise le dossier "vent_5.csv" pour créer une carte vectorielle : avec le vent en fonction de la longitude et de la latitude, qui utilisera des flèches à l'aide des colonnes 2, 3, 4 et 5 du fichier.
