#include "main.h"

char* argument(char* a){
	printf("Veuilez entrer votre argument.\n");
	printf("Les arguments disponibles sont :\n");
	printf("'-f' permet d'afficher le chemin du fichier des sonnées filtrées\n");
	printf("'-o' permet d'afficher le chemin du fichier de sortie\n");
	printf("'-r' permet de trier dans le sens décroissant.\n");
	printf("'--tab' permet de trier les données par des tableaux.\n");
	printf("'--abr' permet de trier les données par des ABR.\n");
	printf("'--avl' permet de trier les données par des AVL.\n");
	scanf("%c",&a);
	while(a!="-f" && a!="-r" && a!="--tab" && a!="--abr" && a!="--avl"){
		printf("Erreur, vous n'avez pas entré un argument valide, veuillez réessayer.\n");
		printf("Les arguments disponibles sont :\n");
		printf("'-f' permet d'afficher le chemin du fichier des sonnées filtrées\n");
		printf("'-o' permet d'afficher le chemin du fichier de sortie\n");
		printf("'-r' permet de trier dans le sens décroissant.\n");
		printf("'--tab' permet de trier les données par des tableaux.\n");
		printf("'--abr' permet de trier les données par des ABR.\n");
		printf("'--avl' permet de trier les données par des AVL.\n");
		scanf("%c",&a);
	}	
	return a;
}


/*void affiche_tab(int n, int tab[]){
	int i;
	for(i=0; i<n; i++){
		printf("%f|",tab[i]);
	}
	printf("\n");
}*/

int main(){
	char* a;
	char* b;
	b=argument(a);
	if(b=="-f"){
	
	}
	else if(b=="-o"){
	
	}
	else if(b=="-r"){
	
	}
	else if(b=="--tab"){
	
	}
	else if(b=="--abr"){
	
	}
	else if(b=="--avl"){
	
	}
}
