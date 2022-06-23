import 'package:flutter/material.dart';

class WinDialog extends StatelessWidget {
  final String winTeam;
 WinDialog({this.winTeam});

  Widget build(BuildContext context){
    return SimpleDialog(
      contentPadding: EdgeInsets.fromLTRB(0, 12, 0, 12),
      title: Center(child:Text("Win",textScaleFactor: 2,)),
      children: <Widget>[
        Center(child:Text(winTeam,textScaleFactor: 4,))
      ],
    );
  }
}