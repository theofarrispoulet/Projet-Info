#include<stdio.h>
#include<stdlib.h>
#define COLOR_RED "\x1b[31m"
#define COLOR_RESET "\x1b[0m"

/*----------On créer la structure Arbre nous permettant de créer et de gérer des arbres----------*/
typedef struct Arbre{
    int elmt; //On créer une variable 'elmt' afin de gérer la valeur chaque élément de l'arbre.
    struct Arbre *fg; //On créer un pointeur 'fg' permettant d'accéder au fils gauche de l'arbre.
    struct Arbre *fd; //On créer un pointeur 'fd' permettant d'accéder au fils gauche de l'arbre.
}Arbre;
typedef Arbre *pArbre; //On défini un pointeur pArbre pointant sur Arbre.
/*----------On créer la structure File nous permettant de créer et de gérer des files----------*/
typedef struct File{ //
	struct Arbre *tete;
	struct Arbre *queue;
}File;
/*----------On créer la structure Liste nous permettant de créer et de gérer des listes----------*/
typedef struct Liste {
	pArbre val;
	struct Liste * suivant;
}Liste;
typedef Liste* Pliste; //On défini un pointeur pliste pointant sur Liste.
/*----------On créer la structure sFile nous permettant de créer et de gérer des files----------*/
typedef struct sFile {
	Pliste tete;
	Pliste queue;
}sFile;

pArbre creerArbre(int e);
int estVide(pArbre  a);
int estFeuille(pArbre a);
int element(pArbre a);
int existeFilsGauche(pArbre a);
int existeFilsDroit(pArbre a);
int traiter(int a);
void recursifPrefixe(pArbre a);
void recursifPostfixe(pArbre a);
void recursifInfixe(pArbre a);
void decroissante(pArbre a);
void parcoursLargeur(pArbre a, sFile f);
pArbre insertABR(pArbre a, int e);
pArbre supprimerFilsGauche(pArbre a);
pArbre supprimerFilsDroit(pArbre a);
Pliste CreerElemenListe(pArbre p);
void CreerFile(sFile *f);
int FileVide(sFile *f);
void enfiler(sFile *f, pArbre e);
pArbre defiler(sFile *f);
pArbre suppMax(pArbre a, int *pe);
pArbre suppression(pArbre a, int e);
