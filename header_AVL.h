#include<stdio.h>
#include<stdlib.h>
#include<math.h>
#define COLOR_RED "\x1b[31m"
#define COLOR_RESET "\x1b[0m"
#define TAILLE 100

/*----------On créer la structure Arbre nous permettant de créer et de gérer des arbres----------*/
typedef struct Arbre{
	int elmt; //On créer une variable 'elmt' afin de gérer la valeur chaque élément de l'arbre.
	struct Arbre *fg; //On créer un pointeur 'fg' permettant d'accéder au fils gauche de l'arbre.
	struct Arbre *fd; //On créer un pointeur 'fd' permettant d'accéder au fils gauche de l'arbre.
	int equilibre; //On créer une variable 'equilibre" afin de gérer l'équilibre de l'AVL.
}Arbre;
typedef Arbre *pArbre; //On défini un pointeur pArbre pointant sur Arbre

pArbre creerArbre(int e);
int existeFilsGauche(pArbre a);
int existeFilsDroit(pArbre a);
pArbre rotationGauche(pArbre a);
pArbre rotationDroite(pArbre a);
pArbre doubleRotationGauche(pArbre a);
pArbre doubleRotationDroite(pArbre a);
int traiter(int a);
int element(pArbre a);
void recursifPrefixe(pArbre a);
pArbre equilibreAVL(pArbre a);
pArbre insertAVL(pArbre a, int e, int *h);
pArbre suppAVL(pArbre a, int e, int *h);
pArbre suppMinAVL(pArbre a, int *h, int *minfd);
void triSelection(float tab[], int taille);
void triInsertion(float tab[],int taille);
