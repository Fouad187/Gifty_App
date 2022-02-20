class Gift
{
  late String id;
  late String name;
  late String type;
  late String price;
  late String description;
  late String image;
  String? docId;
  double? totalPrice;
  int? quantity;
  Gift({required this.id , required this.name, required this.image,required this.description , required this.type , required this.price});

  Gift.fromJson(Map<String,dynamic> map)
  {
    if(map==null)
    {
      return;
    }
    else
    {
      id = map['id'];
      name=map['name'];
      description=map['description'];
      type=map['type'];
      price=map['price'];
      image = map['image'];
    }
  }

  toJson()
  {
    return {
      'id' : id,
      'name' : name,
      'description' : description,
      'type' : type,
      'price': price,
      'image' : image,
    };
  }
}