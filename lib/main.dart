import 'package:flutter/material.dart';
import 'package:nations_app/src/screen/home_screen.dart';
import 'package:nations_app/src/widgets/route_observer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorObservers: [routeObserver],
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
      theme: ThemeData(
        textTheme: TextTheme(
          bodyLarge: TextStyle(fontFamily: 'Nunito'),
          bodyMedium: TextStyle(fontFamily: 'Nunito'),
          bodySmall: TextStyle(fontFamily: 'Nunito'),
        ),
      ),
    );
  }
}
