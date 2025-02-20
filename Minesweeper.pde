import de.bezier.guido.*;
//Declare and initialize constants NUM_ROWS and NUM_COLS = 20
public final static int NUM_ROWS =17;
public final static int NUM_COLS = 17;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> mines; //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
  mines = new ArrayList <MSButton>();
  size(400, 400);
  textAlign(CENTER, CENTER);

  // make the manager
  Interactive.make( this );

  //your code to initialize buttons goes here

  buttons = new MSButton [NUM_ROWS] [NUM_COLS];
  for (int r=0; r<NUM_ROWS; r++) {
    for (int c=0; c<NUM_COLS; c++) {
      buttons[r][c] = new MSButton(r, c);
    }
  }
  for (int i=0; i<20; i++) {
    setMines();
  }
}
public void setMines()
{
  {
    int rowsss = (int)(Math.random()*NUM_ROWS);
    int colsss = (int)(Math.random()*NUM_COLS);
    if (!mines.contains(buttons[rowsss][colsss]))
      mines.add(buttons[rowsss][colsss]);
    else
      setMines();
  }
}



public void draw ()
{
  background( 0 );
  if (isWon() == true)
    displayWinningMessage();
}
public boolean isWon()
{
    for(int i=0; i<NUM_ROWS; i++) {
    for(int j =0; j<NUM_COLS; j++) {
      if(!buttons[i][j].clicked == true && !mines.contains(buttons[i][j]))    
        return false;  
    }
  }
  return true;
}
public void displayLosingMessage()
{
  for (int i=0; i<7; i++) {
    buttons[i][10].myLabel = "Lo";
    buttons[i][11].myLabel = "ser";
    buttons[i][12].myLabel = "Ha";
    buttons[i][13].myLabel = "Ha!";
   
  }
  for(int i=0; i<NUM_ROWS; i++) {
    for(int j=0; j<NUM_COLS; j++) {
      if(mines.contains(buttons[i][j]))
        buttons[i][j].clicked = true;
      
}
  }
}
public void displayWinningMessage()
{
  for (int i=0; i<7; i++) {
    buttons[i][1].myLabel = "Win";
    buttons[i][11].myLabel = "YAY";
  }
}
public boolean isValid(int r, int c)
{
  return r>=0 && r<buttons.length&& c>=0 && c<buttons[r].length;
}
public int countMines(int row, int col)
{
  int numMines = 0;
  for (int r = row -1; r<=row+1; r++ ) {
    for (int c = col - 1; c<=col+1; c++) {
      if (isValid(r, c) && mines.contains(buttons[r][c]))
        numMines++;
    }
  }
  return numMines;
}
public class MSButton
{
  private int myRow, myCol;
  private float x, y, width, height;
  private boolean clicked, flagged;
  private String myLabel;

  public MSButton ( int row, int col )
  {
    width = 400/NUM_COLS;
    height = 400/NUM_ROWS;
    myRow = row;
    myCol = col;
    x = myCol*width;
    y = myRow*height;
    myLabel = "";
    flagged = clicked = false;
    Interactive.add( this ); // register it with the manager
  }

  // called by manager
  public void mousePressed ()
  {
    clicked = true;
    if (mouseButton == RIGHT) {
      if (flagged) {
        flagged = false;
        clicked = false;
      } else if (flagged == false) {
        flagged = true;
      }
    } else if (mines.contains(this))
      displayLosingMessage();
    else if (countMines(myRow, myCol) > 0)
      myLabel = "" + countMines(myRow, myCol);
    else
      for (int i=myRow-1; i<=myRow+1; i++) {
        for (int j=myCol-1; j<=myCol+1; j++) {
          if (isValid(i, j))
            if (buttons[i][j].clicked == false)
              buttons[i][j].mousePressed();
        }
      }
  }


  public void draw ()
  {
    if (flagged)
      fill(0);
    else if ( clicked && mines.contains(this) )
      fill(255, 0, 0);
    else if (clicked)
      fill( 200 );
    else
      fill( 100 );
    rect(x, y, width, height);
    fill(0);
    text(myLabel, x+width/2, y+height/2);
  }
  public void setLabel(String newLabel)
  {
    myLabel = newLabel;
  }
  public void setLabel(int newLabel)
  {
    myLabel = ""+ newLabel;
  }
  public boolean isFlagged()
  {
    return flagged;
  }
}
