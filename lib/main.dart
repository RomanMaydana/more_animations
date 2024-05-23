

import 'package:course_flutter_animations/src/pages/example_two_page.dart';
import 'package:course_flutter_animations/src/pages/rotation_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(brightness: Brightness.dark),
      darkTheme: ThemeData(brightness: Brightness.dark),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      home: const HomePage(),
    );
  }
}


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(onPressed:()=> _goTo(context ,const RoationPage()), child: const Text('Rotation')),
            ElevatedButton(onPressed:()=> _goTo(context ,const ExampleTwo()), child: const Text('Example 2'))
          ],
        ),
      ),
    );
  }

  void _goTo(BuildContext context,Widget child){
    Navigator.push(context, MaterialPageRoute(builder: (_) => child,));
  }
}