import 'food_unit.dart';

/// FMID : 8
/// category : "Bread rolls"
class FoodMenu {
  int? FMID;
  String? category;
  List<FoodUnit?> list=List.empty(growable: true);


  static FoodMenu? fromMap(Map<String, dynamic> map) {

    FoodMenu foodMenuBean = FoodMenu();
    foodMenuBean.FMID = map['FMID'];
    foodMenuBean.category = map['category'];
    foodMenuBean.list = map['list'];
    return foodMenuBean;
  }

  Map toJson() => {
    "FMID": FMID,
    "category": category,
    "list":list
  };
}