/// DbID : 13
/// name : "Rahul"
/// registrationToken : "dEGxO8adTFixkXYPWLG6jo:APA91bHDFcuoWAbIqhwhfw1ra18cDKQQ3SbB07xLRyPWbYKPcXFbKCvrVie9PXSLxqr2bhGh94NNRGNNxbpO2qw1C_US9vXcyIWJiNQiM7Kcnh_dIlJNqcmCkk1rHSkcbnSISFiceBY5"
/// phone : "8360468300"
/// latitude : 30.4779
/// longitude : 74.5201

class DeliveryBoy {
  int? DbID;
  String? name;
  String? registrationToken;
  String? phone;
  double? latitude;
  double? longitude;

  static DeliveryBoy? fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    DeliveryBoy deliveryBoyBean = DeliveryBoy();
    deliveryBoyBean.DbID = map['DbID'];
    deliveryBoyBean.name = map['name'];
    deliveryBoyBean.registrationToken = map['registrationToken'];
    deliveryBoyBean.phone = map['phone'];
    deliveryBoyBean.latitude = map['latitude'];
    deliveryBoyBean.longitude = map['longitude'];
    return deliveryBoyBean;
  }

  Map toJson() => {
    "DbID": DbID,
    "name": name,
    "registrationToken": registrationToken,
    "phone": phone,
    "latitude": latitude,
    "longitude": longitude,
  };
}