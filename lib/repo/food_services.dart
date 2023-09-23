import 'package:firebase_database/firebase_database.dart';
import '../models/FoodMenu.dart';
import '../util/DatabaseRef.dart';

class FoodMenuRepo {

  setMenuList(){
    var fConst = FirebaseConstants();
    var ref = FirebaseDatabase.instance.ref().child(fConst.FOOD_MENU_PATH);
    List<FoodMenu> list = [];
    ref.get().then((value) {
      if (value.exists) {
        for (DataSnapshot snap in value.children) {
          var data = FoodMenu.getMap(
              Map<String, dynamic>.from(snap.value as Map<dynamic, dynamic>));
          list.add(data);
        }
      }
    });
  }
}