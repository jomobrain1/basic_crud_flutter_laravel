import 'package:flutter/material.dart';
import 'package:teachers/constants/widgets.dart';
import 'package:teachers/home.dart';
import 'package:teachers/screens/add_teacher.dart';
import 'package:teachers/screens/view_teacher.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: myApp())
      
      );
}

class myApp extends StatefulWidget {
  @override
  State<myApp> createState() => _myAppState();
}

class _myAppState extends State<myApp> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: currentIndex == 0 ? Home() : ViewTeacher(),
       floatingActionButton: FloatingActionButton(
        onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return AddTeacher();
        }));
      },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        notchMargin: 5,
        elevation: 10,
        clipBehavior: Clip.antiAlias,
        shape: CircularNotchedRectangle(),
        child: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home),label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.person), label:'')
          ],
          currentIndex: currentIndex,
          onTap: (val) {
            setState(() {
              currentIndex = val;
            });
          },
        ),
      ),
     
    );
  }
}
