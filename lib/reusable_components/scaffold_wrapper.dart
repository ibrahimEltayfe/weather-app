import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_projects/reusable_components/custom_drawer.dart';

class MyScaffold extends StatelessWidget {
  final Widget child;
  final String? title;
  final bool showAppBar;
  final bool showBottomSheetBar;

  const MyScaffold({
    required this.child,
    this.title,
    this.showAppBar = true,
    this.showBottomSheetBar = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: const CustomDrawer(),
      appBar:showAppBar? AppBar(
        elevation: 4,
        backgroundColor: Colors.white,
        title:Text(title??'',style: TextStyle(
          color: Colors.black,
          fontFamily: 'bsan',
          fontSize: 26
        ),),

        leading: Builder(
          builder: (context) {
            return GestureDetector(
              onTap: (){
                Scaffold.of(context).openDrawer();
              },
              child: Padding(
                  padding: EdgeInsets.only(top: 15,left: 15),
                  child: FaIcon(
                    FontAwesomeIcons.bars,
                    size: 26,
                    color: Colors.black,
                  ),
                ),
            );
          }
        ),
        automaticallyImplyLeading: false,

      ):null,
      body:SafeArea(
        child: child,
      )
    );
  }
}
