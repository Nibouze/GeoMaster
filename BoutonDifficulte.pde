// Antonin TEP

class BoutonDifficulte {
  int x, y, largeur, hauteur;
  String titre, description;
  boolean estSelectionne;
  PImage image;
  
  BoutonDifficulte(int x, int y, int largeur, int hauteur, 
                   String titre, String description, String cheminImage) {
    this.x = x;
    this.y = y;
    this.largeur = largeur;
    this.hauteur = hauteur;
    this.titre = titre;
    this.description = description;
    this.estSelectionne = false;
    
    try {
      this.image = loadImage(cheminImage);
      if (this.image == null) {
        this.image = creerImagePlaceholder(200, 150);
      } else {
        this.image.resize(200, 0);
      }
    } catch (Exception e) {
      this.image = creerImagePlaceholder(200, 150);
    }
  }
  
  PImage creerImagePlaceholder(int w, int h) {
    PImage img = createImage(w, h, RGB);
    img.loadPixels();
    
    for (int i = 0; i < img.pixels.length; i++) {
      int x = i % w;
      int y = i / w;
      
      if ((x/20 + y/20) % 2 == 0) {
        img.pixels[i] = color(200);
      } else {
        img.pixels[i] = color(150);
      }
    }
    img.updatePixels();
    
    PGraphics pg = createGraphics(w, h);
    pg.beginDraw();
    pg.image(img, 0, 0);
    if (modeSombre) {
      pg.fill(couleursSombre[3]);
    } else {
      pg.fill(couleursClair[3]);
    }
    pg.textAlign(CENTER, CENTER);
    pg.text("Image\n" + titre, w/2, h/2);
    pg.endDraw();
    
    return pg;
  }
  
  void afficher() {
    // Cadre du bouton
    if (estSelectionne) {
      // Bouton sélectionné
      if (modeSombre) {
        fill(couleursSombre[3], 50); // #F375C2 avec transparence
        stroke(couleursSombre[3]); // #F375C2
      } else {
        fill(couleursClair[3], 50); // #769FCD avec transparence
        stroke(couleursClair[3]); // #769FCD
      }
      strokeWeight(4);
    } else {
      // Bouton non sélectionné
      if (modeSombre) {
        fill(couleursSombre[1]); // #4D2FB2
        stroke(couleursSombre[2]); // #B153D7
      } else {
        fill(couleursClair[1]); // #D6E6F2
        stroke(couleursClair[2]); // #B9D7EA
      }
      strokeWeight(2);
    }
    rect(x, y, largeur, hauteur, 15);
    
    // Affichage de l'image
    if (image != null) {
      int imageX = x + (largeur - min(200, image.width)) / 2;
      int imageY = y + 20;
      int affichageLargeur = min(200, image.width);
      int affichageHauteur = min(150, image.height);
      
      image(image, imageX, imageY, affichageLargeur, affichageHauteur);
    }
    
    // Titre
    if (modeSombre) {
      fill(255); // Blanc en mode sombre
    } else {
      fill(30); // Gris foncé en mode clair
    }
    textFont(fontBouton);
    textAlign(CENTER, CENTER);
    
    int titreY;
    if (image != null) {
      titreY = y + 20 + min(150, image.height) + 20;
    } else {
      titreY = y + 20 + 150 + 20;
    }
    text(titre, x + largeur/2, titreY);
    
    // Description
    if (modeSombre) {
      fill(200); // Gris clair en mode sombre
    } else {
      fill(100); // Gris moyen en mode clair
    }
    textFont(fontTexte);
    textAlign(CENTER, TOP);
    
    int descY = titreY + 30;
    text(description, x + 20, descY, largeur - 40, 100);
    
    // Indicateur de sélection
    if (estSelectionne) {
      if (modeSombre) {
        fill(couleursSombre[3]); // #F375C2
      } else {
        fill(couleursClair[3]); // #769FCD
      }
      noStroke();
      ellipse(x + largeur/2, y + hauteur - 15, 20, 20);
    }
  }
  
  boolean estClique() {
    return mouseX >= x && mouseX <= x + largeur && 
           mouseY >= y && mouseY <= y + hauteur;
  }
}
