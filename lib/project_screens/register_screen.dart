import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:postman_project/layout/shop_layout.dart';
import 'package:postman_project/project_cubit/project_cubit.dart';
import '../project_cubit/project_states.dart';
import '../shared/components.dart';
class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return  BlocProvider(create:(BuildContext context)=>ProjectCubit(),
      child:BlocConsumer<ProjectCubit,ProjectStates>(builder:(context,state)
      {
        return Scaffold(
          appBar:AppBar(),
          body:Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key:formKey,
                  child: Column(
                    crossAxisAlignment:CrossAxisAlignment.start,
                    children:
                    [
                      const Text("REGISTER",style:TextStyle(fontSize:24,fontWeight:FontWeight.bold),),
                      const SizedBox(height:10,),
                      const Text("Register Now To Browse Our Hot Offers!",style:TextStyle(fontSize:16.0,fontWeight:FontWeight.w600,color:Colors.grey),),
                      const SizedBox(height:20.0,),
                      defaultTextFormField
                        (
                          controller: nameController,
                          labelText: "User Name",
                          validate: (value)
                          {
                            if(value!.isEmpty)
                            {
                              return "User Name Must Not Be Empty";
                            }
                            return null;
                          },
                          type: TextInputType.name,
                          prefix: Icons.person,
                        ),
                      const SizedBox(height:20.0,),
                      defaultTextFormField
                        (
                        controller: emailController,
                        labelText: "E-mail Address",
                        validate: (value)
                        {
                          if(value!.isEmpty)
                          {
                            return "Sorry E-mail Address Must Not Be Empty";
                          }
                          return null;
                        },
                        type: TextInputType.emailAddress,
                        prefix: Icons.email_outlined,
                      ),
                      const SizedBox(height:20.0,),
                      defaultTextFormField
                        (
                          controller: passwordController,
                          labelText: "User Password",
                          validate: (value)
                          {
                            if(value!.isEmpty)
                            {
                              return "Sorry Password Must Not Be Empty";
                            }
                            return null;
                          },
                          type: TextInputType.visiblePassword,
                          prefix: Icons.lock_outlined,
                          isPassword:ProjectCubit.get(context).isPassword,
                          suffix: ProjectCubit.get(context).suffix,
                          suffixPressed:()
                          {
                            ProjectCubit.get(context).changeItem();
                          }
                      ),
                      const SizedBox(height:20.0,),
                      defaultTextFormField
                        (
                          controller: phoneController,
                          labelText: "User Phone",
                          validate: (value)
                          {
                            if(value!.isEmpty)
                            {
                              return "User Phone Must Not Be Empty";
                            }
                            return null;
                          },
                          type: TextInputType.phone,
                          prefix: Icons.call,
                        ),
                      const SizedBox(height:20.0,),
                      ConditionalBuilder(condition: state is!LoadingRegisterState,
                          builder:(context)=>defaultButton
                            (
                              color: Colors.blue,
                              text: "REGISTER",
                              width: double.infinity,
                              buttonOnPressed: ()
                              {
                                if(formKey.currentState!.validate())
                                {
                                 ProjectCubit.get(context).userRegister
                                   (
                                     email: emailController.text,
                                     password: passwordController.text,
                                     name: nameController.text,
                                     phone: phoneController.text,
                                   );
                                }
                              }
                          ),
                          fallback:(context)=>const Center(child: CircularProgressIndicator()))
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }, listener:(context,state)
      {
        if(state is SuccessRegisterState)
        {
          if(state.registerModel.status)
          {
            print(state.registerModel.message);
            print(state.registerModel.data!.token);
            Fluttertoast.showToast
              (
              msg:state.registerModel.message,
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 5,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0,
            );
            token = state.registerModel.data!.token;
            Navigator.pushReplacement(context,MaterialPageRoute(builder:(context)=>const ShopLayout()));
          }
          else
          {
            print(state.registerModel.message);
            Fluttertoast.showToast
              (
              msg:state.registerModel.message,
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 5,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0,
            );
          }
        }
      }
      ),
    );
  }
}