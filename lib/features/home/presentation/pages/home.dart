import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:my_projects/reusable_components/scaffold_wrapper.dart';

class Home extends StatefulWidget {
   Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {

    return MyScaffold(
      title: 'Home',
      showAppBar: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
              height: 132,
              width: 159,
              child: Lottie.asset(
                  'assets/lottie/hi.json',
                  repeat: false,
                  fit: BoxFit.cover,
              )
          ),

          Padding(
            padding: EdgeInsets.only(left: 35),
            child: Builder(
                builder: (context) {
                  return ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.black87),
                        fixedSize: MaterialStateProperty.all(Size(double.infinity,70)),

                      ),
                      onPressed: (){
                        Scaffold.of(context).openDrawer();
                      },
                      child: FittedBox(
                        fit: BoxFit.cover,
                          child: Text('My Simple Projects',style: TextStyle(fontSize: 28,fontFamily: 'bsan'),)
                      )

                  );
                }
            ),
          ),
        ],
      ),
    );
  }
}