// @author L.M.Nunez 23378441

//Declares an Array of Cloud Objects with a fixed index of 14 total Clouds.
Cloud clouds[] = new Cloud[14];
//Declares an Array of Pumpkin Objects with a fixed index of 12 total Pumpkins.
Pumpkin pumpkins[] = new Pumpkin[10];

PShape truck;
PImage pumpkin;
PImage sky;
PImage logo;
PImage discount;
void setup(){
  size(1200,400,P2D);
  strokeWeight(2);
  
  //importing vector shape made using Adobe Illustrator
  truck = loadShape("images/truck.svg");
  
  //importing images made using Adobe Photoshop
  pumpkin = loadImage("images/pumpkin.png");
  logo = loadImage("images/logo.png");
  discount = loadImage("images/discount.png");
  
  //importing image taken from Vecteezy.com (website that provides free vectors and images)
  //https://www.vecteezy.com/vector-art/6174573-beautiful-blue-sky-background
  sky = loadImage("images/sky.jpg");
  
  //For-Loop to initialize uniform Cloud Objects from instantiable Cloud Class
  for (int i = 0; i < clouds.length; i++){
    float random = random(40,120);
    //constructor parameters -> Cloud(xPosition,yPosition,Viewport Boundry Limit)
    clouds[i] = new Cloud((i*100)+100,random,1400);
  }
  
  //For-Loop to initialize uniform Pumpkin Objects from instantiable Pumpkin Class
  for (int i = 0; i < pumpkins.length; i++){
    float randomY = random(250,320);
    pumpkins[i] = new Pumpkin((i*100)+50, randomY);
  }
}

void draw(){
  //ensures static stage/background shapes
  drawBackground();
  drawClouds();
  drawTrees();
  drawStage();
  drawPumpkin();
  drawInstruction();
  drawTruck();
  drawLogo();
  rollCredits();
}

void drawBackground(){
  //sky.png
  textureMode(NORMAL);
  beginShape();
  texture(sky);
  vertex(0,-50,0,0);
  vertex(1200,0,1,0);
  vertex(1200,300,1,1);
  vertex(0,300,0,1);
  endShape();
}

void drawClouds(){
  fill(255);
  //loop calls cloud objects x and y position to draw cloud shape
  for (int i = 0; i < clouds.length; i++){
    ellipse(clouds[i].getXPos(),clouds[i].getYPos(),50,50);
    arc(clouds[i].getXPos()+20,clouds[i].getYPos(), 50, 50, QUARTER_PI-3, PI-0.75,0);
    arc(clouds[i].getXPos()-20,clouds[i].getYPos(), 50, 50, QUARTER_PI, PI+HALF_PI+0.25,0);
    arc(clouds[i].getXPos(),clouds[i].getYPos()-10, 50, 60, PI+0.25, PI+PI-0.25,0);
    
    //calls Set X Position Method() to shift Shape unit right by parameter pixels
    clouds[i].setXPos(0.4);
  }
}

float treeWiggle = 0.0;
float treeTopDiff[] = {5,-5,10,5};
int treeTopHeight;
int treePush;
boolean treeSway = false;
void drawTrees(){
  treePush = 0;
  for(int i = 0; i < 50; i++){
    
    if(i % 4 == 0){
     treePush+=10;
    }else if (i % 7 == 0){
      treePush+=10;
    }
    //trunk
    treeTopHeight = i % 4;
    fill(112, 82, 33);
    rect(35+treePush,215,10,40);
    
    //tree
    fill(88, 138, 95);
    triangle(40+treePush,170,20+treePush,240,60+treePush,240);
    triangle(40+treePush+treeWiggle,135+treeTopDiff[treeTopHeight],20+treePush,220,60+treePush,220);
    //increment tree and trunk spacing
    treePush+=20;
  }
  
  //alters the X position of each tree top 
  if(treeWiggle > 8){
    treeSway = true;
  }else if(treeWiggle < -2){
    treeSway = false;
  }
  
  if (treeSway){
    treeWiggle -= 0.1;
  }else {
    treeWiggle += 0.1;
  }
  
}

void drawStage(){
  //farm house
  fill(204, 155, 8);
  quad(0,400,0,225,50,175,50,250);
  
  //house window
  fill(255);
  quad(17,300,15,255,43,205,43,240);
  line(16,275,43,225);
  line(30,230,30,270);
  
  //house roof
  fill(217, 77, 30);
  triangle(0,265,60,175,0,125); 
  
  //stage shape
  fill(98,227,113);
  quad(-20,400,50,250,1200,250,1220,400);
  
  //farm plot with rows
  fill(125, 85, 54);
  quad(10,400,60,275,1040,275,1090,400);
  fill(0);
  line(25,380,1070,385);
  line(35,360,1065,360);
  line(43,340,1057,340);
  line(50,325,1050,325);
  line(55,310,1045,310);
  line(60,297,1040,297);
  line(63,285,1037,285);
}

int mouseXTopRange;
int mouseXBottomRange;
int mouseYTopRange;
int mouseYBottomRange;
void mouseClicked(){
  //range set to dimensions of Pumpkin shape
  mouseXTopRange = mouseX-70;
  mouseXBottomRange = mouseX;
  mouseYTopRange = mouseY-70;
  mouseYBottomRange = mouseY;
}

int pumpkinCount = 0;
void drawPumpkin(){
  for(int i = 0; i < pumpkins.length; i++){
    //checks if mouse click is within range of pumpkin[i] X Position and Y Position
    if(mouseXTopRange <= pumpkins[i].getXPos() && mouseXBottomRange >= pumpkins[i].getXPos() && mouseYTopRange <= pumpkins[i].getYPos() && mouseYBottomRange >= pumpkins[i].getYPos()){
      pumpkins[i].setYPos(450);
      pumpkinCount+=10;
      //User has begun play. Instruction leaves screen
      instruction = "";
      instuctionY = 400;
    }
    //Pumpkins scale based on distance from camera
    strokeWeight(0);
    beginShape();
      texture(pumpkin);
      vertex(pumpkins[i].getXPos(),pumpkins[i].getYPos(),0,0);
      vertex(pumpkins[i].getXPos()+(pumpkins[i].getYPos()/5),pumpkins[i].getYPos(),1,0);
      vertex(pumpkins[i].getXPos()+(pumpkins[i].getYPos()/5),pumpkins[i].getYPos()+(pumpkins[i].getYPos()/5),1,1);
      vertex(pumpkins[i].getXPos(),pumpkins[i].getYPos()+(pumpkins[i].getYPos()/5),0,1);
    endShape();
    strokeWeight(2);
  }
}

String instruction = "Click & Collect Pumpkins";
int instuctionY = 150;
void drawInstruction(){
  fill(84, 143, 92);
  //logo background shape
  rect(200,instuctionY,670,75);
  textSize(64);
  fill(0);
  //text shadow
  text(instruction,204, 205);
  text(instruction,204, 201);
  text(instruction,200, 205);
  text(instruction,200, 201);
  fill(255);
  //text line 1
  text(instruction,202, 203);
}

int truckXPos = 1050;
void drawTruck(){
  //draws Truck.svg
  shape(truck,truckXPos,150,300,200);
  
  //draws pumpkin image on truck trailer
  strokeWeight(0);
  beginShape();
    texture(pumpkin);
    vertex(truckXPos+50,270,0,0);
    vertex(truckXPos+100,270,1,0);
    vertex(truckXPos+100,320,1,1);
    vertex(truckXPos+50,320,0,1);
  endShape();
  strokeWeight(2);
  
  //pumpkins collected counter
  fill(0);
  textSize(64);
  text("\u20ac "+pumpkinCount,truckXPos+25,260);
}

int logoMovement = -700;
int discountMovement = 1600;
void drawLogo(){
  strokeWeight(0);
    beginShape();
      texture(logo);
      vertex(logoMovement,0,0,0);
      vertex(logoMovement+700,0,1,0);
      vertex(logoMovement+700,400,1,1);
      vertex(logoMovement,400,0,1);
    endShape();
    beginShape();
      texture(discount);
      vertex(discountMovement-400,0,0,0);
      vertex(discountMovement,0,1,0);
      vertex(discountMovement,400,1,1);
      vertex(discountMovement-400,400,0,1);
    endShape();
    strokeWeight(2);
}

//waits for all pumpkins to be collected to move truck and reveal logo
void rollCredits(){
  if (pumpkinCount == 100 && logoMovement < 0){
    logoMovement+=10;
    discountMovement-=5;
    truckXPos += 2;
  }
}
