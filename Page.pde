class Page {
  PageManager manager;
  
  Page(PageManager manager) {
    this.manager = manager;
  }
  
  boolean boutonEstClique(int x, int y, int largeur, int hauteur) {
    return mouseX >= x && mouseX <= x + largeur && 
           mouseY >= y && mouseY <= y + hauteur;
  }
  
  void afficherFooter() {
    // Ligne de séparation
    if (modeSombre) {
      stroke(couleursSombre[2]); // #B153D7
    } else {
      stroke(couleursClair[2]); // #B9D7EA
    }
    line(0, height - 40, width, height - 40);
    noStroke();
    
    // Texte des auteurs
    if (modeSombre) {fill(255);} else {fill(100);}
    textFont(fontTexte);
    textAlign(LEFT, BOTTOM);
    text("Groupe 2.2 : TEP Antonin, MADANI Marwan, VALENTINO Enzo", 20, height - 12);
    
    // Texte copyright
    textAlign(RIGHT, BOTTOM);
    text("© 2026 GéoMaster - Tous droits réservés", width - 20, height - 12);
  }
}
