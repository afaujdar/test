import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fys/screens/home_screen.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink.shade800),

        appBarTheme: AppBarTheme(
          backgroundColor: Colors.pink.shade50,
          foregroundColor: Colors.black, // Ensures text/icons are visible
          elevation: 0,
          surfaceTintColor: Colors.transparent, // Disables Material 3 overlay effect
          centerTitle: true,
          titleTextStyle: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20)
        ),


        scaffoldBackgroundColor: Colors.pink.shade50,

        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

