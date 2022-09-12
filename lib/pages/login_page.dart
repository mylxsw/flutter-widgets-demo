import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:widgets/common/login.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        padding: const EdgeInsets.only(top: 100, left: 10, right: 10),
        // color: Colors.white,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/login-background.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            const Text(
              "登录",
              style: TextStyle(
                fontSize: 40,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    color: Colors.black,
                    offset: Offset(1, 1),
                    blurRadius: 1,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Card(
              // margin: const EdgeInsets.all(5),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TextField(
                      decoration: const InputDecoration(
                        labelText: "用户名",
                        contentPadding: EdgeInsets.all(10),
                      ),
                      controller: _usernameController,
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      decoration: const InputDecoration(
                        labelText: "密码",
                        contentPadding: EdgeInsets.all(10),
                      ),
                      controller: _passwordController,
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () async {
                        final prefs = await SharedPreferences.getInstance();
                        prefs.setString("login:status",
                            json.encode(LoginStatus(true, _usernameController.text, DateTime.now())));

                        Navigator.of(context).pushNamed("/");
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                        minimumSize:
                            MaterialStateProperty.all(const Size(200, 50)),
                      ),
                      child: const Text("登录"),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
