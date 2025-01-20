int Hm(Event event) {
  int decalageH=100;
  if (20241026>AMJ(event))decalageH+=decalageH;
  return parseInt(event.timeStart.substring(9, 13))+decalageH;
}

int AMJ(Event event) {
  return parseInt(event.timeStart.substring(0, 8));
}

int HmF(Event event) {
  int decalageH=100;
  if (20241026>AMJ(event))decalageH+=decalageH;
  return parseInt(event.timeEnd.substring(9, 13))+decalageH;
}

int autre(Event event, int i, int k) {
  return parseInt(event.timeStart.substring(i, k));
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

int addWeek(int date) {
  int year = date / 10000;
  int month = (date / 100) % 100;
  int day = date % 100;

  day += 7;

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
