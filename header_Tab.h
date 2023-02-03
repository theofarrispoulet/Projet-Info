#include<stdio.h>
#include<stdlib.h>
#define COLOR_RED "\x1b[31m"
#define COLOR_RESET "\x1b[0m"

/*----------On créer la structure Chainon pour les listes chainées----------*/
typedef struct Chainon{
	int elmt; //On créer une variable 'elmt' afin de gérer la valeur de chaque élément de la liste.
	struct Chainon *suivant; //On créer un pointeur 'suivant' nous permettant d'accéder à la valeur suivante de notre liste.
}Chainon;

Chainon *insertDebut(Chainon *pliste, int a);
Chainon *insertFin(Chainon *pliste, int a);
Chainon *ajouterCroissant(Chainon *pliste, int a);
Chainon *inverse(Chainon *pliste, Chainon *pliste2);
void afficheListe(Chainon *pliste);
