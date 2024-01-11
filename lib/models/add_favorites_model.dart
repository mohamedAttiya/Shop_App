class AddFavoritesModel
{
  late bool status;
  late String message;
  AddFavoritesModel.fromJson(Map<String,dynamic>json)
  {
    status = json['status'];
    message = json['message'];
  }
}