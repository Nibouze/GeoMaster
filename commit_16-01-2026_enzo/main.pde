//Gestion du son
import processing.sound.*;
SoundFile son_apprentissage;
SoundFile son_questions;
//Dimensions SVG
final float svgW = 907;
final float svgH = 1000;
//Tableau des departements
Departement departements[];

//Tableau pour créer le tableau des departements de chaque region
String []departement ;
Carte france;

//Tableau des regions
Region r [];

//Tableau des villes
Ville [] villes;

String mode = "questions";
boolean jouer = true;
PFont myFont, fontAccueil, fontTitre, fontSousTitre, fontBouton, fontTexte;

// Question
String questions[] = {" Où est le département : ", " Où est la ville : ", " Où trouve-t-on : "};
int typeQuestion; // 0 pour question sur ville, 1 pour dept, 2 pour monument,...
String questionA; // Question affiché
String repQuestion;
String repT;
boolean repTrouve=false;

float multiplicateur;
int duree = 30; // durée en secondes
int tempsRestant;
int tempsDepart = 0;
boolean timerActif = false;

int score;
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
  son_apprentissage = new SoundFile(this, "TwirlyTops.mp3");
  son_questions = new SoundFile(this, "BunnyHop.mp3");
  myFont = createFont("Georgia", 32);
  fontAccueil = createFont("Arial Bold", 72);
  fontTitre = createFont("Arial Bold", 48);
  fontSousTitre = createFont("Arial", 24);
  fontBouton = createFont("Arial", 20);
  fontTexte = createFont("Arial", 16);
  textFont(myFont);
  fullScreen();

  //Initialisation des différents éléments
  france=new Carte();
  france.initCarte("France", "france.svg");
  initialiser_regions();
  initialiser_departements();
  initialiser_villes();

  // GESTION DIFFICULTE -> Donne le temps par question et la difficulté
  //difficulte : 0 pour facile, 1 pour normal, 2 pour difficile
  gestionDifficulte(2);
  // GENERE UNE QUESTION
  gestionQuestion();
}

//Remplissage du tableau de regions et initialisation de ses valeurs
void initialiser_regions() {
  String temp[] = loadStrings("Data/regions.txt");
  r=new Region [temp.length];
  for (int i = 0; i<temp.length; i++) {
    r[i]=new Region();
    String d [] = splitTokens(temp[i], ";");
    departement = splitTokens(d[1], ",");
    for (int j = 0; j<departement.length; j++) {
      departement[j]="dep_"+departement[j];
    }
    r[i].initRegion(d[0], departement, couleurs[i]);
  }
}

//initialisation du tableau des departements et de ses valeurs
void initialiser_departements() {
  String deps [];
  String dep2 [];
  deps = loadStrings("departements.txt");
  departements = new Departement [deps.length];
  for (int i = 0; i<deps.length; i++) {
    dep2  = splitTokens(deps[i], ";");
    departements[i] = new Departement ();
    departements[i].initDepartement("dep_"+dep2[0], dep2[1]);
  }
}

//initialisation du tableau des villes et de ses valeurs
void initialiser_villes() {
  String city [];
  String city2 [];
  city = loadStrings("villes.txt");
  villes = new Ville [city.length];
  for (int i = 0; i<city.length; i++) {
    city2 = splitTokens(city[i], ";");
    villes[i] = new Ville ();
    villes[i].initVille(city2[1], float(city2[2]), float(city2[3]));
    villes[i].dept_ville="dep_"+city2[0];
  }
}

int lastMouseX = -1;
int lastMouseY = -1;
int deptSurvole = -1;

void draw () {
  background(#F7FBFC);
  france.dessinerCarte();
  fill(#D6E6F2);
  rect(width/2 + 100, 0, width, height);
  stroke(0);
  launcher();
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


// VARIABLE GLOBALE //

// FONCTION //



// GESTION QUESTION : choisi un type de question aléatoirement ( soit dept,ville,monument) et génère question
void gestionQuestion() {
  typeQuestion =0;//int(random(3));
  questionA = generationQuestion(typeQuestion);
}

// Vérifier si le département dans lequel on clique est le bon
void mouseClicked() {
  if (typeQuestion==0) {
    for (int i = 0; i<departements.length; i++) {
      if ((pointInPShape(departements[i].pshape_dept, mouseX-30, mouseY-50))) {
        repT = departements[i].nom_dept;
        if(repQuestion.equals(repT)) {
          departements[i].couleur_dept = color(0,255,0);
          france.dessinerCarte();
        }else{
          departements[i].couleur_dept = color(255,0,0);
          
        }
        france.dessinerCarte();
      }
    }


    if (typeQuestion==1) {
    }
  }
}


// Compare réponse entre repT(réponse transmise par user) et repQuestion(réponse à la question)
boolean verifReponseDept() {
  if (repQuestion.equals(repT)) {
    return true;
  }
  return false;
}

// Génération de question
String generationQuestion(int typeQuestion) {
  String quest = questions[typeQuestion];
  if (typeQuestion==0) {
    String dep1[] = loadStrings("departements.txt");
    String dep2[];
    dep2  = splitTokens(dep1[int(random(dep1.length))], ";");
    repQuestion = dep2[1];
    quest+= repQuestion +" ?";
  } else {
    if (typeQuestion==1) {
      String ville1[] = loadStrings("villes.txt");
      String ville2[] = splitTokens(ville1[int(random(ville1.length))], ";");
      repQuestion = ville2[1];
      quest+= repQuestion +" ?";
    } else {
      if (typeQuestion==2) {
        String monument1[] = loadStrings("images.txt");
        String monument2[] = splitTokens(monument1[int(random(monument1.length))], ";");
        repQuestion = monument2[0];
        quest+= repQuestion+" ?";
      }
    }
  }
  return quest;
}

// Gestion de difficulté : le paramètre en entrée doit être changer quand l'user clique sur la difficulté dans le menu
// La fonction change la duree et le multiplicateur de point
void gestionDifficulte(int difficulte) {
  switch(difficulte) {
  case 0 :
    duree = 120;
    multiplicateur = 2;
    break;
  case 1 :
    duree = 60;
    multiplicateur = 1;
    break;
  case 2 :
    duree = 30;
    multiplicateur = 0.5;
    break;
  }
}

// Temporisation
void startTimer() {
  tempsDepart = millis();
  timerActif = true;
}
void afficherTimer() {
  if (timerActif) {
    tempsRestant = duree - (millis() - tempsDepart) / 1000;
  }
  if (tempsRestant > 0) {
    text(tempsRestant, 1300, 120);
  }
}


// FONCTION PRICIPALE

void launcher() {
  fill(255);
  PFont grosTitre=createFont("Arial Bold", 72);
  noFill();

  //MODE QUESTIONS
  if (jouer) {
    son_questions.play();
    jouer=false;
  }
  if (mode.equals("questions")) {
    textFont(grosTitre);
    text("QUESTIONS", width/2+230, 100);
    for (int i = 0; i<departements.length; i++) {
      departements[i].couleur_dept=color(255);
    }
    if (typeQuestion == 5) { // 5 n'arrivera jamais
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
    }
    france.dessinerCarte();

    fill(0);
    textFont(fontSousTitre);
    text(questionA, width/2 +230, 150);
    afficherTimer();
  }

  //MODE APPRENTISSAGE
  if (mode.equals("apprentissage")) {
    textFont(grosTitre);
    text("APPRENTISSAGE", width/2+230, 100);
    if (jouer) {
      son_apprentissage.play();
      jouer=false;
    }


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
      text("Département : " + departements[deptSurvole].nom_dept, width/2+150, 150);
      text("Région : " + departements[deptSurvole].chercheReg().nom_reg, width/2+150, 200);
      for (int i = 0; i<villes.length; i++) {
        if (villes[i].dept_ville.equals(departements[deptSurvole].id_dept)) {
          text("Ville(s) : " + villes[i].nom_ville, width/2+150, 250);
        }
      }
    }
    for (int i = 0; i<villes.length; i++) {
      villes[i].afficherVille();
    }
  }
}

// Pour gérer le timer temporairement
void keyPressed() {
  if (key == 's') startTimer();   // start
}
