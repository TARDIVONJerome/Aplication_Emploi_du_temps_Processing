class Window { //<>//
  float x, y, sx, sy;
  float vx = 0;
  float vy = 0;
  int destx, desty;
  int weight = 4;

  Window(int x, int y, int sx, int sy) {
    this.x = x;
    this.y = y;
    this.sx = sx;
    this.sy = sy;
  }


  void swipe(String dest) {
    if (dest.equals("UP")) {
      vy = -sqrt(-2 * -(weight) * abs(-(this.y - this.sy) - this.y));
      desty -= (int)(this.sy);
      destx = 0;
    } else if (dest.equals("DOWN")) {
      vy = sqrt(-2 * -(weight) * abs(-(this.y + this.sy) - this.y));
      desty += (int)(this.sy);
      destx = 0;
    } else if (dest.equals("RIGHT")) {
      vx = sqrt(-2 * -(weight) * abs(-(this.x + this.sx) - this.x));
      desty = 0;
      destx += (int)(this.sx);
    } else if (dest.equals("LEFT")) {
      vx = -sqrt(-2 * -(weight) * abs(-(this.x - this.sx) - this.x));
      desty = 0;
      destx -= (int)(this.sx);
    }
  }

  void update() {
    if (vx != 0 || vy != 0) {
      x += vx;
      y += vy;

      if (vx > 0) {
        vx -= weight;
        if (vx < 0) vx = 0;
      } else if (vx < 0) {
        vx += weight;
        if (vx > 0) vx = 0;
      }

      if (vy > 0) {
        vy -= weight;
        if (vy < 0) vy = 0;
      } else if (vy < 0) {
        vy += weight;
        if (vy > 0) vy = 0;
      }
    } else {
      this.x = this.destx;
      this.y = this.desty;
    }
  }
}

class Edt extends Window {

  Bouton prochain;
  Bouton precedent;
  int marge = 40;
  int daySize;

  Edt(int x, int y, int sx, int sy) {
    super(x, y, sx, sy);

    prochain = new Bouton(30, 30, 30, 30, "flèche.png");
    precedent = new Bouton(30, 30, 30, 30, "flèche2.png");
    prochain.actif=true;
    precedent.actif=true;
    daySize = (sy - (marge * 2) - y) / 7;
  }

  void displayboutons() {
    prochain.x=(int)(this.x + this.sx)-40;
    prochain.y=(int)(this.y + this.sy)/2;
    prochain.display();

    precedent.x=12;
    precedent.y=(int)(this.y + this.sy)/2;
    precedent.display();
  }

  /*
  void displayheure() {
   fill(0, 0, 0);
   for (int i=0; i<nbH; i++) {
   if (i!=nbH-1) {
   text(8+i+":00", 70, (((this.y + this.sy)-20)-((this.y + this.sy)/8+50))/(nbH-1)*i+((this.y + this.sy)/8+50));
   for (int y=1; y<51; y++) {
   if (y%2==0)line(((this.x + this.sx)-ecare)/50*(y-1)+first_ele-15, (((this.y + this.sy)-20)-((this.y + this.sy)/8+50))/(nbH-1)*i+((this.y + this.sy)/8+50), ((this.x + this.sx)-ecare)/50*y+first_ele-15, (((this.y + this.sy)-20)-((this.y + this.sy)/8+50))/(nbH-1)*i+((this.y + this.sy)/8+50));
   }
   } else text(">"+(8+i)+":00", 70, (((this.y + this.sy)-20)-((this.y + this.sy)/8+50))/(nbH-1)*i+((this.y + this.sy)/8+50));
   }
   }
   */
  void displayweek() {
    for (int u=0; u<LSTEVENTS.length; u++) {
      for (int i=LSTEVENTS[u].length-1; i>0; i--) {
        if (DDS<=AMJ(LSTEVENTS[u][i]) && DFS>=AMJ(LSTEVENTS[u][i]) && (contains(LSTEVENTS[u][i].groupe, SGROUPE ) || contains(LSTEVENTS[u][i].location, SROOM ))) {
          displayhoraire(LSTEVENTS[u][i], Cweek(autre(LSTEVENTS[u][i], 0, 4), autre(LSTEVENTS[u][i], 4, 6), autre(LSTEVENTS[u][i], 6, 8)), Hm(LSTEVENTS[u][i]), HmF(LSTEVENTS[u][i]));
        }
      }
    }
  }

  void displayhoraire(Event event, float jour, float debut, float fin) {
    if (fin>2000) {
      fin=2000; // 20:00
    }

    fill(105, 15, 88);

    rect(this.daySize * jour + this.marge, this.y + 10, this.daySize * (jour + 1) + marge, this.y + 20);
    fill(255, 255, 255);
    //if (h-y>=100)text(event.summary, ((this.x + this.sx)-ecare)/5*(x-1)+(((this.x + this.sx)-ecare)/5)/2+first_ele, (((this.y + this.sy)-20)-((this.y + this.sy)/8+50))/(nbH-1)*(y/100-8)+((this.y + this.sy)/8+50)+15);
    //else text(event.summary, ((this.x + this.sx)-ecare)/5*(x-1)+(((this.x + this.sx)-ecare)/5)/2+first_ele, (((this.y + this.sy)-20)-((this.y + this.sy)/8+50))/(nbH-1)*(y/100-8)+((this.y + this.sy)/8+50)+(((((this.y + this.sy)-20)-((this.y + this.sy)/8+50))/(nbH-1)*(y/100-8+(h-y)/100)+((this.y + this.sy)/8+50))-((((this.y + this.sy)-20)-((this.y + this.sy)/8+50))/(nbH-1)*(y/100-8)+((this.y + this.sy)/8+50)))/2);
    //if ( event.location.length!=0 && h-y>=100) {
    //  int TW=0;
    //for (int i=0; i<event.location.length; i++) {
    //  TW+=(int)textWidth(event.location[i])+10;
    //}
    //TW-=10;
    //print(TW);
    //for (int k=event.location.length, i=0; i<event.location.length; i++) {

    //  if (k>5)k=5;
    //  text(event.location[i], ((this.x + this.sx)-ecare)/5*(x-1)+(((this.x + this.sx)-ecare)/5)/2+first_ele+(i%5)*60-(k-1)*30, (((this.y + this.sy)-20)-((this.y + this.sy)/8+50))/(nbH-1)*(y/100-8)+((this.y + this.sy)/8+50)+(((((this.y + this.sy)-20)-((this.y + this.sy)/8+50))/(nbH-1)*(y/100-8+(h-y)/100)+((this.y + this.sy)/8+50))-((((this.y + this.sy)-20)-((this.y + this.sy)/8+50))/(nbH-1)*(y/100-8)+((this.y + this.sy)/8+50)))/2+20*(i/5));
    //}
  }

  void display() {


    fill(255);
    stroke(0);
    /*
    rect(first_ele, (this.y + this.sy)/8+10, ((this.x + this.sx)-ecare)/5+first_ele-10, (this.y + this.sy)-20);
     rect(((this.x + this.sx)-ecare)/5+first_ele, (this.y + this.sy)/8+10, ((this.x + this.sx)-ecare)/5*2+first_ele-10, (this.y + this.sy)-20);
     rect(((this.x + this.sx)-ecare)/5*2+first_ele, (this.y + this.sy)/8+10, ((this.x + this.sx)-ecare)/5*3+first_ele-10, (this.y + this.sy)-20);
     rect(((this.x + this.sx)-ecare)/5*3+first_ele, (this.y + this.sy)/8+10, ((this.x + this.sx)-ecare)/5*4+first_ele-10, (this.y + this.sy)-20);
     rect(((this.x + this.sx)-ecare)/5*4+first_ele, (this.y + this.sy)/8+10, ((this.x + this.sx)-ecare)+first_ele-10, (this.y + this.sy)-20);
     
     displayboutons();
     
     
     textAlign(CENTER, CENTER);
     fill(0);
     text("Lundi", (((this.x + this.sx)-ecare)/5)/2+first_ele, ((this.y + this.sy)/8+30));
     text("Mardi", ((this.x + this.sx)-ecare)/5+(((this.x + this.sx)-ecare)/5)/2+first_ele, ((this.y + this.sy)/8+30));
     text("Mercredi", ((this.x + this.sx)-ecare)/5*2+(((this.x + this.sx)-ecare)/5)/2+first_ele, ((this.y + this.sy)/8+30));
     text("Jeudi", ((this.x + this.sx)-ecare)/5*3+(((this.x + this.sx)-ecare)/5)/2+first_ele, ((this.y + this.sy)/8+30));
     text("Vendredi", ((this.x + this.sx)-ecare)/5*4+(((this.x + this.sx)-ecare)/5)/2+first_ele, ((this.y + this.sy)/8+30));
     textAlign(BASELINE);
     */

    //displayheure();
    displayweek();
  }
}

class Controls extends Window {
  DropdownMenu groupDropdown;
  DropdownMenu salleDropdown;
  DropdownMenu statDropdown;

  Controls(int x, int y, int sx, int sy) {
    super(x, y, sx, sy);
    groupDropdown = new DropdownMenu((int)x + 10,
      (int)y + 10,
      (int)(x + sx)/10,
      (int)(y + sy)/2,
      "Select Group",
      addGroups(LSTSOUSGROUPES));

    salleDropdown = new DropdownMenu((int)x + (x + sx)/5 + 10 * 2,
      (int)y + 10,
      (int)(x + sx)/10,
      (int)(y + sy)/2,
      "Select salle",
      addSalles(LSTSALLES));

    statDropdown = new DropdownMenu((int)x + ((x + sx)/5) * 2 + 10 * 3,
      (int)y + 10,
      (int)(x + sx)/10,
      (int)(y + sy)/2,
      "Select Stats",
      addStats(new String[]{"edt", "graph"}));
  }

  void clicked(int ex, int ey) {
    if (groupDropdown.estClique(ex, ey)) {
      SGROUPE = groupDropdown.selected;
      SROOM = "";
    }
    if (salleDropdown.estClique(ex, ey)) {
      SROOM = salleDropdown.selected;
      SGROUPE = "";
    }
    if (statDropdown.estClique(ex, ey)) {
      SSTATS = statDropdown.selected;
      SGROUPE = "";
      SROOM = "";
    }
  }

  String[] addGroups(SousGroupe[] groups) {
    String[] items = new String[groups.length];
    for (int i = 0; i < groups.length; i++) {
      items[i] = groups[i].nomSsGroupe;
    }
    return items;
  }

  String[] addSalles(Salle[] salles) {
    String[] items = new String[salles.length];
    for (int i = 0; i < salles.length; i++) {
      items[i] = salles[i].nom;
    }
    return items;
  }

  String[] addStats(String[] Stats) {
    String[] items = new String[Stats.length];
    for (int i = 0; i < Stats.length; i++) {
      items[i] = Stats[i];
    }
    return items;
  }

  void display() {
    fill(125);
    rect(x, y, sx, sy);
    groupDropdown.display();
    salleDropdown.display();
    statDropdown.display();
  }
}

class Graph extends Window {
  int marge = 60;
  float[] content;
  float Xscale;
  float Yscale;
  int min, max;

  Graph(int x, int y, int sx, int sy) {
    super(x, y, sx, sy);
  }

  void setContent(float[] content) {
    this.content = content;
    this.min = 0;
    this.max = 0;

    for (int i = 0; i < this.content.length; i++) {
      if (this.content[i] > this.content[this.max]) {
        this.max = i;
      } else if (this.content[i] < this.content[this.min]) {
        this.min = i;
      }
    }

    this.Xscale = (this.sx - (this.marge * 2) - this.x) / (this.content.length);
    this.Yscale = (this.sy - (this.marge) - this.y) / (this.content[this.max] - this.content[this.min]);
  }

  void display() {
    textSize(8);
    line(this.x + this.marge, this.y + this.marge, this.x + marge, this.y + this.sy - this.marge/2);
    line(this.x + this.marge, this.y + this.sy - this.marge, this.x + this.sx - marge, this.y + this.sy - this.marge);
    if (content != null) {
      for (int i = (int)content[min]; i < content[max]; i += Yscale) {
        line(this.x + this.marge/2, // X
          (this.y + this.sy) - (this.y + this.Yscale * (i - content[min]) + this.Yscale * 2), // Y
          this.x + this.marge, // X
          (this.y + this.sy) - (this.y + this.Yscale * (i - content[min]) + this.Yscale * 2) // Y
          );

        text(i,
          this.x + this.marge/4,
          (this.y + this.sy) - (this.y + this.Yscale * (i - content[min]) + this.Yscale * 2) + 3
          );
      }

      circle(this.x + this.Xscale * 0 + this.marge, // X
        (this.y + this.sy) - (this.y + this.Yscale * (content[0] - content[min]) + this.Yscale * 2), // Y
        2 // R
        );

      for (int i = 1; i < content.length; i++) {
        circle(this.x + this.Xscale * i + this.marge, // X
          (this.y + this.sy) - (this.y + this.Yscale * (content[i] - content[min]) + this.Yscale * 2), // Y
          2 // R
          );

        line(this.x + this.Xscale * (i - 1) + this.marge, // X
          (this.y + this.sy) - (this.y + this.Yscale * (content[i - 1] - content[min]) + this.Yscale * 2), // Y
          this.x + this.Xscale * i + this.marge, // X
          (this.y + this.sy) - (this.y + this.Yscale * (content[i] - content[min]) + this.Yscale * 2) // Y
          );

        line(this.x + this.Xscale * i + this.marge, // X
          this.y + this.sy - this.marge/2, // Y
          this.x + this.Xscale * i + this.marge, // X
          this.y + this.sy - this.marge // Y
          );
      }
    }
  }
}
