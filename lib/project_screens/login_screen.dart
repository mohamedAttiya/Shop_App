// ignore_for_file: avoid_print
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:postman_project/layout/shop_layout.dart';
import 'package:postman_project/project_cubit/project_cubit.dart';
import 'package:postman_project/project_cubit/project_states.dart';
import 'package:postman_project/project_screens/register_screen.dart';
import 'package:postman_project/shared/components.dart';
class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create:(BuildContext context)=>ProjectCubit(),
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
                      const Text("LOGIN",style:TextStyle(fontSize:24,fontWeight:FontWeight.bold),),
                      const SizedBox(height:10,),
                      const Text("Login Now To Browse Our Hot Offers!",style:TextStyle(fontSize:16.0,fontWeight:FontWeight.w600,color:Colors.grey),),
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
                      ConditionalBuilder
                        (
                          condition: state is! LoadingLoginState,
                          builder: (context)=>defaultButton
                            (
                              color: Colors.blue,
                              text: "LOGIN",
                              width: double.infinity,
                              buttonOnPressed: ()
                              {
                                if(formKey.currentState!.validate())
                                {
                                  ProjectCubit.get(context).userLogin
                                    (
                                      email: emailController.text,
                                      password: passwordController.text
                                    );
                                }
                              }
                          ),
                          fallback: (context)=>const Center(child: CircularProgressIndicator())
                        ),
                      const SizedBox(height:10.0,),
                      Row(
                        mainAxisAlignment:MainAxisAlignment.center,
                        children:
                        [
                          const Text("Don\'t have an account ?",style:TextStyle(fontSize:14.0,fontWeight:FontWeight.bold),),
                          TextButton(onPressed:()
                          {
                            Navigator.push(context,MaterialPageRoute(builder:(context)=>RegisterScreen()));
                          }, child: const Text("REGISTER NOW"))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }, listener:(context,state)
      {
        if(state is SuccessLoginState)
        {
          if(state.loginModel.status)
          {
            print(state.loginModel.message);
            print(state.loginModel.data!.token);
            Fluttertoast.showToast
              (
              msg:state.loginModel.message,
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 5,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0,
            );
            token = state.loginModel.data!.token;
            Navigator.pushReplacement(context,MaterialPageRoute(builder:(context)=>const ShopLayout()));
          }
          else
          {
            print(state.loginModel.message);
            Fluttertoast.showToast
              (
                msg:state.loginModel.message,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 5,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0,
              );
          }
        }
      }),
    );
  }
}