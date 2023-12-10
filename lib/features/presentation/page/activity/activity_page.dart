
import 'package:flutter/material.dart';
import 'package:proyecto_c2/consts.dart';

class ActivityPage extends StatelessWidget {
  const ActivityPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroundColor,
      appBar: AppBar(
        backgroundColor: backGroundColor,
        title: Text("Actividad", style: TextStyle(color: primaryColor),),
      ),
    );
  }
}
