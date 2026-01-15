class PageRegles extends Page {
  Bouton btnRetour;
  
  // Règles pour chaque mode
  String[] reglesModes = {
    "Le mode traditionnel avec des règles standards : Répondez correctement pour gagner des points.\nObjectif : Atteindre le score maximal.",
    "Vous souviendrez-vous de tout les départements ?\nObjectif : Reconstituer toute la carte dans le temps imparti.",
    "Une impression de déjà vu ? Repérez là où se situe l'image affichée.\nObjectif : Reconaître le plus d'images le plus rapidement possible.",
    "Vous êtes avide de précision ? Placer votre point le plus proche possible de la zone cible.\nObjectif : Gagner le plus de points possible en visant juste.",
    "Arriverez-vous à déterminer le département mystère ? (Conseil : Consulter la partie 'Apprentissage' avant)\nObjectif : Trouver la bonne réponse avec le moins d'indice possible."
  };
  
  PageRegles(PageManager manager) {
    super(manager);
    
    // Bouton retour en bas à gauche
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
    text("RÈGLES DES MODES DE JEU", width/2, 80);
    
    // Affichage des règles
    int largeurRegle = 800;
    int hauteurRegle = 80;
    int espacement = 15;
    int startY = 150;
    
    for (int i = 0; i < modesJeu.length; i++) {
      int y = startY + i * (hauteurRegle + espacement);
      
      // Rectangle pour chaque règle
      if (modeSombre) {
        fill(couleursSombre[1]); // #4D2FB2
        stroke(couleursSombre[2]); // #B153D7
      } else {
        fill(couleursClair[1]); // #D6E6F2
        stroke(couleursClair[2]); // #B9D7EA
      }
      strokeWeight(1);
      rect(width/2 - largeurRegle/2, y, largeurRegle, hauteurRegle, 10);
      
      // Titre du mode
      if (modeSombre) {
        fill(couleursSombre[3]); // #F375C2
      } else {
        fill(couleursClair[3]); // #769FCD
      }
      textFont(fontBouton);
      textAlign(LEFT, TOP);
      text(modesJeu[i], width/2 - largeurRegle/2 + 20, y + 10);
      
      // Règles
      if (modeSombre) {
        fill(200); // Gris clair
      } else {
        fill(80); // Gris foncé
      }
      textFont(fontTexte);
      textAlign(LEFT, TOP);
      text(reglesModes[i], width/2 - largeurRegle/2 + 20, y + 40, largeurRegle - 40, 40);
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
    if (btnRetour.estClique()) {
      manager.changerPage(1);
    }
  }
}
