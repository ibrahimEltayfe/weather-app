import 'package:flutter/material.dart';
import 'package:my_projects/constants/app_colors.dart';
import 'package:my_projects/constants/app_routes.dart';
import 'package:responsive_framework/responsive_framework.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> with TickerProviderStateMixin{
  late AnimationController diceAnimController;
  late AnimationController heightAnimController;
  late AnimationController widthAnimController;
  late CurvedAnimation widthAnim ;

  @override
  void initState() {

    diceAnimController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 1100),
        lowerBound: 1,
        upperBound: 180
    );


    heightAnimController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 670),
        lowerBound:1,
        upperBound: 500
    );

    widthAnimController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 600),
    );

    widthAnim = CurvedAnimation(parent: widthAnimController, curve: Curves.fastOutSlowIn);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width,
      elevation: 0,
      backgroundColor: Colors.black.withOpacity(0.75),

      child: Wrap(
       runAlignment:WrapAlignment.center ,
       crossAxisAlignment: WrapCrossAlignment.center,
       direction: Axis.vertical,
       clipBehavior: Clip.none,
       children: [
         SizedBox(height:  MediaQuery.of(context).size.height*0.08),
         //home page
         GestureDetector(
           onTap: (){
             navigateToPage(pageName:AppRoutes.homePage);
           },
           child: _buildText('Home')
         ),

         SizedBox(height:  MediaQuery.of(context).size.height*0.04),

         //dice page
         GestureDetector(
          onTap: (){
            navigateToPage(
              pageName:AppRoutes.dicePage,
              customNavigate: () {
               diceAnimController.forward().whenComplete((){
                Navigator.pushNamedAndRemoveUntil(context, AppRoutes.dicePage, (route) => false);
              });
            });
          },
          child: AnimatedBuilder(
            animation: diceAnimController,
            builder:(context, child) =>
                Transform.scale(
                  scale: diceAnimController.value,
                  origin:Offset(8.5,10.6) ,
                  alignment: Alignment.topCenter,

                  child: _buildText('Dice')
                )
          ),
        ),

         SizedBox(height:  MediaQuery.of(context).size.height*0.04),

         //weather app
         GestureDetector(
             onTap: (){
               navigateToPage(
                 pageName:AppRoutes.weatherPage,
                 customNavigate: () {
                 widthAnimController.forward().whenComplete((){
                   heightAnimController.forward().whenComplete((){
                     Navigator.pushNamedAndRemoveUntil(context,AppRoutes.weatherPage , (route) => false);
                   });
                 });
               });
             },
              child: SizedBox(
                width:  MediaQuery.of(context).size.width,
                child: Stack(
                  alignment: Alignment.topCenter,
                  clipBehavior: Clip.none,
                  children:[
                    _buildText('Weather App'),

                    Positioned(
                      top: 21,
                      child: AnimatedBuilder(
                        animation: widthAnimController,
                        builder: (context, child) {
                          return AnimatedBuilder(
                            animation: heightAnimController,
                            builder: (context, child) {
                              return Transform.scale(
                                scaleY: heightAnimController.value,
                                child: Container(
                                  width:  MediaQuery.of(context).size.width*widthAnim.value,
                                  height: 3,
                                  color: AppColors.bgColor,
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ]
                ),
              )
         ),

         SizedBox(height:  MediaQuery.of(context).size.height*0.04),

         //google search app
         GestureDetector(
             onTap: (){
               navigateToPage(pageName:AppRoutes.googleSearchPage);
             },
             child: _buildText('Google Search')
          ),

         SizedBox(height:  MediaQuery.of(context).size.height*0.04),

         //google search app
         GestureDetector(
             onTap: (){
               navigateToPage(pageName:AppRoutes.mapPage);
             },
             child: _buildText('MapBox')
         )

      ],
      ),
    );
  }

  navigateToPage({required String pageName,VoidCallback? customNavigate}){
    final String? currentRouteName = ModalRoute.of(context)!.settings.name;
    if(currentRouteName!=pageName){
      if(customNavigate==null){
        Navigator.pushNamedAndRemoveUntil(context,pageName , (route) => false);
      }else{
        customNavigate();
      }

    }
  }

  Text _buildText(String text){
    return Text(text,style: TextStyle(
        fontSize: 42,
        color: Colors.white,
        fontFamily: 'mat'
    )
    );
  }

}

