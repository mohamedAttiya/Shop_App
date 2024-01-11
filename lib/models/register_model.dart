class ShopRegisterModel
{
  late bool status;
  late String message;
  UserDataModel? data;
  ShopRegisterModel.fromJson(Map<String,dynamic>json)
  {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null? UserDataModel.fromJson(json['data']) : null;
  }
}
class UserDataModel
{
  late int id;
  late String name;
  late String email;
  late String phone;
  late String image;
  late int points;
  late int credit;
  late String token;
  UserDataModel.fromJson(Map<String,dynamic>json)
  {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    points = json['points'];
    credit = json['credit'];
    token = json['token'];
  }
}