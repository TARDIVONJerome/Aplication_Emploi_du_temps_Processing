Salle[] LSTSALLES; //<>// //<>//
SousGroupe[] LSTSOUSGROUPES;
String[] LSTPROFS;
Event[][] LSTEVENTS;


final int Displaywidth=1440;
final int Displayheight=900;
PFont myFont;
Edt[] EdtWin = new Edt[3];
Controls contPanel;
String SGROUPE = "";
String SROOM = "";
String SSTATS = "graph";
String[] items;
Graph graph;
int cooldown = 0;
String[] JSemaine={"Lundi","Mardi","Mercredi","Jeudi","Vendredi","Samedi","Dimanche"};
String previousPanel = "edt";
String[] graphOpt = {"Affluence à l'IUT", "Affluence au RU", "Examens", "Random"};
String prevOpt = "";



int nbH=12;
int annee = year();
int mois = month();
int jour = day();
int DDS =annee*10000+mois*100+jour-Cweek(annee, mois, jour);
int FDS =DDS+6;

boolean compTime(String time1, String time2) {
  time1 = time1.substring(0, 15);
  time2 = time2.substring(0, 15);
  String[] a_2 = time1.split("T");
  String[] b_2 = time2.split("T");

  if (parseInt(a_2[0]) == parseInt(b_2[0])) {
    if (parseInt(a_2[1]) > parseInt(b_2[1])) {
      return true;
    } else {
      return false;
    }
  } else if (parseInt(a_2[0]) > parseInt(b_2[0])) {
    return true;
  } else {
    return false;
  }
}

void DecalageH() {
  for (int u=0; u<LSTEVENTS.length; u++) {
    if (LSTEVENTS[u]!=null) {
    for (int i=LSTEVENTS[u].length-1; i>=0; i--) {
      if (LSTEVENTS[u][i]!=null && LSTEVENTS[u][i].timeStart!=null &&  LSTEVENTS[u][i].timeEnd!=null) {
        int decalageH=1;
        if (20241026>AMJ(LSTEVENTS[u][i]))decalageH+=decalageH;
        if (parseInt(LSTEVENTS[u][i].timeStart.substring(9, 11))+decalageH<10)LSTEVENTS[u][i].timeStart=LSTEVENTS[u][i].timeStart.substring(0, 9)+"0"+(parseInt(LSTEVENTS[u][i].timeStart.substring(9, 11))+decalageH)+LSTEVENTS[u][i].timeStart.substring(11, 16);
        else LSTEVENTS[u][i].timeStart=LSTEVENTS[u][i].timeStart.substring(0, 9)+(parseInt(LSTEVENTS[u][i].timeStart.substring(9, 11))+decalageH)+LSTEVENTS[u][i].timeStart.substring(11, 16);
        if (parseInt(LSTEVENTS[u][i].timeEnd.substring(9, 11))+decalageH<10)LSTEVENTS[u][i].timeEnd=LSTEVENTS[u][i].timeEnd.substring(0, 9)+"0"+(parseInt(LSTEVENTS[u][i].timeEnd.substring(9, 11))+decalageH)+LSTEVENTS[u][i].timeEnd.substring(11, 16);
        else LSTEVENTS[u][i].timeEnd=LSTEVENTS[u][i].timeEnd.substring(0, 9)+(parseInt(LSTEVENTS[u][i].timeEnd.substring(9, 11))+decalageH)+LSTEVENTS[u][i].timeEnd.substring(11, 16);
      }}
    }
  }
}

Event[] initEvents(String path) {
  String[] lines = loadStrings(path);
  Event[] event = new Event[lines.length];
  String[] tmp;
  String[] DescTmp = new String[1];
  Event toPush = new Event();

  for (int i = 0; i<lines.length; i++) {
    tmp = lines[i].split(":");
    if (tmp[0].equals("BEGIN") && tmp[1].equals("VEVENT")) {
      toPush = new Event();
    } else if (tmp[0].equals("END") && tmp[1].equals("VEVENT")) {
      event[i] = toPush;
    } else if (tmp[0].equals("DTSTART")) {
      toPush.timeStart = tmp[1];
    } else if (tmp[0].equals("DTEND")) {
      toPush.timeEnd = tmp[1];
    } else if (tmp[0].equals("SUMMARY")) {
      toPush.summary = tmp[1];
    } else if (tmp[0].equals("LOCATION")) {
      try {
        DescTmp[0] = lines[i].substring(1);
        if (lines[i + 1].charAt(0) == ' ') {
          DescTmp[0] += lines[i + 1].substring(1);
          i++;
        }
        toPush.location = DescTmp[0].split(":")[1].split("\\\\,");
      }
      catch (ArrayIndexOutOfBoundsException e) {
        toPush.location = new String[0];
      }
    } else if (tmp[0].equals("DESCRIPTION")) {
      DescTmp[0] = "";
      while (!lines[i + 1].split(":")[0].equals("UID")) {
        DescTmp[0] += lines[i].substring(1);
        i++;
      }
      DescTmp[0] += lines[i].substring(1);
      DescTmp = DescTmp[0].split("\\\\n\\\\n")[1].split("\\\\n");
      toPush.groupe = new String[DescTmp.length];
      toPush.teacher = new String[DescTmp.length];
      boolean isProf = false;
      for (int l = 0; l<DescTmp.length; l++) {
        isProf = false;
        for (int k = 0; k<LSTPROFS.length; k++) {
          if (LSTPROFS[k].equals(DescTmp[l])) {
            toPush.teacher[l] = DescTmp[l];
            isProf = true;
            break;
          }
        }
        if (!isProf) {
          toPush.groupe[l] = DescTmp[l];
        }
      }
    }
  }
  return event;
}

Salle[] initSalles(String file) {

  String[] tab=loadStrings(file);
  Salle[] res=new Salle[tab.length-1];
  for (int i=1; i<tab.length; i++) {

    String[] t=splitTokens(tab[i], ";");
    res[i-1]=new Salle();
    res[i-1].nom= t[0];
    res[i-1].type= t[2];
    res[i-1].nbPlaces= int(t[1]);
  }
  return res;
}

SousGroupe[] initSousGroupes(String file) {
  String[] tab=loadStrings(file);
  SousGroupe[] res=new SousGroupe[tab.length-1];
  for (int i=1; i<tab.length; i++) {
    String[]t=splitTokens(tab[i], ";");
    res[i-1]=new SousGroupe();
    res[i-1].nomGroupe=t[1];
    res[i-1].nomSsGroupe=t[0];
    res[i-1].nbEtu=int(t[2]);
    res[i-1].nbRU=round(res[i-1].nbEtu*float(t[3])/100);
  }
  return res;
}

String[] initProfs(String file) {
  String[] tab=loadStrings(file);
  String[]res=new String[tab.length-1];
  for (int i=1; i<tab.length; i++) {
    res[i-1]=tab[i];
  }
  return res;
}

void printData() {


  for (int i=0; i<LSTSALLES.length; i++) {
    println(LSTSALLES[i].nom, LSTSALLES[i].nbPlaces, LSTSALLES[i].type);
  }
  println();
  for (int i=0; i<LSTSOUSGROUPES.length; i++) {
    println(LSTSOUSGROUPES[i].nomGroupe, LSTSOUSGROUPES[i].nomSsGroupe, LSTSOUSGROUPES[i].nbEtu, LSTSOUSGROUPES[i].nbRU);
  }
  println();
  for (int i=0; i<LSTPROFS.length; i++) {
    println(LSTPROFS[i]);
  }
}

Event[] delNull(Event[]tab) {
  int cpt=0;

  for (int i=0; i<tab.length; i++) {
    if (tab[i]!=null)cpt++;
  }
  Event[] res=new Event[cpt];
  int a=0;
  for (int i=0; i<tab.length; i++) {
    if (tab[i]!=null) {
      res[a]=tab[i];
      a++;
    }
  }
  return res;
}

void triEvent(Event[] tab) {

  for ( int i=1; i<tab.length; i++) {
    Event tmp=null;
    for (int j=i; j>0; j--) {
      if (tab[j]!=null&&tab[j-1]!=null) {
        if (!compTime(tab[j].timeStart, tab[j-1].timeStart)) {
          tmp=tab[j];
          tab[j]=tab[j-1];
          tab[j-1]=tmp;
        }
      }
    }
  }
}

void settings(){
  size(Displaywidth, Displayheight);
}

void setup() {

  LSTSALLES=initSalles("salles.csv");
  LSTSOUSGROUPES=initSousGroupes("etudiants.csv");
  LSTPROFS=initProfs("enseignants.csv");
  String[] files={"INFO-BUT1-S1.ics", "INFO-BUT2-S3.ics", "INFO-BUT3-S5.ics", "INFO-LP-ESSIR.ics"};
  LSTEVENTS=new Event[files.length][];
  for (int i=0; i<LSTEVENTS.length; i++) {
    LSTEVENTS[i]=delNull(initEvents(files[i]));
    triEvent(LSTEVENTS[i]);
  }
  DecalageH();
  myFont = createFont("Arial", 32);
  textFont(myFont);
  textSize(18);
  contPanel = new Controls(0, 0, Displaywidth, 50);
  contPanel.statDropdown.selected = "edt";
  graph = new Graph(0, 50, Displaywidth, Displayheight - 50);
  //float[] data = examOverTime();
  //float[] data = affluenceRUlist(20240902, 20250902);
  //float[] data = peopleOverTime(20240902, 20250902);
  float[] data = randomFloats(3);
  graph.setContent(data);
  EdtWin[0] = new Edt(0, 50, Displaywidth, Displayheight - 50);
}

void draw() {
  background(255);
  cooldown--;
  if (mousePressed && cooldown <= 0) {
    contPanel.clicked(mouseX, mouseY);
    cooldown = 10;
  }
  if (SSTATS.equals("edt")) {
    if (!previousPanel.equals("edt")) {
        contPanel.groupDropdown.setItems(contPanel.addGroups(LSTSOUSGROUPES));
        contPanel.groupDropdown.tag = "Select Group";
        contPanel.salleDropdown.hidden = false;
    }
    EdtWin[0].display();
    previousPanel = "edt";
  } else if (SSTATS.equals("graph")) {
    if (!previousPanel.equals("graph")) {
        contPanel.groupDropdown.setItems(graphOpt);
        contPanel.groupDropdown.tag = "Select Graph";
        contPanel.salleDropdown.hidden = true;
    }
    if (!prevOpt.equals(contPanel.groupDropdown.selected)) {
      if (contPanel.groupDropdown.selected.equals("Affluence à l'IUT")){
        graph.setContent(peopleOverTime(20240902, 20250902));
      } else if (contPanel.groupDropdown.selected.equals("Affluence au RU")){
        graph.setContent(affluenceRUlist(20240902, 20250902));
      } else if (contPanel.groupDropdown.selected.equals("Examens")){
        graph.setContent(examOverTime());
      } else if (contPanel.groupDropdown.selected.equals("Random")){
        graph.setContent(randomFloats(3));
      }
      prevOpt = contPanel.groupDropdown.selected;
    }
    graph.display();
    previousPanel = "graph";
  }

  contPanel.display();
}

void mousePressed() {
  if (EdtWin[0].prochain.estClique(mouseX, mouseY)) {
    DDS = addDays(DDS,7);
    FDS = addDays(FDS,7);
    print(DDS);
  }

  if (EdtWin[0].precedent.estClique(mouseX, mouseY)) {
    DDS = subtractWeek(DDS);
    FDS = subtractWeek(FDS);
    print(DDS);
  }
}