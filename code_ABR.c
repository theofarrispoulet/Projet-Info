#include "header_ABR.h"

/*----------Cette fonction permet de créer un arbre----------*/
pArbre creerArbre(int e){
    pArbre noeud = malloc(sizeof(pArbre)); //On aloue la mémoire pour l'arbre. 
    noeud -> elmt = e; //La valeur de la racine est égale à 'e'.
    noeud -> fg = NULL; //On initialise le fils gauche de l'arbre à NULL.
    noeud -> fd = NULL; //On initialise le fils droit de l'arbre à NULL.
    return noeud;
}

int estVide(pArbre a){
	if(a == NULL){
		return 0;
	}
	else{
		return 1;
	}
}

/*----------Cette fonction permet de savoir si l'arbre possède des feuilles ou non----------*/
int estFeuille(pArbre a){
    if(a == NULL){ //Condition selon laquelle si l'arbre n'existe pas, on sort de la fonction.
        exit(1);
    }
    if(a -> fg == NULL && a -> fd == NULL){ //Condition selon laquelle si l'arbre ne possède ni fils gauche, ni fils droit, on retourne 0, sinon, 1.
        return 0;
    }
    else{
        return 1;
    }
}

/*----------Cette fonction permet de retourner l'élément de 'a', passé en paramètre----------*/
int element(pArbre a){
    if(a == NULL){ //Condition selon laquelle si l'arbre n'existe pas, on sort de la fonction, sinon, on retourne l'élément de 'a'.
        exit(1);
    }
    return a -> elmt;
}

/*----------Cette fonction permet de vérifier si la valeur passée en paramètre possède un fils gauche----------*/
int existeFilsGauche(pArbre a){
    if(a == NULL){ //Condition selon laquelle si l'arbre n'existe pas, on sort de la fonction.
        exit(1);
    }
    if(a -> fg == NULL){ //Condition selon laquelle si le fils gauche de 'a' n'existe pas, on retourne 0, sinon, 1.
        return 0;
    }
    else{
        return 1;
    }
}

/*----------Cette fonction permet de vérifier si la valeur passée en paramètre possède un fils droit----------*/
int existeFilsDroit(pArbre a){
    if(a == NULL){ //Condition selon laquelle si l'arbre n'existe pas, on sort de la fonction.
        exit(1);
    }
    if(a -> fd == NULL){ //Condition selon laquelle si le fils gauche de 'a' n'existe pas, on retourne 0, sinon, 1.
        return 0;
    }
    else{
        return 1;
    }
}

/*----------Cette fonction permet d'afficher la valeur de l'arbre entrer en paramètre----------*/
int traiter(int a){
    printf("%d \n", a); //On affiche 'a'.
}

/*----------Cette fonction permet d'afficher de façon "préfixe" les valeurs de l'arbre----------*/
void recursifPrefixe(pArbre a){
    if(a != NULL){ //Condition selon laquelle si l'abre existe, on continue la fonction.
        traiter(element(a)); //On affiche la valeur de 'a'.
        recursifPrefixe(a -> fg);
        recursifPrefixe(a -> fd);
    }
}

/*----------Cette fonction permet d'afficher de façon "postfixe" les valeurs de l'arbre----------*/
void recursifPostfixe(pArbre a){
    if(a != NULL){ //Condition selon laquelle si l'abre existe, on continue la fonction.
        recursifPostfixe(a -> fg);
        recursifPostfixe(a -> fd);
        traiter(element(a)); //On affiche la valeur de 'a'.
    }
}

/*----------Cette fonction permet d'afficher de façon croissante les valeurs de l'arbre----------*/
void recursifInfixe(pArbre a){
    if(a != NULL){ //Condition selon laquelle si l'abre existe, on continue la fonction.
        recursifInfixe(a -> fg);
        traiter(element(a)); //On affiche la valeur de 'a'.
        recursifInfixe(a -> fd);
    }
}

/*----------Cette fonction permet d'afficher de façon décroissante les valeurs de l'arbre----------*/
void decroissante(pArbre a){
    if(a != NULL){ //Condition selon laquelle si l'abre existe, on continue la fonction.
        decroissante(a -> fd);
        traiter(element(a)); //On affiche la valeur de 'a'.
        decroissante(a -> fg);
    }
}
/*----------Cette fonction permet de parcourir en largeur l'arbre saisi----------*/
void parcoursLargeur(pArbre a, sFile f){
	pArbre x;
	if(estVide(a) == 1){ //Condition selon laquelle, si l'arbre existe, on enfile et défile afin deparcourir l'arbre en largeur.
		CreerFile(&f);
		enfiler(&f, a);
		while(FileVide(&f) == 1){ //Tant qu'il existe des élément dans l'arbre, continuer de parcourir et d'afficher les éléments.
			x = defiler(&f);
			traiter(element(x));
			if(existeFilsGauche(x) == 1){
				enfiler(&f, x -> fg);
			}
			if(existeFilsDroit(x) == 1){
				enfiler(&f, x -> fd);
			}
		}
	}
}

/*----------Cette fonction permet d'inserer les valeurs dans l'arbre----------*/
pArbre insertABR(pArbre a, int e){
    if(a == NULL){ //Condition selon laquelle si l'Arbre n'existe pas, on en créer avec la valeur passée en paramètre 'a'.
        a = creerArbre(e);
    }
    if(e < a -> elmt){ //Condition selon laquelle si la valeur de 'a' est plus grande que 'e', on insert l'élément donné en tant que fils gauche.
        a -> fg = insertABR(a -> fg, e);
    }
    else if(e > a -> elmt){ //Condition selon laquelle si la valeur de 'a' est plus petite que 'e', on insert l'élément donné en tant que fils droit.
        a -> fd = insertABR(a -> fd, e);
    }
    return a; //On retourne a.
}
/*----------Cette fonction permet de supprimer le fils gauche demandé----------*/
pArbre supprimerFilsGauche(pArbre a){
	if (a == NULL){ //Condition selon laquelle si l'élément existe déjà, on affiche une erreur. 
		printf("error !\n");
		exit(1);
	}
	else if(existeFilsGauche(a) == 1){ //Sinon si il existe un fils gauche ou/et droit à l'élément que l'on veut supprimer, on supprime d'abord le fils gauche et/ou droit, puis on supprime l'élément demandé. Ensuite on libère la place de l'élément. 
		if(existeFilsGauche(a -> fg) == 1){
			supprimerFilsGauche(a -> fg);
		}
		if(existeFilsDroit(a -> fg) == 1){
			supprimerFilsDroit(a -> fg);
		}
		free(a -> fg);
		a -> fg = NULL;
	}
}
/*----------Cette fonction permet de supprimer le fils droit demandé----------*/
pArbre supprimerFilsDroit(pArbre a){
	if (a == NULL){
		printf("error !\n");
		exit(1);
	}
	else if(existeFilsDroit(a) == 1){
		if(existeFilsGauche(a -> fd) == 1){
			supprimerFilsGauche(a -> fd);
		}
		if(existeFilsDroit(a -> fd) == 1){
			supprimerFilsDroit(a -> fd);
		}
		free(a -> fd);
		a -> fd = NULL;
	}
}
/*----------Cette fonction permet de créer un élément dans liste----------*/
Pliste CreerElemenListe(pArbre p){
	Pliste n = malloc(sizeof(Liste));
	if(n == NULL){
 		printf("error !\n");
 		exit(1);
 	}
 	n -> val = p;
 	n -> suivant = NULL;
 	return n;
}
/*----------Cette fonction permet de créer une file----------*/
void CreerFile(sFile *f){
	f -> tete = NULL;
	f -> queue = NULL;
}
/*----------Cette fonction permet de vérifier si la file est vide---------*/
int FileVide(sFile *f){
	if(f -> tete == NULL){
 		return 0;
 	}
 	else{
 		return 1;
 	}
}
/*----------Cette fonction permet d'enfiler les éléments demandés----------*/
void enfiler(sFile *f, pArbre e){
	Pliste elmt = CreerElemenListe(e);
 	if(f -> queue == NULL){
 		f -> tete = elmt;
 	}
 	else{
  		f -> queue -> suivant = elmt;
  	}
	f -> queue = elmt;
}
/*----------Cette fonction permet de défiler les éléments demandés----------*/
pArbre defiler(sFile *f){
	Pliste r;
	pArbre element;
	r = f -> tete;
	if(r == NULL){
  		printf("error !\n");
  		exit(1);
 	}
 	f -> tete = r -> suivant;
 	if(r == f -> queue){
  		f -> queue = NULL;
 	} 
 	element = r -> val;
 	free(r); 
	return element;
}
/*----------Cette fonction permet de supprimer l'élément de valeure maximale de l'abre----------*/
pArbre suppMax(pArbre a, int *pe){
	pArbre tmp;
	if(existeFilsDroit(a) == 1){
		a -> fd = suppMax(a -> fd, pe);
	}
	else{
		*pe = element(a);
		tmp = a;
		a = a -> fg;
		free(tmp);
	}
	return a;
}
/*----------Cette fonction permet de supprimer l'arbre saisi----------*/
pArbre suppression(pArbre a, int e){
	pArbre tmp;
	int p = element(a);
	if(a == NULL){
		return a;
	}
	else if(e > a -> elmt){
		a-> fd = suppression(a -> fd, e);
	}
	else if(e < a -> elmt){
		a-> fg = suppression(a -> fg, e);
	}
	else if(existeFilsGauche(a) == 0){
		tmp = a;
		a = a -> fd;
		free(tmp);
	}
	else{
		a -> fg = suppMax(a -> fg, &p);
	}
	return a;
}

int main(){
	pArbre a = NULL;
	FILE *fichier = fopen("temp1_3.csv", "r");
	/*if (fichier == NULL){
		printf(COLOR_RED "Le fichier est vide. \n" COLOR_RESET);
		return 0;
	}*/
	printf(COLOR_RED "Nous n'avons pas vu coder la partie C, le tri c'est donc fait en shell. \n" COLOR_RESET);
	/*int elmt;
	while(fscanf(fichier, "%d", &elmt) == 0){
		insertABR(a, elmt);
	}
	printf("PreFixe :\n");
	recursifPrefixe(a);
	printf("\nPostFixe :\n");
	recursifPostfixe(a);
	printf("\nInFixe :\n");
	recursifInfixe(a);
	printf("\nDécroissant :\n");
	decroissante(a);
	fclose(fichier);*/
	return 0;
}
