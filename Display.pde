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

 void displayEDT() {


    stroke(0);
    rectMode(CORNERS);
    textAlign(CENTER, CENTER);
    for (int i=0; i<Nbdays; i++) {
      fill(255);
      rect(daySize*i+first_J, y+margeH, daySize*(i+1)+first_J-10, Edtheight-margeH);
      fill(0);
      if ((FDS-(7-i))%100>0 && (FDS-(7-i))%100<50) {
        if (FDS%10000/100<10)text(JSemaine[i]+" "+((FDS-(7-i))%100)+"/0"+FDS%10000/100, daySize*i+Cday+first_J, y+margeJS/2+margeH);
        else text(JSemaine[i]+" "+((FDS-(7-i))%100)+"/"+FDS%10000/100, daySize*i+Cday+first_J, y+margeJS/2+margeH);
      } else {
        if (DDS%10000/100<10)text(JSemaine[i]+" "+((DDS+i-1)%100)+"/0"+DDS%10000/100, daySize*i+Cday+first_J, y+margeJS/2+margeH);
        else text(JSemaine[i]+" "+((DDS+i-1)%100)+"/"+DDS%10000/100, daySize*i+Cday+first_J, y+margeJS/2+margeH);
      }
    }
    rectMode(CORNER);
    textAlign(RIGHT, CENTER);
    fill(0);
    for (int i=0; i<nbH; i++) {
      if (i!=nbH-1) {
        text(8+i+":00", first_J-3, hourSize*i+y+margeH+margeJS);
        for (int y=1; y<51; y++) {
          if (y%2==1)line((Edtwidth-first_J)/50*y+first_J-15, hourSize*i+this.y+margeH+margeJS, (Edtwidth-first_J)/50*(y+1)+first_J-15, hourSize*i+this.y+margeH+margeJS);
        }
      } else text(">"+(8+i)+":00", first_J-3, hourSize*i+y+margeH+margeJS);
    }
  }


  void displayweek() {
    for (int u=0; u<LSTEVENTS.length; u++) {
      for (int i=LSTEVENTS[u].length-1; i>0; i--) {
        if (DDS<=AMJ(LSTEVENTS[u][i]) && FDS>AMJ(LSTEVENTS[u][i]) && (contains(LSTEVENTS[u][i].groupe, SGROUPE ) || contains(LSTEVENTS[u][i].location, SROOM ))) {
          displayhoraire(LSTEVENTS[u][i], Cweek(Dat(LSTEVENTS[u][i], 0, 4, true), Dat(LSTEVENTS[u][i], 4, 6, true), Dat(LSTEVENTS[u][i], 6, 8, true)), Hm(LSTEVENTS[u][i]), HmF(LSTEVENTS[u][i]));
        }
      }
    }
    textAlign(LEFT, LEFT);

    //    for (int u=0; u<blbl.length; u++) {
    //  for (int i=blbl[u].length-1; i>0; i--) {
    //    if (DDS<=AMJ(blbl[u][i]) && FDS>AMJ(blbl[u][i]) && (contains(blbl[u][i].groupe, SGROUPE ) || contains(blbl[u][i].location, SROOM ))) {
    //      displayhoraire(blbl[u][i], Cweek(Dat(blbl[u][i], 0, 4, true), Dat(blbl[u][i], 4, 6, true), Dat(blbl[u][i], 6, 8, true)), Hm(blbl[u][i]), HmF(blbl[u][i]));
    //    }
    //  }
    //}
    textAlign(LEFT, LEFT);

    //for (int u=0; u<initExam().length; u++) {
    //  for (int i=initExam()[u].length-1; i>0; i--) {
    //    if (DDS<=AMJ(initExam()[u][i]) && FDS>AMJ(initExam()[u][i]) && (contains(initExam()[u][i].groupe, SGROUPE ) || contains(initExam()[u][i].location, SROOM ))) {
    //      displayhoraire(initExam()[u][i], Cweek(Dat(initExam()[u][i], 0, 4, true), Dat(initExam()[u][i], 4, 6, true), Dat(initExam()[u][i], 6, 8, true)), Hm(initExam()[u][i]), HmF(initExam()[u][i]));
    //    }
    //  }
    //}
    //textAlign(LEFT, LEFT);
  }

  void displayhoraire(Event event, float jour, float debut, float fin) {
    textAlign(CENTER, CENTER);
    float dbut=(hourSize*(debut-800)/100)+(y+margeH+margeJS);
    float fn=(hourSize*(fin-800)/100)+(y+margeH+margeJS);
    float Height=fn-dbut;
    rectMode(CORNERS);
    if (fin>1900) {
      fn=(hourSize*(1900-800)/100)+(y+margeH+margeJS);
    }

    fill(105, 15, 88);
    rect(daySize * jour + first_J, dbut, this.daySize * (jour + 1) + first_J - 10, fn, 20);
    fill(255, 255, 255);
    int k=0;
    int p=0;
    int i=0;
    for (int l=0; l<Height/15; l++) {
      int TxtW=0;

      if (textWidth(event.summary)+15>daySize)event.summary=event.summary.substring(0, 20)+"...";
      if (l==0) {
        if (Height>50)text(event.summary, daySize * jour + first_J +Cday, dbut+13);
        else text(event.summary, daySize * jour + first_J +Cday, dbut+Height/2);
      }
      if ( event.location.length!=0 && Height>=100) {
        for (int j=0; j<event.location.length; j++) {
          TxtW+=(int)textWidth(event.location[j])+10;
        }
        TxtW-=10;
        for (; i<event.location.length && i*15<Height/4; i++) {
          if (k>5)k=5;
          text(event.location[i], daySize * jour + first_J +Cday, dbut+Height/2 + i*15);
        }
      }
      if (l<Height/30 && l!=1) {
        if ( event.teacher.length!=0 && Height>=100) {
          for (; p<event.teacher.length; p++) {
            if (event.teacher[p]!=null) {
              if (textWidth(event.teacher[p])+5>daySize)event.teacher[p]=event.teacher[p].substring(0, 18)+"...";
              text(event.teacher[p], daySize * jour + first_J +Cday, dbut+Height/4 +p*14 -event.teacher.length*7);
            }
          }
        }
      }
    }
    rectMode(CORNER);
    textAlign(LEFT, LEFT);
    text(DatS(event, 9, 11, true)+":"+DatS(event, 11, 13, true)+"-->"+DatS(event, 9, 11, false)+":"+DatS(event, 11, 13, false), daySize * jour + first_J +5, fn-10 );
  }
  void display() {
    textSize(13);
    displayEDT();
    displayweek();
    displayboutons();
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
    fill(175);
    stroke(175);
    line(this.x + this.marge, this.y + this.marge, this.x + marge, this.y + this.sy - this.marge*0.8);
    line(this.x + this.marge, this.y + this.sy - this.marge, this.x + this.sx - marge, this.y + this.sy - this.marge);
    if (content != null) {
      for (int i = (int)content[min]; i < content[max]; i += Yscale) {
        line(this.x + this.marge*0.8, // X
          (this.y + this.sy - this.marge) - (this.Yscale * (i - content[min])), // Y
          this.x + this.marge, // X
          (this.y + this.sy - this.marge) - (this.Yscale * (i - content[min])) // Y
          );

        text(i,
          this.x + this.marge/4,
          (this.y + this.sy - this.marge) - (this.Yscale * (i - content[min])) + 3
          );
      }
      textSize(12);
      text("Valeur max.:" + round(content[max]),
        this.x + this.marge/4,
        this.y + this.marge/2
        );
      stroke(204, 102, 0);
      fill(204, 102, 0);
      circle(this.x + this.Xscale * 0 + this.marge, // X
        (this.y + this.sy - this.marge) - (this.Yscale * (content[0] - content[min])), // Y
        4 // R
        );

      for (int i = 1; i < content.length; i++) {

        stroke(0);
        line(this.x + this.Xscale * (i - 1) + this.marge, // X
          (this.y + this.sy - this.marge) - (this.Yscale * (content[i - 1] - content[min])), // Y
          this.x + this.Xscale * i + this.marge, // X
          (this.y + this.sy - this.marge) - (this.Yscale * (content[i] - content[min])) // Y
          );
        stroke(204, 102, 0);
        fill(204, 102, 0);
        circle(this.x + this.Xscale * (i - 1) + this.marge, // X
          (this.y + this.sy - this.marge) - (this.Yscale * (content[i - 1] - content[min])), // Y
          4 // R
          );
        fill(175);
        stroke(175);
        line(this.x + this.Xscale * i + this.marge, // X
          this.y + this.sy - this.marge*0.8, // Y
          this.x + this.Xscale * i + this.marge, // X
          this.y + this.sy - this.marge // Y
          );
      }
      stroke(204, 102, 0);
      fill(204, 102, 0);
      circle(this.x + this.Xscale * (content.length - 1) + this.marge, // X
        (this.y + this.sy - this.marge) - (this.Yscale * (content[(content.length - 1)] - content[min])), // Y
        4 // R
        );
    }
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