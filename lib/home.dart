import 'package:flutter/material.dart';
import 'package:teachers/constants/widgets.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: constantAppBar("Home",true,Colors.blue,20.0),
      body: Center(
        child: Text('Home'),
      ),
    );
  }
}