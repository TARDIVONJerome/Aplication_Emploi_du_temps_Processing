import controlP5.*;


final int Displaywidth=1500;
final int Displayheight=1000;

int nbH=12;
int first_ele=100;
int ecare =first_ele+40;
int annee = year();
int mois = month();
int jour = day();
int DDS =annee*10000+mois*100+jour-Cweek(annee, mois, jour);
int DFS =DDS+5;
//int iDS;
//int iFS;

ControlP5 cp5;
DropdownList groupDropdown;
DropdownList salleDropdown;
DropdownList statDropdown;
String selectedGroup = null;
String selectedsalle = null;
String selectedstat = null;
Bouton prochain=new Bouton();
Bouton precedent=new Bouton();

void initDisplay() {

  prochain.init(30, 30, "flèche.png");
  precedent.init(30, 30, "flèche2.png");
  prochain.actif=true;
  precedent.actif=true;

  cp5 = new ControlP5(this);

  groupDropdown = cp5.addDropdownList("Select Group") //liste Deroulante des groupes
    .setPosition(width/10, height/16-10)
    .setSize(width/5, width/5)
    .setBarHeight(30)
    .setItemHeight(25)
    .setColorBackground(color(100, 100, 255))
    .setColorActive(color(200, 100, 100))
    .setColorForeground(color(150, 150, 255));

  salleDropdown = cp5.addDropdownList("Select salle") //liste Deroulante des salles
    .setPosition(width/10+width/5+20, height/16-10)
    .setSize(width/5, width/5)
    .setBarHeight(30)
    .setItemHeight(25)
    .setColorBackground(color(100, 100, 255))
    .setColorActive(color(200, 100, 100))
    .setColorForeground(color(150, 150, 255));

  statDropdown = cp5.addDropdownList("Select Stats") //liste Deroulante des salles
    .setPosition(width/10+width/5*2+40, height/16-10)
    .setSize(width/5, width/5)
    .setBarHeight(30)
    .setItemHeight(25)
    .setColorBackground(color(100, 100, 255))
    .setColorActive(color(200, 100, 100))
    .setColorForeground(color(150, 150, 255));

  groupDropdown.close();
  salleDropdown.close();
  statDropdown.close();
  addGroups(LSTSOUSGROUPES);
  addSalles(LSTSALLES);
  addStats(new String[]{"graph,%"});
}



void Edt() {

  fill(255);
  stroke(0);
  rect(first_ele, height/8+10, (width-ecare)/5+first_ele-10, height-20);
  rect((width-ecare)/5+first_ele, height/8+10, (width-ecare)/5*2+first_ele-10, height-20);
  rect((width-ecare)/5*2+first_ele, height/8+10, (width-ecare)/5*3+first_ele-10, height-20);
  rect((width-ecare)/5*3+first_ele, height/8+10, (width-ecare)/5*4+first_ele-10, height-20);
  rect((width-ecare)/5*4+first_ele, height/8+10, (width-ecare)+first_ele-10, height-20);
  Boutons();
  textAlign(CENTER, CENTER);

  fill(0, 0, 0);
  text("Lundi", ((width-ecare)/5)/2+first_ele, (height/8+30));
  text("Mardi", (width-ecare)/5+((width-ecare)/5)/2+first_ele, (height/8+30));
  text("Mercredi", (width-ecare)/5*2+((width-ecare)/5)/2+first_ele, (height/8+30));
  text("Jeudi", (width-ecare)/5*3+((width-ecare)/5)/2+first_ele, (height/8+30));
  text("Vendredi", (width-ecare)/5*4+((width-ecare)/5)/2+first_ele, (height/8+30));


  heure();
  fill(105, 15, 88);
  afficheweek();
}

void Boutons() {
  prochain.x=width-40;
  prochain.y=height/2;
  prochain.dessin();

  precedent.x=12;
  precedent.y=height/2;
  precedent.dessin();
}

void addGroups(SousGroupe[] groups) {
  for (int i = 0; i < groups.length; i++) {
    groupDropdown.addItem(groups[i].nomSsGroupe, i);
  }
}
void addSalles(Salle[] salles) {
  for (int i = 0; i < salles.length; i++) {
    salleDropdown.addItem(salles[i].nom, i);
  }
}

void addStats(String[] Stats) {
  for (int i = 0; i < Stats.length; i++) {
    statDropdown.addItem(Stats[i], i);
  }
}

void controlEvent(ControlEvent theEvent) {
  if (theEvent.isFrom(groupDropdown)) {
    selectedGroup = groupDropdown.getItem((int) theEvent.getValue()).get("name").toString();
    println("Selected Group: " + selectedGroup);
    selectedsalle = null;
    selectedstat = null;
  }
  if (theEvent.isFrom(salleDropdown)) {
    selectedsalle = salleDropdown.getItem((int) theEvent.getValue()).get("name").toString();
    println("Selected Group: " + selectedsalle);
    selectedGroup = null;
    selectedstat = null;
  }
  if (theEvent.isFrom(statDropdown)) {
    selectedstat = statDropdown.getItem((int) theEvent.getValue()).get("name").toString();
    println("Selected Group: " + selectedstat);
    selectedGroup = null;
    selectedsalle = null;
  }
}

void heure() {
  fill(0, 0, 0);
  for (int i=0; i<nbH; i++) {
    if (i!=nbH-1) {
      text(8+i+":00", 70, ((height-20)-(height/8+50))/(nbH-1)*i+(height/8+50));
      for (int y=1; y<51; y++) {
        if (y%2==0)line((width-ecare)/50*(y-1)+first_ele-15, ((height-20)-(height/8+50))/(nbH-1)*i+(height/8+50), (width-ecare)/50*y+first_ele-15, ((height-20)-(height/8+50))/(nbH-1)*i+(height/8+50));
      }
    } else text(">"+(8+i)+":00", 70, ((height-20)-(height/8+50))/(nbH-1)*i+(height/8+50));
  }
}

int Hm(Event event) {
  int decalageH=100;
  if(20241026>AMJ(event))decalageH+=decalageH;
  return parseInt(event.timeStart.substring(9, 13))+decalageH;
}

int AMJ(Event event) {
  return parseInt(event.timeStart.substring(0, 8));
}

int HmF(Event event) {
    int decalageH=100;
  if(20241026>AMJ(event))decalageH+=decalageH;
  return parseInt(event.timeEnd.substring(9, 13))+decalageH;
}

int autre(Event event, int i, int k) {
  return parseInt(event.timeStart.substring(i, k));
}

void créneauDessin(int x, int y, int h) {
  if (h>2000)h=1800;
  rect((width-ecare)/5*x+first_ele-10, ((height-20)-(height/8+50))/(nbH-1)*(y/100-8)+(height/8+50), (width-ecare)/5*(x-1)+first_ele, ((height-20)-(height/8+50))/(nbH-1)*(y/100-8+(h-y)/100)+(height/8+50), 25);
}

int Cweek(int annee, int mois, int jour) {
  // Étape 1: Prendre les deux derniers chiffres de l'année
  int anneeDerniersChiffres = annee % 100;

  // Étape 2: Ajouter 1/4 de ce chiffre (sans les décimales)
  int quartAnnee = anneeDerniersChiffres / 4;

  // Étape 3: Ajouter le jour du mois
  int somme = anneeDerniersChiffres + quartAnnee + jour;

  // Étape 4: Ajouter le mois selon la table fournie
  int moisTable[] = {0, 1, 4, 4, 0, 2, 5, 0, 3, 6, 1, 4, 6};
  somme += moisTable[mois];

  // Étape 5: Si l'année est bissextile et le mois est janvier ou février, on soustrait 1
  if ((annee % 4 == 0 && annee % 100 != 0) || (annee % 400 == 0)) {
    if (mois == 1 || mois == 2) {
      somme -= 1;
    }
  }

  // Étape 6: Ajouter le siècle (0 pour 1900, 6 pour 2000)
  int century = annee / 100;
  if (century == 17) {
    somme += 4;
  } else if (century == 18) {
    somme += 2;
  } else if (century == 19) {
    somme += 0;
  } else if (century == 20) {
    somme += 6;
  }

  // Étape 7: Diviser la somme par 7 et garder le reste
  int jourSemaine = somme % 7;

  // Réajuster pour que dimanche = 7 et lundi = 0
  if (jourSemaine == 0) {
    jourSemaine = 7;  // Dimanche devient 7
  } else {
    jourSemaine -= 1;  // Décaler lundi à 0, mardi à 1, ...
  }

  // Retourner le jour de la semaine ajusté
  return jourSemaine;
}



void afficheweek() {
  for (int u=0; u<LSTEVENTS.length; u++) {
    for (int i=0; i<LSTEVENTS[u].length; i++) {
      if (DDS<=AMJ(LSTEVENTS[u][i]) && DFS>=AMJ(LSTEVENTS[u][i]) && contains(LSTEVENTS[u][i].groupe, selectedGroup ) || contains(LSTEVENTS[u][i].location, selectedsalle )) {
        créneauDessin( Cweek(autre(LSTEVENTS[u][i], 0, 4), autre(LSTEVENTS[u][i], 4, 6), autre(LSTEVENTS[u][i], 6, 8)), Hm(LSTEVENTS[u][i]), HmF(LSTEVENTS[u][i]));
        text("Mardi", (width-ecare)/5+((width-ecare)/5)/2+first_ele, (height/8+30));
      }
    }
  }
}

boolean contains(String[] array, String str) {
  for (int i = 0; i < array.length; i++) {
    if (array[i]!=null && str!=null && str.contains(array[i])) {
      return true;
    }
  }
  return false;
}


void draw() {
  printArray(LSTEVENTS[0][503].groupe);
  println(contains(LSTEVENTS[0][503].groupe, "S1G2.2"));
  println(contains(LSTEVENTS[0][503].groupe, "S1G2"));
  println(contains(LSTEVENTS[0][503].groupe, "S1"));
  background(240);
  fill(0, 180, 0);
  rect(0, 0, width, height/8);
  textSize(18);
  Edt();
}
