final int GAME_START = 0;
final int GAME_RUN = 1;
final int GAME_OVER = 2;
int gameState = GAME_START;

final int BUTTON_TOP = 360;
final int BUTTON_BOTTOM = 420;
final int BUTTON_LEFT = 248;
final int BUTTON_RIGHT = 392;

PImage skyImg, lifeImg;
PImage soil0, soil1, soil2, soil3, soil4, soil5, stone1, stone2;
PImage groundhogImg, groundhogDownImg, groundhogLeftImg, groundhogRightImg;
PImage titleImg, gameoverImg, startNormalImg, startHoveredImg, restartNormalImg, restartHoveredImg;

int x=0, y=0;
int soldierX, soldierY;

float groundhogX;
float groundhogY;
int groundhogSize;
final int soilSize = 80;
int cabbageX;
int cabbageY;
int cabbageSize;

int hogState;
boolean downPressed = false;
boolean leftPressed = false;
boolean rightPressed = false;
final int HOG_IDLE=1;
final int HOG_DOWN=2;
final int HOG_LEFT=3;
final int HOG_RIGHT=4;
float t;
float moveY=0;

// For debug function; DO NOT edit or remove this!
int playerHealth = 0;
float cameraOffsetY = 0;
boolean debugMode = false;

void setup() {
  size(640, 480, P2D);
  frameRate (60);


  skyImg = loadImage("img/bg.jpg");
  lifeImg = loadImage("img/life.png");

  soil0 = loadImage("img/soil0.png");
  soil1 = loadImage("img/soil1.png");
  soil2 = loadImage("img/soil2.png");
  soil3 = loadImage("img/soil3.png");
  soil4 = loadImage("img/soil4.png");
  soil5 = loadImage("img/soil5.png");
  stone1 = loadImage("img/stone1.png");
  stone2 = loadImage("img/stone2.png");

  groundhogImg = loadImage("img/groundhogIdle.png");
  groundhogDownImg = loadImage("img/groundhogDown.png");
  groundhogLeftImg = loadImage("img/groundhogLeft.png");
  groundhogRightImg = loadImage("img/groundhogRight.png");
  titleImg = loadImage("img/title.jpg");
  startNormalImg = loadImage("img/startNormal.png");
  startHoveredImg = loadImage("img/startHovered.png");
  restartNormalImg = loadImage("img/restartNormal.png");
  restartHoveredImg = loadImage("img/restartHovered.png");
  gameoverImg = loadImage("img/gameover.jpg");


  playerHealth = 2;


  groundhogX=0.0;
  groundhogY=0.0;
  groundhogSize=80;
  t=0.0;
  hogState = HOG_IDLE;

}

void draw() {
  switch(gameState) {
  case GAME_START:
    image(titleImg, 0, 0);
    hogState=HOG_IDLE;
    t=0.0;
    downPressed=false;
    leftPressed=false;
    rightPressed=false;

    if (mouseX > BUTTON_LEFT && mouseX < BUTTON_RIGHT
      && mouseY > BUTTON_TOP && mouseY < BUTTON_BOTTOM) {
      image(startHoveredImg, BUTTON_LEFT, BUTTON_TOP);
      if (mousePressed) {
        gameState = GAME_RUN;
      }
    } else {
      image(startNormalImg, BUTTON_LEFT, BUTTON_TOP);
    }
    break;

  case GAME_RUN:

    image(skyImg, 0, 0);
    fill(253, 184, 19);
    strokeWeight(5);
    stroke(255, 255, 0);
    ellipse(590, 50, 120, 120);
    
    /* ------ Debug Function ------
    Please DO NOT edit the code here.
    It's for reviewing other requirements when you fail to complete the camera moving requirement.
    */
    if (debugMode) {
      pushMatrix();
      translate(0, cameraOffsetY);
    }
    /* ------ End of Debug Function ------ */
    
    if(moveY > -1600){
      moveY=soilSize-groundhogY;//a changing number(since the groundhogY is changing)
    }
    pushMatrix();
    translate(0,moveY);
     
        for (int i=0; i<width; i+=soilSize) {
          for (int n=160; n<160+soilSize*4; n+=soilSize) {
            image(soil0, i, n);
          }
          for (int n=480; n<480+soilSize*4; n+=soilSize) {
            image(soil1, i, n);
          }
          for (int n=800; n<800+soilSize*4; n+=soilSize) {
            image(soil2, i, n);
          }
          for (int n=1120; n<1120+soilSize*4; n+=soilSize) {
            image(soil3, i, n);
          }
          for (int n=1440; n<1440+soilSize*4; n+=soilSize) {
            image(soil4, i, n);
          }
          for (int n=1760; n<1760+soilSize*4; n+=soilSize) {
            image(soil5, i, n);
          }
        }
    
        //stone1~8
        pushMatrix();
        translate(0, 160);
        y=0;
        x = soilSize;
        y=0;
        for (int i=0; i<8; i++) {
          x = i*soilSize;
          image(stone1, x, y);
          y += soilSize;
        }
        popMatrix();
    
        //stone 9~16
        pushMatrix();
        translate(0, 160+soilSize*8);
        y=0;
        x = soilSize;
        for (int i=0; i<4; i++) {
          for (int n=0; n<4; n++) {
            x = (i+1)*soilSize;
            y = n*soilSize;
            if (i>1) {
              x = (i+3)*soilSize;
            }
            if (n>=1) {
              y = (n+2)*soilSize;
            }
            if (n>=3) {
              y = (n+4)*soilSize;
            }
            image(stone1, x, y);
          }
        }
        for (int i=0; i<4; i++) {
          for (int n=0; n<4; n++) {
            x = i*soilSize;
            y = (n+1)*soilSize;
            if (i>0) {
              x = (i+2)*soilSize;
            }
            if (i==3) {
              x = (i+4)*soilSize;
            }
            if (n>=2) {
              y = (n+3)*soilSize;
            }
            image(stone1, x, y);
          }
        }
        popMatrix();
    
        //stone 17~24
        pushMatrix();
        translate(-soilSize*6, 160+soilSize*16);
        y=0;
        x=0;
        for (int n=0; n<5; n++) {
          pushMatrix();
          translate(n*soilSize*3, 0);
          for (int i=7; i>-1; i--) {
            int x1, x2;
            x1 = soilSize*i;
            image(stone1, x1, y);
            x2 = soilSize*(i+1);
            image(stone1, x2, y);
            image(stone2, x2, y);
            y += soilSize;
          }
          y=0;
          popMatrix();
        }
        popMatrix();
    
        strokeWeight(15);
        stroke(24, 204, 25);
        line(0, 152.5, 640, 152.5);
     
        
        // groundhog
        
        switch(hogState) {
        case HOG_IDLE:
          image(groundhogImg, groundhogX, groundhogY);
          t=0.0;
          break;
    
        case HOG_DOWN:
          image(groundhogDownImg, groundhogX, groundhogY);
          groundhogY += (80.0/15.0);
          t++;
          break;
    
        case HOG_LEFT:
          image(groundhogLeftImg, groundhogX, groundhogY);
          groundhogX -= (80.0/15.0);
          t++;
          break;
    
        case HOG_RIGHT:
          image(groundhogRightImg, groundhogX, groundhogY);
          groundhogX += (80.0/15.0);
          t++;
          break;
        }
        
      
        if (groundhogX > width-groundhogSize) {
          groundhogX = width-groundhogSize;
        }
        if (groundhogX < 0) {
          groundhogX = 0.0;
        }
        if (groundhogY > 160+24*soilSize-groundhogSize) {
          groundhogY = 160+24*soilSize-groundhogSize;
        }
        if (groundhogY < 80) {
          groundhogY = 80.0;
        }
        
        if (t==15.0) {
          hogState=HOG_IDLE;
          if (groundhogX%soilSize < 10) {
            groundhogX=groundhogX-groundhogX%soilSize;
          } else {
            groundhogX=groundhogX-groundhogX%soilSize+soilSize;
          }
          if (groundhogY%soilSize < 10) {
            groundhogY=groundhogY-groundhogY%soilSize;
          } else {
            groundhogY=groundhogY-groundhogY%soilSize+soilSize;
          }
        

        
       
        }
        
        
    popMatrix();
    
    
    // DO NOT REMOVE OR EDIT THE FOLLOWING 3 LINES
    if (debugMode) {
      popMatrix();
    }
    
    //playerHealth (size: 50*43) game change; gap=20pixel
    if (playerHealth >= 5) playerHealth = 5;
    for (int i=0; i<playerHealth; i++) {
      image(lifeImg, 10+i*70, 10);
    }
    if (playerHealth == 0) {
      gameState = GAME_OVER;
    }
    
    break;

  case GAME_OVER:
    image(gameoverImg, 0, 0);//gameover picture
    downPressed=false;
    leftPressed=false;
    rightPressed=false;
    //detect button position
    if (mouseX > BUTTON_LEFT && mouseX < BUTTON_RIGHT
      && mouseY > BUTTON_TOP && mouseY < BUTTON_BOTTOM) {
      image(restartHoveredImg, BUTTON_LEFT, BUTTON_TOP);
      if (mousePressed) {
        gameState = GAME_RUN;
        playerHealth = 2;
        
        moveY=0;
        
        groundhogX=320.0;
        groundhogY=80.0;
        hogState=HOG_IDLE;
        t=0.0;

        soldierY = 80*floor(random(2, 6));
        cabbageX = 80*floor(random(0, 8));
        cabbageY = 80*floor(random(2, 6));
      }
    } else {
      image(restartNormalImg, BUTTON_LEFT, BUTTON_TOP);
    }
    break;
  }
}

void keyPressed() {
  if (key==CODED) {
    switch (keyCode) {
    case DOWN:
      if (hogState == HOG_IDLE) {
        downPressed=true;
        hogState = HOG_DOWN;
        t=0.0;
      }
      break;
    case LEFT:
      if (hogState == HOG_IDLE) {
        leftPressed=true;
        hogState = HOG_LEFT;
        t=0.0;
      }
      break;
    case RIGHT:
      if (hogState == HOG_IDLE) {
        rightPressed=true;
        hogState = HOG_RIGHT;
        t=0.0;
      }
      break;
    }
  }

  // DO NOT REMOVE OR EDIT THE FOLLOWING SWITCH/CASES
  switch(key) {
  case 'w':
    debugMode = true;
    cameraOffsetY += 25;
    break;

  case 's':
    debugMode = true;
    cameraOffsetY -= 25;
    break;

  case 'a':
    if (playerHealth > 0) playerHealth --;
    break;

  case 'd':
    if (playerHealth < 2) playerHealth ++;
    break;
  }
}
