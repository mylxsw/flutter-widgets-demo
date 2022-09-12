import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Page'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("厉害了"),
            ),
            AddPageFormWidget(),
          ],
        ),
      ),
    );
  }
}

class AddResult {
  final String name;
  final int age;

  AddResult(this.name, this.age);
}

class AddPageFormWidget extends StatefulWidget {
  const AddPageFormWidget({super.key});

  @override
  State<AddPageFormWidget> createState() => _AddPageFormWidgetState();
}

class _AddPageFormWidgetState extends State<AddPageFormWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                  hintText: "请输入姓名",
                  label: Text("姓名"),
                  prefixIcon: Icon(Icons.person)),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "姓名不能为空";
                }

                return null;
              },
              controller: _nameController,
            ),
            TextFormField(
              decoration: InputDecoration(
                  hintText: "请输入年龄",
                  prefixIcon: Icon(Icons.numbers),
                  label: Text("年龄")),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              controller: _ageController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "年龄不能为空";
                }

                if (int.tryParse(value) == null) {
                  return "年龄必须是数字";
                }

                if (int.parse(value) > 100 || int.parse(value) < 1) {
                  return "年龄不能大于100或小于1";
                }

                return null;
              },
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  Navigator.of(context).pop(AddResult(
                      _nameController.text, int.parse(_ageController.text)));
                }
              },
              child: Text("保存"),
            ),
          ],
        ));
  }
}
