import 'package:flutter/material.dart';
import 'package:nations_app/src/screen/home_screen.dart';
import 'package:nations_app/src/widgets/route_observer.dart';
import 'package:nations_app/theme/theme_data.dart';
import 'package:nations_app/theme/theme_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      navigatorObservers: [routeObserver],
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      // theme: ThemeData(

      //   // textTheme: TextTheme(
      //   //   bodyLarge: TextStyle(fontFamily: 'Nunito'),
      //   //   bodyMedium: TextStyle(fontFamily: 'Nunito'),
      //   //   bodySmall: TextStyle(fontFamily: 'Nunito'),
      //   // ),
      // ),
    );
  }
}
