import 'package:flutter/material.dart';
import 'package:futtbol/screens/home.dart';
import 'package:futtbol/blocs/timer/timer.dart';
import 'package:flutter/services.dart';
import 'package:futtbol/screens/results.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:futtbol/blocs/main_block.dart';
import 'locale.dart';

void main() { 
  SystemChrome.setEnabledSystemUIOverlays([]);
  runApp(MyApp());}

class MyApp extends StatelessWidget {
  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    //mb.init();
    return StateBuilder(
      stateID: "main",
      blocs: [mb],
      builder: (_){
        return MaterialApp(
      supportedLocales: [
        const Locale('en','US'), //English
        const Locale('ru','RUS')
        //const Locale('ua','UKR')
      ],
      localizationsDelegates: [
        AppLocalizationDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      onGenerateTitle: (BuildContext context)=>AppLocalization.of(context).title,
      theme: ThemeData.dark(),
      locale: mb.loc,
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/first':(context) => Container(child:TimerWidget()),
        '/results':(context) => Results()
      },
    );
      },
    );
    
  }
}
