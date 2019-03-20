import 'package:flutter/material.dart';
import '../widgets/cat.dart';

class Home extends StatefulWidget {
  createState() => HomeState();
}

class HomeState extends State<Home> with TickerProviderStateMixin {
  Animation<double> catAnimation;
  AnimationController catController;
  Animation<double> boxAnimation;
  AnimationController boxController;

  initState() {
    super.initState();

    boxController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    boxAnimation = Tween(begin: 0.0, end: -3.145 / 6).animate(
      CurvedAnimation(
        parent: boxController,
        curve: Curves.easeIn,
      ),
    );

    catController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    catAnimation = Tween(begin: -35.0, end: -80.0).animate(
      CurvedAnimation(
        parent: catController,
        curve: Curves.easeIn,
      ),
    );
    boxAnimation.addStatusListener(
      (status) {
        if (status == AnimationStatus.completed) {
          boxController.repeat();
        }
      },
    );
    boxController.forward();
  }

  onTap() {
    if (catController.status == AnimationStatus.completed) {
      catController.reverse();
    } else if (catController.status == AnimationStatus.dismissed) {
      catController.forward();
    }
    catController.forward();
  }

  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animation'),
      ),
      body: GestureDetector(
        child: Center(
          child: Stack(
            overflow: Overflow.visible,
            children: <Widget>[
              buildCatAnimation(),
              buildBox(),
              buildLeftFlap(),
            ],
          ),
        ),
        onTap: onTap,
      ),
    );
  }

  Widget buildCatAnimation() {
    return AnimatedBuilder(
      animation: catAnimation,
      child: Cat(),
      builder: (context, child) {
        return Positioned(
          child: child,
          top: catAnimation.value,
          right: 0.0,
          left: 0.0,
        );
      },
    );
  }

  Widget buildBox() {
    return Container(
      height: 200.0,
      width: 200.0,
      color: Colors.brown,
    );
  }

  Widget buildLeftFlap() {
    return Positioned(
      child: AnimatedBuilder(
        animation: boxAnimation,
        child: Container(
          height: 10,
          width: 125,
          color: Colors.pinkAccent,
        ),
        builder: (context, child) {
          return Transform.rotate(
              child: child,
              alignment: Alignment.topLeft,
              angle: boxAnimation.value);
        },
      ),
    );
  }
}
