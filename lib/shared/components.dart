import 'package:flutter/material.dart';
import 'package:postman_project/project_cubit/project_cubit.dart';
Widget defaultTextFormField({
  @required TextEditingController? controller,
  bool isPassword = false,
  @required String? labelText,
  @required String? Function(String?)? validate,
  Function(String)? onSubmit,
  @required TextInputType? type,
  @required IconData? prefix,
  IconData? suffix,
  Function()? suffixPressed,
})=>TextFormField(
  onFieldSubmitted:onSubmit,
  obscureText:isPassword,
  controller:controller,
  validator:validate,
  keyboardType:type,
  decoration:InputDecoration(
  border:const OutlineInputBorder(),
  labelText: labelText,
  prefixIcon:Icon(prefix),
  suffixIcon:suffix != null ? IconButton
  (
    onPressed:suffixPressed,
    icon: Icon(suffix)
  ) : null,
),
);
Widget myDivider()=>Padding(
  padding: const EdgeInsetsDirectional.only(start:20.0),
  child: Container(
    width:double.infinity,
    height:1.0,
    color:Colors.grey[300],
  ),
);
Widget defaultButton({
  required Color color,
  required String text,
  required var width,
  required Function()? buttonOnPressed,
})=>Container(
    width: width,
    color: color,
    child: MaterialButton(onPressed:buttonOnPressed,child:Text(text,style:const TextStyle(color:Colors.white),),));
String token ='';
Widget buildListProduct(model,context,{bool isOldPrice = true})=>Padding(
  padding: const EdgeInsets.all(20.0),
  child: Container(
    height:120.0,
    child: Row(
      crossAxisAlignment:CrossAxisAlignment.start,
      children:
      [
        Stack(
          alignment:AlignmentDirectional.bottomStart,
          children: [
            Image(image:NetworkImage(model.image),width:120.0,height:120.0,),
            if(model.discount!=0 && isOldPrice)
              Container(
                padding:const EdgeInsets.symmetric(horizontal:5.0),
                color:Colors.red,
                child:const Text("DISCOUNT",style:TextStyle(fontSize:8.0,color:Colors.white),),
              ),
          ],
        ),
        const SizedBox(width:20.0,),
        Expanded(
          child: Column(
            crossAxisAlignment:CrossAxisAlignment.start,
            children: [
              Text(model.name,maxLines:2,overflow:TextOverflow.ellipsis,style:const TextStyle(fontSize:14.0),),
              const Spacer(),
              Row(
                children: [
                  Text('${model.price.round()}',style:const TextStyle(fontSize:12.0,height:1.3,color:Colors.blue),),
                  const SizedBox(width:5.0,),
                  if(model.discount!=0 && isOldPrice)
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
  ),
);