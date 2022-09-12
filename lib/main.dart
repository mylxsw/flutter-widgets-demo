import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:widgets/pages/add_page.dart';
import 'pages/home_page.dart';
import 'pages/login_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final Map<String, Widget> _pages = {
    "/": const MyHomePage(),
    "/add": const AddPage(),
    "/login": const LoginPage(),
  };

  bool _isLogin = false;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '密码管理器',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // routes: {
      //   "/": (context) => const MyHomePage(),
      //   "/add": (context) => const AddPage(),
      // },
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) {
            // return _pages[settings.name]!;
            // if (!_isLogin) {
            //   return const LoginPage();
            // }

            // await SharedPreferences.getInstance();

            return _pages[settings.name]!;
          },
        );
      },
      // home: const MyHomePage(),
    );
  }
}
