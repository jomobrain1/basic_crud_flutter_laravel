import 'package:flutter/material.dart';

AppBar constantAppBar(String mytitle, bool center, bg, double elevate) {
  return AppBar(
    title: Text(mytitle),
    centerTitle: center,
    backgroundColor: bg,
    elevation: elevate,
  );
}

InputDecoration constantInputDecoration(String mylabel) {
  return InputDecoration(
      labelText: mylabel,
      border: OutlineInputBorder(
          borderSide:
              BorderSide(width: 1, color: Color.fromRGBO(0, 0, 0, 0.38))));
}

TextButton constantTextButton(String label, Function WhenAmPressed) {
  return TextButton(
    child: Text(
      label,
      style: TextStyle(color: Colors.white),
    ),
    style: ButtonStyle(
        backgroundColor:
            MaterialStateColor.resolveWith((states) => Colors.blue),
        padding: MaterialStateProperty.resolveWith(
            (states) => EdgeInsets.symmetric(vertical: 10))),
    onPressed: () => WhenAmPressed(),
  );
}


// BottomNavigationBar constantBottonNavigationBar() {
//   return BottomNavigationBar(
      
//       elevation: 20,
//       currentIndex: currentIndex,
//       onTap: (index) => setState(() => currentIndex = index),
//       backgroundColor: Colors.white,
//       selectedItemColor: Colors.blue[600],
//       unselectedItemColor: Colors.blue[200],
//       iconSize: 25,
//       selectedFontSize: 15,
//       unselectedFontSize: 13,
//       showUnselectedLabels: false,
//       items: [
//         BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
//         BottomNavigationBarItem(icon: Icon(Icons.people), label: ''),
//       ]);
// }
