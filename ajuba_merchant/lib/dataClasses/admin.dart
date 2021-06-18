/// ADMINID : 0
/// registrationToken : "eEqcM55kSNGgzLVE4kMvci:APA91bHgvQlTDjjbYNz0caqqT5aCGv1oj2unPok1_Gy8zyYR34Z5ssuCi8YhKBOwymyHY8Y0313bsOQ8gTZp1UikNNx-Pt_fra-LxmOR--3XS5hcln0SHMMnia3hZKqwqCqjf5mV26hj"
/// phone : "7508843100"
/// latitude : 30.4769
/// longitude : 74.5159
/// dist1 : 1
/// dist2 : 4
/// dist3 : 6
/// price1 : 20
/// price2 : 20
/// price3 : 30
/// minimumDistance : 50
/// minimumPrice : 40

class Admin {
  int? ADMINID;
  String? registrationToken;
  String? phone;
  double? latitude;
  double? longitude;
  int? dist1;
  int? dist2;
  int? dist3;
  int? price1;
  int? price2;
  int? price3;
  int? minimumDistance;
  int? minimumPrice;

  static Admin? fromMap(Map<String, dynamic>? map) {
    if (map == null) return null;
    Admin adminBean = Admin();
    adminBean.ADMINID = map['ADMINID'];
    adminBean.registrationToken = map['registrationToken'];
    adminBean.phone = map['phone'];
    adminBean.latitude = map['latitude'];
    adminBean.longitude = map['longitude'];
    adminBean.dist1 = map['dist1'];
    adminBean.dist2 = map['dist2'];
    adminBean.dist3 = map['dist3'];
    adminBean.price1 = map['price1'];
    adminBean.price2 = map['price2'];
    adminBean.price3 = map['price3'];
    adminBean.minimumDistance = map['minimumDistance'];
    adminBean.minimumPrice = map['minimumPrice'];
    return adminBean;
  }

  Map toJson() => {
    "ADMINID": ADMINID,
    "registrationToken": registrationToken,
    "phone": phone,
    "latitude": latitude,
    "longitude": longitude,
    "dist1": dist1,
    "dist2": dist2,
    "dist3": dist3,
    "price1": price1,
    "price2": price2,
    "price3": price3,
    "minimumDistance": minimumDistance,
    "minimumPrice": minimumPrice,
  };
}