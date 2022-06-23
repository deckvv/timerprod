import "package:futtbol/blocs/timer/timer_provider.dart";
import "package:states_rebuilder/states_rebuilder.dart";
import "package:futtbol/blocs/comand/comand_block.dart";
import 'package:futtbol/screens/winDialog.dart';
import "package:flutter/material.dart";
import "dart:async";
import 'package:vibration/vibration.dart';
import '../../locale.dart';

class TimerBlock extends StatesRebuilder{

  TimerProvider tp = new TimerProvider();
  final GlobalKey<ScaffoldState> scafoldKey = new GlobalKey<ScaffoldState>();
 

  Timer t; //,t1;
  State timerState;
  State halfState;
  bool isTimerActive = false;
  bool v1 = false;
  bool v2 = false;
  bool pauseStart = false;
  double w1 = 80;
  double w2 = 110;
  double opac = 0.0;
  String winTeam = "";
  
/*
  int pauseSec = 0;
  int pauseMin = 0;
*/
  String get timeSpan{
    return "${tp.minTmp.toString().padLeft(2,"0")}:${tp.secTmp.toString().padLeft(2,"0")}";
  }

  scafold(String message,int t){
    
  scafoldKey.currentState.showSnackBar(new SnackBar(
                         content: Text(message),duration: Duration(milliseconds: t),
                       ));
 }

  startBtn(){
    if((tp.secTmp>0 && tp.minTmp>=0) || (tp.minTmp>0 && tp.secTmp>=0)) {
                   if(!tm.isTimerActive){
                     if(tm.v1) tm.changeWidth1();
                     if(tm.v2) tm.changeWidth2();
                      if(tp.halfTime>tp.halfTimeTmp){
                        tp.halfTimeTmp = tp.halfTime;
                      }
                    tm.changeIsTime();
                    tm.startTime();
                   } else {
                     tm.stopTime();
                   }
                  }else{
                    Vibration.vibrate(duration: 100);
                    tm.scafold("First, set time!",200);
                  }
  }

   changeWidth1(){
    if(v1){
     v1 = false; 
     w1-=50;
    } else{
      v1 = true;
      w1+=50;
    }
    rebuildStates(ids: ["HalfTime"]);
  }

  changeWidth2(){
    if(v2){
     v2 = false; 
     w2-=50;
    } else{
      v2 = true;
      w2+=50;
    }
    rebuildStates(ids: ["GoalTime"]);
  }

  addMin(){
    tp.isActive?tp.addMin():tp.addSec();
    rebuildStates(ids:["shedule"]);
  }

  revMin(){
    tp.isActive?tp.revMin():tp.revSec();
    rebuildStates(ids:["shedule"]);
  }

  changeIsActive(){
    tp.changeIsActive();
    rebuildStates(ids:["shedule"]);
  }

  timerTapedState(State state){
    timerState = state;
    tp.min = tp.minTmp;
    tp.sec = tp.secTmp;
  }

  saveTime(State state){
    rebuildStates(states: [state]);
  }

  setTime(){
    tp.minTmp = tp.min;
    tp.secTmp = tp.sec;
    
    
  }

  changeIsTime(){
    isTimerActive?isTimerActive=false:isTimerActive=true;
    rebuildStates(ids:["strBtn"]);
  }

  startTime(){
    t =  Timer.periodic(Duration(seconds: 1), (d){
    tick();
    });
  }

  stopTime(){
    changeIsTime();
    t.cancel();
    /*if(tp.secTmp>0 || tp.minTmp>0){
      opac = 1.0;
      startPause();
      t.cancel();
    }else{
      //opac = 0.0;
     // stopPause();
    }*/
  }
  
  tick(){

    if(tp.secTmp!=0){

      tp.secTmp--;

      if((tp.secTmp==0 && tp.minTmp==0)|| tp.togoal>0 &&(tp.togoal==cm.g1 || tp.togoal==cm.g2)){
      if(tp.halfTime>1){
        tp.revHalf();
        rebuildStates(ids: ["HalfTime"]);
        tp.minTmp = tp.min;
        tp.secTmp = tp.sec;
        stopTime();
      } else{
      stopTime();
      if(cm.c1.length>cm.c2.length){
        //scafold("${cm.c1Name} WIN", 300);
        
        winTeam = cm.c1Name;
      }
      else{
       // scafold("${cm.c2Name} WIN", 300);
        winTeam = cm.c2Name;
      }
      //scafold(, t)
      Vibration.vibrate(duration: 300);
      showDialog(context: scafoldKey.currentContext,builder: (context){
          return WinDialog(winTeam: winTeam,);
        });
      }
      }
    }else if(tp.secTmp==0 && tp.minTmp!=0){
      tp.minTmp--;
      tp.secTmp = 59;
    }
    rebuildStates(ids:["mainShed"]);
    
  }

  addToGoal(){
   
      if(tp.togoal<10) tp.addToGoal();
    
    rebuildStates(ids: ["GoalTime"]);
  }

  revToGoal(){
    if(tp.togoal>=1)tp.revToGoal();
    rebuildStates(ids: ["GoalTime"]);
  }

  addHalf(){
    if(tp.halfTime<10 && tp.halfTimeTmp==1) tp.addHalf();
    rebuildStates(ids: ["HalfTime"]);
  }

  revHalf(){
    if(tp.halfTime>1 && tp.halfTimeTmp==1) {tp.revHalf();
    rebuildStates(ids:["HalfTime"]);}
  }

  resetAll(){
    tp.reset();
    cm.resetAll();
    winTeam = "";
    //stopPause();
   // pauseMin = 0;
    //pauseSec = 0;
    Vibration.vibrate(duration: 500);
    rebuildStates(ids: ["mainShed","HalfTime","GoalTime"]);
  }

}

TimerBlock tm = TimerBlock();
