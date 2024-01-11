// ignore_for_file: avoid_function_literals_in_foreach_calls, avoid_print
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:postman_project/models/add_favorites_model.dart';
import 'package:postman_project/models/category_model.dart';
import 'package:postman_project/models/favorites_model.dart';
import 'package:postman_project/models/home_model.dart';
import 'package:postman_project/models/login_model.dart';
import 'package:postman_project/models/register_model.dart';
import 'package:postman_project/network/remote/dio_helper.dart';
import 'package:postman_project/project_cubit/project_states.dart';
import 'package:postman_project/project_screens/categories_screen.dart';
import 'package:postman_project/project_screens/favorite_screen.dart';
import 'package:postman_project/project_screens/product_screen.dart';
import 'package:postman_project/shared/components.dart';
class ProjectCubit extends Cubit<ProjectStates>
{
  ProjectCubit():super(InitialState());
  static ProjectCubit get(context)=>BlocProvider.of(context);
  bool isPassword = true;
  int currentIndex = 0;
  List<Widget>screens=
  [
    const ProductScreen(),
    const CategoriesScreen(),
    const FavoriteScreen(),
  ];
  IconData suffix = Icons.visibility_outlined;
  void changeItem()
  {
    isPassword = !isPassword;
    suffix = isPassword? Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(ChangeItem());
  }
  ShopLoginModel? loginModel;
  void userLogin({
    required String email,
    required String password,
})
  {
    emit(LoadingLoginState());
    DioHelper.postData
      (
        url: 'https://student.valuxapps.com/api/login',
        data:
        {
          "email":email,
          "password":password,
        }
      ).then((value)
    {
      loginModel = ShopLoginModel.fromJson(value.data);
      emit(SuccessLoginState(loginModel!));
    }).catchError((error)
    {
      emit(ErrorLoginState(error.toString()));
    });
  }
  void changeBottomNavigation(int index)
  {
    currentIndex = index;
    emit(ChangeBotNav());
  }
  HomeModel? homeModel;
  Map<int,bool> favorites = {};
  void getHomeData()
  {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(url:'https://student.valuxapps.com/api/home').then((value)
    {
        homeModel = HomeModel.fromJson(value.data);
        homeModel!.data.products.forEach((element)
        {
          favorites.addAll({
            element.id : element.inFavorites,
          });
        });
      emit(ShopSuccessHomeDataState());
    }).catchError((error)
    {
      emit(ShopErrorHomeDataState(error.toString()));
    });
  }
  CategoriesModel? categoriesModel;
  void getCategoriesData()
  {
    DioHelper.getData(url:'https://student.valuxapps.com/api/categories',token:token).then((value)
    {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(ShopSuccessCategoriesDataState());
    }).catchError((error)
    {
      emit(ShopErrorCategoriesDataState(error.toString()));
    });
  }
  AddFavoritesModel? favoritesModel;
  void changeFavorites(int productId)
  {
    favorites[productId] = !favorites[productId]!;
    emit(ShopChangeSuccessFavoritesDataState());
    DioHelper.postData(url:'https://student.valuxapps.com/api/favorites', data:
    {
      'product_id' : productId ,
    } ,token:token).then((value)
    {
      favoritesModel = AddFavoritesModel.fromJson(value.data);
      if(!favoritesModel!.status)
      {
        favorites[productId] = !favorites[productId]!;
      }
      else
      {
        getFavorites();
      }
      emit(ShopSuccessFavoritesDataState(favoritesModel!));
    }).catchError((error)
    {
      favorites[productId] = !favorites[productId]!;
      emit(ShopErrorFavoritesDataState(error.toString()));
    });
  }
  FavoritesModel? favoritesModelData;
  void getFavorites()
  {
    emit(ShopLoadingGetFavoritesState());
    DioHelper.getData(url:'https://student.valuxapps.com/api/favorites',token:token).then((value)
    {
      favoritesModelData = FavoritesModel.fromJson(value.data);
      emit(ShopSuccessGetFavoritesState());
    }).catchError((error)
    {
      emit(ShopErrorGetFavoritesState(error.toString()));
    });
  }
  ShopRegisterModel? registerModel;
  void userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
  })
  {
    emit(LoadingRegisterState());
    DioHelper.postData
      (
        url: 'https://student.valuxapps.com/api/register',
        data:
        {
          "email":email,
          "password":password,
           "name":name,
           "phone":phone,
        }
    ).then((value)
    {
      registerModel = ShopRegisterModel.fromJson(value.data);
      emit(SuccessRegisterState(registerModel!));
    }).catchError((error)
    {
      emit(ErrorRegisterState(error.toString()));
    });
  }
}