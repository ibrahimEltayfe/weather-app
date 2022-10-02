import 'dart:developer' as d;
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_cube/flutter_cube.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Dice extends StatefulWidget {
  const Dice({Key? key}) : super(key: key);

  @override
  State<Dice> createState() => _DiceState();
}

class _DiceState extends State<Dice> with SingleTickerProviderStateMixin{
  late Object dice;
  late AnimationController _animationController;
  late CurvedAnimation _curvedAnimation;
  Vector3 values = Vector3.all(0);

  @override
  void initState() {
    dice = Object(fileName: 'assets/objects/dice/Dice.obj',scale: Vector3.all(0.75));

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2100),
    );

    _curvedAnimation = CurvedAnimation(
        parent: _animationController,
        curve: Curves.decelerate
    )..addListener(() {
        _updateDiceRotation();
    });

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _curvedAnimation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        backgroundColor: Colors.white,
        title:Text('Dice',style: TextStyle(
            color: Colors.black,
            fontFamily: 'bsan',
            fontSize: 26.sp
        ),),

        leading: Builder(
            builder: (context) {
              return GestureDetector(
                onTap: (){
                  Scaffold.of(context).openDrawer();
                },
                child: Padding(
                  padding: EdgeInsets.only(top: 15.r,left: 15.r),
                  child: FaIcon(
                    FontAwesomeIcons.bars,
                    size: 26.sp,
                    color: Colors.black,
                  ),
                ),
              );
            }
        ),
        automaticallyImplyLeading: false,

      ),
      body: Center(
        child: GestureDetector(
          onTap: (){
            values.setValues(getRandomNumb(901), getRandomNumb(361), getRandomNumb(361));

            if(_animationController.isDismissed) {
              _animationController.forward();
            }else{
              _animationController.reset();
              _animationController.forward();
            }
          },
          child: SizedBox(
            width: 1.sw,
            height: 1.sh,
            child: AnimatedBuilder(
              animation: _curvedAnimation,
              builder: (context, child) =>
                  Cube(
                    interactive: false,
                    onSceneCreated: (scene) {
                      scene.camera.zoom = 10;
                      scene.world.add(dice);
                      scene.camera.position.setValues(-21, 0, 0);
                    },
                  ),
            ),
          ),
        ),
      ),
    );
  }

  double getRandomNumb(int max){
    int rand = Random().nextInt(max);
    while(rand % 90 != 0) {
      rand = Random().nextInt(max);
    }
    d.log( rand.toDouble().toString());
    return rand.toDouble();
  }

  void _updateDiceRotation(){
    dice.rotation.setValues(
      values.x*_curvedAnimation.value,
      values.y*_curvedAnimation.value,
      values.z*_curvedAnimation.value,
    );
    dice.updateTransform();
  }
}