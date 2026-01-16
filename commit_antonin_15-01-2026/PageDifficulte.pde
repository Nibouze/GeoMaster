class PageDifficulte extends Page {
  Bouton btnRetour;
  BoutonDifficulte[] boutonsDifficulte;
  
  PageDifficulte(PageManager manager) {
    super(manager);
    
    btnRetour = new Bouton(20, height - 100, 120, 50, "RETOUR");
    
    boutonsDifficulte = new BoutonDifficulte[difficultes.length];
    
    int largeur = 250;
    int hauteur = 350;
    int espacement = 30;
    int totalLargeur = largeur * difficultes.length + espacement * (difficultes.length - 1);
    int startX = (width - totalLargeur) / 2;
    
    for (int i = 0; i < difficultes.length; i++) {
      int x = startX + i * (largeur + espacement);
      boutonsDifficulte[i] = new BoutonDifficulte(x, height/2 - hauteur/2, 
                                                  largeur, hauteur, 
                                                  difficultes[i], descriptionsDifficulte[i],
                                                  "images/niveau_" + (i+1) + ".jpg");
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
    text("SÉLECTION DE LA DIFFICULTÉ", width/2, 80);
    
    // Affichage des boutons de difficulté
    for (int i = 0; i < boutonsDifficulte.length; i++) {
      if (i == manager.difficulteSelectionnee) {
        boutonsDifficulte[i].estSelectionne = true;
      } else {
        boutonsDifficulte[i].estSelectionne = false;
      }
      boutonsDifficulte[i].afficher();
    }
    
    // Ajuster la couleur du bouton retour
    if (modeSombre) {
      btnRetour.couleurFond = couleursSombre[2];
      btnRetour.couleurTexte = color(255);
    } else {
      btnRetour.couleurFond = couleursClair[2];
      btnRetour.couleurTexte = color(0);
    }
    
    btnRetour.afficher();
    
    // Footer
    afficherFooter();
  }
  
  void gererClic() {
    for (int i = 0; i < boutonsDifficulte.length; i++) {
      if (boutonsDifficulte[i].estClique()) {
        manager.setDifficulte(i);
        return;
      }
    }
    
    if (btnRetour.estClique()) {
      manager.changerPage(0);
    }
  }
}
