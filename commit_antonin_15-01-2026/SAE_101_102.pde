// Antonin TEP

PageManager pageManager;
PFont fontTitre, fontAccueil, fontSousTitre, fontBouton, fontTexte;

String[] modesJeu = {
  "Classique", "Remplissage", "GeoGuessr", "Distance", "Devinette"
};
String[] difficultes = {
  "Facile", "Normal", "Difficile"
};
String[] descriptionsDifficulte = {
  "2min/essai\n\nMultiplicateur 2x points\nPas de pénalités",
  "1min/essai\n\nMultiplicateur 1x points\nPour se challenger un peu",
  "30s/essai\n\nMultiplicateur 0.5x points\nPoints négatifs si erreur\nPas de pitié :)"
};

// Couleurs du thème clair (par défaut)
color[] couleursClair = {
  color(247, 251, 252), // #F7FBFC - Fond très clair
  color(214, 230, 242), // #D6E6F2 - Fond secondaire
  color(185, 215, 234), // #B9D7EA - Boutons normaux
  color(118, 159, 205)  // #769FCD - Boutons sélectionnés/accents
};

// Couleurs du thème sombre
color[] couleursSombre = {
  color(14, 33, 160),   // #0E21A0 - Fond très sombre
  color(77, 47, 178),   // #4D2FB2 - Fond secondaire
  color(177, 83, 215),  // #B153D7 - Boutons normaux
  color(243, 117, 194)  // #F375C2 - Boutons sélectionnés/accents
};

// Variables pour le mode sombre/clair
boolean modeSombre = false;
color[] couleursActuelles;
PImage iconeModeClair, iconeModeSombre;

////////////////////////////////////////////////////////////////////////////////////////////////


void setup() {
  size(907, 1000);
  fullScreen();
  // Initialisation des polices
  fontAccueil = createFont("Arial Bold", 72);
  fontTitre = createFont("Arial Bold", 48);
  fontSousTitre = createFont("Arial", 24);
  fontBouton = createFont("Arial", 20);
  fontTexte = createFont("Arial", 16);
  
  // Initialisation des couleurs (clair par défaut)
  couleursActuelles = couleursClair;
  
  // Création des icônes placeholder pour le switch mode
  creerIconesMode();
  
  // Initialisation du gestionnaire de pages
  pageManager = new PageManager();
  
  // Configuration des couleurs
  colorMode(HSB, 360, 100, 100);
}

void draw() {
  // Définir la couleur de fond selon le mode
  if (modeSombre) {
    background(couleursSombre[0]);
  } else {
    background(couleursClair[0]);
  }
  
  // Affichage de la page courante
  pageManager.afficherPage();
}

void mousePressed() {
  // Gestion des clics
  pageManager.gererClic();
}

// Méthode pour créer les icônes placeholder
void creerIconesMode() {
  // Icône mode clair (soleil)
  iconeModeClair = createImage(40, 40, ARGB);
  iconeModeClair.loadPixels();
  for (int i = 0; i < iconeModeClair.pixels.length; i++) {
    int x = i % iconeModeClair.width;
    int y = i / iconeModeClair.width;
    float dist = dist(x, y, 20, 20);
    
    if (dist < 15 && dist > 8) {
      // Rayons du soleil
      iconeModeClair.pixels[i] = color(255, 204, 0, 255);
    } else if (dist <= 8) {
      // Centre du soleil
      iconeModeClair.pixels[i] = color(255, 255, 100, 255);
    } else {
      iconeModeClair.pixels[i] = color(0, 0, 0, 0);
    }
  }
  iconeModeClair.updatePixels();
  
  // Icône mode sombre (lune)
  iconeModeSombre = createImage(40, 40, ARGB);
  iconeModeSombre.loadPixels();
  for (int i = 0; i < iconeModeSombre.pixels.length; i++) {
    int x = i % iconeModeSombre.width;
    int y = i / iconeModeSombre.width;
    float dist = dist(x, y, 20, 20);
    
    if (dist < 15) {
      // Lune
      iconeModeSombre.pixels[i] = color(200, 200, 255, 255);
    } else if (dist(x, y, 25, 15) < 5) {
      // Croissant de lune
      iconeModeSombre.pixels[i] = color(100, 100, 150, 255);
    } else {
      iconeModeSombre.pixels[i] = color(0, 0, 0, 0);
    }
  }
  iconeModeSombre.updatePixels();
}

// Méthode pour basculer entre mode clair et sombre
void toggleModeSombre() {
  modeSombre = !modeSombre;
  if (modeSombre) {
    couleursActuelles = couleursSombre;
    println("Mode sombre activé");
  } else {
    couleursActuelles = couleursClair;
    println("Mode clair activé");
  }
}
