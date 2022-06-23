import "package:states_rebuilder/states_rebuilder.dart";
import 'package:flutter/material.dart';


class MainBlock extends StatesRebuilder{

Locale loc = new Locale('en');

Image im = Image.asset("assets/images/flags/en.png");//loc.languageCode == "ru" ? Image.asset("assets/images/flags/en.png"):Image.asset("assets/images/flags/ru.png");

/*init(){
  loc = Locale.cachedLocale;
  //print(loc.languageCode);
  im = loc.languageCode == "ru" ? Image.asset("assets/images/flags/en.png"):Image.asset("assets/images/flags/ru.png");
}*/

changeLocal(){
  if(loc == Locale('en')){
    loc = Locale('ru');
    im = Image.asset("assets/images/flags/en.png");
  }else{
    loc =Locale('en');
    im = Image.asset("assets/images/flags/ru.png");
  }
  rebuildStates(ids: ["main"]);
}

}

MainBlock mb = new MainBlock();