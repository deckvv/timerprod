import 'package:flutter/material.dart';
import 'package:futtbol/blocs/timer/timer_bloc.dart';
import 'package:futtbol/blocs/timer/timer.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:futtbol/blocs/comand/comand_block.dart';
import 'package:futtbol/blocs/main_block.dart';
import '../locale.dart';
import 'package:futtbol/screens/comandNameDialog.dart';
import 'package:futtbol/screens/helpDialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

/*class HomePage extends StatefulWidget{

  HomePageState createState() => HomePageState();
}*/

class HomePage extends StatelessWidget {
 

  @override
  Widget build(BuildContext context){
      getValue(context);
      //mb.init();
    return Scaffold(
      key: tm.scafoldKey,
      appBar: AppBar(
        title: GestureDetector(
          child: Text(AppLocalization.of(context).title),
          onTap: (){
            showDialog(context: context,
              builder: (context){ return HelpDialog();});
          },
        ), 
        actions: <Widget>[
          InkWell(
            child: mb.im,
            onTap: mb.changeLocal,
          )
        ],
      ),
      bottomNavigationBar: RaisedButton(
        child: Text(AppLocalization.of(context).resultsBtn),
        onPressed: (){
          if(cm.g1>0 || cm.g2>0)
          Navigator.of(context).pushNamed('/results');
        },
      ),
      body: 
          Container(
            padding: EdgeInsets.only(top: 10.0),
            decoration: BoxDecoration(
              image:  new DecorationImage(
                image: AssetImage("assets/images/football-field.jpg"),
                fit: BoxFit.fill,
                
              )
            ),
            child:
     ListView( 
       children: <Widget>[
          Column(
            children: <Widget>[
           Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              timerShedule(context),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
          child: Row(
            //crossAxisCount: 2,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top:10.0),
                child: goalBtn(true, 1, context),
              ),
              Padding(
                padding: const EdgeInsets.only(top:10.0),
                child: goalBtn(false, 2, context),
              )
            ],
          ),
          )
        ],
      ),
      
      ]),
      )
      
      );
    
  }

  Widget timerShedule(BuildContext context){
    return Container(
      width: MediaQuery.of(context).size.width-10,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.all(Radius.circular(15.0))
      ),
      child: Column ( children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          child: Stack(
            //mainAxisAlignment: MainAxisAlignment.spaceAround,
            //mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              //Container(),
              Padding(
                padding: EdgeInsets.only(top: 8.0),
                child:               Align(alignment: Alignment.center, child: Text(AppLocalization.of(context).timerText,style: TextStyle(letterSpacing: 10,color: Colors.white),textScaleFactor: 2,)),
),
              
              
            ],
          ),
        ),
         StateBuilder(
                stateID: "mainShed",
                blocs: [tm],
                builder: (state){
                    return GestureDetector(
                      child: Text("${tm.tp.minTmp.toString().padLeft(2,"0")}:${tm.tp.secTmp.toString().padLeft(02,"0")}",textScaleFactor: 2, style: new TextStyle(fontSize: 80,color: Colors.white),
                    ),
                    onTap: (){
                       tm.timerTapedState(state);
                       showDialog(
                          context: context,
                          builder: (context){
                            return TimerWidget();
                            }
                       );
                       }
              );
                }
           ),
          
           Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             mainAxisSize: MainAxisSize.min,
             children: <Widget>[

               Padding(
                 padding: EdgeInsets.only(right: 10,left: 10),
                 child: HalfBlock(),
               ),

               Padding(
                 padding: EdgeInsets.only(right: 10,left: 5),
                 child: GoalTo()
               ),
               
                Padding(
                 padding: EdgeInsets.only(left: 10),
                 child: startBtn(),
               ),
               
             ],
           )
           
      ],)
    );
    
    
  }

  Widget startBtn(){
    return StateBuilder(
                stateID: "strBtn",
                blocs: [tm],
                builder: (state){
                   return GestureDetector(
                     onLongPress: (){
                       tm.resetAll(); 
                       tm.scafold(AppLocalization.of(tm.scafoldKey.currentContext).timerReseted,1000);
                     },
                     child: IconButton(
                       
                  icon: Icon(tm.isTimerActive ? Icons.pause_circle_filled:Icons.play_circle_filled),
                  iconSize: 90.0,
                  color: tm.isTimerActive ? Colors.pink : Colors.blue,
                  onPressed: (){
                    if(tm.winTeam=="")
                    tm.startBtn();
                  },
                )
                );
                },
              );
  }

  Widget goalBtn(bool g,int i,BuildContext context){
    
    return new Column(
      children: <Widget>[
    
              Padding(
                padding: const EdgeInsets.only(bottom:8.0),
                child: InkWell(
                      child:StateBuilder(
                        stateID: "ComandN$i",
                        blocs: [cm],
                        builder: (_){
                          return Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                              
                            ),
                            child: Text("${g?cm.c1Name:cm.c2Name}",style: TextStyle(color: Colors.black,wordSpacing: 5,fontWeight: FontWeight.w900,fontSize: 20,)),
                          );
                        },
                      ),
                      onTap: () => showDialog(
                        context: context,
                        builder: (context){
                            return ComandNameDialog(name:g?cm.c1Name:cm.c2Name,com:i);
                          
                        }
                      ),
                    ),
              ),

    InkWell(
      child: Container(
      height: 150,
      width: 150,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/ball.png"),
          fit: BoxFit.fill
        )
      ),
      child: Center( child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
          border:Border.all(color: Colors.black,width: 1,),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black,
              offset: Offset(0.0, 7.0),
              blurRadius: 8.0,
              spreadRadius: 3.0
            )
          ],
          color: Colors.white
        ),
              child: StateBuilder(
                stateID: "Goal$i",
                blocs: [cm],
                builder: (_){
                  return Text("${g?cm.g1:cm.g2}",style: TextStyle(color: Colors.blueAccent,fontSize: 40,));
                },
              )
              ) 
      )
      
    ),
    radius: 150,
    onTap: (){
      if(tm.t.isActive){
      //String timeSpan = "${tm.tp.minTmp.toString().padLeft(2,"0")}:${tm.tp.secTmp.toString().padLeft(2,"0")}";
      cm.addGoal("Goal$i");
      cm.addTimeSpan("Goal$i", tm.timeSpan, (tm.tp.halfTimeTmp - tm.tp.halfTime)+1);
      }
    },
    )

    ]
    );

  }

  getValue(BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool val = prefs.getBool('ad')??false;
  //print('1');
  if(!val){
    //print('2');
    prefs.setBool('ad', true);
    return Future.delayed(Duration.zero,()=>{
      showDialog(context:context,builder: (context){ return HelpDialog();})
      
      });
  }
}
}



class GoalTo extends StatelessWidget{

  Widget build(BuildContext context){
    return GestureDetector(
    child: StateBuilder(
    stateID: "GoalTime",
    blocs: [tm],
      builder: (_){
        return AnimatedContainer(
        duration: Duration(seconds: 1),
        curve: Curves.fastOutSlowIn,
        width: tm.w2,
                   decoration: BoxDecoration(
                     border: Border.all(width: 2,color: Colors.white)
                   ),
                   padding: EdgeInsets.all(5),
                   child: Column(
                    children: <Widget>[

                    Text(AppLocalization.of(context).gameTo,style: TextStyle(letterSpacing: 5,color: Colors.white),textScaleFactor: 1,),
                    
                    Stack(
                      children: <Widget>[
                     
                        Visibility(
                        child: Align(alignment: Alignment.centerLeft, child: revBtn(),),
                        replacement: Container(height: 0,),
                        visible: tm.v2,
                        
                      ),
                      

                      Align(alignment: Alignment.center, child: goalGame(),),
                      
                      Visibility(
                        child: Align(alignment: Alignment.centerRight, child: addBtn(),),
                        replacement: Container(height: 0,),
                        visible: tm.v2,
                        
                      ),

                        ],
                      ),         
        ],
      ),
      
                 );
                 }
    ),
               onTap: (){
                 if(!tm.isTimerActive){
               if(tm.v1&&!tm.v2){
                   tm.changeWidth1();
                   tm.changeWidth2();
                 }else{
                   tm.changeWidth2();
                   }
                   }
               },
      );
  }


 addBtn(){
 return IconButton(icon: Icon(Icons.add),onPressed: (){
       tm.addToGoal();
 },); 
 }

goalGame(){
      return Text("${tm.tp.togoal}",style: new TextStyle(fontFamily: "digital-7",fontSize: 60));

}
 revBtn(){
   return IconButton(icon: Icon(Icons.remove), onPressed: (){
     tm.revToGoal();
   },);
   
 }

}

///////////////HalfBlock///////////////////


class HalfBlock extends StatelessWidget{



  Widget build(BuildContext context){
    return GestureDetector(
    child: StateBuilder(
    stateID: "HalfTime",
    blocs: [tm],
    builder: (_){
    return AnimatedContainer(
      duration: Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
      width: tm.w1,
                 decoration: BoxDecoration(
                   border: Border.all(width: 2,color: Colors.white)
                 ),
                 padding: EdgeInsets.all(5),
                 child: Column(
                  children: <Widget>[

                  Text(AppLocalization.of(context).halfTime,style: TextStyle(letterSpacing: 5,color: Colors.white),textScaleFactor: 1,),
                  
                  Stack(
                    //mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //mainAxisSize: MainAxisSize.max,
                    //fit: StackFit.passthrough,
                    //overflow: Overflow.clip,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        
                        child:
                   Visibility(
                    child: revBtn(),
                    replacement: Container(height: 0,),
                    visible: tm.v1,
                    ),
                    ),

                    Align(alignment: Alignment.center, child:goalGame()),

                    Align(
                      alignment: Alignment.centerRight,
                      child: Visibility(
                        child: addBtn(),
                        replacement: Container(height: 0,),
                        visible: tm.v1,
                        
                      ),
                    ),

                    
                      ],
                    ),

                    
                  
      ],
    ),
    
               );
               }
               ),
               onTap: (){
                 if(!tm.isTimerActive){
                 if(tm.v2&&!tm.v1){
                   tm.changeWidth2();
                   tm.changeWidth1();
                 }else{
                   tm.changeWidth1();
                   }
                 }
                 
              },
      );
  }


 addBtn(){
 return IconButton(icon: Icon(Icons.add),onPressed: (){
       tm.addHalf();
 },); 
 }

goalGame(){
   
      return Text("${tm.tp.halfTime}",style: new TextStyle(fontFamily: "digital-7",fontSize: 60));

}
 revBtn(){
   return IconButton(icon: Icon(Icons.remove), onPressed: (){
     tm.revHalf();
   },);
   
 }

}



/*
class HelpDialogWrapper extends StatefulWidget{
  final Function onInit;
  final Widget child;
  const HelpDialogWrapper({@required this.onInit,@required this.child});
  _HelpDialogWrapperState createState() => _HelpDialogWrapperState();
}

class _HelpDialogWrapperState extends State<HelpDialogWrapper>{
  
  void initState() async{
    if(widget.onInit != null){
      widget.onInit;
    }
    
     
    
    super.initState();
  }

  Widget build(BuildContext context){
    return widget.child;
  }

}*/


