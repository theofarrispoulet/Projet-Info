#include "header_Tab.h"

/*----------Cette fonction permet de créer la liste chainée----------*/
Chainon *creationChainon(int a){
	Chainon *c = malloc(sizeof(Chainon)); //On aloue la mémoire pour la liste chainée.
	if(c == NULL){ //Condition selon laquelle si le chainon n'existe pas, on sort de la fonction, sinon, la valeur du chainon est égal à la valeur passée en paramètre 'a'.
		exit(1);
	}
	else{
	c -> elmt = a; //La valeur du chainon est égal à 'a'.
	c -> suivant = NULL; //On initialise le chainon suivant à NULL.
	}
	return c;
}

/*----------Cette fonction permet d'inserer au début la valeur passée en paramètre----------*/
Chainon *insertDebut(Chainon *pliste, int a){
	Chainon *nouveau = creationChainon(a); //On créer un nouveau chainon.
	nouveau -> suivant = pliste; //la valeur du nouveau chainon est égale à 'pliste'.
	return nouveau;
}

/*----------Cette fonction permet d'inserer à la fin, la valeur passée en paramètre----------*/
Chainon *insertFin(Chainon *pliste, int a){
	Chainon *nouveau = creationChainon(a); //On créer un nouveau chainon.
	Chainon *p1 = pliste; //On créer un nouveau chainon.
	if (pliste == NULL){ //Condition selon laquelle si 'pliste' n'existe pas, pliste est égal au nouveau chainon.
		pliste = nouveau;
	}
	else{
		while(p1 -> suivant != NULL){ //Condition selon laquelle tant que le chainon après 'p1' existe, on passe au chainon suivant.
			p1 = p1 -> suivant;
		}
		p1 -> suivant = nouveau; //On met le chainon suivant égal au nouveau chainon.
	}
	return pliste;
}

/*----------Cette fonction permet d'ajouter de façon croissante la valeur passée en paramètre----------*/
Chainon *ajouterCroissant(Chainon *pliste, int a){
	Chainon *nouveau = creationChainon(a); //On créer un nouveau chainon.
	Chainon *p1 = pliste; //On créer un pointeur p1 qui pointe sur pliste.
	if(pliste == NULL){ //Condition selon laquelle si 'pliste' n'existe pas, pliste est égal au nouveau chainon.
		pliste = nouveau;
	}
	else if(pliste -> elmt > a){ //Condition selon laquelle si la valeur de pliste est plus grande que 'a', on insert 'a' au début de la liste.
		pliste = insertDebut(pliste, a);
	}
	else{ //Si aucune des conditions précedente est vrai, on cherche ou inserer 'a'.
		while(p1 -> suivant != NULL && p1 -> suivant -> elmt < a){ //Condition selon laquelle si le chainon arpès 'p1' existe et sa valeur est plus petite que a, on passe au chainon suivant.
			p1 = p1 -> suivant;
		}
		if(p1 -> suivant == NULL){ //Condition selon laquelle si le chainon arpès p1 n'existe pas, on le met égal au nouveau chainon.
			p1 -> suivant = nouveau;
		}
		else{ //Si aucune des conditions précedente est vrai, on met le suivant du nouveau chainon égal au suivant du chainon.
			nouveau -> suivant = p1 -> suivant;
			p1 -> suivant = nouveau; //On met le chainon après p1 égal au nouveau chainon.
		}
	}
	return pliste;
}

/*----------Cette fonction permet d'inverser l'ordre des valeurs dans la liste----------*/
Chainon *inverse(Chainon *pliste, Chainon *pliste2){
	Chainon *p1 = pliste; //On créer un pointeur p1 qui pointe sur pliste.
	while(p1 != NULL){ //Condition selon laquelle tant que p1 existe, on rentre continue la boucle.
		pliste2 = insertDebut(pliste2, p1 -> elmt); //On insert les éléments au début de la liste.
		p1 = p1 -> suivant; //On passe au chainon suivant.
	}
	return pliste2;
}

/*----------Cette fonction permet d'afficher les valeurs inscrient dans la liste----------*/
void afficheListe(Chainon *pliste){
	Chainon *p1 = pliste; //On créer un pointeur p1 qui pointe sur pliste.
	while(p1 != NULL){ //Condition selon laquelle tant que p1 existe, on rentre continue la boucle.
		printf("%d", p1 -> elmt); //On affiche la valeur de 'p1'.
		if(p1 -> suivant != NULL){ //Condition selon laquelle si le chainon après p1 existe, on afficher '->'.
			printf("->"); // on écrit des flèches entre les elmteurs.
		}
		p1 = p1 -> suivant; //On passe au chainon suivant.
	}
	printf("\n\n");
}

int main(){
	Chainon *pliste2 = NULL;
	printf(COLOR_RED "Nous n'avons pas vu coder la partie C, le tri c'est donc fait en shell. \n" COLOR_RESET);
	/*Chainon *pliste = creationChainon(2);
	pliste = ajouterCroissant(pliste,3);
	pliste = ajouterCroissant(pliste,6);
	pliste = ajouterCroissant(pliste,7);
	pliste = insertFin(pliste,8);
	pliste = ajouterCroissant(pliste,5);
	afficheListe(pliste);
	pliste2 = inverse(pliste, pliste2);
	afficheListe(pliste2);*/
	return 0;
}
