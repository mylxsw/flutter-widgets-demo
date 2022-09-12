import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:widgets/pages/favorite_page.dart';
import 'package:widgets/pages/setting_page.dart';

import 'add_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Map<String, Widget> _pages = {
    "favorite": const FavoritePage(),
    "setting": const SettingPage(),
  };

  String _selectedIndex = "favorite";
  String _title = "收藏夹";

  late Widget _appbarTitle;

  _MyHomePageState() {
    _appbarTitle = Text(_title);
  }

  Icon _searchIcon = const Icon(Icons.search);

  void _onMenuItemTapped(String index, String title) {
    setState(() {
      _selectedIndex = index;
      _title = title;
      _appbarTitle = Text(_title);
    });
  }

  void _onSearchIconTapped() {
    setState(() {
      if (_searchIcon.icon == Icons.search) {
        _searchIcon = const Icon(Icons.close);

        var focusNode = FocusNode();
        var searchController = TextEditingController();
        _appbarTitle = ListTile(
          leading: const Icon(Icons.search, color: Colors.white, size: 28),
          title: TextField(
            controller: searchController,
            focusNode: focusNode,
            onChanged: (value) {
              print(value);
            },
            onEditingComplete: () {
              print("onEditingComplete: ${searchController.text}");
            },
            decoration: const InputDecoration(
              hintText: "你想搜索点啥子？",
              border: InputBorder.none,
              hintStyle: TextStyle(
                color: Colors.white,
                fontStyle: FontStyle.italic,
                fontSize: 18,
              ),
            ),
            style: const TextStyle(color: Colors.white),
          ),
        );

        focusNode.requestFocus();
      } else {
        _searchIcon = const Icon(Icons.search);
        _appbarTitle = Text(_title);
      }
    });
  }

  void _openMessageCenter() {
    print("open message center");
  }

  void _openAccountCenter() {
    print("open account center");
  }

  void _accountLogout() {
    print("account logout");
    Navigator.of(context).pushNamed("/login");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _appbarTitle,
        actions: [
          IconButton(
            icon: _searchIcon,
            onPressed: _onSearchIconTapped,
          )
        ],
      ),
      body: _pages[_selectedIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // var result = await Navigator.of(context)
          //     .push(MaterialPageRoute(builder: (context) => const AddPage()));

          var result =
              await Navigator.of(context).pushNamed("/add", arguments: "张三");

          if (result != null && result is AddResult) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Name: ${result.name}, Age: ${result.age}"),
            ));
          }
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.star),
              onPressed: () {
                _onMenuItemTapped("favorite", "收藏夹");
              },
            ),
            const SizedBox(),
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                _onMenuItemTapped("setting", "设置");
              },
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: Colors.blue),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("密码管理器",
                      style: TextStyle(color: Colors.white, fontSize: 24)),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      // Container(
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(100),
                      //     image: const DecorationImage(
                      //       image: CachedNetworkImageProvider(
                      //           "http://t13.baidu.com/it/u=2296451345,460589639&fm=224&app=112&f=JPEG?w=500&h=500"),
                      //       fit: BoxFit.cover,
                      //     ),
                      //   ),
                      //   width: 80,
                      //   height: 80,
                      // ),
                      CachedNetworkImage(
                        imageUrl:
                            "http://t13.baidu.com/it/u=2296451345,460589639&fm=224&app=112&f=JPEG?w=500&h=500",
                        imageBuilder: (context, imageProvider) => Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                      const SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          SizedBox(width: 10),
                          Text("次奥o(*////▽////*)q",
                              style: TextStyle(color: Colors.white)),
                          SizedBox(height: 10),
                          Text("ciaoxiuxiu@google.com",
                              style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            ListTile(
                leading: const Icon(Icons.message),
                title: const Text("站内信"),
                onTap: () => _openMessageCenter()),
            ListTile(
              leading: const Icon(Icons.account_circle),
              title: const Text("个人中心"),
              onTap: () => _openAccountCenter(),
            ),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text("退出"),
              onTap: () => _accountLogout(),
            )
          ],
        ),
      ),
    );
  }
}
