int Hm(Event event) {
  return parseInt(event.timeStart.substring(9, 13));
}

int AMJ(Event event) {
  return parseInt(event.timeStart.substring(0, 8));
}

int HmF(Event event) {
  return parseInt(event.timeEnd.substring(9, 13));
}

int Dat(Event event, int i, int k, boolean t) {
  if(t)return parseInt(event.timeStart.substring(i, k));
  return parseInt(event.timeEnd.substring(i, k));
}

String DatS(Event event, int i, int k, boolean t) {
  if(t){
    return event.timeStart.substring(i, k);
  }
    return event.timeEnd.substring(i, k);
}

int Cweek(int annee, int mois, int jour) {
  int anneeDerniersChiffres = annee % 100;
  int quartAnnee = anneeDerniersChiffres / 4;
  int somme = anneeDerniersChiffres + quartAnnee + jour;
  int moisTable[] = {0, 1, 4, 4, 0, 2, 5, 0, 3, 6, 1, 4, 6};
  somme += moisTable[mois];

  if ((annee % 4 == 0 && annee % 100 != 0) || (annee % 400 == 0)) {
    if (mois == 1 || mois == 2) {
      somme -= 1;
    }
  }

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

  int jourSemaine = somme % 7;

  return (jourSemaine + 5) % 7;
}

  
boolean contains(String[] array, String str) {
  for (int i = 0; i < array.length; i++) {
    if (array[i]!=null && str!=null && (str.contains(array[i]) || (array[i].equals("Mobile") && (str.equals("Mob.1")|| str.equals("Mob.2"))))) {
      return true;
    }
  }
  return false;
}

int addDays(int date, int days) {
  int year = date / 10000;
  int month = (date / 100) % 100;
  int day = date % 100;

  day += days;

  int daysInMonth = getDaysInMonth(year, month);
  if (day > daysInMonth) {
    day -= daysInMonth;
    month += 1;

    // Gestion du passage à l'année suivante
    if (month > 12) {
      month = 1;
      year += 1;
    }
  }

  return year * 10000 + month * 100 + day;
}

int subtractWeek(int date) {
  int year = date / 10000;
  int month = (date / 100) % 100;
  int day = date % 100;

  day -= 7;

  if (day <= 0) {
    month -= 1;
    if (month <= 0) {
      month = 12;
      year -= 1;
    }
    day += getDaysInMonth(year, month);
  }

  return year * 10000 + month * 100 + day;
}

int getDaysInMonth(int year, int month) {
  if (month == 1 || month == 3 || month == 5 || month == 7 || month == 8 || month == 10 || month == 12) {
    return 31;
  } else if (month == 4 || month == 6 || month == 9 || month == 11) {
    return 30;
  } else if (month == 2) {
    return isLeapYear(year) ? 29 : 28;
  }
  return 30;
}

boolean isLeapYear(int year) {
  return (year % 4 == 0 && (year % 100 != 0 || year % 400 == 0));
}

float[] peopleOverTime(int date1, int date2){
  FloatList list = new FloatList();
  while(date1 < date2){
    list.append(present(date1 + ""));
    date1 = addDays(date1, 1);
  }
  
  return list.toArray();
}

float[] affluenceRUlist(int date1, int date2){
  FloatList list = new FloatList();
  while(date1 < date2){
    list.append(present(date1 + ""));
    date1 = addDays(date1, 1);
  }
  
  return list.toArray();
}

float[] examOverTime(){
  Event[] exam = initExam()[0];
  float[] res = new float[exam.length];
  int k = -1;
  String lastDate = "00000000T000000Z";
  triEvent(exam);
  
  for(int i = 0; i<exam.length; i++){
    if (!lastDate.substring(0, 8).equals(exam[i].timeStart.substring(0, 8))){
      k++;
      lastDate = exam[i].timeStart;
    }
    res[k]++;
  }
  
  return res;
}

float[] randomFloats(int nb){
  float[] res = new float[nb];
  for (int i = 0; i < nb; i++){
    res[i] = (int)random(0, 255);
  }
  return res;
}

float[] chargeOvertime(int date1, int date2){
  FloatList list = new FloatList();
  while(date1 < date2){
    
    list.append(chargeTravail(SROOM, date1 + "T000000Z", addDays(date1, 1) + "T000000Z")/24.0);
    date1 = addDays(date1, 7);
  }
  return list.toArray();
}