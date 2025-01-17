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

int duree(Event event){
  
  int m1=int(event.timeStart.substring(9,11))*60+int(event.timeStart.substring(11,13));
  int m2=int(event.timeEnd.substring(9,11))*60+int(event.timeEnd.substring(11,13));
  return m2-m1;
  
}

int chargeTravail(SousGroupe sousGroupe) {
  int cpt=0;
  for (int i=0; i<LSTEVENTS.length; i++) {
    for (int j=0; j<LSTEVENTS[i].length; j++) {
      for(int k=0;k<LSTEVENTS[i][j].groupe.length;k++){
        if(sousGroupe.nomSsGroupe.contains(LSTEVENTS[i][j].groupe[k])){
          
          cpt+=duree(LSTEVENTS[i][j]);
          
        }
        
      }
      
    }
    
  }
  return cpt;
}
