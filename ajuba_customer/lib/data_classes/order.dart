/// OID : 41
/// name : "Manish"
/// phone : "7508843100"
/// houseName : "Green Avenue colony"
/// streetAddress : "St no 3c"
/// latitude : 30.4815
/// longitude : 74.5292
/// contents : "Chhole Bhature (2pcs) x 2"
/// price : 90
/// date : "04 06 2021 07.35"
/// deliveryBoy : "8360468300"
/// status : "C"
class Order {

  int? OID;
  String? name;
  String? phone;
  String? houseName;
  String? streetAddress;
  double? latitude;
  double? longitude;
  String? contents;
  int? price;
  String? date;
  String? deliveryBoy;
  String? status;

  Order();

  Order.constructorSet(
      this.OID,
      this.name,
      this.phone,
      this.houseName,
      this.streetAddress,
      this.latitude,
      this.longitude,
      this.contents,
      this.price,
      this.date,
      this.deliveryBoy,
      this.status);

  static Order? fromMap(Map<String, dynamic>? map) {
    if (map == null) return null;
    Order ordersBean = Order();
    ordersBean.OID = map['OID'];
    ordersBean.name = map['name'];
    ordersBean.phone = map['phone'];
    ordersBean.houseName = map['houseName'];
    ordersBean.streetAddress = map['streetAddress'];
    ordersBean.latitude = map['latitude'];
    ordersBean.longitude = map['longitude'];
    ordersBean.contents = map['contents'];
    ordersBean.price = map['price'];
    ordersBean.date = map['date'];
    ordersBean.deliveryBoy = map['deliveryBoy'];
    ordersBean.status = map['status'];
    return ordersBean;
  }

  Map toJson() => {
    "OID": OID,
    "name": name,
    "phone": phone,
    "houseName": houseName,
    "streetAddress": streetAddress,
    "latitude": latitude,
    "longitude": longitude,
    "contents": contents,
    "price": price,
    "date": date,
    "deliveryBoy": deliveryBoy,
    "status": status,
  };
}