import 'package:flutter/material.dart';
import 'package:havvadurumuuuu/screens/loading_screen.dart'; // Corrected the import statement

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key); // Added the super call

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const LoadingScreen(), // Added const
    );
  }
}

// It's better to use your own API key to fetch weather data from any weather API.
// Example API KEY: 863919b0ae72ee9e3634f1fcf6158d6a
