import 'package:flutter/material.dart';
import 'dart:math' show pi;

enum CircleSide { left, right }

extension ToPath on CircleSide {
  Path toPath(Size size) {
    final path = Path();
    Offset offset;
    bool clockwise;
    switch (this) {
      case CircleSide.left:
        path.moveTo(size.width, 0);
        offset = Offset(size.width, size.height);
        clockwise = false;
      case CircleSide.right:
        offset = Offset(0, size.height);
        clockwise = true;
    }
    path.arcToPoint(offset,
        radius: Radius.elliptical(size.width / 2, size.height / 2),
        clockwise: clockwise);
    path.close();
    return path;
  }
}

class HalfCircleClipper extends CustomClipper<Path> {
  HalfCircleClipper({required this.side});

  final CircleSide side;

  @override
  Path getClip(Size size) {
    return side.toPath(size);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class ExampleTwo extends StatefulWidget {
  const ExampleTwo({super.key});

  @override
  State<ExampleTwo> createState() => _ExampleTwoState();
}

class _ExampleTwoState extends State<ExampleTwo>
    with SingleTickerProviderStateMixin {
  late AnimationController _counterClockwiseRotationController;
  late Animation<double> _counterClockwiseRotationAnimation;

  @override
  void initState() {
    super.initState();
    _counterClockwiseRotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _counterClockwiseRotationAnimation = Tween<double>(
      begin: 0,
      end: -(pi / 2),
    ).animate(
      CurvedAnimation(
        parent: _counterClockwiseRotationController,
        curve: Curves.bounceOut,
      ),
    );
    _counterClockwiseRotationController.repeat();
  }

  @override
  void dispose() {
    _counterClockwiseRotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // _counterClockwiseRotationController..reset()..forward();
    return Scaffold(
      body: AnimatedBuilder(
        animation: _counterClockwiseRotationController,
        builder: (context, child) {
          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..rotateZ(_counterClockwiseRotationAnimation.value),
            child: child,
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipPath(
              clipper: HalfCircleClipper(side: CircleSide.left),
              child: Container(
                color: const Color(0xff0057b7),
                height: 100,
                width: 100,
              ),
            ),
            ClipPath(
              clipper: HalfCircleClipper(side: CircleSide.right),
              child: Container(
                color: const Color(0xffffd700),
                height: 100,
                width: 100,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
