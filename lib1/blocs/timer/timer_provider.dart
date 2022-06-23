
class TimerProvider {
  int min = 0;
  int sec = 0;
  int minTmp = 0;
  int secTmp = 0;
  bool isActive = false;
  int halfTime = 1;
  int halfTimeTmp = 1;
  int togoal = 0;
 
  void addMin() => min<99?min++:null;
  void revMin() => min>0?min--:null;
  void addSec() {
    if(sec>=59)
          {sec = 0; addMin();} 
          else sec++;
          }
  void revSec() { 
    if(sec<=0 && min>0){
      sec=59;
      revMin();
    }else if(sec>0){sec--;}
    }
  void changeIsActive() => isActive?isActive=false:isActive=true;
  void addHalf()=>halfTime++;
  void revHalf()=>halfTime--;
  void addToGoal()=> togoal++;
  void revToGoal()=> togoal--;
  void reset(){
      min = 0;
      sec = 0;
      minTmp = 0;
      secTmp = 0;
      halfTimeTmp = 1;
      isActive = false;
      halfTime = 1;
      togoal = 0;
      
  } 
}