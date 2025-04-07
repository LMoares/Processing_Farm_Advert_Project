// @author L.M.Nunez 23378441

public class Cloud{
  private float xPos;
  private float yPos;
  private int boundry;
  
  public Cloud(float xPos, float yPos, int boundry){
    this.xPos = xPos;
    this.yPos = yPos;
    this.boundry = boundry;
  }
  
  public void setXPos(float number){
    this.xPos += number;
    
    if(this.xPos > boundry){
     this.xPos = -45; 
    }
  }
  
  public float getXPos(){
   return this.xPos;
  }
  
  public float getYPos(){
    return this.yPos;
  }
  
}

//In-order for each cloud to reset its position as a distinct unit of shapes,
//the solution I came to was treating each Cloud as an object who's X-Axis Position
//could be tracked and reset on a Cloud by Cloud basis.
