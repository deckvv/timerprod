import 'package:flutter/material.dart';
import 'package:futtbol/blocs/timer/timer_bloc.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:futtbol/locale.dart';
import 'dart:async';

class TimerWidget extends StatelessWidget{

  Timer btnAddTm,btnRevTm;
  
  @override
  Widget build(BuildContext context){
    return AlertDialog(
      //backgroundColor: Colors.white,
      title: Text(AppLocalization.of(context).oneHalf,textAlign: TextAlign.center,style: TextStyle(fontSize: 30),),
      contentPadding: EdgeInsets.fromLTRB(10, 5, 10, 5),
      titlePadding: EdgeInsets.fromLTRB(10, 20, 10, 10),
      content: timer(),
      actions: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
          child:   Row(
            //crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(0,0,10,0),
              child: RaisedButton(
          textColor: Colors.black,
          child: new Text(AppLocalization.of(context).ok),
          onPressed: () {tm.saveTime(tm.timerState); tm.setTime(); Navigator.of(context).pop();},
        ),
            ),
        
        RaisedButton(
          textColor: Colors.black,
          child: new Text(AppLocalization.of(context).cancel),
          onPressed: () {Navigator.of(context).pop();},
        ),
          ],
        )  
        )
      
      ],
    );
  }

  Widget timeSPan(int data,bool b){
    return new Padding(
      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
      child: Text("${data.toString().padLeft(2,'0')}",style: TextStyle(fontSize: 50,color: b?Colors.pink:Colors.white))
    );
    
  }

  Widget addBtn(){
    return new GestureDetector(
      child: FloatingActionButton(child:Icon(Icons.add),onPressed: tm.addMin),
      onTapDown: (td){ btnAddTm = Timer.periodic(Duration(milliseconds: 60), (btnAddTM) => tm.addMin() );},
      onTapUp: (td){ if(btnAddTm.isActive)btnAddTm.cancel();},
      onTapCancel: (){btnAddTm.cancel();},
    );
    
  }

  Widget revBtn(){
     return new GestureDetector(
      child: FloatingActionButton(child: Icon(Icons.remove), onPressed: tm.revMin,),
      onTapDown: (td){ btnRevTm = Timer.periodic(Duration(milliseconds: 60), (btnAddTM) => tm.revMin() );},
      onTapUp: (td){ btnAddTm.cancel();},
      onTapCancel: (){btnRevTm.cancel();},
    );
  }

  Widget timer(){
    return new Row(
          //mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
           
           Expanded(
             
             child: Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               mainAxisSize: MainAxisSize.min,
               children: <Widget>[
                revBtn(),
                shedule(),
                addBtn()
               ],
             )
           ),
            
            
            
            //addBtn()
          ]
          );
  }

   Widget shedule(){
   return StateBuilder(
              stateID: "shedule",
              blocs: [tm],
              builder: (State st){
                return new Row(
              children: <Widget>[
              GestureDetector(
                child: timeSPan(tm.tp.min, tm.tp.isActive),
                onTap: tm.changeIsActive,
              ),
              Text(":",style: TextStyle(fontSize: 50)),
              GestureDetector(
                child: timeSPan(tm.tp.sec, !tm.tp.isActive),
                onTap: tm.changeIsActive,
              ),
            ],
            );
              },
            );
 }


}