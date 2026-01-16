class PageManager {
  int pageActuelle; // 0: Accueil, 1: Mode, 2: Difficulté, 3: Règles, 4: Apprendre
  PageAccueil pageAccueil;
  PageMode pageMode;
  PageDifficulte pageDifficulte;
  PageRegles pageRegles;
  PageApprendre pageApprendre;
  
  // Variables pour les sélections
  int modeSelectionne;
  int difficulteSelectionnee;
  
  PageManager() {
    pageActuelle = 0;
    modeSelectionne = 0;
    difficulteSelectionnee = 1;
    
    // Initialisation des pages
    pageAccueil = new PageAccueil(this);
    pageMode = new PageMode(this);
    pageDifficulte = new PageDifficulte(this);
    pageRegles = new PageRegles(this);
    pageApprendre = new PageApprendre(this);
  }
  
  void afficherPage() {
    switch(pageActuelle) {
      case 0:
        pageAccueil.afficher();
        break;
      case 1:
        pageMode.afficher();
        break;
      case 2:
        pageDifficulte.afficher();
        break;
      case 3:
        pageRegles.afficher();
        break;
      case 4:
        pageApprendre.afficher();
        break;
    }
  }
  
  void gererClic() {
    switch(pageActuelle) {
      case 0:
        pageAccueil.gererClic();
        break;
      case 1:
        pageMode.gererClic();
        break;
      case 2:
        pageDifficulte.gererClic();
        break;
      case 3:
        pageRegles.gererClic();
        break;
      case 4:
        pageApprendre.gererClic();
        break;
    }
  }
  
  void changerPage(int nouvellePage) {
    pageActuelle = nouvellePage;
  }
  
  void setMode(int mode) {
    modeSelectionne = mode;
  }
  
  void setDifficulte(int difficulte) {
    difficulteSelectionnee = difficulte;
  }
}
