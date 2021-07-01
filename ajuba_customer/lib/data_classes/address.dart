import 'package:hive/hive.dart';


part 'address.g.dart';

@HiveType(typeId: 0)
class Address extends HiveObject{
  @HiveField(0)
  String homeAddress="";
  @HiveField(1)
  String streetAddress="";
  @HiveField(2)
  double latitude=0.0;
  @HiveField(3)
  double longitude=0.0;

  Address(this.homeAddress, this.streetAddress, this.latitude, this.longitude);
}