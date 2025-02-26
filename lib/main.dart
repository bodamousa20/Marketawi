import 'package:flutter/material.dart';
import 'package:marketawi/provider/Product_provider.dart';
import 'package:marketawi/auth/login.dart';
import 'package:marketawi/main/welcomeScreen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => ProductProvider(),
      child: const MyApp()));
      }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
     
      home:login()
    );
  }
}
