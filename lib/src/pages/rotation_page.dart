import 'package:flutter/material.dart';
import 'dart:math' show pi;

class RoationPage extends StatefulWidget {
  const RoationPage({super.key});

  @override
  State<RoationPage> createState() => _HomePageState();
}

class _HomePageState extends State<RoationPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _animation = Tween<double>(begin: 0.0, end: 2 * pi).animate(_controller);
    _controller.repeat();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
          animation: _animation,        
          builder: (context, snapshot) {
            return Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()..rotateY(_animation.value ),
              child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      )
                    ]),
              ),
            );
          }
        ),
      ),
    );
  }
}
