#include "header_AVL.h"

/*----------Cette fonction permet de créer un arbre----------*/
pArbre creerArbre(int e){
	pArbre noeud = malloc(sizeof(Arbre)); //On aloue la mémoire pour l'arbre.
	noeud -> elmt = e; //La valeur de la racine est égale à 'e'.
	noeud -> fg = NULL; //On initialise le fils gauche de l'arbre à NULL.
	noeud -> fd = NULL; //On initialise le fils droit de l'arbre à NULL.
	noeud -> equilibre = 0; //On initialise l'équilibrage de l'arbre à 0.
	return noeud;
}

/*----------Cette fonction permet de vérifier si la valeur passée en paramètre possède un fils gauche----------*/
int existeFilsGauche(pArbre a){
	if(a == NULL){ //Condition selon laquelle si l'arbre n'existe pas, on sort de la fonction.
		exit(1);
	}
	else if(a -> fg == NULL){ //Condition selon laquelle si le fils gauche de 'a' n'existe pas, on retourne 0, sinon, 1.
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
	else if(a -> fd == NULL){ //Condition selon laquelle si le fils gauche de 'a' n'existe pas, on retourne 0, sinon, 1.
		return 0;
	}
	else{
		return 1;
	}
}
/*---------Cette fonction permet d'établir une rotation gauche de l'arbre afin d'obtenir un arbre équilibré---------*/
pArbre rotationGauche(pArbre a){
	pArbre pivot = NULL;
	int eq_a = 0, eq_p = 0;
	pivot = a->fd;
	a -> fd = pivot -> fg;
	pivot -> fg = a;
	eq_a = a -> equilibre;
	eq_p = pivot -> equilibre;
	a -> equilibre = eq_a - fmax(eq_p, 0) -1;
	pivot -> equilibre = fmin(eq_a - 2, fmin(eq_a + eq_p - 2, eq_p - 1));
	a = pivot;
	return a;
}
/*---------Cette fonction permet d'établir une rotation droite de l'arbre afin d'obtenir un arbre équilibré ---------*/
pArbre rotationDroite(pArbre a){
	pArbre pivot = NULL;
	int eq_a = 0, eq_p = 0;
	pivot = a -> fg;
	a -> fg = pivot -> fd;
	pivot -> fd = a;
	eq_a = a -> equilibre;
	eq_p = pivot -> equilibre;
	a -> equilibre = eq_a - fmin(eq_p, 0) + 1;
	pivot -> equilibre = fmax(eq_a + 2, fmax(eq_a + eq_p + 2, eq_p + 1));
	a = pivot;
	return a;	
}
/*---------Cette fonction permet de ---------*/
pArbre doubleRotationGauche(pArbre a){
	a -> fd = rotationDroite(a->fd);
	return rotationGauche(a);
}

pArbre doubleRotationDroite(pArbre a){
	a -> fg = rotationGauche(a->fg);
	return rotationDroite(a);
}

/*----------Cette fonction permet d'afficher la valeur de l'arbre entrer en paramètre----------*/
int traiter(int a){
	printf("%d \n",a); //On affiche 'a'.
}

/*----------Cette fonction permet de retourner l'élément de l'arbre----------*/
int element(pArbre a){
	if(a == NULL){ //Condition selon laquelle si l'arbre n'existe pas, on sort de la fonction, sinon, on retourne l'élément de 'a'.
		exit(1);
	}
	return a -> elmt;
}

/*----------Cette fonction permet d'afficher de façon "préfixe" les valeurs de l'arbre----------*/
void recursifPrefixe(pArbre a){
	if(a != NULL){ //Condition selon laquelle si l'abre existe, on continue la fonction.
		traiter(element(a)); //On affiche la valeur de 'a'.
		recursifPrefixe(a -> fg);
		recursifPrefixe(a -> fd);
	}
}

/*----------Cette fonction permet d'équilibrer l'arbre----------*/
pArbre equilibreAVL(pArbre a){
	if( a-> equilibre >= 2){ //Condition selon laquelle si l'équilibrage de 'a' est supérieur ou égal à -2, aller dans la condition.
		if(a -> fd -> equilibre >= 0){ //Condition selon laquelle si l'équilibrage du fils droit de 'a' est supérieur ou égal à 0, faire la rotation gauche de 'a'.
			return rotationGauche(a);
		}
		else{ //Sinon, faire la double rotation droite de 'a'.
			return doubleRotationGauche(a);
		}
	}
	else if(a -> equilibre <= - 2){ //Condition selon laquelle si l'équilibrage de 'a' est inférieur ou égal à -2, aller dans la condition.
		if(a -> fg -> equilibre <= 0){ //Condition selon laquelle si l'équilibrage du fils gauche de 'a' est inférieur ou égal à 0, faire la rotation gauche de 'a'. 
			return rotationGauche(a);
		}
		else{ //Sinon, faire la double rotation droite de 'a'.
			return doubleRotationDroite(a);
		}
	}
	return a;
}

/*----------Cette fonction permet d'inserer les valeurs dans l'arbre----------*/
pArbre insertAVL(pArbre a, int e, int *h){
	if(a == NULL){ //Condition selon laquelle si l'arbre n'existe pas, le pointeur 'h' est égal à 1 et on créer un arbre.
		*h = 1;
		return creerArbre(e);
	}
	else if(e < a -> elmt){ //Condition selon laquelle si la valeur de 'a' est plus grande que 'e', ?????
		a -> fg = insertAVL(a -> fg, e, h);
		*h = - *h;
	}
	else if(e > a -> elmt){ //Condition selon laquelle si la valeur de 'a' est plus petite que 'e', ?????
		a -> fd = insertAVL(a -> fd, e, h);
	}
	else{ //Si les deux conditions précedentes ne sont pas vrai, le pointeur 'h' est égal à 0 et on retourne a.
		*h = 0;
		return a;
	}
	if(*h != 0){ //Condition selon laquelle si le pointeur 'h' est différent de 0, faire les 2 lignes suivantes.
		a -> equilibre = a -> equilibre + *h;
		a = equilibreAVL(a);
		if(a -> equilibre == 0){ //Condition selon laquelle si l'équilibre de 'a' est égal à 0, le pointeur 'h' est égal à 0, sinon, égal à 1.
			*h = 0;
		}
		else{ //Sinon, le pointeur 'h' est égal à 1.
			*h = 1;
		}
	}
	return a;
}	

pArbre suppAVL(pArbre a, int e, int *h){
	if(a == NULL){
     	*h = 0;
     	return a;
     }
     else if(e < a -> elmt){
          a -> fg = suppAVL(a -> fg, e, h);
          *h = - *h;
     }
     else if(e > a -> elmt)
          a -> fd = suppAVL(a -> fd, e, h);
     else{
          if(a -> fd)
          	a -> fd = suppMinAVL(a -> fd, h, &(a -> elmt));
          else{
               pArbre tmp = a;
         		a = a -> fg;
               free(tmp);
               *h = - 1;
		}
	}
     if(*h != 0){
          a -> equilibre += *h;
          a = equilibreAVL(a);
		if(a -> equilibre == 0)
			*h = - 1;
		else
			*h = 0;
	}
}

pArbre suppMinAVL(pArbre a, int *h, int *minfd){
	pArbre tmp;
	if (a->fg == NULL){
		*minfd = a -> elmt;
		*h = - 1;
		tmp = a -> fd;
		free(a);
		return tmp;
	}
	else{
		a -> fg = suppMinAVL(a -> fg, h, minfd);
		*h = - *h;
	}
	if (*h != 0) {
		a -> equilibre = a -> equilibre + *h;
		a = equilibreAVL(a);
		if (a -> equilibre == 0){
			*h = - 1;
		}
		else{
			*h = 0;
		}
	}
	return a;
}

void triSelection(float tab[], int taille){
	int i;
	int temp;	
	for (i=0; i<TAILLE-1; i++){
		int min=i;
		for(int j=i+min; j<TAILLE; j++){
			if (tab[j]<tab[min]){
				min=j;
			}
		}
		if (min!=i){
			temp=tab[min];
			tab[min]=tab[i];
			tab[i]=temp;
		}
	}
}

void triInsertion(float tab[],int taille){
	int i,j;
	float temp;
		for(i=1;i<TAILLE; i++){
			temp=tab[i];
			j=i-1;
			while ((j>=0) && (tab[j]>temp)){
				tab[j+1]=tab[j];
				j=j-1;
			}
			tab[j+1]=temp;
		}
}
int main(){
	int *h = NULL;
	pArbre a = NULL;
	FILE *fichier = fopen("temp.csv", "r");
	/*if (fichier == NULL){
		printf(COLOR_RED "Le fichier est vide. \n" COLOR_RESET);
		return 0;
	}*/
	printf(COLOR_RED "Nous n'avons pas vu coder la partie C, le tri c'est donc fait en shell. \n" COLOR_RESET);
	/*int elmt;
	while(fscanf(fichier, "%d", &elmt) == 0){
		insertAVL(a, elmt, h);
	}
	printf("PreFixe :\n");
	recursifPrefixe(a);*/
	return 0;
}
