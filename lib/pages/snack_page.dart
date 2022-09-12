import 'package:flutter/material.dart';

class SnackBarPage extends StatelessWidget {
  const SnackBarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.yellow,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      constraints: BoxConstraints.expand(
        height: Theme.of(context).textTheme.headline1!.fontSize! * 1.1 + 200.0,
        width: 200,
      ),
      transform: Matrix4.rotationZ(0.2),
      // alignment: Alignment.center,
      child: ElevatedButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Hello!'),
              action: SnackBarAction(
                label: 'Undo',
                onPressed: () {
                  // Some code to undo the change.
                },
              ),
            ),
          );
        },
        child: const Text("Hello, world"),
      ),
    );
  }
}
