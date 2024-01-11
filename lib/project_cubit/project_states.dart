import 'package:postman_project/models/add_favorites_model.dart';
import 'package:postman_project/models/login_model.dart';
import 'package:postman_project/models/register_model.dart';
abstract class ProjectStates{}
class InitialState extends ProjectStates{}
class ChangeItem extends ProjectStates{}
class LoadingLoginState extends ProjectStates{}
class SuccessLoginState extends ProjectStates {
  final ShopLoginModel loginModel;
  SuccessLoginState(this.loginModel);
}
class ErrorLoginState extends ProjectStates {
  final String error;
  ErrorLoginState(this.error);
}
class ChangeBotNav extends ProjectStates{}
class ShopLoadingHomeDataState extends ProjectStates{}
class ShopSuccessHomeDataState extends ProjectStates{}
class ShopErrorHomeDataState extends ProjectStates {
  final String error;
  ShopErrorHomeDataState(this.error);
}
class ShopSuccessCategoriesDataState extends ProjectStates{}
class ShopErrorCategoriesDataState extends ProjectStates {
  final String error;
  ShopErrorCategoriesDataState(this.error);
}
class ShopSuccessFavoritesDataState extends ProjectStates {
  final AddFavoritesModel model;
  ShopSuccessFavoritesDataState(this.model);
}
class ShopChangeSuccessFavoritesDataState extends ProjectStates{}
class ShopErrorFavoritesDataState extends ProjectStates {
  final String error;
  ShopErrorFavoritesDataState(this.error);
}
class ShopLoadingGetFavoritesState extends ProjectStates{}
class ShopSuccessGetFavoritesState extends ProjectStates{}
class ShopErrorGetFavoritesState extends ProjectStates
{
  final String error;
  ShopErrorGetFavoritesState(this.error);
}
class LoadingRegisterState extends ProjectStates{}
class SuccessRegisterState extends ProjectStates {
  final ShopRegisterModel registerModel;
  SuccessRegisterState(this.registerModel);
}
class ErrorRegisterState extends ProjectStates {
  final String error;
  ErrorRegisterState(this.error);
}