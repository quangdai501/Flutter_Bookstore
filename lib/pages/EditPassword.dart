import 'package:flutter/material.dart';


class EditPassword extends StatefulWidget {
  const EditPassword({Key? key}) : super(key: key);

  @override
  EditPasswordState createState() => EditPasswordState();
}

class EditPasswordState extends State<EditPassword> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Builder(
        builder: (context) {
          return Text("Thông tin cá nhân");
        },
      ),
    );
  }
}
