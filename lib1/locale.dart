import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'l10n/messages_all.dart';

class AppLocalization{

  static Future<AppLocalization> load(Locale locale){
    final String name =locale.countryCode == null ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((bool _){
      Intl.defaultLocale = localeName;
      return new AppLocalization();
    });
  }

  static AppLocalization of(BuildContext context){
    return Localizations.of<AppLocalization>(context,AppLocalization);
  }

  String get title{
    return Intl.message("Football timer",name:'title',desc: 'App title');
  }

   String get timerText{
    return Intl.message("TIMER", name:'timerText');
  }

    String get resultsBtn{
      return Intl.message("Results",name:"resultsBtn");
    }
     String get halfTime{
      return Intl.message("HALF",name:"halfTime");
    }
     String get gameTo{
      return Intl.message("GAME TO",name:"gameTo");
    }
      String get timerReseted{
        return Intl.message("Timer has been reset!",name:"timerReseted");
      }
      String get ok{
        return Intl.message("OK",name:"ok");
      }
      String get cancel{
        return Intl.message("Cancel",name:"cancel");
      }
      String get cmdName{
        return Intl.message("Command name",name:"cmdName");
      }
      String get oneHalf{
        return Intl.message("Time of one half",name:"oneHalf");
      }
      String get halfTimeForRes{
        return Intl.message("Half",name:"halfTimeForRes");
      }
      String get goalForRes{
        return Intl.message("Goal at",name:"goalForRes");
      }

      String get help1{
        return Intl.message("- To start game you need to set the time.",name:"help1");
      }
      String get help2{
        return Intl.message("- To set the time, half or to goal option, you need to tap on it.",name:"help2");
      }
      String get help3{
        return Intl.message("- To restart all options, you need long press the start button.",name:"help3");
      }
      String get help4{
        return Intl.message("- To change team name, you need tap on it.",name:"help4");
      }
      String get help5{
        return Intl.message("- To set minute or seconds, you need tap on it and change.",name:"help5");
      }
      String get help6{
        return Intl.message("- To show help dialog, you need tap on app name in left corner.",name:"help6");
      }



      

}

class AppLocalizationDelegate extends LocalizationsDelegate<AppLocalization>{
  const AppLocalizationDelegate();

  bool isSupported(Locale locale){
    return ['en','ru'].contains(locale.languageCode);
  }

  Future<AppLocalization> load(Locale locale){
    return AppLocalization.load(locale);
  }

  
  bool shouldReload(LocalizationsDelegate<AppLocalization> old) {
    
    return false;
  }
}