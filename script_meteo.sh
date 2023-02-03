#!/bin/bash
echo "le nom du script est : $0" #Commande qui affiche le nom du script.
echo "le nombre d'argument est : $#" #Commande qui affiche le nombre d'arguments passés en paramètre.
echo "le(s) argument(s) est(sont) : $*" #Commande qui affiche chaque arguments passé en paramètre.

	#LA FONCTION "Options_Fin" PERMET DE SUPPRIMER DES FICHIERS TEMPORAIRES PUIS DE FERMER LE PROGRAMME#
Option_Fin () {
	#rm *.csv #On supprime tout les fichier csv temporaires.
	echo -e "\033[35mLE PROGRAMME SHELL S'EST PARFAITEMENT EXÉCUTÉ ! \033[0m"
	exit 0
}

	 #LA FONCTION "Options_Tris" PERMET DE SELECTIONNER LE TYPE DE TRIS QUE L'UTILISATEUR A ENTRÉ EN ARGUMENT#
Options_Tris () {
	#LES OPTIONS POUR LE TYPE DE TRI#
	echo -e "\033[32mLe tri à bien été enregistré. \033[0m"
	if [[ $test4 = "--tab" ]]; then #Si l'argument saisi est "--tab", alors exécuter la commande suivante.
  		gcc -o code_Tab code_Tab.c #On compile le programme qui gère les tableaux de données. 
		./code_Tab #On exécute le programme qui gère les tableaux de données.
		
	elif [[ $test4 = "--abr" ]]; then #Si l'argument saisi est "--abr", alors exécuter la commande suivante.
  		gcc -o code_ABR code_ABR.c #On compile le programme qui gère les ABR.
		./code_ABR #On exécute le programme qui gère les ABR.
		
	elif [[ $test4 = "--avl" ]]; then #Si l'argument saisi est "--avl", alors exécuter la commande suivante.
  		gcc -o code_AVL code_AVL.c -lm #On compile le programme qui gère les AVL.
		./code_AVL #On exécute le programme qui gère les AVL.
		
	else #Si la personne n'a entré aucun argument correspondant à un tri, le code execute la commande suivante.
		gcc -o code_AVL code_AVL.c -lm #On compile le programme qui gère les AVL.
		./code_AVL #On exécute le programme qui gère les AVL.
	fi
	Option_Fin
}

	#LA FONCTION "Tris_Tris" PERMET DE RECUPERER L'ARGUMENT CORRESPONDANT AU TRIS#
Tris_Tris () {
	test4=" " #Variable qui permet de vérifier si un argument de tri à déjà été lu.
	for arg4 in "$@"; do #Cette boucle permet de vérifier si la personne a entré plusieurs fois un argument de tri, si c'est le cas, on affiche un message d'erreur et on quitte le programme.
		if [[ $arg4 = "--tab" ]] || [[ $arg4 = "--abr" ]] || [[ $arg4 = "--avl" ]]; then
			if [[ $test4 != " " ]]; then
				echo -e "\033[31mErreur! Vous ne pouvez pas entrer plusieurs mode de tri. Veuillez réessayer. \033[0m"
				rm lieu.csv #On supprime le fichier temporaire "lieu.csv".
				exit 1 #On quitte le programme.
			fi
			test4=$arg4
		fi
	done
	Options_Tris "test4" #On appelle la fonction avec commme argument, le mode de tri les arguments entrés par l'utilisateur.
}

	#LA FONCTION "Options_Modes" PERMET DE SELECTIONNER LE MODE QUE L'UTILISATEUR A ENTRÉ EN ARGUMENT#
Options_Modes () {
	#LES OPTIONS POUR LA TEMPERATURE#
	if [[ $test3 = "-t1" ]]; then #Si l'argument saisi est "-t1", alors exécuter la commande suivante.
		cut -f1,11 -d ";" lieu.csv > temp1.csv #Script qui permet d'inscrire l'identifiant de la station, et la température de chaque station dans un fichier csv nommé temp1.csv.
		sed '1d' temp1.csv > temp1_1.csv #On copie le fichier dans un second fichier, en supprimant la première ligne inutile pour nos calculs.
		sort -t, -k1n temp1_1.csv > temp1_2.csv #On trie le fichier dans l'ordre croissant des numéros de station dans la colonne 1.
		grep -v ";$" temp1_2.csv > temp1_3.csv #On copie les lignes non vides dans un nouveau fichier.
		awk -F ';' 'BEGIN {num!="";n=0} {
			if(num!=$1){
				if(tot!=0){
					print num";"sum/tot";"min";"max
				} 
				num=$1;
				sum=0;
				tot=0;
				min=$2;
				max=$2
			}
			sum += $2;
			tot+=1;
			if($2<min){
				min=$2
			}
			if($2>max){
				max=$2
			}
		}
		END {print num";"sum/tot";"min";"max}' temp1_3.csv > temp1_4.csv #Cette commande awk permet de calculer la moyenne, le minimum et le maximum pour la température de chaque station et de mettre les résultats dans le fichier "temp1_4.csv".
		rm temp1.csv #On supprime le fichier temporaire.
		rm temp1_1.csv #On supprime le fichier temporaire.
		rm temp1_2.csv #On supprime le fichier temporaire.
		rm temp1_3.csv #On supprime le fichier temporaire.
		echo -e "\033[32mUne option de mode a bien été enregistrée. \033[0m"
		gnuplot -p t1_gnu.sh
		echo -e "\033[32mLe Graphique s'est ouvert dans le dossier graphique_gnuplot. \033[0m"
		Tris_Tris $@ #On appelle la fonction avec commme argument, les arguments entrés par l'utilisateur.
		
	elif [[ $test3 = "-t2" ]]; then #Si l'argument saisi est "-t2", alors exécuter la commande suivante.
		cut -f1,2,11 -d ";" lieu.csv > temp2.csv #Script qui permet d'inscrire l'identifiant de la station, la date, l'heure et la température moyenne de chaque station dans un fichier csv nommé temp2.csv.
		sed '1d' temp2.csv > temp2_1.csv #On copie le fichier dans un second fichier, en supprimant la première ligne inutile pour nos calculs.
		sort -t, -k2n temp2_1.csv > temp2_2.csv #On trie le fichier dans l'ordre croissant des dates dans la colonne 2.
		grep -v ";$" temp2_2.csv > temp2_3.csv #On copie les lignes non vides dans un nouveau fichier.
		rm temp2.csv #On supprime le fichier temporaire.
		rm temp2_1.csv #On supprime le fichier temporaire.
		rm temp2_2.csv #On supprime le fichier temporaire.
		echo -e "\033[32mUne option de mode a bien été enregistrée. \033[0m"
		gnuplot -p t2_gnu.sh
		echo -e "\033[32mLe Graphique s'est ouvert dans le dossier graphique_gnuplot. \033[0m"
		Tris_Tris $@
		
	elif [[ $test3 = "-t3" ]]; then #Si l'argument saisi est "-t3", alors exécuter la commande suivante.
		cut -f1,2,11 -d ";" lieu.csv > temp3.csv #Script qui permet d'inscrire l'identifiant de la station, la date, l'heure et la température moyenne de chaque station dans un fichier csv nommé temp3.csv.
		sed '1d' temp3.csv > temp3_1.csv #On copie le fichier dans un second fichier, en supprimant la première ligne inutile pour nos calculs.
		sort -t, -k2n temp3_1.csv > temp3_2.csv #On trie le fichier dans l'ordre croissant des dates dans la colonne 2.
		grep -v ";$" temp3_2.csv > temp3_3.csv #On copie les lignes non vides dans un nouveau fichier.
		sort -t, -k1n temp3_3.csv > temp3_4.csv #On trie le fichier dans l'ordre croissant des numéros de stations dans la colonne 2.
		rm temp3.csv #On supprime le fichier temporaire.
		rm temp3_1.csv #On supprime le fichier temporaire.
		rm temp3_2.csv #On supprime le fichier temporaire.
		rm temp3_3.csv #On supprime le fichier temporaire.
		echo -e "\033[32mUne option de mode a bien été enregistrée. \033[0m"
		gnuplot -p t3_gnu.sh
		echo -e "\033[32mLe Graphique s'est ouvert dans le dossier graphique_gnuplot. \033[0m"
		Tris_Tris $@
			
			
	#LES OPTIONS POUR LA PRESSION#
	elif [[ $test3 = "-p1" ]]; then #Si l'argument saisi est "-p1", alors exécuter la commande suivante.
		cut -f1,7 -d ";" lieu.csv > pression1.csv #Script qui permet d'inscrire l'identifiant de la station et la pression de chaque station dans un fichier csv nommé pression1.csv.
		sed '1d' pression1.csv > pression1_1.csv #On copie le fichier dans un second fichier, en supprimant la première ligne inutile pour nos calculs.
		sort -t, -k1n pression1_1.csv > pression1_2.csv #On trie le fichier dans l'ordre croissant des numéros de station dans la colonne 1.
		grep -v ";$" pression1_2.csv > pression1_3.csv #On copie les lignes non vides dans un nouveau fichier.
		awk -F";" 'BEGIN {num=0;tot=0}{
			if(num!=$1){
				if(tot!=0){
					print num";"sum/tot";"min";"max
				} 
				num=$1;
				sum=0;
				tot=0;
				min=$2;
				max=$2;
			}
			sum += $2; tot++;
			if($2<min){
				min=$2;
			}
			if($2>max){
				max=$2;
			}
		}
		END {print num";"sum/tot";"min";"max}' pression1_3.csv > pression1_4.csv #Cette commande awk permet de calculer la moyenne, le minimum et le maximum pour la pression de chaque station et de mettre les résultats dans le fichier "pression1_4.csv".
		rm pression1.csv #On supprime le fichier temporaire.
		rm pression1_1.csv #On supprime le fichier temporaire.
		rm pression1_2.csv #On supprime le fichier temporaire.
		rm pression1_3.csv #On supprime le fichier temporaire.
		echo -e "\033[32mUne option de mode a bien été enregistrée. \033[0m"
		gnuplot -p p1_gnu.sh
		echo -e "\033[32mLe Graphique s'est ouvert dans le dossier graphique_gnuplot. \033[0m"
		Tris_Tris $@
		
	elif [[ $test3 = "-p2" ]]; then #Si l'argument saisi est "-p2", alors executer la commande suivante.
		cut -f1,2,7 -d ";" lieu.csv > pression2.csv #Script qui permet d'inscrire l'identifiant de la station, la date, l'heure et la pression moyenne de chaque station dans un fichier csv nommé pression2.csv.
		sed '1d' pression2.csv > pression2_1.csv #On copie le fichier dans un second fichier, en supprimant la première ligne inutile pour nos calculs.
		sort -t, -k2n pression2_1.csv > pression2_2.csv #On trie le fichier dans l'ordre croissant des numéros des dates dans la colonne 2.
		grep -v ";$" pression2_2.csv > pression2_3.csv #On copie les lignes non vides dans un nouveau fichier.
		rm pression2.csv #On supprime le fichier temporaire.
		rm pression2_1.csv #On supprime le fichier temporaire.
		rm pression2_2.csv #On supprime le fichier temporaire.
		echo -e "\033[32mUne option de mode a bien été enregistrée. \033[0m"
		gnuplot -p p2_gnu.sh
		echo -e "\033[32mLe Graphique s'est ouvert dans le dossier graphique_gnuplot. \033[0m"
		Tris_Tris $@
		
	elif [[ $test3 = "-p3" ]]; then #Si l'argument saisi est "-p3", alors exécuter la commande suivante. 
		cut -f1,2,7 -d ";" lieu.csv > pression3.csv #Script qui permet d'inscrire l'identifiant de la station, la date, l'heure et la pression moyenne de chaque station dans un fichier csv nommé pression3.csv.
		sed '1d' pression3.csv > pression3_1.csv #On copie le fichier dans un second fichier, en supprimant la première ligne inutile pour nos calculs.
		sort -t, -k2n pression3_1.csv > pression3_2.csv #On trie le fichier dans l'ordre croissant des dates dans la colonne 2.
		grep -v ";$" pression3_2.csv > pression3_3.csv #On copie les lignes non vides dans un nouveau fichier.
		sort -t, -k1n pression3_3.csv > pression3_4.csv #On trie le fichier dans l'ordre croissant des numéros de stations dans la colonne 2.
		rm pression3.csv #On supprime le fichier temporaire.
		rm pression3_1.csv #On supprime le fichier temporaire.
		rm pression3_2.csv #On supprime le fichier temporaire.
		rm pression3_3.csv #On supprime le fichier temporaire.
		echo -e "\033[32mUne option de mode a bien été enregistrée. \033[0m"
		gnuplot -p p3_gnu.sh
		echo -e "\033[32mLe Graphique s'est ouvert dans le dossier graphique_gnuplot. \033[0m"
		Tris_Tris $@
			
			
	#L'OPTION POUR LE VENT#
	elif [[ $test3 = "-w" ]]; then #Si l'argument saisi est "-w", alors exécuter la commande suivante. 
		cut -f1,4,5,10 -d";" lieu.csv > vent.csv #Script qui permet d'inscrire l'identifiant de la station,la moyenne, la vitesse et les coordonnées du vent pour chaque station dans un fichier csv nommé vent.csv.
		sed '1d' vent.csv > vent_1.csv #On copie le fichier dans un second fichier, en supprimant la première ligne inutile pour nos calculs.
		sort -t, -k1n vent_1.csv > vent_2.csv #On trie le fichier dans l'ordre croissant des numéros de station dans la colonne 1.
		grep -v ";$" vent_2.csv > vent_3.csv #On copie les lignes non vides dans un nouveau fichier.
		sed 's/,/;/g' vent_3.csv > vent_4.csv
		awk -F";" 'BEGIN {num=0;tot=0;coord1=0;coord2=0}{
			if(num!=$1){
				if(tot!=0){
					print num";"sum/tot";"sum2/tot";"coord1";"coord2
				} 
				num=$1;
				sum=0;
				sum2=0;
				tot=0;
				coord1=$4;
				coord2=$5;
			}
			sum += $2; tot++;
			sum2 += $3;
		}
		END {print num";"sum/tot";"sum2/tot";"coord1";"coord2}' vent_4.csv > vent_5.csv #Cette commande awk permet de calculer la moyenne de la direction et de la vitesse du vent de chaque station et de mettre les résultats dans le fichier "vent_5.csv".
		rm vent.csv #On supprime le fichier temporaire.
		rm vent_1.csv #On supprime le fichier temporaire.
		rm vent_2.csv #On supprime le fichier temporaire.
		rm vent_3.csv #On supprime le fichier temporaire.
		rm vent_4.csv #On supprime le fichier temporaire.
		echo -e "\033[32mUne option de mode a bien été enregistrée. \033[0m"
		gnuplot -p w_gnu.sh
		echo -e "\033[32mLe Graphique s'est ouvert dans le dossier graphique_gnuplot. \033[0m"
		Tris_Tris $@
			
			
	#L'OPTION L'ALTITUDE#
	elif [[ $test3 = "-h" ]]; then #Si l'argument saisi est "-h", alors exécuter la commande suivante. 
		cut -f1,10,14 -d ";" lieu.csv > altitude.csv #Script qui permet d'inscrire l'identifiant de la station, l'altitude et les coordonnées de chaque station dans un fichier csv nommé altitude.csv.
		sed '1d' altitude.csv > altitude_1.csv #On copie le fichier dans un second fichier, en supprimant la première ligne inutile pour nos calculs.
		sort -t, -k2nr altitude_1.csv > altitude_2.csv #On trie le fichier dans l'ordre décroissant des valeurs d'altitude dans la colonne 2.
		grep -v ";$" altitude_2.csv > altitude_3.csv #On copie les lignes non vides dans un nouveau fichier.
		sed 's/,/;/g' altitude_3.csv > altitude_4.csv
		awk -F";" 'BEGIN {num="";coord1=0;coord2=0}{
			if(num!=$1){
				print num";"val";"coord1";"coord2
				num=$1;
				val=$4;
				coord1=$2;
				coord2=$3;
			}
			if($2>val){
				val=$2;
			}
		}
		END {print num";"val";"coord1";"coord2}' altitude_4.csv > altitude_5.csv #Cette commande awk permet de calculer l'altitude de chaque station et de mettre les résultats dans le fichier "altitude_5.csv".
		sed '1d' altitude_5.csv > altitude_6.csv #On copie les lignes non vides dans un nouveau fichier.
		rm altitude.csv #On supprime le fichier temporaire.
		rm altitude_1.csv #On supprime le fichier temporaire.
		rm altitude_2.csv #On supprime le fichier temporaire.
		rm altitude_3.csv #On supprime le fichier temporaire.
		rm altitude_4.csv #On supprime le fichier temporaire.
		rm altitude_5.csv #On supprime le fichier temporaire.
		echo -e "\033[32mUne option de mode a bien été enregistrée. \033[0m"
		gnuplot -p h_gnu.sh
		echo -e "\033[32mLe Graphique s'est ouvert dans le dossier graphique_gnuplot. \033[0m"
		Tris_Tris $@
			
			
	#L'OPTION POUR L'HUMIDITE#
	elif [[ $test3 = "-m" ]]; then #Si l'argument saisi est "-m", alors exécuter la commande suivante. 
		cut -f1,6,10 -d ";" lieu.csv > humidite.csv #Script qui permet d'inscrire l'identifiant de la station, l'humidité et les coordonnées de chaque station dans un fichier csv nommé humidite.csv.
		sed '1d' humidite.csv > humidite_1.csv #On copie le fichier dans un second fichier, en supprimant la première ligne inutile pour nos calculs.
		sort -t, -k2nr humidite_1.csv > humidite_2.csv #On trie le fichier dans l'ordre décroissant des valeurs d'humidité dans la colonne 2.
		grep -v ";$" humidite_2.csv > humidite_3.csv #On copie les lignes non vides dans un nouveau fichier.
		sed 's/,/;/g' humidite_3.csv > humidite_4.csv
		awk -F";" 'BEGIN {num="";coord1=0;coord2=0}{
			if(num!=$1){
				print num";"max";"coord1";"coord2
				num=$1;
				max=$2;
				coord1=$3;
				coord2=$4;
			}
			if($2>max){
				max=$2;
			}
		}
		END {print num";"max";"coord1";"coord2}' humidite_4.csv > humidite_5.csv #Cette commande awk permet de calculer le maximum pour l'humidité de chaque station et de mettre les résultats dans le fichier "humidite_5.csv".
		sed '1d' humidite_5.csv > humidite_6.csv #On copie le fichier dans un second fichier, en supprimant la première ligne inutile pour nos calculs.
		rm humidite.csv #On supprime le fichier temporaire.
		rm humidite_1.csv #On supprime le fichier temporaire.
		rm humidite_2.csv #On supprime le fichier temporaire.
		rm humidite_3.csv #On supprime le fichier temporaire.
		rm humidite_4.csv #On supprime le fichier temporaire.
		echo -e "\033[32mUne option de mode a bien été enregistrée. \033[0m"
		gnuplot -p m_gnu.sh
		echo -e "\033[32mLe Graphique s'est ouvert dans le dossier graphique_gnuplot. \033[0m"
		Tris_Tris $@
	else
		echo -e "\033[31mErreur! Vous n'avez pas entré d'argument pour le mode. Veuillez réessayer. \033[0m"
		rm lieu.csv
		exit 1
	fi
}

	#LA FONCTION "Tris_Modes" PERMET DE RECUPERER L'ARGUMENT CORRESPONDANT AU MODE#
Tris_Modes () {
	test3=" " #Variable qui permet de vérifier si un argument de mode à déjà été lu.
	for arg3 in "$@"; do #Cette boucle permet de vérifier si la personne a entré plusieurs fois un argument de mode, si c'est le cas, on affiche un message d'erreur et on quitte le programme.
		if [[ $arg3 = "-t1" ]] || [[ $arg3 = "-t2" ]] || [[ $arg3 = "-t3" ]] || [[ $arg3 = "-p1" ]] || [[ $arg3 = "-p2" ]] || [[ $arg3 = "-p3" ]] || [[ $arg3 = "-w" ]] || [[ $arg3 = "-h" ]] || [[ $arg3 = "-m" ]]; then
			test3=$arg3
			Options_Modes "test3" $@ #On appelle la fonction avec commme argument, le mode et les arguments entrés par l'utilisateur.
		fi
	done
	if [[ $test3 = " " ]]; then #Si variable est toujours à 0, on affiche un message d'erreur et on sort de la fonction.
		echo -e "\033[31mErreur! Vous n'avez pas entré de type de mode. Veuillez réessayer. \033[0m"
		rm lieu.csv #On supprime le fichier temporaire "lieu.csv".
		exit 1 #On quitte le programme.
	fi
}


	 #LA FONCTION "Options_Dates" PERMET DE SELECTIONNER LA DATE QUE L'UTILISATEUR A ENTRÉ EN ARGUMENT#
Options_Dates () {
	#LES OPTIONS POUR LA DATE#
	#if [[ $date_min < 2010-(0[1-9]|1[0-2])-(0[1-9]|[12][0-9]|3[01])$ ]] || [[ $date_max > 2020-(0[1-9]|1[0-2])-(0[1-9]|[12][0-9]|3[01])$ ]]; then
		echo -e "\033[31mErreur! La date n'est pas valide. Veuillez réessayer. \033[0m"
		exit 1 #On quitte le programme.
	#fi
	
	if [[ "date_min" > "date_max" ]]; then
		echo -e "\033[31mErreur! La date minimale ne peut pas être plus grande que la date maximale. Veuillez réessayer. \033[0m"
		exit 1 #On quitte le programme.
	fi
		#grep -v < 
		echo "ok"
}

	#LA FONCTION "Tris_Dates" PERMET DE RECUPERER L'ARGUMENT CORRESPONDANT A LA DATE#
Tris_Dates () {
	test2=" "
	#cette boucle verifie que la personne n'a entrée qu'une seule fois la date 
	for ((arg2 = 1 ; arg2 <= $# ; arg2++)); do
		if [[ $test2 != " " ]]; then
			echo -e "\033[31mErreur! Vous ne pouvez pas entrer plusieurs fois la date. Veuillez réessayer. \033[0m"
			exit 1 #On quitte le programme.
		fi
		if [[ ${!arg2} = "-d" ]]; then
			arg2=$(( arg2+1 ))
			test2=1
			arg2=$date_min
			arg2=$(( arg2+1 ))
			arg2=$date_max
		fi
		echo "$date_min"
		echo "$date_max"
	done
	Options_Dates $date_min $date_max $@
}



	#LA FONCTION "Options_Lieux" PERMET DE SELECTIONNER LE LIEU QUE L'UTILISATEUR A ENTRÉ EN ARGUMENT#
Options_Lieux () {
	#LES OTPIONS DE LIEUX#
	if [[ $test = "-F" ]]; then
		cat $file | grep -e "^07..." > lieu.csv
		echo -e "\033[32mLe lieu à bien été enregistré. \033[0m"
		Tris_Modes $@ #On appelle la fonction avec commme argument, les arguments entrés par l'utilisateur.
	elif [[ $test = "-G" ]]; then
		cat $file | grep -e "^814.." > lieu.csv
		echo -e "\033[32mLe lieu à bien été enregistré. \033[0m"
		Tris_Modes $@
	elif [[ $test = "-S" ]]; then
		cat $file | grep -e "^71805" > lieu.csv
		echo -e "\033[32mLe lieu à bien été enregistré. \033[0m"
		Tris_Modes $@
	elif [[ $test = "-A" ]]; then
		cat $file | grep -e "^78890" -e "^78897" -e "^78894" -e "^78922" -e "^78995" > lieu.csv
		echo -e "\033[32mLe lieu à bien été enregistré. \033[0m"
		Tris_Modes $@
	elif [[ $test = "-O" ]]; then
		cat $file | grep -e "^61980" -e "^67005" > lieu.csv
		echo -e "\033[32mLe lieu à bien été enregistré. \033[0m"
		Tris_Modes $@
	elif [[ $test = "-Q" ]]; then
		cat $file | grep -e "^6197." -e "^6199." > lieu.csv
		echo -e "\033[32mLe lieu à bien été enregistré. \033[0m"
		Tris_Modes $@
	else
		cp $file lieu.csv
		echo -e "\033[32mLe lieu à bien été enregistré. \033[0m"
		Tris_Modes $@
		#Tris_Dates $@
	fi
}

	#LA FONCTION "Tris_Lieux" PERMET DE RECUPERER L'ARGUMENT CORRESPONDANT AU LIEU#
Tris_Lieux () {
	test=" " #Variable qui permet de vérifier si un argument de tri à déjà été lu.
	for arg in "$@"; do #Cette boucle permet de vérifier si la personne a entré plusieurs fois un argument de lieu, si c'est le cas, on affiche un message d'erreur et on quitte le programme.
		if [[ $arg = "-F" ]] || [[ $arg = "-G" ]] || [[ $arg = "-S" ]] || [[ $arg = "-A" ]] || [[ $arg = "-O" ]] || [[ $arg = "-Q" ]]; then
			if [[ $test != " " ]]; then
				echo -e "\033[31mErreur! Vous ne pouvez pas entrer plusieurs lieux. Veuillez réessayer. \033[0m"
				exit 1 #On quitte le programme.
			fi
			test=$arg
		fi
	done
	Options_Lieux $file "test" $@ #On appelle la fonction avec commme argument, le lieu et les arguments entrés par l'utilisateur.
}

	#LA FONCTION "Option_Verification" PERMET DE VERIFIER QUE L'ULITISATEUR A ENTRÉ UN ARGUMENT VALIDE, AINSI QUE LE NOM DU FICHIER ".csv"#
Option_Verification () {
	test=" " #Variable qui permet de vérifier si un argument de tri à déjà été lu.
	for ((arg = 1 ; arg <= $# ; arg++)); do #Cette boucle permet de vérifier si la personne a entré un argument valide, si ce n'est pas le cas, on affiche un message d'erreur et on quitte le programme.
		if [[ ${!arg} != "-t1" ]] && [[ ${!arg} != "-t2" ]] && [[ ${!arg} != "-t3" ]] && [[ ${!arg} != "-p1" ]] && [[ ${!arg} != "-p2" ]] && [[ ${!arg} != "-p3" ]] && [[ ${!arg} != "-w" ]] && [[ ${!arg} != "-h" ]] && [[ ${!arg} != "-m" ]] && [[ ${!arg} != "-F" ]] && [[ ${!arg} != "-G" ]] && [[ ${!arg} != "-S" ]] && [[ ${!arg} != "-A" ]] && [[ ${!arg} != "-O" ]] && [[ ${!arg} != "-Q" ]] && [[ ${!arg} != "--tab" ]] && [[ ${!arg} != "--abr" ]] && [[ ${!arg} != "--avl" ]] && [[ ${!arg} != "--help" ]] && [[ ${!arg} != "-f" ]] && [[ ${!arg} != *.csv ]] && [[ ${!arg} != "-d" ]] && [[ ! ${!arg} =~ ^[0-9]{4}-(0[1-9]|1[0-2])-(0[1-9]|[12][0-9]|3[01])$ ]]; then
			echo -e "\033[31mErreur! Vous n'avez pas entré un argument valide. Veuillez réessayer. \033[0m"
			exit 1 #On sort du programme.
		elif [[ ${!arg} = "-f" ]]; then #Si un des arguments est un "-f", on rentre dans la condition.
			arg=$(( arg+1 ))
			test=1
			if [[ ${!arg} = *.csv ]]; then #Si l'argument arpès le "-f" est un fichier se finissant par ".csv", on indique que l'utilisateur à entré un nom de fichier valide. Sinon, on lui affiche un message d'erreur.
				file=${!arg}
				echo -e "\033[32mVous avez bien entré le nom du fichier. \033[0m"
				if [ -f "$file" ]; then
				  echo -e "\033[32mLe fichier existe. \033[0m"
				else
				  echo -e "\033[31mErreur! Le fichier n'existe pas. Veuillez réessayer. \033[0m"
				  exit 1
				 fi
			else
				echo -e "\033[31mErreur! Vous n'avez pas entré le nom du fichier. Veuillez réessayer. \033[0m"
				exit 1 #On sort du programme.
			fi
		fi
	done
	if [[ $test = " " ]]; then #Si la variable est toujours à 0, on affiche un message d'erreur et on quitte le programme.
		echo -e "\033[31mErreur! Vous n'avez pas entré le nom du fichier. Veuillez réessayer. \033[0m"
		exit 1 #On sort du programme.
	fi
	
	test2=" " #Variable qui permet de vérifier si un argument de tri à déjà été lu.
	for ((arg2 = 1 ; arg2 <= $# ; arg2++)); do #cette boucle permet de vérifier si la personne à entrée la bonne syntaxe pour la date, si ce n'est pas le cas, on affiche un message d'erreur et on quitte le programme.
		if [[ ${!arg2} = "-d" ]]; then
			arg2=$(( arg2+1 ))
			test2=1
			if [[ ${!arg2} =~ ^[0-9]{4}-(0[1-9]|1[0-2])-(0[1-9]|[12][0-9]|3[01])$ ]]; then
				date_min=${!arg2}
				arg2=$(( arg2+1 ))
				test2=1
				if [[ ${!arg2} =~ ^[0-9]{4}-(0[1-9]|1[0-2])-(0[1-9]|[12][0-9]|3[01])$ ]]; then
					date_max=${!arg2}
				else
					echo -e "\033[31mErreur! La date n'est pas valide. Veuillez réessayer. \033[0m"
					exit 1 #On quitte le programme.
				fi
			else
				echo -e "\033[31mErreur! La date n'est pas valide. Veuillez réessayer. \033[0m"
				exit 1 #On quitte le programme.
			fi
			test2=$arg2
			if [[ $date_min > $date_max ]]; then
				echo -e "\033[31mErreur! La date minimale ne peut pas être plus grande que la date maximale. Veuillez réessayer. \033[0m"
				exit 1 #On quitte le programme.
			else
				echo -e "\033[32mLa syntaxe de la date est valide. \033[0m"
			fi
		fi
	done
	Tris_Lieux $file $@  #On appelle la fonction avec commme argument, les arguments entrés par l'utilisateur.
}

	#LA FONCTION "Option_Help" PERMET DE VERIFIER ET D'AFFICHER LES OPTIONS QUE PEUT EFFECTUER L'UTILISATEUR SI IL LE DEMANDE, SINON, ON VÉRIFIE QUE CELUI-CI N'A PAS ENTRÉ PLUSIEURS FOIS LE MÊME ARGUMENT#	
Option_Help () {	
	#L'OPTION --HELP#
for arg in "$@"; do
	if [[ $arg = "--help" ]]; then #Condition selon laquelle si un des arguments est "--help", le programme doit afficher toutes les options de type de données, de lieu et de tris et quitter le programme.
		echo " "
		echo -e "\033[34mVoici les options de type de données : \033[0m"
		echo -e "\033[32m-t<mode> : pour avoir la température; \033[0m"
		echo -e "\033[32m	-> t1 : températures minimales, maximales et moyennes par station et dans l'ordre croissant du numéro de station; \033[0m"
		echo -e "\033[32m	-> t2 : températures moyennes sur toutes les stations, par date/heure et triées dans l'ordre chronologique; \033[0m"
		echo -e "\033[32m	-> t3 : températures par date/heure et triées dans l'ordre chronologique, puis dans l'ordre croissant de l'identifiant de la station. \033[0m"
		echo	-e "\033[32m-p<mode> : pour avoir la pression atmosphérique; \033[0m"
		echo -e "\033[32m	-> t1 : pressions minimales, maximales et moyennes par station et dans l'ordre croissant du numéro de station; \033[0m"
		echo -e "\033[32m	-> t2 : pression moyennes sur toutes les stations, par date/heure et triées dans l'ordre chronologique; \033[0m"
		echo -e "\033[32m	-> t3 : pression par date/heure et triées dans l'ordre chronologique, puis dans l'ordre croissant de l'identifiant de la station. \033[0m"
		echo " "
		echo -e "\033[32m-w : pour avoir le vent; \033[0m"
		echo -e "\033[32m-m : pour avoir l'humidité; \033[0m"
		echo -e "\033[32m-h : pour avoir l'altitude de chaque station; \033[0m"
		echo -e "\033[31mToute fois, vous pouvez entrer plusieurs de ces options. \033[0m"
		echo " "
		echo -e "\033[34mVoici les options de lieux : \033[0m"
		echo -e "\033[32m-F : pour avoir la France métropolitaine et la Corse; \033[0m"
		echo -e "\033[32m-G : pour avoir la Guyane française; \033[0m"
		echo -e "\033[32m-S : pour avoir Saint-Pierre et Miquelon; \033[0m"
		echo -e "\033[32m-A : pour avoir les Antilles; \033[0m"
		echo -e "\033[32m-O : pour avoir l'Océan indien; \033[0m"
		echo -e "\033[32m-Q : pour avoir l'Antarctique; \033[0m"
		echo -e "\033[31mToute fois : \033[0m"
		echo -e "\033[31m- Cette option n'est pas obligatoire. Si aucune de ces options n'est entrée, la zone séléctionée sera le monde entier; \033[0m"
		echo -e "\033[31m- Vous ne pouvez pas entrer plusieurs lieux. \033[0m"
		echo " "
		echo -e "\033[34mVoici les options de temps : \033[0m"
		echo -e "\033[32m-d<min><max> : pour avoir la date; \033[0m"
		echo -e "\033[32mle format pour la date est le suivant : -d YYYY-MM-DD YYYY-MM-DD; \033[0m"
		echo -e "\033[31mToute fois : \033[0m"
		echo -e "\033[31m- Vous ne pouvez pas entrer plusieurs fois d'intervalle de temps. \033[0m"
		echo " "
		echo -e "\033[34mVoici les options de tris : \033[0m"
		echo -e "\033[32m--tab : pour trier à l'aide d'une liste chaînée; \033[0m"
		echo -e "\033[32m--abr : pour trier à l'aide d'un arbre binaire de recherche ABR; \033[0m"
		echo -e "\033[32m--avl : pour trier à l'aide d'un arbre binaire de recherche équilibré AVL; \033[0m"
		echo -e "\033[31mToute fois : \033[0m"
		echo -e "\033[31m- Cette option n'est pas obligatoire. Si aucune de ces options n'est entrée, le tri sera fait à l'aide d'un arbre binaire de recherche équilibré AVL. \033[0m"
		echo -e "\033[31m- Vous ne pouvez pas entrer plusieurs mode de tri. \033[0m"
		echo " "
		echo -e "\033[32m-f <nomdufichier> : pour entrer le nom du fichier; \033[0m"
		echo -e "\033[32mle format pour le fichier est le suivant : -f 'nomfichier'.csv ; \033[0m"
		echo -e "\033[31m- Cette option est obligatoire."
		echo " "
		echo -e "\033[31mAttention ! \033[0m"
		echo -e "\033[31mVous ne pouvez pas entrer plusieurs fois le même argument. Si cela arrive, un message d'erreur vous sera affiché. \033[0m"
		echo " "
		exit 0 #On sort du programme.
	fi
done	

	if [[ $# = 0 ]]; then #Condition selon laquelle si l'utilisateur n'écrit aucun argument, le programme doit afficher une erreur et sortir du programme.
		echo -e "\033[31mErreur! Vous n'avez pas entré d'argument. Veuillez réessayer. \033[0m" #Il y a une erreur, l'utilisateur doit réessayer.
		exit 1 #On sort du programme.
	else #Condition selon laquelle si l'utilisateur a entré au moins un argument, et qu'il est différent de "--help", on vérifie que celui-ci n'a pas entré plusieurs fois le même argument, si c'est le cas, nous affichons un message d'erreur et quittons le programme.
		seen_args=()
		for arg in "$@"; do #Condition selon laquelle si l'utilisateur a entré plusieurs fois le même argument, le programme affiche un message d'erreur et quitte le programme, sinon, il passe à la suite du programme.
			if [[ ${seen_args[@]} = ${arg} ]]; then
				echo -e "\033[31mErreur! Vous ne pouvez entrer qu'un seul argument de chaque type. Veuillez réessayer. \033[0m"
				exit 1 #On sort le programme.
			else
				seen_args+=($arg)
			fi
		done
		Option_Verification $@ #Nous commencons le programme en appelant la fonction "Option_Verification".
	fi
}
Option_Help $@ #Nous commencons le programme en appelant la fonction "Option_Help".

#echo "plot 'temp1_1.csv'" | gnuplot
