Table table;
int startX;
int startY;

void setup(){
  table = loadTable("Autonomous Cars Data - Sheet1.csv");
  saveTable(table, "data/new.csv");
  size(1900, 950);
  stroke(255);
  background(255);
  loadMonthlyIncidentsPerMiles();
  seperation();
  loadMonthTotalMiles();
  compareMiles();
}

void loadMonthlyIncidentsPerMiles(){
  textSize(30);
  fill(0, 0, 255);
  text("Monthly Accidents per 1,000,000 Miles Driven", 50, 50);
  startX = 100;
  startY = 175;
  for(int i = 1; i < table.getRowCount(); i++){
    fill(0);
    textSize(15);
    if(table.getInt(i, 1) == 0){
      ellipse(startX, startY, 0, 0);
      fill(255, 0, 0);
      text(table.getString(i, 0), startX - table.getString(i, 0).length() * 3, startY - 75);
      text("" + table.getDouble(i, 1), startX + 5, startY + 5);
    }else{
      ellipse(startX + 15, startY, ((int)table.getDouble(i, 1) * 5), ((int)table.getDouble(i, 1) * 5));
      fill(255, 0, 0);
      text(table.getString(i, 0), startX  - table.getString(i, 0).length() * 3, startY - 75);
      text("" + table.getDouble(i, 1), startX - 5, startY + 5);
    }
    startX += 170;
  }
}

void seperation(){
  stroke(0);
  line(0, 250, 1900, 250);
  line(0, 460, 1900, 460);
}

void loadMonthTotalMiles(){
  textSize(30);
  fill(0, 0, 255);
  text("Monthly Total Miles Driven", 50, 290);
  startX = 100;
  startY = 400;
  for(int i = 1; i < table.getRowCount(); i++){
    fill(0);
    textSize(15);
    int x = 0;
    String d = table.getString(i, 2);
    if(d.indexOf(",") == -1){
      x = Integer.parseInt(d);
    }else{
      String newString = d.substring(0, d.indexOf(","));
      x = Integer.parseInt(newString);
    }
    ellipse(startX + 14, startY, x, x);
    fill(255, 0, 0);
    text(table.getString(i, 0), startX - table.getString(i, 0).length() * 2.75, startY - 75);
    text("" + table.getString(i, 2), startX - 10, startY + 5);
    startX += 170;
  }
}

void compareMiles(){
  textSize(30);
  fill(0, 0, 255);
  text("Manual Cars vs. Automatic Cars per 1,000,000 Miles", 50, 500);
  startX = 200;
  startY = 700;
  fill(0);
  textSize(15);
  double carsPerMile = (double)6064000 / 4371706;
  String rounded = nf((float)carsPerMile, 1, 2);
  ellipse(startX, startY, (int)carsPerMile * 35, (int)carsPerMile * 35);
  ellipse(startX + 600, startY, (int)table.getDouble(1, 5) * 35, (int)table.getDouble(1, 5) * 35);
  fill(255, 0, 0);
  text("Automatic Cars, Crashes per 1,000,000 Miles; Total up to April 2016", startX - 190, startY - 180);
  text("Manual Cars, Crashes per 1,000,000 Miles; Total in 2014", startX + 400, startY - 180);
  text("" + table.getDouble(1, 5), startX + 590, startY);
  text(rounded, startX - 16, startY + 5);
}