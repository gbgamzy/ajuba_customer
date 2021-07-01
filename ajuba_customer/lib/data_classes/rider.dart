/// DbID : 13
/// name : "Rahul"
/// registrationToken : "dEGxO8adTFixkXYPWLG6jo:APA91bHDFcuoWAbIqhwhfw1ra18cDKQQ3SbB07xLRyPWbYKPcXFbKCvrVie9PXSLxqr2bhGh94NNRGNNxbpO2qw1C_US9vXcyIWJiNQiM7Kcnh_dIlJNqcmCkk1rHSkcbnSISFiceBY5"
/// phone : "8360468300"
/// latitude : 30.4779
/// longitude : 74.5201
class Rider {
  int? DbID;
  String? deliveryBoyName;
  String? registrationToken;
  String? deliveryBoyPhone;
  double latitude=0;
  double longitude=0;

  static Rider fromMap(Map<String, dynamic> map) {

    Rider deliveryBoyBean = Rider();
    deliveryBoyBean.DbID = map['DbID'];
    deliveryBoyBean.deliveryBoyName = map['deliveryBoyName'];
    deliveryBoyBean.registrationToken = map['registrationToken'];
    deliveryBoyBean.deliveryBoyPhone = map['deliveryBoyPhone'];
    deliveryBoyBean.latitude = map['latitude'];
    deliveryBoyBean.longitude = map['longitude'];
    return deliveryBoyBean;
  }

  Map toJson() => {
    "DbID": DbID,
    "deliveryBoyName": deliveryBoyName,
    "registrationToken": registrationToken,
    "deliveryBoyPhone": deliveryBoyPhone,
    "latitude": latitude,
    "longitude": longitude,
  };
}