/// FMID : 8
/// category : "Bread rolls"

class FoodMenu {
  int? FMID;
  String? category;

  static FoodMenu? fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    FoodMenu foodMenuBean = FoodMenu();
    foodMenuBean.FMID = map['FMID'];
    foodMenuBean.category = map['category'];
    return foodMenuBean;
  }

  Map toJson() => {
    "FMID": FMID,
    "category": category,
  };
}