import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:wordle_clone/wordle_page.dart';
import 'package:wordle_clone/wordle_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => WordleProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
      ),
      builder: EasyLoading.init(), // For use with EasyLoading
      home: WordlePage(),
    );
  }
}
