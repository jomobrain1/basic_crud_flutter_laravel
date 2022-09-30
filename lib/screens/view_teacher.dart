import 'package:flutter/material.dart';
import 'package:teachers/constants/widgets.dart';
import 'package:teachers/models/teacher.dart';
import 'package:teachers/screens/add_teacher.dart';
import 'package:teachers/screens/edit_teacher.dart';
import 'package:teachers/services/api_response.dart';
import 'package:teachers/services/teacher_service.dart';

class ViewTeacher extends StatefulWidget {
  ViewTeacher({Key? key}) : super(key: key);

  @override
  State<ViewTeacher> createState() => _ViewTeacherState();
}

class _ViewTeacherState extends State<ViewTeacher> {
  List<dynamic> _teacherList = [];
  bool _loading = true;
  // get all posts
  Future<void> retrieveTeachers() async {
    ApiResponse response = await getTeachers();

    if (response.error == null) {
      // print("No Error");
      setState(() {
        _teacherList = response.data as List<dynamic>;
        _loading = _loading ? !_loading : _loading;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${response.error}'),
      ));
    }
  }

  @override
  void initState() {
    retrieveTeachers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: constantAppBar('Teacher', true, Colors.blue, 6),
      body:   _loading
        ? Center(child: CircularProgressIndicator()):
        RefreshIndicator(
              child: ListView.builder(
                itemCount: _teacherList.length,
                itemBuilder: (BuildContext context, int index) {
                  Teacher teacher = _teacherList[index];
                  return ListTile(
                    title: Text('${teacher.name}'),
                    subtitle: Text('${teacher.phone}'),
                    trailing: IconButton(
                      onPressed: (){
                            //     Navigator.push(context, MaterialPageRoute(builder: (context) {
                            //     return AddTeacher(
                                 
                            //       title: 'Edit Teacher',
                            //       teacher: teacher,
                                   
                            //     );
                            //  }));
                              Navigator.push(context, MaterialPageRoute(builder: (context) {
                                return EditTeacher(
                                  id: teacher.id,
                                  title: 'Edit Teacher',
                                  name: teacher.name,
                                  phone: teacher.phone,
                                  
                                  
                                   
                                );
                             }));
                      },
                       icon: Icon(Icons.edit)
                       ),
                    leading: CircleAvatar(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                          // child:Image.network('${student.image}')
                        child:teacher.image != null ?Image.network('${teacher.image}'):null  ,
                       ),
                    ),
                  );
                },
              ),
              onRefresh: () {
                return retrieveTeachers();
              }
        ),
    );
  }
}