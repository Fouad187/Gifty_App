class UserModel {
  late String id;
  late String name;
  late String email;
  late String type;
  late String phone;
  UserModel(
      {required this.id, required this.name, required this.email , required this.type , required this.phone});

  UserModel.fromJson(Map <String, dynamic> map)
  {
    if (map == null) {
      return;
    }
    else {
      id = map['id'];
      name = map['name'];
      email = map['email'];
      type = map['type'];
      phone =map['phone'];
    }
  }

  toJson()
  {
    return {
      'id':id,
      'name' : name,
      'email' : email,
      'type' : type,
      'phone':phone,
    };
  }

}