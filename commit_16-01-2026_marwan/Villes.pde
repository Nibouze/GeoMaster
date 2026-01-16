class Ville extends Departement {

  String nom_ville;
  float longitude;
  float latitude;
  float longitude_max = 8.31;
  float longitude_min = -5;
  float latitude_min = 41.4;
  float latitude_max = 51.09;
  String parent_ville = id_dept;
  String dept_ville;


  void initVille(String nom, float longi, float lati) {
    this.nom_ville = nom;
    this.longitude = longi;
    this.latitude = lati;
  }

  void afficherVille() {
    float x = map(longitude, longitude_min, longitude_max, 0, svgW);
    float y = map(latitude, latitude_min,latitude_max, svgH,0);
    fill(0, 0, 255);
    noStroke();
    ellipse(x+30, y+50, 6, 6);
  }
}
