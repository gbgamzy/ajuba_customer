/// FUID : 1
/// name : "Chhole Bhature (2pcs)"
/// price : 35
/// image : "5b3ad529a5cdd7ca07231701e164eeaa"
/// category : "Breakfast"
/// available : 0

class FoodUnit {
  int? FUID;
  String? name;
  int? price;
  String? image;
  String? category;
  int? available;

  static FoodUnit? fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
		FoodUnit dataClassesBean = FoodUnit();
    dataClassesBean.FUID = map['FUID'];
    dataClassesBean.name = map['name'];
    dataClassesBean.price = map['price'];
    dataClassesBean.image = map['image'];
    dataClassesBean.category = map['category'];
    dataClassesBean.available = map['available'];
    return dataClassesBean;
  }

  Map toJson() => {
    "FUID": FUID,
    "name": name,
    "price": price,
    "image": image,
    "category": category,
    "available": available,
  };
}

