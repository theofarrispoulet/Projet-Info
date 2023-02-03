#!/usr/local/bin/gnuplot -persist
reset #On réinitialise les paramètre de gnuplot.
set terminal png size 2000, 1000 #On définie la taille de la fenêtre à 2000 pixels de long sur 1000 pixels de large.
set grid layerdefault   lt 0 linecolor 0 linewidth 0.500,  lt 0 linecolor 0 linewidth 0.500 #On créer un cadrillage sous forme de pointillées.
set output "p1_png" #On indique que le fichier de sortie doit s'appeler p1_png.
set title "Pression p1" #On définie "Pression p1" comme titre du graphique.
set title  font ",17" #On met la taille de la police à 17.
set xlabel "ID Stations" #On définie "ID Stations" comme nom de l'axe des abscisses.
set xlabel  font ",10" #On met la taille de la police à 10.
set xtic(1) rotate 45
set ylabel "Pression" #On définie "Pression" comme nom de l'axe des ordonnées.
set ylabel  font ",10" #On met la taille de la police à 10.
Shadecolor_a = "#98e698" #On déclare une variable contenant la couleur vert clair.
Shadecolor_b = "#006600" #On déclare une variable contenant la couleur vert foncé.
set datafile separator ';' #On indique que le séparateur dans le fichier qui sera lu est ";".
plot 'pression1_4.csv' using 0:3:4 with filledcurve fc rgb Shadecolor_a title "Pression minimale à maximale", '' using 0:2:xtic(1) with linespoint lw 4 lc rgb Shadecolor_b title "Pression moyenne" #on utilise le dossier "pression1_4.csv" pour créer deux courbes : une avec la pression minimale à maximale en vert clair, qui utilisera des courbes remplis à l'aide des colonnes 1, 2 et 4 du fichier. Et l'autre avec la pression moyenne en vert foncé, qui utilisera des courbes à l'aide des colonnes 1 et 3 du fichier.
