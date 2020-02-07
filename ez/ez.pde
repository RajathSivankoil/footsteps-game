import java.awt.Component; //<>//
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JOptionPane;
import javax.swing.JPasswordField;

int p1coin=50, p2coin=50, win = 0, p1out, p2out;
String p1string, p2string;
int sq = 80, dist = 120, x, xAlign=5, yAlign=40;
float opacity=0;
boolean click, play1, play2, done1, done2, restart, op;
void setup() {
  fullScreen();
  //size(1000, 500);
  background(255);
  rectMode(CENTER);
  strokeWeight(4);
  x=width/2;
  textAlign(CENTER, CENTER);
}
void draw() {
  if (!click)  //wait for any button press
  {
    menu();
  } else {
    input();
    step();
    display();
    reset();
    restart();
  }
}
void keyPressed() {  //for menu
  click=true;
}
void step() {  //moving the token
  if (p1out>p2out) {
    x-=dist;
    win--;  //winning value towards p1
  }
  if (p1out<p2out) {
    x+=dist;
    win++;  //winning value towards p2
  }
}
void display() {
  restart=false;
  background(255);
  rect(width/2, height/2, sq, sq);  //center
  
  rect(width/2+dist, height/2, sq, sq);  //player 2's squares
  rect(width/2+2*dist, height/2, sq, sq);
  
  rect(width/2-dist, height/2, sq, sq);  //player 1's squares
  rect(width/2-2*dist, height/2, sq, sq);
  
  stroke(#FF2828);
  rect(width/2+3*dist, height/2, sq, sq);  //p2 home box
  stroke(#2828FF);
  rect(width/2-3*dist, height/2, sq, sq);  //p1 home box
  fill(0, 255, 0);
  noStroke();
  rect(x, height/2, sq*2/3, sq*2/3);  //token
  stroke(0);
  fill(0);  //to tell the players who's home box is who's
  text("P2", width/2+3*dist, height/2-sq);
  text("P1", width/2-3*dist, height/2-sq);
  fill(255);
}
void input() {
  while (done1==false) {  //player one's input,looped in case of user error
    try {
      p1string= JOptionPane.showInputDialog("Player ONE: How many coins? You have " + p1coin + " coins left.");
      p1out=int(p1string);  //cast from string to int
      if (p1out<=p1coin&&p1out>=0)  //to make sure user can take out that many coins
        done1=true;  //end loop
      else 
      JOptionPane.showMessageDialog(frame, 
        "valid numbers please, player one");
    }
    catch(NullPointerException npe) {  //if nothing
      JOptionPane.showMessageDialog(frame, 
        "not a number, player one");
    }
    catch(NumberFormatException nfe) {  //if not a number
      JOptionPane.showMessageDialog(frame, 
        "not a number, player one");
    }
  }
  while (done2==false) {  //player two's input,looped in case of user error
    try {
      p2string= JOptionPane.showInputDialog("Player TWO: How many coins?  You have " + p2coin + " coins left.");
      p2out=int(p2string);  //cast from string to int
      if (p2out<=p2coin&&p2out>=0)  //to make sure user can take out that many coins
        done2=true;  //end loop
      else 
      JOptionPane.showMessageDialog(frame, 
        "valid numbers please, player two");
    }
    catch(NullPointerException npe) {  //if nothing
      JOptionPane.showMessageDialog(frame, 
        "not a number, player one");
    }
    catch(NumberFormatException nfe) {  //if not a number
      JOptionPane.showMessageDialog(frame, 
        "not a number, player one");
    }
  }  //taking coins from bank
  p1coin-=p1out;
  p2coin-=p2out;
}
void reset() {  
  p1out=0;  //resetting values to make sure that comparison doesn't happen with old vals
  p2out=0;
  if (abs(win)<3 && !(p1coin==0&&p2coin==0)) {    //checking win conditions
    done1=false;  //asking for more input from user, more turns needed to win
    done2=false;
  } else if (win==3) {  //player 2 wins by home box
    p2win();
  } else if (win==-3) {  //player 1 wins by home box
    p1win();
  } else if (p1coin==0&&p2coin==0) {  //no coins left
    done1=true;
    done2=true;
    if (win==0) {  //draw state
      loss();
    } else if (win>0) {  //closer to p2
      p2win();
    } else if (win<0) {  //closer to p1
      p1win();
    }
  }
}
void p1win() {  //if player one wins
  textSize(40);
  background(255);
  fill(0);
  text("Player One WINS", width/2, 200);
  textSize(20);
  text("Player One had "+ p1coin + " coins left", width/2, height/2);  
  text("Player Two had "+ p2coin + " coins left", width/2, height/2+yAlign);
  restart=true;
}
void p2win() {  //if player two wins
  textSize(40);
  background(255);
  fill(0);
  text("Player Two WINS", width/2, 200);
  textSize(20);
  text("Player One had "+ p1coin + " coins left", width/2, height/2); 
  text("Player Two had "+ p2coin + " coins left", width/2, height/2+yAlign);
  restart=true;
}
void loss() {  //in case of a draw
  textSize(100);
  background(255);
  fill(0);
  text("DRAW", width/2, height/2);  
  restart=true;
}
void restart() {
  if (restart) {  //after end of game
    if (key=='r') {  //resetting all of the old values changed by game
      p1coin=50;  
      p2coin=50;
      p2out=0;
      p1out=0;
      done1=false;
      done2=done1;
      x=width/2;
      win=0;
    }
  }
}
void menu() {
  background(255);
  fill(0);
  textSize(40);
  text("WELCOME TO FOOTSTEPS", width/2, 50 );
  fill(opacity);  //changing opacity of text
  opacity();
  text("Press any key to continue...", width/2, height-yAlign);
  fill(0);
  textSize(20);
  textAlign(LEFT, CENTER);
  text("How to Play: The goal of footsteps is to move the token to your home box on your side of the board.", xAlign, 100);  //Game Explanation
  text("Each Player bets an amount of coins from their pool of 50 coins in order to move their pieces. ", xAlign, 100+yAlign);
  text("The player that bets higher wins that turn and moves the piece towards them", xAlign, 100+2*yAlign);
  text("If both players run out of coins, then the player that was closer to their home box wins", xAlign, 100+3*yAlign);
  text("If only one runs out, then the other player can make as many moves as coins that they have left", xAlign, 100+4*yAlign);  
  textAlign(CENTER, CENTER);
  fill(255);
}
void opacity() {  //to make sure user knows where to go
  if (op==true) {  //setting the opacity to up or down
    opacity+=3;
  } else {
    opacity-=3;
  }
  if (opacity>=255) {  //hitting upper and lower bounds of greyscale
    op=false;
  } else if (opacity<=0)
    op=true;
}
