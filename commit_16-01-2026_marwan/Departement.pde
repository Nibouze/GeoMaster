class Departement  {
  String id_dept;
  String nom_dept;
  PShape pshape_dept;
  color couleur_dept = color(255);
  int etat = 0;
  
  void initDepartement(String i,String n){
    this.id_dept = i;
    this.nom_dept=n;
    this.pshape_dept = france.pshape_carte.getChild(i);
  }
  
  //Cherche dans quelle region se trouve le departement et la retourne, renvoie null si le departement n'est dans aucune region
  Region chercheReg(){
    for(int i = 0; i<r.length;i++){
      for(int j=0;j<r[i].dept.length;j++){
        if(r[i].dept[j].equals(this.id_dept)){
          return r[i];
        }
      }
    }
    return null;
  }
  
}
