class PageAccueil extends Page {
  // Boutons
  Bouton btnApprendre, btnJouer, btnMode, btnDifficulte, btnQuitter;
  Bouton btnToggleMode; // Bouton pour changer de mode
  
  PageAccueil(PageManager manager) {
    super(manager);
    
    // CORRECTION : Repositionnement avec bouton Apprendre supplémentaire
    int largeurBouton = 300;
    int hauteurBouton = 60;
    int espacement = 15; // Réduit un peu l'espacement pour 5 boutons
    int startY = height/2 - 100; // Ajusté pour centrer les 5 boutons
    
    btnApprendre = new Bouton(width/2 - largeurBouton/2, startY, largeurBouton, hauteurBouton, "APPRENDRE");
    btnJouer = new Bouton(width/2 - largeurBouton/2, startY + hauteurBouton + espacement, largeurBouton, hauteurBouton, "JOUER");
    btnMode = new Bouton(width/2 - largeurBouton/2, startY + 2*(hauteurBouton + espacement), largeurBouton, hauteurBouton, "MODE DE JEU");
    btnDifficulte = new Bouton(width/2 - largeurBouton/2, startY + 3*(hauteurBouton + espacement), largeurBouton, hauteurBouton, "DIFFICULTÉ");
    btnQuitter = new Bouton(width/2 - largeurBouton/2, startY + 4*(hauteurBouton + espacement), largeurBouton, hauteurBouton, "QUITTER");
    btnToggleMode = new Bouton(width - 100, height - 100, 80, 50, "");
  }
  
  void afficher() {
    // Appliquer la couleur de fond appropriée
    if (modeSombre) {
      fill(couleursSombre[0]);
    } else {
      fill(couleursClair[0]);
    }
    noStroke();
    rect(0, 0, width, height);
    
    // Titre avec couleur adaptée au mode
    if (modeSombre) {
      fill(couleursSombre[3]); // #F375C2 en mode sombre
    } else {
      fill(couleursClair[3]); // #769FCD en mode clair
    }
    textFont(fontAccueil);
    textAlign(CENTER, CENTER);
    text("GéoMaster", width/2, height/4 - 80);
    
    // Sous-titre
    if (modeSombre) {
      fill(255); // Gris clair pour être lisible sur fond sombre
    } else {
      fill(100); // Gris foncé pour être lisible sur fond clair
    }
    textFont(fontSousTitre);
    text("Testez vos connaissances géographiques !", width/2, height/4 - 20);
    
    // Rectangle décoratif sous le titre
    noFill();
    if (modeSombre) {
      stroke(couleursSombre[3]); // #F375C2
    } else {
      stroke(couleursClair[3]); // #769FCD
    }
    strokeWeight(2);
    rect(width/2 - 200, height/4 + 15, 400, 0);
    noStroke();
    
    // Ajuster les couleurs des boutons selon le mode
    for (Bouton btn : new Bouton[]{btnApprendre, btnJouer, btnMode, btnDifficulte, btnQuitter}) {
      if (modeSombre) {
        btn.couleurFond = couleursSombre[2]; // #B153D7
        btn.couleurTexte = color(255); // Texte blanc en mode sombre
      } else {
        btn.couleurFond = couleursClair[2]; // #B9D7EA
        btn.couleurTexte = color(0); // Texte noir en mode clair
      }
    }
    
    // Affichage des boutons principaux
    btnApprendre.afficher();
    btnJouer.afficher();
    btnMode.afficher();
    btnDifficulte.afficher();
    btnQuitter.afficher();
    
    // Affichage du bouton de changement de mode
    afficherBoutonMode();
    
    // Footer
    afficherFooter();
  }
  
  // Méthode pour afficher le bouton de changement de mode
  void afficherBoutonMode() {
    // Cadre du bouton
    if (modeSombre) {
      fill(couleursSombre[1]); // #4D2FB2
      stroke(couleursSombre[3]); // #F375C2
    } else {
      fill(couleursClair[1]); // #D6E6F2
      stroke(couleursClair[3]); // #769FCD
    }
    strokeWeight(2);
    rect(btnToggleMode.x, btnToggleMode.y, 
         btnToggleMode.largeur, btnToggleMode.hauteur, 10);
    
    // Icône selon le mode actuel
    if (modeSombre) {
      image(iconeModeSombre, width - 80, height - 90);
      fill(couleursSombre[3]);
      textFont(fontTexte);
      textAlign(CENTER, CENTER);
      text("Clair", width - 60, height - 60);
    } else {
      image(iconeModeClair, width - 80, height - 90);
      fill(couleursClair[3]);
      textFont(fontTexte);
      textAlign(CENTER, CENTER);
      text("Sombre", width - 60, height - 60);
    }
  }
  
  void gererClic() {
    // Gestion des clics sur les boutons
    if (btnApprendre.estClique()) {
      manager.changerPage(4);
    }
    else if (btnJouer.estClique()) {
      println("Lancement de la partie...");
      println("Mode: " + modesJeu[manager.modeSelectionne]);
      println("Difficulté: " + difficultes[manager.difficulteSelectionnee]);
    }
    else if (btnMode.estClique()) {
      manager.changerPage(1);
    }
    else if (btnDifficulte.estClique()) {
      manager.changerPage(2);
    }
    else if (btnQuitter.estClique()) {
      println("Au revoir ! Merci d'avoir joué !");
      exit();
    }
    else if (btnToggleMode.estClique()) {
      toggleModeSombre();
    }
  }
}
