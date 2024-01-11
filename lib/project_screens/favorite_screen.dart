import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:postman_project/project_cubit/project_cubit.dart';
import 'package:postman_project/shared/components.dart';
import '../project_cubit/project_states.dart';
class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProjectCubit,ProjectStates>(builder:(context,state)
    {
      return ConditionalBuilder(condition:state is!ShopLoadingGetFavoritesState,
          builder:(context)=> ListView.separated(
            physics:const BouncingScrollPhysics(),
            itemBuilder:(context,index)=>buildListProduct(ProjectCubit.get(context).favoritesModelData!.data.data[index].product,context),
            separatorBuilder:(context,index)=>myDivider(),
            itemCount:ProjectCubit.get(context).favoritesModelData!.data.data.length,
          ),
          fallback:(context)=>const Center(child: CircularProgressIndicator()));
    }, listener:(context,state){});
  }
}