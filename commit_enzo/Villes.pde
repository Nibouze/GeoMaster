class Ville extends Departement{
  
  String nom_ville;
  float longitude;
  float latitude;
  String parent_ville = id_dept;
  
  
  void initVille(String nom, float longitude,float latitude){
    this.nom_ville = nom;
    this.longitude = longitude;
    this.latitude = latitude;
  }
  
  
  
}
