class CustomGift
{
  late String name;
  late String type;
  late String price;
  late String description;
  late String image;
  late String userId;
  late String userName;
  late String userEmail;
  String? docId;
  double? totalPrice;
  int? quantity;
  CustomGift({required this.name, required this.image,required this.description , required this.type , required this.price , required this.userId , required this.userEmail , required this.userName});

  CustomGift.fromJson(Map<String,dynamic> map)
  {
    if(map==null)
    {
      return;
    }
    else
    {
      name=map['name'];
      description=map['description'];
      type=map['type'];
      price=map['price'];
      image = map['image'];
      userId=map['userId'];
      userName=map['userName'];
      userEmail=map['userEmail'];
    }
  }

  toJson()
  {
    return {
      'name' : name,
      'description' : description,
      'type' : type,
      'price': price,
      'image' : image,
      'userId':userId,
      'userName':userName,
      'userEmail':userEmail
    };
  }
}