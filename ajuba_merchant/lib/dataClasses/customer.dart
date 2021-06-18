/// CustID : 7
/// name : "Parveen Kumari"
/// registrationToken : "f0GzLVgMTz25-CIzoFJT7k:APA91bFVa_V05zMucSq1d9iNU1iGJzjQVzkuNIzdyUnfXoUFTyXPSWAyR3eBZNRHEQn9kzJN4_6nUy3eWLMqWPa0zI08Fs8wK36aqCqcQf-UxnWenXMbMVeZJyykxFFxyJVedm0NZltF"
/// phone : "9465844510"
/// successCount : 0
/// successPrice : 0
/// failureCount : 0
/// failurePrice : 0

class Customer {
  int? CustID;
  String? name;
  String? registrationToken;
  String? phone;
  int? successCount;
  int? successPrice;
  int? failureCount;
  int? failurePrice;

  static Customer? fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    Customer customerBean = Customer();
    customerBean.CustID = map['CustID'];
    customerBean.name = map['name'];
    customerBean.registrationToken = map['registrationToken'];
    customerBean.phone = map['phone'];
    customerBean.successCount = map['successCount'];
    customerBean.successPrice = map['successPrice'];
    customerBean.failureCount = map['failureCount'];
    customerBean.failurePrice = map['failurePrice'];
    return customerBean;
  }

  Map toJson() => {
    "CustID": CustID,
    "name": name,
    "registrationToken": registrationToken,
    "phone": phone,
    "successCount": successCount,
    "successPrice": successPrice,
    "failureCount": failureCount,
    "failurePrice": failurePrice,
  };
}