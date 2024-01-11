import 'package:flutter/material.dart';
import 'package:postman_project/project_screens/login_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
class BoardingModel
{
  final String? image;
  final String? title;
  final String? body;
  BoardingModel(this.image, this.title, this.body);
}
class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}
class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var controller = PageController();
  List<BoardingModel> boarding = [
    BoardingModel
      (
        "images/two.jpg",
        "Explore Fashion",
        "Explore the 2020's hottest fashion , jewellery , accessories and more ...."
      ),
    BoardingModel
      (
        "images/three.jpg",
        "Select What You Love",
        "Exclusively curated selection of top brands in the palm of your hand ...."
      ),
    BoardingModel
      (
        "images/four.jpg",
        "Be The Real You",
        "It brings you the latest trends and products from all over the world"
      ),
  ];
  bool isLast = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        actions:[
          TextButton(
              onPressed:()
              {
                Navigator.pushReplacement(context,MaterialPageRoute(builder:(context)=>LoginScreen()));
              }, child:const Text("SKIP")),
        ],
      ),
      body:Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded
              (
                child: PageView.builder
                (
                   onPageChanged:(int index)
                   {
                     if(index == boarding.length -1)
                     {
                       setState(() {
                         isLast = true;
                       });
                     }
                     else
                     {
                       setState(() {
                         isLast = false;
                       });
                     }
                   },
                   controller:controller,
                   physics:const BouncingScrollPhysics(),
                   itemBuilder:(context,index)=>buildOnBoarding(boarding[index]),itemCount:boarding.length,
                )
              ),
            const SizedBox(height:40.0,),
            Row
              (
              children:
              [
                SmoothPageIndicator(
                    controller: controller, count: boarding.length ,
                    effect: const ExpandingDotsEffect
                    (
                    dotColor:Colors.grey,
                    activeDotColor:Colors.blue,
                    dotHeight:7,
                    expansionFactor:1.3,
                    dotWidth:7,
                    spacing:4,

                  ),
                ),
                const Spacer(),
               ElevatedButton
                  (
                  onPressed:()
                    {
                       if(isLast == true)
                       {
                         Navigator.pushReplacement(context,MaterialPageRoute(builder:(context)=>LoginScreen()));
                       }
                       else
                       {
                                 controller.nextPage
                           (
                                 duration:
                                 const Duration (milliseconds:750,),
                                 curve:Curves.fastLinearToSlowEaseIn
                           );
                       }
                   },child:const Text("Next !"),
                ),
              ],
              )
          ],
        ),
      ),
    );
  }

  Widget buildOnBoarding(BoardingModel model)=>Column(
    crossAxisAlignment:CrossAxisAlignment.start,
    children:
    [
      Expanded(child: Image(image:AssetImage("${model.image}"))),
      Text("${model.title}",style:const TextStyle(fontSize:24.0,fontWeight:FontWeight.bold),),
      const SizedBox(height:20.0,),
      Text("${model.body}",style:const TextStyle(fontSize:14.0),),
    ],
  );
}