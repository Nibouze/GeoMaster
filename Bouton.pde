// Antonin TEP

class Bouton {
  int x, y, largeur, hauteur;
  String texte;
  color couleurFond;
  color couleurTexte;
  
  Bouton(int x, int y, int largeur, int hauteur, String texte) {
    this.x = x;
    this.y = y;
    this.largeur = largeur;
    this.hauteur = hauteur;
    this.texte = texte;
    this.couleurFond = color(180);
    this.couleurTexte = color(0);
  }
  
  void afficher() {
    // Rectangle du bouton
    fill(couleurFond);
    if (modeSombre) {
      stroke(couleursSombre[3]); // #F375C2
    } else {
      stroke(couleursClair[3]); // #769FCD
    }
    strokeWeight(2);
    rect(x, y, largeur, hauteur, 10);
    
    // Texte du bouton
    fill(couleurTexte);
    noStroke();
    textFont(fontBouton);
    textAlign(CENTER, CENTER);
    text(texte, x + largeur/2, y + hauteur/2);
  }
  
  boolean estClique() {
    return mouseX >= x && mouseX <= x + largeur && 
           mouseY >= y && mouseY <= y + hauteur;
  }
}
