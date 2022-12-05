import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:memo/view/page/home_page.dart';
import 'package:memo/view/page/input_page.dart';
import 'package:memo/view/theme/my_theme.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: MyTheme.themeData,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/input': (context) => const InputPage(),
      },
    );
  }
}
