import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:postman_project/models/category_model.dart';
import 'package:postman_project/project_cubit/project_cubit.dart';
import 'package:postman_project/project_cubit/project_states.dart';
import 'package:postman_project/shared/components.dart';
class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProjectCubit,ProjectStates>(builder:(context,state)
    {
      return ListView.separated(
          itemBuilder:(context,index)=>buildCatItem(ProjectCubit.get(context).categoriesModel!.data.data[index]),
          separatorBuilder:(context,index)=>myDivider(),
          itemCount:ProjectCubit.get(context).categoriesModel!.data.data.length
      );
    }, listener:(context,state){});
  }
  Widget buildCatItem(DataModel model)=>Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children:
      [
        Image(image:NetworkImage(model.image),width:80,height:80,fit:BoxFit.cover,),
        const SizedBox(width:20.0,),
        Text(model.name,style:const TextStyle(fontSize:20.0,fontWeight:FontWeight.bold),),
        const Spacer(),
        const Icon(Icons.arrow_forward_ios),
      ],
    ),
  );
}