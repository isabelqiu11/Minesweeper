import de.bezier.guido.*;
//Declare and initialize constants NUM_ROWS and NUM_COLS = 20
public final static int NUM_ROWS = 20;
public final static int NUM_COLS = 20;
public final static int NUM_MINES = 35;
int numflags = 0;

private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> mines = new ArrayList<MSButton>(); //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    //your code to initialize buttons goes here
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for(int r = 0; r < NUM_ROWS; r ++){
      for(int c = 0; c < NUM_COLS; c++){
        buttons[r][c] = new MSButton(r,c);
      }
    }
    
    
    setMines();
}
public void setMines()
{
  while(mines.size() < NUM_MINES){
    int r = (int)(Math.random()*NUM_ROWS);
    int c = (int)(Math.random()*NUM_COLS);
    if(!mines.contains(buttons[r][c])){
      mines.add(buttons[r][c]);
      System.out.println(r + ", " + c);
    }
  }
}

public void draw ()
{
    background(0);
    if(isWon() == true){
        displayWinningMessage();
        
    }
}
public boolean isWon()
{
  int win = 0;
    for(int r = 0; r<NUM_ROWS;r++){
  for(int c = 0; c < NUM_COLS; c++){
  if(!mines.contains(buttons[r][c]) && buttons[r][c].clicked && numflags == NUM_MINES){
  win = 1;
}else if(mines.size()>0){
  win = -1;
}
}
    }return win==1;
    
    
}
public void displayLosingMessage()
{
  if(isWon() == false){
      
     buttons[16][9].setLabel("E");
     buttons[16][8].setLabel("M");
      buttons[16][7].setLabel("A");
      buttons[16][6].setLabel("G");
       buttons[16][11].setLabel("O");
        buttons[16][12].setLabel("V");
         buttons[16][13].setLabel("E");
      buttons[16][14].setLabel("R");
      for(int r = 0; r<NUM_ROWS;r++){
  for(int c = 0; c < NUM_COLS; c++){
  if(mines.contains(buttons[r][c]) && !buttons[r][c].clicked){
    buttons[r][c].setClick(true);
  }}}
  }
}
public void displayWinningMessage()
{
  if(isWon() == true){
   
buttons[16][9].setLabel("U");
  buttons[16][8].setLabel("O");
   buttons[16][7].setLabel("Y");
   buttons[16][11].setLabel("W");
   buttons[16][12].setLabel("I");
   buttons[16][13].setLabel("N");
  
  }
}
public boolean isValid(int r, int c)
{
    if(r>=0 && r<NUM_ROWS && c>=0 && c<NUM_COLS){
      return true;
    }
    return false;
}
public int countMines(int row, int col)
{
    int numMines = 0;
    for(int r =-1; r <=1; r++){
      for(int c = -1; c <=1 ; c++){
        if(isValid(row+r, col+c) && mines.contains(buttons[row+r][col+c])){
          numMines++;
        }
      }
    }
    return numMines;
}
public class MSButton
{
    private int myRow, myCol;
    private float x,y, width, height;
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
        if(mouseButton == RIGHT){
          flagged = !flagged;
          numflags++;
        }else if(mines.contains(this)){
         displayLosingMessage(); 
        }else if(countMines(myRow,myCol) >0){
         setLabel (countMines(myRow,myCol));
        }else{
          for(int r = -1; r <=1; r++){
          for(int c = -1; c <=1; c++){
    if(isValid(myRow+r,myCol+c) == true && !buttons[myRow+r][myCol+c].clicked){
  buttons[myRow+r][myCol+c].mousePressed();
}
}
}
        }
    }
    public void draw () 
    {    
        if (flagged)
            fill(0);
         else if( clicked && mines.contains(this) ) 
             fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(myLabel,x+width/2,y+height/2);
        
    }
    public void setLabel(String newLabel)
    {
        myLabel = newLabel;
    }
    public void setLabel(int newLabel)
    {
        myLabel = ""+ newLabel;
    }
    public void setClick(boolean click){
       clicked = click;
    }
    
    public boolean isFlagged()
    {
        return flagged;
    }
}
