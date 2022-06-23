import 'package:flutter/material.dart';
import 'package:futtbol/locale.dart';

class HelpDialog extends StatelessWidget{
  TextStyle ts = TextStyle(
    fontSize: 16
  );
  EdgeInsets ei = const EdgeInsets.fromLTRB(10.0,8.0,10.0,8.0);
  Widget build(BuildContext context){
    return new SimpleDialog(
      title: Center(child:Text("Help",style: TextStyle(fontSize: 25),)),
      children: <Widget>[
        Padding(
              padding:  ei,
              child: Text(AppLocalization.of(context).help1,style: ts,),
            ),
            Padding(
              padding:  ei,
              child: Text(AppLocalization.of(context).help2,style: ts,),
            ),
          Padding(
            padding: ei,
            child: Text(AppLocalization.of(context).help3,style: ts,),
          ),
          Padding(
            padding: ei,
            child: Text(AppLocalization.of(context).help4,style: ts,),
          ),
        Padding(
          padding: ei,
          child: Text(AppLocalization.of(context).help5,style: ts,),
        ),
        Padding(
          padding: ei,
          child: Text(AppLocalization.of(context).help6,style: ts,),
        ),
        
        
      
      ],
    );
  }
}