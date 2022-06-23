import 'dart:io';
import 'package:pdf/pdf.dart';
//import 'package:flutter/material.dart' show ListView;
import 'package:pdf/widgets.dart';
import 'package:flutter/material.dart' as mat;
import 'package:path_provider/path_provider.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:futtbol/blocs/comand/comand_block.dart';
import 'package:futtbol/blocs/timer/timer_bloc.dart';
import 'package:futtbol/locale.dart';



void mainer(ctx) async{
  
final Document pdf = Document();
final dir = await getTemporaryDirectory();
final String path = '${dir.path}/res.pdf';
print(path);

pdf.addPage(
  Page(
    pageFormat: PdfPageFormat.a4,
    build: (context){
      return Center(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text("Results ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}")),
                
                ]
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.max,
              children: [
              Text(cm.c1Name),
              Text(cm.g1.toString()),
              Text("-"),
              Text(cm.g2.toString()),
              Text(cm.c2Name),

               
              ]
            ),),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  child: ListView( children:List.generate(cm.c1.length, (s){ return Text("${AppLocalization.of(ctx).goalForRes} - ${cm.c1[s]} ${AppLocalization.of(ctx).halfTimeForRes} ${cm.goals[s]}");}),),
                  
                ),
                
                Container(
                  child: ListView(
                  children: List.generate(cm.c2.length, (s){ return Text("${AppLocalization.of(ctx).goalForRes} - ${cm.c2[s]} ${AppLocalization.of(ctx).halfTimeForRes} ${cm.goals1[s]}");})
                ),
                  
                ),
                
              ]
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(tm.winTeam+" WIN!",style: TextStyle(fontSize: 20)),
              ]
            )
            
            
          ]
        )
      );
    }
  )
);



  print(path);
  final File file = File(path);
   await file.writeAsBytes(pdf.save());
   
   await Share.file("Results", "res.pdf", file.readAsBytesSync(), '*/*');


}