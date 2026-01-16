class Carte1{

  String nom_carte;
  PShape pshape_carte;

  void initCarte(String n, String fichier) {
    nom_carte=n;
    pshape_carte=loadShape(fichier);
    pshape_carte.disableStyle();
  }

  void dessinerCarte() {
    for (int i = 0; i < departements.length; i++) {
      if (departements[i].pshape_dept != null) {
        //Parcours regions
        for (int j = 0; j<r.length; j++) {
          //Parcours departements de la regions
          for (int k = 0; k<r[j].dept.length; k++) {
            if (r[j].dept[k].equals(departements[i].id_dept) && departements[i].etat==0) {
              departements[i].couleur_dept = r[j].couleur;
            }
          }
          fill(departements[i].couleur_dept);
          shape(departements[i].pshape_dept, 0, 0, 800, 800);
        }
      }
    }
  }
}
