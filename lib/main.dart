import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:postman_project/network/remote/dio_helper.dart';
import 'package:postman_project/project_cubit/project_cubit.dart';
import 'package:postman_project/project_screens/splash_screen.dart';
import 'project_cubit/project_bloc_observer.dart';
main()
{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create:(BuildContext context)=>ProjectCubit()..getHomeData()..getCategoriesData()..getFavorites(),
      child:MaterialApp(
          debugShowCheckedModeBanner:false,
          theme:ThemeData(
              bottomNavigationBarTheme:const BottomNavigationBarThemeData(
                  type:BottomNavigationBarType.fixed,
                  elevation:0.0,
                  selectedItemColor:Colors.blue,
                  unselectedItemColor:Colors.grey,
                  showSelectedLabels:true,
                  showUnselectedLabels:true
              ),
              scaffoldBackgroundColor: Colors.white,
              appBarTheme:const AppBarTheme(
                  iconTheme:IconThemeData(
                      color:Colors.black
                  ),
                  systemOverlayStyle:SystemUiOverlayStyle(
                      statusBarColor:Colors.white,
                      statusBarIconBrightness:Brightness.dark
                  ),
                  color:Colors.white,
                  elevation:0.0
              )
          ),
          home:const SplashScreen()),
    );
  }
}