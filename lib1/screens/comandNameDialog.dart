import 'package:flutter/material.dart';
import 'package:futtbol/blocs/comand/comand_block.dart';
import '../locale.dart';

class ComandNameDialog extends StatelessWidget{

  ComandNameDialog({Key key,this.name,this.com}):super(key:key);

  final String name;
  String _name = "";
  final int com;
  
  @override
  Widget build(BuildContext context){
    return new SimpleDialog(
      title: Center(child:Text(AppLocalization.of(context).cmdName)),
      contentPadding: EdgeInsets.fromLTRB(20, 5, 20, 10),
      children: <Widget>[
        TextField(
          onChanged: (e){
            if(e!="" && e!=null){
              _name = e;
            }
            
          },
          decoration: new InputDecoration(
            hintText: name
          ),
          maxLength: 10,
          keyboardType: TextInputType.text,
          
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            FlatButton(
          child: Text(AppLocalization.of(context).ok),
          onPressed: (){
            if(_name!=null && _name!="" && _name.length>1){
              cm.changeCName(com, _name);
            }
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: Text(AppLocalization.of(context).cancel),
          onPressed: (){
            Navigator.of(context).pop();
          },
        )
          ],
        )
        
      ],
    );
  }
}