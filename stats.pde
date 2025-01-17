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

/*
String[] emptySchedule(String entity, String start, String stop) {
  String[] empty = new String[1];
  int k = 0;
  Event[] eventsFromAtoB = delNull(getEventTime(start, stop));
  triEvent(eventsFromAtoB);
  for (int i=0; i<eventsFromAtoB.length; i++) {
    if(
  }

  return empty;
}
*/
