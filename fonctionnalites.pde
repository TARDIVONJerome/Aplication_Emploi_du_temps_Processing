int present(String date) { //<>// //<>//
  int cpt=0; //<>//
  SousGroupe[] tab=new SousGroupe[LSTSOUSGROUPES.length];
  arrayCopy(LSTSOUSGROUPES, tab);
  for (int i=0; i<LSTEVENTS.length; i++) {
    for (int j=0; j<LSTEVENTS[i].length; j++) {
      boolean loc=false;
      for (int t=0; t<LSTEVENTS[i][j].location.length; t++) {
        if (LSTEVENTS[i][j].location[t]!=null) {
          loc=true;
          break;
        }
      }
      if (date.equals(LSTEVENTS[i][j].timeStart.substring(0, 8)) && loc) {
        for (int k=0; k<tab.length; k++) {
          for (int l=0; l<LSTEVENTS[i][j].groupe.length; l++) {
            if (tab[k]!=null && LSTEVENTS[i][j].groupe[l]!=null && (tab[k].nomGroupe.contains(LSTEVENTS[i][j].groupe[l]) || tab[k].nomSsGroupe.contains(LSTEVENTS[i][j].groupe[l]) )) {

              cpt+=tab[k].nbEtu;
              tab[k]=null;
            } else if (LSTEVENTS[i][j].groupe[l]!=null && LSTEVENTS[i][j].groupe[l].equals("BUT3")) {
              for (int m=0; m<tab.length; m++) {
                if (tab[m]!=null && (tab[m].nomGroupe.equals("Mobile") || tab[m].nomGroupe.equals("Web"))) {
                  cpt+=tab[m].nbEtu;
                  tab[m]=null;
                }
              }
            }
          }
        }
      }
    }
  }
  return cpt;
}

int affluenceRU(String date) {
  int cpt=0;
  SousGroupe[] tab=new SousGroupe[LSTSOUSGROUPES.length];
  arrayCopy(LSTSOUSGROUPES, tab);
  for (int i=0; i<LSTEVENTS.length; i++) {
    for (int j=0; j<LSTEVENTS[i].length; j++) {
      boolean loc=false;
      for (int t=0; t<LSTEVENTS[i][j].location.length; t++) {
        if (LSTEVENTS[i][j].location[t]!=null) {
          loc=true;
          break;
        }
      }
      if (date.equals(LSTEVENTS[i][j].timeStart.substring(0, 8)) && loc) {
        for (int k=0; k<tab.length; k++) {
          for (int l=0; l<LSTEVENTS[i][j].groupe.length; l++) {
            if (tab[k]!=null && LSTEVENTS[i][j].groupe[l]!=null && (tab[k].nomGroupe.contains(LSTEVENTS[i][j].groupe[l]) || tab[k].nomSsGroupe.contains(LSTEVENTS[i][j].groupe[l]) )) {

              cpt+=tab[k].nbRU;
              tab[k]=null;
            } else if (LSTEVENTS[i][j].groupe[l]!=null && LSTEVENTS[i][j].groupe[l].equals("BUT3")) {
              for (int m=0; m<tab.length; m++) {
                if (tab[m]!=null && (tab[m].nomGroupe.equals("Mobile") || tab[m].nomGroupe.equals("Web"))) {
                  cpt+=tab[m].nbRU;
                  tab[m]=null;
                }
              }
            }
          }
        }
      }
    }
  }
  return cpt;
}


Event[][] initExam() {

  Event[][]res=new Event[LSTEVENTS.length][];
  for (int i=0; i<LSTEVENTS.length; i++) {
    Event[] tmp=new Event[LSTEVENTS[i].length];
    for (int j=0; j<LSTEVENTS[i].length; j++) {
      if (LSTEVENTS[i][j].summary.contains("(DS)")|| LSTEVENTS[i][j].summary.contains("(TP noté)")) {
        tmp[j]=LSTEVENTS[i][j];
      }
    }
    tmp=delNull(tmp);
    res[i]=tmp;
  }
  return res;
}

int duree(Event event) {

  int m1=int(event.timeStart.substring(9, 11))*60+int(event.timeStart.substring(11, 13));
  int m2=int(event.timeEnd.substring(9, 11))*60+int(event.timeEnd.substring(11, 13));
  return m2-m1;
}

int chargeTravail(SousGroupe sousGroupe, String date1, String date2) {
  int cpt=0;
  for (int i=0; i<LSTEVENTS.length; i++) {
    for (int j=0; j<LSTEVENTS[i].length; j++) {
      if (compTime(LSTEVENTS[i][j].timeStart,date1)&& !compTime(LSTEVENTS[i][j].timeStart,date2)) {
        for (int k=0; k<LSTEVENTS[i][j].groupe.length; k++) {
          if (LSTEVENTS[i][j].groupe[k]!=null && sousGroupe.nomSsGroupe.contains(LSTEVENTS[i][j].groupe[k])) {

            cpt+=duree(LSTEVENTS[i][j]);
          }
        }
      }
    }
  }
  return cpt;
}


Event[] getEventTime(String start, String stop) { //<>//
  Event[] res = new Event[1];
  int k = 0;
  for (int i=0; i<LSTEVENTS.length; i++) {
    for (int l=0; l<LSTEVENTS[i].length; l++) {
      if (compTime(LSTEVENTS[i][l].timeStart, start) && compTime(stop, LSTEVENTS[i][l].timeStart)) {
        try {
          res[k] = LSTEVENTS[i][l];
        }
        catch (ArrayIndexOutOfBoundsException e) {
          Event[] tmp = res;
          res = new Event[res.length * 2];
          for (int a = 0; a<tmp.length; a++) {
            res[a] = tmp[a];
          }
          tmp = null;
          res[k] = LSTEVENTS[i][l];
        }
        k++;
      }
    }
  }
  return res;
}

int roomOccupation(String room, String start, String stop, int all) {
  int used = 0;
  int total = 0;
  Event[] eventsFromAtoB = delNull(getEventTime(start, stop));
  triEvent(eventsFromAtoB);
  for (int i=0; i<eventsFromAtoB.length; i++) {
    for (int k = 0; k<eventsFromAtoB[i].location.length; k++) {
      if (eventsFromAtoB[i].location[k].equals(room)) {
        used++;
      }
    }
    if (!eventsFromAtoB[i].timeStart.equals(eventsFromAtoB[abs(i - 1)].timeStart)) {
      total++;
    }
  }
  return round((float)(used * 100) / (float)(total * ((LSTSALLES.length * all) + (-1 * all + 1))));
}

boolean anyIn(String obj1, String[] obj2) {
  for (int i = 0; i<obj2.length; i++) {
    if (obj2[i] != null && (obj1.contains(obj2[i]) || obj2[i].contains(obj1))) {
      return true;
    }
  }
  return false;
}

Event[] emptySchedule(String entity, String start, String stop) {
  Event[] empty = new Event[1];
  Event last = new Event();
  boolean eod = false;
  int k = 0;
  Event[] eventsFromAtoB = delNull(getEventTime(start, stop));
  triEvent(eventsFromAtoB);
  String head = eventsFromAtoB[0].timeStart.substring(0, 8) + "T073000Z";
  for (int i=0; i<eventsFromAtoB.length; i++) {
    if (anyIn(entity, eventsFromAtoB[i].teacher) || anyIn(entity, eventsFromAtoB[i].groupe)) {
      try {
        empty[k] = new Event();
        if (eod) {
          empty[k + 1] = new Event();
        }
      }
      catch (ArrayIndexOutOfBoundsException e) {
        Event[] tmp = empty;
        empty = new Event[empty.length * 3];
        for (int a = 0; a<tmp.length; a++) {
          empty[a] = tmp[a];
        }
        tmp = null;
        empty[k] = new Event();
        if (eod) {
          empty[k + 1] = new Event();
        }
      }
      if (eod) {
        empty[k + 1].timeStart = head;
        empty[k + 1].groupe = new String[1];
        empty[k + 1].groupe[0] = "S1G1";
         empty[k + 1].summary = "";
         empty[k + 1].location = new String[0];
        empty[k + 1].timeEnd = eventsFromAtoB[i].timeStart;
        empty[k].timeStart = last.timeEnd;
        empty[k].groupe = new String[1];
        empty[k].summary = "";
        empty[k].location = new String[0];
        empty[k].groupe[0] = "S1G1";
        empty[k].timeEnd = last.timeEnd.substring(0, 8) + "T180000Z";
      } else {
        empty[k].timeStart = head;
        empty[k].groupe = new String[1];
        empty[k].summary = "";
        empty[k].location = new String[0];
        empty[k].groupe[0] = "S1G1";
        empty[k].timeEnd = eventsFromAtoB[i].timeStart;
      }
      last = eventsFromAtoB[i];
      head = eventsFromAtoB[i].timeEnd;
      k++;
      if (eod) {
        k++;
        eod = false;
      }
    }
    if (!eventsFromAtoB[i].timeStart.substring(0, 8).equals(head.substring(0, 8))) {
      eod = true;
      head = eventsFromAtoB[i].timeStart.substring(0, 8) + "T073000Z";
    }
  }
  Event[] result = new Event[k];
  System.arraycopy(empty, 0, result, 0, k);
  return result;
}