
import "package:states_rebuilder/states_rebuilder.dart";
import "dart:core";


class ComandBlock extends StatesRebuilder{
  List<String> c1 = [];
  List<String> c2 = [];
  List<int> goals =[];
  List<int> goals1 =[];
  String c1Name = "Team 1", c2Name="Team 2";
  int g1 = 0,g2 = 0;


  addGoal(String stateId){
    if(stateId=="Goal1"){
    g1++;
    }
    else{
    g2++;
    }
    rebuildStates(ids: [stateId]);
  }

  addTimeSpan(String stateId,String timeSpan, int half){
    if(stateId=="Goal1"){
      c1.add(timeSpan);
      goals.add(half);
    }else{
      c2.add(timeSpan);
      goals1.add(half);
    }
  }

  changeCName(int i,String name){
    i==1?c1Name=name:c2Name=name;
    rebuildStates(ids: ["CommandN$i"]);
  }

  resetAll(){
    c1.clear();
    c2.clear();
    goals.clear();
    goals1.clear();
    g1 = 0;
    g2 = 0;
    rebuildStates(ids: ["Goal1","Goal2"]);
  }

  
}

ComandBlock cm =ComandBlock();