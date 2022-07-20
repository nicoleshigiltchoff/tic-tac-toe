boolean intro=true;
boolean game=false;
boolean won=false;
String winner="";

int player_mode=1; //0=o, 1=x
boolean player=false; //it is player's turn to go

String[][] board={{"", "", ""}, {"", "", ""}, {"", "", ""}};

color c1=color(150, 255, 255);
color c2=color(0, 0, 100);
color c3=color(0, 0, 100);

//CONTROLLER FUNCTIONS

void setup()
  //runs at the start of program operation
{
  rectMode(CENTER);
  size(1000, 1000);
  textSize(40);
}

void draw()
  //runs continuously throughout program operation
{
  if (intro)
  {
    introSetup();
  } else if (game)
  {
    player=true;
    drawBoard();
    checkWin();
    checkTie();
  }
}

void keyPressed()
  //runs each time a key is pressed
{
  if (intro) {
    if (key=='x' || key=='X') {
      player_mode=1;
      intro=false;
      game=true;
      gameSetup();
    } else if (key=='o' || key=='O' || key=='0') {
      player_mode=0;
      intro=false;
      game=true;
      gameSetup();
    }
  }
}

void mouseClicked()
  //runs each time mouse is clicked
{

  if (intro) 
  {
    //choosing x vs o with the buttons
    if (mouseX>width/3-50 && mouseX<width/3+50 && mouseY>500 && mouseY<600) { //player clicked on X
      player_mode=1;
      intro=false;
      game=true;
      gameSetup();
    }
    if (mouseX>2*width/3-50 && mouseX<2*width/3+50 && mouseY>500 && mouseY<600) { //player clicked on O
      player_mode=0;
      intro=false;
      game=true;
      gameSetup();
    }

    //choosing color mode
    if (mouseX>width/5-60 && mouseX<width/5+60 && mouseY>760 && mouseY<840) { //aqua
      c1=color(150, 255, 255);
      c2=color(0, 0, 100);
      c3=color(0, 0, 100);
      introSetup();
    }

    if (mouseX>2*width/5-60 && mouseX<2*width/5+60 && mouseY>760 && mouseY<840) { //sunset
      c1=color(255, 220, 138);
      c2=color(156, 36, 17);
      c3=color(201, 24, 181);
      introSetup();
    }

    if (mouseX>3*width/5-60 && mouseX<3*width/5+60 && mouseY>760 && mouseY<840) { //forest
      c1=color(234, 252, 174);
      c2=color(39, 130, 9);
      c3=color(95, 105, 12);
      introSetup();
    }

    if (mouseX>4*width/5-60 && mouseX<4*width/5+60 && mouseY>760 && mouseY<840) { //mono
      c1=color(255);
      c2=color(0);
      c3=color(0);
      introSetup();
    }
  }

  if (game) //put the player positions into the board
  {   
    textSize(400);
    
    if (player) {
      playerTurn();
    }
  }

  if (won)
  {
    if (mouseX>width/2-65 && mouseX<width/2+65 && mouseY>height/2-40 && mouseY<height/2+40) {
      won=false;
      game=false;
      intro=true;
      winner="";
      player=false;

      //make the board blank
      for (int h=0; h<3; h++)
      {
        for (int w=0; w<3; w++)
        {
          board[h][w]="";
        }
      }
    }
  }
}

void printBoard()
  //prints the tictactoe board in the console, mainly useful for debugging purposes
{
  for (int h=0; h<3; h++) {
    for (int w=0; w<3; w++) {
      if (board[h][w]=="") {
        print("/");
      } else {
        print(board[h][w]);
      }
    }
    println();
  }
  println("---");
}

//INTERFACES

void introSetup()
  //introduction interface
{
  fill(c1);
  stroke(c1);
  rect(width/2, height/2, width+2, height+2);
  textSize(40);
  fill(c2);
  text("Welcome to Nicole's tictactoe!", 215, 250);
  text("Do you want to play as X or O?", 210, 320);
  textSize(20);
  fill(c3);
  text("Click the buttons to select, or use the keys after clicking ", 235, 380);
  text("inside the window to activate keyboard functions", 265, 410);

  textSize(40);
  fill(c2);
  stroke(c2);
  rect(width/3, 550, 100, 100, 10);
  rect(2*width/3, 550, 100, 100, 10);
  fill(c1);
  text("X", 320, 563);
  text("O", 650, 563);

  fill(c2);
  textSize(30);
  text("Click to select your color mode", 275, 730);

  //aqua
  fill(0, 0, 100);
  stroke(0, 0, 100);
  rect(width/5, 800, 120, 80, 10);
  fill(150, 255, 255);
  text("aqua", width/5-35, 808);

  //sunset
  fill(156, 36, 17);
  stroke(156, 36, 17);
  rect(2*width/5, 800, 120, 80, 10);
  fill(255, 220, 138);
  text("sunset", 2*width/5-48, 808);

  //forest
  fill(39, 130, 9);
  stroke(39, 130, 9);
  rect(3*width/5, 800, 120, 80, 10);
  fill(234, 252, 174);
  text("forest", 3*width/5-43, 808);

  //mono
  fill(0);
  stroke(0);
  rect(4*width/5, 800, 120, 80, 10);
  fill(255);
  text("mono", 4*width/5-42, 808);
}

void gameSetup()
  //draws board grid
{
  fill(c1);
  rect(width/2, height/2, width+2, height+2);
  stroke(c3);
  strokeWeight(3);
  line(width/3, 0, width/3, height);
  line(2*width/3, 0, 2*width/3, height);
  line(0, height/3, width, height/3);
  line(0, 2*height/3, width, 2*height/3);
}

void restartButton()
{
  fill(c2);
  stroke(c2);
  rect(width/2, height/2, 130, 80, 10);
  fill(c1);
  textSize(30);
  text("Restart?", width/2-57, height/2+7);
}

void winScreen()
  //draws winning interface
{
  fill(c1, 200);
  stroke(c1);
  rect(width/2, height/2, width, height);
  fill(c3);
  textSize(40);
  if (winner=="p") {
    text("You won!", width/3+80, height/2-100);
  } else if (winner=="c") {
    text("Computer won!", width/3+20, height/2-100);
  }

  restartButton();
}

void tieScreen()
  //draws tie interface
{
  fill(c1, 200);
  stroke(c1);
  rect(width/2, height/2, width, height);
  fill(c3);
  textSize(40);
  text("Yall tied", width/3+90, height/2-100);

  restartButton();
}

void drawBoard()
  //draws Xs and Os on the board based on stored board
{
  textSize(300);
  fill(c2);
  for (int h=0; h<3; h++) {
    for (int w=0; w<3; w++) {
      if (board[h][w]=="p") {
        if (player_mode==0) {
          text("O", w*width/3+50, h*height/3+280);
        } else if (player_mode==1) {
          text("X", w*width/3+75, h*height/3+270);
        }
      } else if (board[h][w]=="c") {
        if (player_mode==1) {
          text("O", w*width/3+50, h*height/3+280);
        } else if (player_mode==0) {
          text("X", w*width/3+75, h*height/3+270);
        }
      }
    }
  }
}

//GAME STATUS CHECKS

void checkWin()
  //check if someone has one, ie there are 3 non-blanks in a row
{
  //check straight wins
  for (int i=0; i<3; i++) {
    //check horizontal wins
    if (board[i][0]==board[i][1] && board[i][0]==board[i][2] && board[i][0]!="") {
      winner=board[i][0];
      game=false;
      won=true;
      winScreen();
    }
    //check vertical wins
    if (board[0][i]==board[1][i] && board[0][i]==board[2][i] && board[0][i]!="") {
      winner=board[0][i];
      game=false;
      won=true;
      winScreen();
    }
  }

  //check up->down diagonal
  if (board[0][0]==board[1][1] && board[0][0]==board[2][2] && board[0][0]!="") {
    winner=board[0][0];
    game=false;
    won=true;
    winScreen();
  }

  //check down->up diagonal
  if (board[0][2]==board[1][1] && board[0][2]==board[2][0] && board[0][2]!="") {
    winner=board[0][2];
    game=false;
    won=true;
    winScreen();
  }
}

void checkTie()
  //check if there's a tie, ie all the spaces on the board are full and the game hasn't been won
{
  if (won==false && intro==false) {
    boolean tie=true;
    for (int h=0; h<3; h++) {
      if (tie) {
        for (int w=0; w<3; w++) {
          if (board[h][w]=="") {
            tie=false;
            break;
          }
        }
      } else {
        break;
      }
    }
    if (tie) {
      game=false;
      tieScreen();
      won=true;
    }
  }
}

//GAME PLAY ACTIONS

void playerTurn()
  //stores a player position in the board based on click location
{
  for (int w=0; w<3; w++) {
    for (int h=0; h<3; h++) {
      //check whether player has clicked in what given square
      if (mouseX>w*width/3 && mouseX<(w+1)*width/3 && mouseY>h*height/3 && mouseY<(h+1)*height/3) 
      {
        //println("position detected");
        if (board[h][w]=="") { //if that position is currently not filled...
          board[h][w]="p"; //...store that there is a player there
          //turn_counter++;
          player=false;
        }
      }
    }
  }
  drawBoard();
  checkWin();
  computerTurn(); //computer goes after player
}

void computerTurn()
  //THE WINNING ALGORITHM, AS OBTAINED FROM https://inventwithpython.com/chapter10.html
  //1. check if computer can win, then go there
  //2. check if player is about to win, then go there
  //3. check if corners are free, then go there
  //4. check if center is free, then go there
  //5. move to side as a last resort

{
  if (rule1_2("c")) {
  } else if (rule1_2("p")) {
  } else if (rule3()) {
  } else if (rule4()) {
  } else {
    rule5();
  }

  player=true;
}

boolean conditions(String itemType, int ppCounter, int ccCounter) 
  //itemType: "c" or "p" ; ppCounter: pCounter, how many player positions there are ; ccCounter: cCounter, how many computer positions there are
  //returns whether or not there is a near-win for either player or computer (depending on itemType)
{
  if (itemType=="p") {
    if (ppCounter==2 && ccCounter==0) {
      return true;
    }
  } else {
    if (ppCounter==0 && ccCounter==2) {
      return true;
    }
  }
  return false;
}

boolean rule1_2(String ruleType) //ruleType: "c" for rule 1, "p" for rule 2
{
  //check near-wins for rows:
  for (int h=0; h<3; h++) { //iterate through rows
    int pCounter=0;
    int cCounter=0;
    //counts how many player and computer spaces there are in each row
    for (int w=0; w<3; w++) {
      if (board[h][w]=="c") {
        cCounter++;
      } else if (board[h][w]=="p") {
        pCounter++;
      }
    }

    //checking if computer/player is about to win
    if (conditions(ruleType, pCounter, cCounter)) {
      for (int i=0; i<3; i++) {
        //put the computer in the blank space to either win (rule 1) or stop player from winning (rule 2)
        if (board[h][i]=="") {
          board[h][i]="c";
          return true;
        }
      }
    }
  }

  //check near-wins for columns
  for (int w=0; w<3; w++) {
    int pCounter=0;
    int cCounter=0;
    for (int h=0; h<3; h++) {
      if (board[h][w]=="c") {
        cCounter++;
      } else if (board[h][w]=="p") {
        pCounter++;
      }
    }

    //checking if computer/player is about to win
    if (conditions(ruleType, pCounter, cCounter)) {
      for (int i=0; i<3; i++) {
        if (board[i][w]=="") {
          board[i][w]="c";
          return true;
        }
      }
    }
  }

  //check near-wins for up->down diagonal
  int pCounter1=0;
  int cCounter1=0;
  for (int pos=0; pos<3; pos++) {
    if (board[pos][pos]=="c") {
      cCounter1++;
    } else if (board[pos][pos]=="p") {
      pCounter1++;
    }
  }

  //checking if computer/player is about to win
  if (conditions(ruleType, pCounter1, cCounter1)) {
    for (int i=0; i<3; i++) {
      if (board[i][i]=="") {
        board[i][i]="c";
        return true;
      }
    }
  }

  //check near-wins for down->up diagonal
  int pCounter2=0;
  int cCounter2=0;
  for (int pos=0; pos<3; pos++) {
    if (board[pos][2-pos]=="c") {
      cCounter2++;
    } else if (board[pos][2-pos]=="p") {
      pCounter2++;
    }
  }

  //checking if computer/player is about to win
  if (conditions(ruleType, pCounter2, cCounter2)) {
    for (int i=0; i<3; i++) {
      if (board[i][2-i]=="") {
        board[i][2-i]="c";
        return true;
      }
    }
  }

  return false;
}

boolean rule3()
{
  int[] collectedCorners=new int[0]; 

  //checking for blank corners
  if (board[0][0]=="") {
    collectedCorners=append(collectedCorners, 1);
  }
  if (board[0][2]=="") {
    collectedCorners=append(collectedCorners, 2);
  }
  if (board[2][0]=="") {
    collectedCorners=append(collectedCorners, 3);
  }
  if (board[2][2]=="") {
    collectedCorners=append(collectedCorners, 4);
  }

  if (collectedCorners.length==0) {
    return false;
    //
  } else {
    //randomly select a blank corner from the list of blank corner
    int cornerChooser=collectedCorners[int(random(collectedCorners.length))]; 
    int[] position=new int[2];

    if (cornerChooser==1) {
      position[0]=0;
      position[1]=0;
    } else if (cornerChooser==2) {
      position[0]=0;
      position[1]=2;
    } else if (cornerChooser==3) {
      position[0]=2;
      position[1]=0;
    } else if (cornerChooser==4) {
      position[0]=2;
      position[1]=2;
    }

    board[position[0]][position[1]]="c";
    return true;
  }
}

boolean rule4()
{
  if (board[1][1]=="") {
    board[1][1]="c";
    return true;
  } else {
    return false;
  }
}

boolean rule5()
{
  int[] collectedSides=new int[0]; 

  //checking for blank corners
  if (board[0][1]=="") {
    collectedSides=append(collectedSides, 1);
  }
  if (board[1][0]=="") {
    collectedSides=append(collectedSides, 2);
  }
  if (board[1][2]=="") {
    collectedSides=append(collectedSides, 3);
  }
  if (board[2][1]=="") {
    collectedSides=append(collectedSides, 4);
  }

  if (collectedSides.length==0) {
    return false;
    //
  } else {
    //randomly select a blank side from the array of empty sides
    int cornerChooser=collectedSides[int(random(collectedSides.length))]; 
    
    int[] position=new int[2];

    //based on the random number selection, return the corresponding side
    if (cornerChooser==1) {
      position[0]=0;
      position[1]=1;
    } else if (cornerChooser==2) {
      position[0]=1;
      position[1]=0;
    } else if (cornerChooser==3) {
      position[0]=1;
      position[1]=2;
    } else if (cornerChooser==4) {
      position[0]=2;
      position[1]=1;
    }
    board[position[0]][position[1]]="c";

    return true;
  }
}
