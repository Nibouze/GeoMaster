class Ville extends Departement{
  
  String nom_ville;
  float longitude;
  float latitude;
  float longitude_min = 8.5;
  float longitude_max = -5.5;
  float latitude_min = 41;
  float latitude_max = 51.5;
  String parent_ville = id_dept;
  
  
  void initVille(String nom, float longitude,float latitude){
    this.nom_ville = nom;
    this.longitude = longitude;
    this.latitude = latitude;
  }
  
  void afficherVille(){
      float x = map(this.longitude,longitude_min,  longitude_max,0,france.pshape_carte.width);
      float y = map(this.latitude,latitude_min, latitude_max,france.pshape_carte.height,0);
      fill(0,0,255);
      noStroke();
      ellipse(x,y,16,16);
  }
}
