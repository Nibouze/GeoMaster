class Departement  {
  String id_dept;
  String nom_dept;
  PShape pshape_dept;
  color couleur_dept;
  int etat = 0;
  
  void initDepartement(String i,String n){
    this.id_dept = i;
    this.nom_dept=n;
    this.pshape_dept = france.pshape_carte.getChild(i);
  }
  
}
