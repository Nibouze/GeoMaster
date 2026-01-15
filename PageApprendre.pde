class PageApprendre extends Page {
  Bouton btnRetour;
  
  PageApprendre(PageManager manager) {
    super(manager);
    btnRetour = new Bouton(20, height - 100, 120, 50, "RETOUR");
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
    text("APPRENDRE À JOUER", width/2, 120);
    
    // Message placeholder
    if (modeSombre) {
      fill(255); // Gris clair
    } else {
      fill(100); // Gris foncé
    }
    textFont(fontSousTitre);
    textAlign(CENTER, CENTER);
    text("Cette section est en cours de développement", width/2, height/2);
    
    // Encadré d'information
    if (modeSombre) {
      stroke(couleursSombre[2]); // #B153D7
      fill(couleursSombre[1]); // #4D2FB2
    } else {
      stroke(couleursClair[2]); // #B9D7EA
      fill(couleursClair[1]); // #D6E6F2
    }
    strokeWeight(2);
    rect(width/2 - 300, height/2 + 40, 600, 150, 15);
    
    // Texte informatif
    if (modeSombre) {
      fill(255); // Gris clair
    } else {
      fill(80); // Gris foncé
    }
    textFont(fontTexte);
    textAlign(CENTER, CENTER);
    text("Ici, vous trouverez bientôt des tutoriels,\n" +
         "des explications des mécaniques de jeu,\n" +
         "et des conseils pour améliorer votre niveau.", 
         width/2, height/2 + 120);
    
    // Icône placeholder
    if (modeSombre) {
      stroke(couleursSombre[3]); // #F375C2
    } else {
      stroke(couleursClair[3]); // #769FCD
    }
    strokeWeight(3);
    noFill();
    ellipse(width/2, height/2 - 100, 80, 80);
    line(width/2 - 20, height/2 - 100, width/2 + 20, height/2 - 100);
    line(width/2, height/2 - 120, width/2, height/2 - 80);
    
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
    if (btnRetour.estClique()) {
      manager.changerPage(0);
    }
  }
}
