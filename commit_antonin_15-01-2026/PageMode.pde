class PageMode extends Page {
  Bouton btnRetour, btnRegles;
  Bouton[] boutonsModes;
  
  PageMode(PageManager manager) {
    super(manager);
    
    btnRetour = new Bouton(20, height - 100, 120, 50, "RETOUR");
    btnRegles = new Bouton(width - 140, height - 100, 120, 50, "RÈGLES");
    
    boutonsModes = new Bouton[modesJeu.length];
    int largeurBouton = 500;
    int hauteurBouton = 70;
    int espacement = 15;
    int startY = height/2 - (hauteurBouton * modesJeu.length + espacement * (modesJeu.length - 1))/2;
    
    for (int i = 0; i < modesJeu.length; i++) {
      int y = startY + i * (hauteurBouton + espacement);
      boutonsModes[i] = new Bouton(width/2 - largeurBouton/2, y, 
                                   largeurBouton, hauteurBouton, modesJeu[i]);
    }
  }
  
  void afficher() {
    // Titre de la page
    if (modeSombre) {
      fill(couleursSombre[3]); // #F375C2
    } else {
      fill(couleursClair[3]); // #769FCD
    }
    textFont(fontTitre);
    textAlign(CENTER, CENTER);
    text("SÉLECTION DU MODE", width/2, 80);
    
    // Affichage des boutons de mode
    for (int i = 0; i < boutonsModes.length; i++) {
      if (i == manager.modeSelectionne) {
        // Bouton sélectionné
        if (modeSombre) {
          boutonsModes[i].couleurFond = couleursSombre[3]; // #F375C2
          boutonsModes[i].couleurTexte = color(255);
        } else {
          boutonsModes[i].couleurFond = couleursClair[3]; // #769FCD
          boutonsModes[i].couleurTexte = color(255);
        }
      } else {
        // Bouton non sélectionné
        if (modeSombre) {
          boutonsModes[i].couleurFond = couleursSombre[2]; // #B153D7
          boutonsModes[i].couleurTexte = color(255);
        } else {
          boutonsModes[i].couleurFond = couleursClair[2]; // #B9D7EA
          boutonsModes[i].couleurTexte = color(0);
        }
      }
      boutonsModes[i].afficher();
    }
    
    // Ajuster les couleurs des boutons retour et règles
    if (modeSombre) {
      btnRetour.couleurFond = couleursSombre[2];
      btnRetour.couleurTexte = color(255);
      btnRegles.couleurFond = couleursSombre[2];
      btnRegles.couleurTexte = color(255);
    } else {
      btnRetour.couleurFond = couleursClair[2];
      btnRetour.couleurTexte = color(0);
      btnRegles.couleurFond = couleursClair[2];
      btnRegles.couleurTexte = color(0);
    }
    
    btnRegles.afficher();
    btnRetour.afficher();
    
    // Footer
    afficherFooter();
  }
  
  void gererClic() {
    for (int i = 0; i < boutonsModes.length; i++) {
      if (boutonsModes[i].estClique()) {
        manager.setMode(i);
        return;
      }
    }
    
    if (btnRegles.estClique()) {
      manager.changerPage(3);
    }
    
    if (btnRetour.estClique()) {
      manager.changerPage(0);
    }
  }
}
