import 'package:flutter/material.dart';
import 'package:futtbol/blocs/comand/comand_block.dart';
import 'package:futtbol/blocs/timer/timer_bloc.dart';
import 'package:futtbol/locale.dart';
import 'package:futtbol/blocs/pdfCreator.dart';


class Results extends StatelessWidget{

  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(AppLocalization.of(context).resultsBtn),
          
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: (){
                mainer(context);
            },
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Row(
            //mainAxisAlignment: MainAxisAlignment.spaceAround,
            //mainAxisSize: MainAxisSize.max,
            

            children: <Widget>[
              
              Container(
                width: MediaQuery.of(context).size.width/2,
                alignment: Alignment.center,
                padding: EdgeInsets.all(8.0),
                child: Text(cm.c1Name,style: TextStyle(fontSize: 20),overflow: TextOverflow.ellipsis,softWrap: false,)
                ),
                   
               
               Container(
                 width: MediaQuery.of(context).size.width/2,
                 alignment: Alignment.center,
                 padding: EdgeInsets.all(8.0),
                 child: Text(cm.c2Name,style: TextStyle(fontSize: 20),overflow: TextOverflow.ellipsis,softWrap: false,)
                 ),
                 
              
               
              
            ],
          ),
          listBuild(context),
          Row(
            children: <Widget>[
              Container(
                 width: MediaQuery.of(context).size.width/2,
                 alignment: Alignment.center,
                 padding: EdgeInsets.all(8.0),
                 child: Text(cm.g1.toString(),style: TextStyle(fontSize: 20),overflow: TextOverflow.ellipsis,softWrap: false,)
                 ),
                 Container(
                 width: MediaQuery.of(context).size.width/2,
                 alignment: Alignment.center,
                 padding: EdgeInsets.all(8.0),
                 child: Text(cm.g2.toString(),style: TextStyle(fontSize: 20),overflow: TextOverflow.ellipsis,softWrap: false,)
                 ),
            ],
          )
          
        ],
      )
    );
}

listBuild(BuildContext context){
    return new Row(
        children: <Widget>[
          list1(context),
          list2(context)
        ],
      );
  }



list1(BuildContext context){ 
  return new Expanded(
    child: new Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black,width: 1)
      ),
      height: MediaQuery.of(context).size.height-134,
      child: new ListView.builder(
        
       itemCount: cm.c1.length,
       itemBuilder: (context,index)
       {
         return new ListTile(title: Center(
           child:Text("${AppLocalization.of(context).goalForRes} - ${cm.c1[index]} ${AppLocalization.of(context).halfTimeForRes} ${cm.goals[index]}")
         ) );
       }
     ),
    )
  );
}

list2(BuildContext context){ 
  return new Expanded(
    child: new Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black,width: 1)
      ),
      height: MediaQuery.of(context).size.height-134,
      child: new ListView.builder(
       itemCount: cm.c2.length,
       itemBuilder: (context,index)
       {
         return new ListTile(
             
             title: Center(
               //child: Text("Goal - ${cm.c2[index]}")),
                        child:Text("${AppLocalization.of(context).goalForRes} - ${cm.c2[index]} ${AppLocalization.of(context).halfTimeForRes} ${cm.goals1[index]}"),

             )
             ); 
           
           }
      )
     ),
    );
    
}
}

