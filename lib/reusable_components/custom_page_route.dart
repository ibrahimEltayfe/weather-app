import 'package:flutter/material.dart';

class CustomPageRoute extends PageRouteBuilder{
  final Widget child;
  final RouteSettings routeSettings;
  CustomPageRoute({required this.child,required this.routeSettings}):super(
    pageBuilder: (context,anim,_) => child
  );

  @override
  RouteTransitionsBuilder get transitionsBuilder =>(context, anim,_, child){
    return FadeTransition(
        opacity: anim,
        child: child,
    );
  };

 @override
  Duration get transitionDuration => const Duration(milliseconds: 750);

  @override
  RouteSettings get settings => routeSettings;

}