import 'gift.dart';

class CustomGift
{
  late Gift gift;
  late String userId;
  late String userName;
  late String userEmail;
  late String address;
  late String city;
  late String status;
  String? docId;
  double? totalPrice;
  int? quantity;
  CustomGift({required this.gift ,required this.userId,  required this.userEmail , required this.userName , required this.city , required this.address , required this.status});

  CustomGift.fromJson(Map<String,dynamic> map)
  {
    if(map==null)
    {
      return;
    }
    else
    {
      gift=Gift.fromJson(map['gift']);
      userId=map['userId'];
      userName=map['userName'];
      userEmail=map['userEmail'];
      city=map['city'];
      address=map['address'];
      status=map['status'];
    }
  }

  toJson()
  {
    return {
      'gift': gift.toJson(),
      'userId':userId,
      'userName':userName,
      'userEmail':userEmail,
      'city':city,
      'address':address,
      'status':status,
    };
  }
}