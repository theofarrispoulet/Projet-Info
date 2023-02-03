#!/usr/local/bin/gnuplot -persist
reset #On réinitialise les paramètre de gnuplot.
set terminal png size 2000, 1000 #On définie la taille de la fenêtre à 2000 pixels de long sur 1000 pixels de large.
set grid layerdefault   lt 0 linecolor 0 linewidth 0.500,  lt 0 linecolor 0 linewidth 0.500 #On créer un cadrillage sous forme de pointillées.
set output "p2_png" #On indique que le fichier de sortie doit s'appeler p2_png.
set title "Pression p2" #On définie "Pression p2" comme titre du graphique.
set title  font ",17" #On met la taille de la police à 17.
set xlabel "Jour et heure" #On définie "Jour et Heure" comme nom de l'axe des abscisses.
set xlabel  font ",10" #On met la taille de la police à 10.
set ylabel "Pression moyenne" #On définie "Pression moyenne" comme nom de l'axe des ordonnées.
set ylabel  font ",10" #On met la taille de la police à 10.
Shadecolor_a = "#006600" #On déclare une variable contenant la couleur vert foncé.
set datafile separator ';' #On indique que le séparateur dans le fichier qui sera lu est ";".
plot 'pression2_3.csv' using 1:2 with linespoint lw 4 lc rgb Shadecolor_a title "Pression en fonction du temps" #on utilise le dossier "pression2_3.csv" pour créer une courbe : avec la pression en fonction du temps en vert foncé, qui utilisera des courbes à l'aide des colonnes 1 et 2 du fichier.
