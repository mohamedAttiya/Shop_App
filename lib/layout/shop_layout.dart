// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:postman_project/project_cubit/project_cubit.dart';
import 'package:postman_project/project_cubit/project_states.dart';
class ShopLayout extends StatelessWidget {
  const ShopLayout({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProjectCubit,ProjectStates>(builder:(context,state){
        return Scaffold(
          bottomNavigationBar:BottomNavigationBar(
              currentIndex:ProjectCubit.get(context).currentIndex,
              onTap:(index)
              {
                ProjectCubit.get(context).changeBottomNavigation(index);
              },
              items:const [
                BottomNavigationBarItem(icon:Icon(Icons.home),label:"Home"),
                BottomNavigationBarItem(icon:Icon(Icons.apps),label:"Categories"),
                BottomNavigationBarItem(icon:Icon(Icons.favorite),label:"Favorites"),
              ]),
          appBar:AppBar(
            title:const Text("Salla",style:TextStyle(color:Colors.black),),
          ),
          body:ProjectCubit.get(context).screens[ProjectCubit.get(context).currentIndex],
        );
      }, listener:(context,state){});
  }
}