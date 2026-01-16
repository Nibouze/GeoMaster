Departement departements[];
String []departement ;
Carte1 france;
Region r [];
String questionA;
PFont myFont;

color[] couleurs = {
  color(161, 8, 39), // rouge
  color(255, 165, 0), // orange
  color(255, 255, 0), // jaune
  color(144, 238, 144), // vert clair
  color(0, 100, 0), // vert foncé
  color(173, 216, 230), // bleu clair
  color(40, 55, 166), // bleu foncé
  color(138, 43, 226), // violet
  color(137, 81, 41), // Marron
  color(255, 192, 203), // Rose
  color(128, 128, 128), // gris
  color(82, 74, 74), // gris foncé
  color(255, 255, 255)  // blanc
};

void setup() {
  size(1400, 1000);
  france=new Carte1();
  france.initCarte("France", "france.svg");
  String temp[] = loadStrings("Data/regions.txt");
  r=new Region [temp.length];
  for (int i = 0; i<temp.length; i++) {
    r[i]=new Region();
    String d [] = splitTokens(temp[i], ";");
    departement = splitTokens(d[1], ",");
    for (int j = 0; j<departement.length; j++) {
      if (departement[j].equals("200")) {
        departement[j]="2a";
      }
      if (departement[j].equals("201")) {
        departement[j]="2b";
      }
      departement[j]="dep_"+departement[j];
    }
    r[i].initRegion(d[0], departement, couleurs[i]);
  }
  initialiser_departements();
  
  
  typeQuestion=int(random(3)); 
  questionA = generationQuestion(typeQuestion);
  gestionDifficulte(2);
  myFont = createFont("Arial",32);
  textFont(myFont);
}

void initialiser_departements() {
  String deps [];
  String dep2 [];
  deps = loadStrings("departements.txt");
  departements = new Departement [deps.length];
  for (int i = 0; i<deps.length; i++) {
    dep2  = splitTokens(deps[i], ";");
    if (dep2[0].equals("200")) {
      dep2[0]="2a";
    }
    if (dep2[0].equals("201")) {
      dep2[0]="2b";
    }
    departements[i] = new Departement ();
    departements[i].initDepartement("dep_"+dep2[0], dep2[1]);
  }
}

void draw () {
  background(#F7FBFC);
  france.dessinerCarte();
  for (int i = 0; i<departements.length; i++) {
    if (pointInPShape(departements[i].pshape_dept, mouseX, mouseY)) {
      departements[i].etat=1;
      departements[i].couleur_dept = color(255, 0, 0);
      france.dessinerCarte();
      departements[i].etat=0;
    }
  }
  text(questionA,900,100);
  debutTimer();
}

boolean pointInPShape(PShape shape, float px, float py) {
  boolean inside = false;
  int n = shape.getVertexCount();

  for (int i = 0, j = n - 1; i < n; j = i++) {
    PVector vi = shape.getVertex(i);
    PVector vj = shape.getVertex(j);

    boolean intersect =
      ((vi.y > py) != (vj.y > py)) &&
      (px < (vj.x - vi.x) * (py - vi.y) / (vj.y - vi.y) + vi.x);

    if (intersect) inside = !inside;
  }
  return inside;
}




// ------ Génération des questions ------ //

String questions[] = {" Où est le département ", " Où est la ville ", " Où trouve-t-on "};
int typeQuestion; // 0 pour question sur ville, 1 pour dept, 2 pour monument,...

String generationQuestion(int typeQuestion) {

  String quest = questions[typeQuestion];
  String elt;
  if (typeQuestion==0) {
    String dep1[] = loadStrings("departements.txt");
    String dep2[];
    dep2  = splitTokens(dep1[int(random(dep1.length))], ";");
    elt = dep2[1];
    quest+= '\n'+"'" + elt + "'"+"?";
  } else {
    if (typeQuestion==1) {
      String ville1[] = loadStrings("villes.txt");
      String ville2[] = splitTokens(ville1[int(random(ville1.length))], ";");
      elt = ville2[1];
      quest+= '\n'+"'" + elt + "'"+"?";
    } else {
      if (typeQuestion==2) {
        String monument1[] = loadStrings("images.txt");
        String monument2[] = splitTokens(monument1[int(random(monument1.length))], ";");
        elt = monument2[0];
        quest+= '\n'+"'" + elt + "'"+"?";
      }
    }
  }
  return quest;
}

// ------ Temporisation et gestion de difficulté ------ //

//difficulte : 0 pour facile, 1 pour normal, 2 pour difficile
int duree; // en seconde 
float multiplicateur;

void gestionDifficulte(int difficulte) {
  switch(difficulte) {
  case 0 :
    duree = 120;multiplicateur = 2;break;
  case 1 :
    duree = 60;multiplicateur = 1;break;
  case 2 :
    duree = 30;multiplicateur = 0.5;break;
  }
}

void debutTimer(){
  int tempsRestant = duree - (millis()/1000);
  if (tempsRestant > 0){
   text(tempsRestant, 1300, 120); 
  }else{
    text("Temps écoulé !",1100,300);
  }
}
