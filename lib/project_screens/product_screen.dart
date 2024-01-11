import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:postman_project/models/category_model.dart';
import 'package:postman_project/models/home_model.dart';
import 'package:postman_project/project_cubit/project_cubit.dart';
import 'package:postman_project/project_cubit/project_states.dart';
class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProjectCubit,ProjectStates>(builder:(context,state)
    {
      return ConditionalBuilder
        (
          condition: ProjectCubit.get(context).homeModel!=null && ProjectCubit.get(context).categoriesModel!=null,
          builder: (context)=>productsBuilder(ProjectCubit.get(context).homeModel!,ProjectCubit.get(context).categoriesModel! , context),
          fallback: (context)=>const Center(child: CircularProgressIndicator())
        );
    }, listener:(context,state)
    {
      if(state is ShopSuccessFavoritesDataState)
      {
        if(!state.model.status)
        {
          Fluttertoast.showToast
            (
            msg:state.model.message,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 5,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }
      }
    });
  }
  Widget productsBuilder(HomeModel model , CategoriesModel categoriesModel , context)=>SingleChildScrollView(
    physics:const BouncingScrollPhysics(),
    child: Column(
      crossAxisAlignment:CrossAxisAlignment.start,
      children:
      [
        CarouselSlider(
            items:model.data.banners.map((e)=> Image(image:NetworkImage(e.image),
              width:double.infinity,
              fit:BoxFit.cover,),).toList(),
            options: CarouselOptions(
              height:250.0,
              initialPage:0,
              enableInfiniteScroll:true,
              reverse:false,
              autoPlay:true,
              autoPlayInterval:const Duration(
                seconds:3
              ),
              autoPlayAnimationDuration:const Duration(
                seconds:1
              ),
              autoPlayCurve:Curves.fastOutSlowIn,
              scrollDirection:Axis.horizontal,
              viewportFraction:1.0,
            )
          ),
        const SizedBox(height:10.0,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal:10.0),
          child: Column(
            crossAxisAlignment:CrossAxisAlignment.start,
            children: [
              const Text("Categories",style:TextStyle(fontSize:24.0,fontWeight:FontWeight.w800),),
              const SizedBox(height:10.0,),
              Container(
                height:100.0,
                child: ListView.separated(
                    physics:const BouncingScrollPhysics(),
                    scrollDirection:Axis.horizontal,
                    itemBuilder:(context,index)=>buildCategoryItem(ProjectCubit.get(context).categoriesModel!.data.data[index]),
                    separatorBuilder:(context,index)=>const SizedBox(width:10.0,),
                    itemCount: categoriesModel.data.data.length),
              ),
              const SizedBox(height:20.0,),
              const Text("New Products",style:TextStyle(fontSize:24.0,fontWeight:FontWeight.w800),),
            ],
          ),
        ),
        const SizedBox(height:10.0,),
        Container(
          color:Colors.grey[300],
          child: GridView.count(
            mainAxisSpacing:1.0,
            crossAxisSpacing:1.0,
            childAspectRatio:1/2,
            crossAxisCount:2,
            shrinkWrap:true,
            physics:const NeverScrollableScrollPhysics(),
            children:List.generate(model.data.products.length,
                    (index)=>buildGridProduct(model.data.products[index] , context)),
          ),
        )
      ],
    ),
  );
  Widget buildGridProduct(ProductsModel model , context)=>Container(
    color:Colors.white,
    child: Column(
      crossAxisAlignment:CrossAxisAlignment.start,
      children:
      [
        Stack(
          alignment:AlignmentDirectional.bottomStart,
          children: [
            Image(image:NetworkImage(model.image),width:double.infinity,height:200.0,),
            if(model.discount!=0)
            Container(
              padding:const EdgeInsets.symmetric(horizontal:5.0),
              color:Colors.red,
              child:const Text("DISCOUNT",style:TextStyle(fontSize:8.0,color:Colors.white),),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment:CrossAxisAlignment.start,
            children: [
              Text(model.name,maxLines:2,overflow:TextOverflow.ellipsis,style:const TextStyle(fontSize:14.0),),
              Row(
                children: [
                  Text('${model.price.round()}',style:const TextStyle(fontSize:12.0,height:1.3,color:Colors.blue),),
                  const SizedBox(width:5.0,),
                  if(model.discount!=0)
                  Text('${model.oldPrice.round()}',style:const TextStyle(fontSize:10.0,height:1.3,color:Colors.grey,decoration:TextDecoration.lineThrough),),
                  const Spacer(),
                  IconButton(
                      onPressed:()
                      {
                        ProjectCubit.get(context).changeFavorites(model.id);
                      }, icon: CircleAvatar(
                      backgroundColor:ProjectCubit.get(context).favorites[model.id]! ? Colors.blue :Colors.grey,
                      radius:15.0 ,
                      child: const Icon(Icons.favorite_border_outlined,size:14.0,color:Colors.white,)))
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
  Widget buildCategoryItem(DataModel model)=>Stack(
    alignment:AlignmentDirectional.bottomCenter,
    children:
    [
      Image(image:NetworkImage(model.image),height:100,width:100,fit:BoxFit.cover,),
      Container(
          width:100.0,
          color:Colors.black.withOpacity(0.6),
          child: Text(model.name,style:const TextStyle(color:Colors.white),textAlign:TextAlign.center,maxLines:1,overflow:TextOverflow.ellipsis,))
    ],
  );
}