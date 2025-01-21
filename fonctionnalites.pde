int present(String date) { //<>// //<>// //<>//
  int cpt = 0;
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

int chargeTravail(String sousGroupe, String date1, String date2) {
  int cpt=0;
  for (int i=0; i<LSTEVENTS.length; i++) {
    for (int j=0; j<LSTEVENTS[i].length; j++) {
      if (compTime(LSTEVENTS[i][j].timeStart, date1)&& !compTime(LSTEVENTS[i][j].timeStart, date2)) {
        for (int k=0; k<LSTEVENTS[i][j].groupe.length; k++) {
          if (LSTEVENTS[i][j].groupe[k]!=null && sousGroupe.contains(LSTEVENTS[i][j].groupe[k])) {

            cpt+=duree(LSTEVENTS[i][j]);
          } else if (LSTEVENTS[i][j].groupe[k]!=null && sousGroupe.equals("Mob.1") &&( LSTEVENTS[i][j].groupe[k].equals("Mob.1")|| LSTEVENTS[i][j].groupe[k].equals("Mobile")||LSTEVENTS[i][j].groupe[k].equals("BUT3"))) {
            cpt+=duree(LSTEVENTS[i][j]);
          } else if (LSTEVENTS[i][j].groupe[k]!=null && sousGroupe.equals("Mob.2") &&( LSTEVENTS[i][j].groupe[k].equals("Mob.2")|| LSTEVENTS[i][j].groupe[k].equals("Mobile")||LSTEVENTS[i][j].groupe[k].equals("BUT3"))) {
            cpt+=duree(LSTEVENTS[i][j]);
          } else if (LSTEVENTS[i][j].groupe[k]!=null && sousGroupe.equals("Web.1") &&( LSTEVENTS[i][j].groupe[k].equals("Web.1")|| LSTEVENTS[i][j].groupe[k].equals("Web")||LSTEVENTS[i][j].groupe[k].equals("BUT3"))) {
            cpt+=duree(LSTEVENTS[i][j]);
          } else if (LSTEVENTS[i][j].groupe[k]!=null && sousGroupe.equals("Web.2") &&( LSTEVENTS[i][j].groupe[k].equals("Web.2")|| LSTEVENTS[i][j].groupe[k].equals("Web")||LSTEVENTS[i][j].groupe[k].equals("BUT3"))) {
            cpt+=duree(LSTEVENTS[i][j]);
          }
        }
      }
    }
  }
  return cpt;
}


Event[] getEventTime(String start, String stop) {
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



Event[][] crenauxCommuns(SousGroupe[] tab) {
  Event[][] res= new Event[1][];
  int max=0;
  int ab=0;
  for(int i=0;i<tab.length;i++){
    if(tab[i]!=null) ab++;
  }
  SousGroupe[] tabtmp=new SousGroupe[ab];
  int v=0;
  for(int i=0;i<tab.length;i++){
    if(tab[i]!=null){
      tabtmp[v]=tab[i];
      v++;
    }
  }
  tab=tabtmp;
  for (int i=0; i<LSTEVENTS.length; i++) {
    if (max<LSTEVENTS[i].length) max=LSTEVENTS[i].length;
  }
  Event[][] tmp=new Event[tab.length][max];
  Event[][] tmp2=new Event[tab.length][max];
  for (int i=0; i< LSTEVENTS.length; i++) {
    for (int j=0; j<LSTEVENTS[i].length; j++) {
      for (int l=0; l<tab.length; l++) {
        for (int k=0; k<LSTEVENTS[i][j].groupe.length; k++) {
          if (LSTEVENTS[i][j].groupe[k]!=null && tab[l].nomSsGroupe.contains(LSTEVENTS[i][j].groupe[k])) {
            if (tmp[l][j]==null) tmp[l][j]=LSTEVENTS[i][j];
            else for (int b=0; b<tmp[l].length; b++) {
              if (tmp[l][b]==null) {
                tmp[l][b]=LSTEVENTS[i][j];
                break;
              }
            }
          } else if (LSTEVENTS[i][j].groupe[k]!=null && tab[l].nomSsGroupe.equals("Mob.1") &&( LSTEVENTS[i][j].groupe[k].equals("Mob.1")|| LSTEVENTS[i][j].groupe[k].equals("Mobile")||LSTEVENTS[i][j].groupe[k].equals("BUT3"))) {
            if (tmp[l][j]==null) tmp[l][j]=LSTEVENTS[i][j];
            else for (int b=0; b<tmp[l].length; b++) {
              if (tmp[l][b]==null) {
                tmp[l][b]=LSTEVENTS[i][j];
                break;
              }
            }
          } else if (LSTEVENTS[i][j].groupe[k]!=null && tab[l].nomSsGroupe.equals("Mob.2") &&( LSTEVENTS[i][j].groupe[k].equals("Mob.2")|| LSTEVENTS[i][j].groupe[k].equals("Mobile")||LSTEVENTS[i][j].groupe[k].equals("BUT3"))) {
            if (tmp[l][j]==null) tmp[l][j]=LSTEVENTS[i][j];
            else for (int b=0; b<tmp[l].length; b++) {
              if (tmp[l][b]==null) {
                tmp[l][b]=LSTEVENTS[i][j];
                break;
              }
            }
          } else if (LSTEVENTS[i][j].groupe[k]!=null && tab[l].nomSsGroupe.equals("Web.1") &&( LSTEVENTS[i][j].groupe[k].equals("Web.1")|| LSTEVENTS[i][j].groupe[k].equals("Web")||LSTEVENTS[i][j].groupe[k].equals("BUT3"))) {
            if (tmp[l][j]==null) tmp[l][j]=LSTEVENTS[i][j];
            else for (int b=0; b<tmp[l].length; b++) {
              if (tmp[l][b]==null) {
                tmp[l][b]=LSTEVENTS[i][j];
                break;
              }
            }
          } else if (LSTEVENTS[i][j].groupe[k]!=null && tab[l].nomSsGroupe.equals("Web.2") &&( LSTEVENTS[i][j].groupe[k].equals("Web.2")|| LSTEVENTS[i][j].groupe[k].equals("Web")||LSTEVENTS[i][j].groupe[k].equals("BUT3"))) {
            if (tmp[l][j]==null) tmp[l][j]=LSTEVENTS[i][j];
            else for (int b=0; b<tmp[l].length; b++) {
              if (tmp[l][b]==null) {
                tmp[l][b]=LSTEVENTS[i][j];
                break;
              }
            }
          }
        }
      }
    }
  }

  for (int i=0; i<tmp.length; i++) {
    tmp[i]=delNull(tmp[i]);
    triEvent(tmp[i]);
    for (int j=0; j<tmp[i].length-1; j++) {
      if (!tmp[i][j].timeEnd.equals(tmp[i][j+1].timeStart) && !tmp[i][j].timeEnd.equals(tmp[i][j+1].timeEnd) && !tmp[i][j].timeStart.equals(tmp[i][j+1].timeStart)) {
        if (tmp[i][j].timeEnd.substring(0, 8).equals(tmp[i][j+1].timeStart.substring(0, 8))) {
          tmp2[i][j]=new Event();
          tmp2[i][j].timeStart=tmp[i][j].timeEnd;
          tmp2[i][j].timeEnd=tmp[i][j+1].timeStart;
          tmp2[i][j].summary="Créneau vide commun";
          tmp2[i][j].location= new String[0];
          tmp2[i][j].groupe=new String[tab.length];
          for (int a=0; a<tab.length; a++) tmp2[i][j].groupe[a]=tab[a].nomSsGroupe;
          tmp2[i][j].teacher= new String[0];
        } else {
          if (compTime(tmp[i][j+1].timeStart, tmp[i][j+1].timeStart.substring(0, 8)+"T083000Z")) {
            tmp2[i][j]=new Event();
            tmp2[i][j].timeStart=tmp[i][j+1].timeStart.substring(0, 8)+"T083000Z";
            tmp2[i][j].timeEnd=tmp[i][j+1].timeStart;
            tmp2[i][j].summary="Créneau vide commun";
            tmp2[i][j].location= new String[0];
            tmp2[i][j].groupe=new String[tab.length];
            for (int a=0; a<tab.length; a++) tmp2[i][j].groupe[a]=tab[a].nomSsGroupe;
            tmp2[i][j].teacher= new String[0];
          }

          if (compTime(tmp[i][j].timeEnd.substring(0, 8)+"T174500Z", tmp[i][j].timeEnd)) {
            tmp2[i][j]=new Event();
            tmp2[i][j].timeStart=tmp[i][j].timeEnd;
            tmp2[i][j].timeEnd=tmp[i][j].timeEnd.substring(0, 8)+"T174500Z";
            tmp2[i][j].summary="Créneau vide commun";
            tmp2[i][j].location= new String[0];
            tmp2[i][j].groupe=new String[tab.length];
            for (int a=0; a<tab.length; a++) tmp2[i][j].groupe[a]=tab[a].nomSsGroupe;
            tmp2[i][j].teacher= new String[0];
          }
        }
      }
    }
  }

  for (int i=0; i<tmp2.length; i++) {
    tmp2[i]=delNull(tmp2[i]);
    triEvent(tmp2[i]);
  }

  for (int i=1; i<tmp.length; i++) {
    Event[]tmp3=new Event[tmp2[0].length];
    for (int k=0; k<tmp2[0].length; k++) {
      for (int j=0; j<tmp2[i].length; j++) {
        if (tmp2[i][j].timeStart.substring(0,8).equals(tmp2[0][k].timeStart.substring(0,8))) {
          if(tmp2[i][j].timeStart.equals(tmp2[0][k].timeStart) && tmp2[i][j].timeEnd.equals(tmp2[0][k].timeEnd)){
          tmp3[k]=tmp2[i][j];
          }
          else if(tmp2[i][j].timeStart.equals(tmp2[0][k].timeStart)){
            if(compTime(tmp2[i][j].timeEnd,tmp2[0][k].timeEnd)){
            tmp3[k]=tmp2[0][k];
            }
            else {
              tmp3[k]=tmp2[i][j];
            }
          }
          else if(tmp2[i][j].timeEnd.equals(tmp2[0][k].timeEnd)){
            if(compTime(tmp2[i][j].timeStart,tmp2[0][k].timeStart)){
            tmp3[k]=tmp2[i][j];
            }
            else {
              tmp3[k]=tmp2[0][k];
            }
          }
          else if(compTime(tmp2[i][j].timeStart,tmp2[0][k].timeStart)&&compTime(tmp2[0][k].timeEnd,tmp2[i][j].timeEnd)){
            tmp3[k]=tmp2[i][j];
            
          }
          else if(compTime(tmp2[0][k].timeStart,tmp2[i][j].timeStart)&&compTime(tmp2[i][j].timeEnd,tmp2[0][k].timeEnd)){
            tmp3[k]=tmp2[0][k];
            
          }
        }
      }
    }
    tmp2[0]=delNull(tmp3);
  }
  res[0]=tmp2[0];
  return res;
}
