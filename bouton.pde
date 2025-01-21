class Bouton {
  int x, y, sx, sy;
  PImage icone;
  boolean actif=false;
  color c = color(255);

  Bouton(int x, int y, int sx, int sy, String image) {
    this.x = x;
    this.y = y;
    this.sx = sx;
    this.sy = sy;
    if (!image.equals("")) {
      icone=loadImage(image);
      icone.resize(sx, sy);
    }
  }

  boolean estClique(int posX, int posY) {
    return actif && posX > this.x && posX < this.x + this.sx && posY > this.y && posY < this.y + this.sy;
  }

  void display() {
    fill(c);
    if (actif) {
      if (icone != null) {
        image(icone, x, y);
      } else {
        rect(x, y, sx, sy);
      }
    }
  }
}

class DropdownMenu {
  Bouton[] elem;
  String[] items;
  String selected = "";
  SousGroupe[] selectedliste = new SousGroupe[LSTSOUSGROUPES.length];
  String arrowUp = "↑ ";
  String arrowDown = "↓ ";
  String tag;
  boolean hidden = false;
  boolean isOpen = false;
  int x, y, sx, sy;
  color c = color(255);

  DropdownMenu(int x, int y, int sx, int sy, String tag, String[] items) {
    this.x = x;
    this.y = y;
    this.sx = sx;
    this.sy = sy;
    this.tag = tag;
    this.items = items;
    this.elem = new Bouton[items.length];
    for (int i = 0; i < items.length; i++) {
      elem[i] = new Bouton(x, y + (sy * (i + 1)), sx, sy, "");
      elem[i].actif = true;
    }
    for (int i = 0; i < selectedliste.length; i++) {
      selectedliste[i]= new SousGroupe();
    }
  }

  void setItems(String[] items) {
    this.items = items;
    this.elem = new Bouton[items.length];
    for (int i = 0; i < items.length; i++) {
      elem[i] = new Bouton(x, y + (sy * (i + 1)), sx, sy, "");
      elem[i].actif = true;
    }
  }

  boolean estClique(int posX, int posY) {
    if (isOpen && !hidden) {
      for (int i = 0; i < elem.length; i++) {
        if (elem[i].estClique(posX, posY)) {
          selected = items[i];
          return true;
        }
      }
    }
    if (posX > this.x && posX < this.x + this.sx && posY > this.y && posY < this.y + this.sy) {
      isOpen = !isOpen;
      return true;
    }
    isOpen = false;
    return false;
  }

  boolean estClique2(int posX, int posY) {
    printArray(items);
    if (isOpen && !hidden) {
      for (int i = 0; i < elem.length; i++) {
        if (elem[i].estClique(posX, posY)) {
          for (int k = 0; k < selectedliste.length; k++) {
            if (selectedliste[k]==null || selectedliste[k].nomSsGroupe.equals(items[i])) {
              if (selectedliste[k].nomSsGroupe != null) selectedliste[k]=new SousGroupe();
              else {
                selectedliste[k]= new SousGroupe();
                selectedliste[k].nomSsGroupe = items[i];
                print(selectedliste[k].nomSsGroupe, items[i] );
              }
              return true;
            }
          }
        }
      }
    }
    if (posX > this.x && posX < this.x + this.sx && posY > this.y && posY < this.y + this.sy) {
      isOpen = !isOpen;
      return true;
    }
    isOpen = false;
    return false;
  }

  void display() {
    if (!hidden) {
      textSize(sy);
      stroke(0);
      strokeWeight(1);
      fill(this.c);
      rect(this.x, this.y, this.sx, this.sy);
      if (isOpen) {
        for (int i = 0; i < elem.length; i++) {
          if (items[i].equals(selected) || containsSS(selectedliste, items[i])) {
            stroke(0, 191, 255);
            strokeWeight(2);
          } else {
            stroke(0);
            strokeWeight(1);
          }
          elem[i].display();
          fill(0);
          text(items[i], elem[i].x + (sx / 10), elem[i].y + sy - 4);
        }
        fill(0);
        text(arrowUp + tag, this.x + (sx / 10), this.y + sy - 4);
      } else {
        fill(0);
        text(arrowDown + tag, this.x + (sx / 10), this.y + sy - 4);
      }
      stroke(0);
      strokeWeight(1);
    }
  }
}
