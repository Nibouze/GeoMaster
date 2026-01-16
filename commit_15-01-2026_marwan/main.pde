//Tableau des departements
Departement departements[];
//Tableau pour créer le tableau des departements de chaque region
String []departement ;
Carte france;
//Tableau des regions
Region r [];
//Tableau des villes
Ville [] villes;

PFont myFont, fontAccueil, fontTitre, fontSousTitre, fontBouton, fontTexte;
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
  myFont = createFont("Georgia", 32);
  fontAccueil = createFont("Arial Bold", 72);
  fontTitre = createFont("Arial Bold", 48);
  fontSousTitre = createFont("Arial", 24);
  fontBouton = createFont("Arial", 20);
  fontTexte = createFont("Arial", 16);
  textFont(myFont);
  size(1920, 1080);
  fullScreen();
  france=new Carte();
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
      println(departement[j]);
    }
    r[i].initRegion(d[0], departement, couleurs[i]);
  }
  initialiser_departements();
  
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

int lastMouseX = -1;
int lastMouseY = -1;
int deptSurvole = -1;

void draw () {
  background(#F7FBFC);
  noStroke();
  france.dessinerCarte();
  fill(#D6E6F2);
  rect(width/2 + 100, 0, width, height);
  stroke(0);

  if (mouseX != lastMouseX || mouseY != lastMouseY) {
    deptSurvole = -1;

    for (int i = 0; i < departements.length; i++) {
      if (pointInPShape(departements[i].pshape_dept, mouseX-30, mouseY-50)) {
        deptSurvole = i;
        break; // ← très important
      }
    }

    lastMouseX = mouseX;
    lastMouseY = mouseY;
  }

  for (int i = 0; i < departements.length; i++) {
    departements[i].etat = 0;
  }


  if (deptSurvole != -1) {
    departements[deptSurvole].etat = 1;
    departements[deptSurvole].couleur_dept=color(255, 0, 0);
  }

  france.dessinerCarte();

  if (deptSurvole != -1) {
    fill(0);
    textFont(fontSousTitre);
    text("Département : " + departements[deptSurvole].nom_dept, width/2+150, 50);
    text("Région : " + departements[deptSurvole].chercheReg().nom_reg, width/2+150, 100);
  }
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
