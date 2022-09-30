import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:teachers/constants/widgets.dart';
import 'package:teachers/models/teacher.dart';
import 'package:teachers/screens/view_teacher.dart';
import 'dart:io';

import 'package:teachers/services/api_response.dart';
import 'package:teachers/services/teacher_service.dart';

class AddTeacher extends StatefulWidget {
  final Teacher? teacher;
  final String? title;

  AddTeacher({this.teacher, this.title});

  @override
  State<AddTeacher> createState() => _AddTeacherState();
}

class _AddTeacherState extends State<AddTeacher> {
  @override
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  File? _imageFile;
  bool _loading = false;
  final _picker = ImagePicker();
  Future getImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  //create Teacher
  void _addTeacher() async {
    String? image_save = _imageFile == null ? null : getStringImage(_imageFile);
    ApiResponse response = await createTeacher(
        _nameController.text, _phoneController.text, image_save);

    if (response.error == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('success')));
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return ViewTeacher();
      }));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
    }
  }
  // Edit teacher

  void _editTeacher(int postId) async {
    String? image_save = _imageFile == null ? null : getStringImage(_imageFile);
    ApiResponse response = await editTeacher(
        postId, _nameController.text, _phoneController.text, image_save);
    if (response.error == null) {
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.error}')));
      setState(() {
        _loading = !_loading;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
     if(widget.teacher != null){
      _nameController.text = widget.teacher!.name ?? '';
      _phoneController.text = widget.teacher!.phone ?? '';
      String? image_save = _imageFile == null ? null : getStringImage(_imageFile);
      // _nameController.text = widget.teacher!.name ?? '';
    }
    super.initState();

   
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar:widget.teacher != null? constantAppBar('${widget.title}', false, Colors.blueAccent, 5.0) :constantAppBar('Add Teacher', false, Colors.blueAccent, 5.0),
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              child: ListView(
                scrollDirection: Axis.vertical,
                children: [
                  Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 20),
                            child: TextFormField(
                                controller: _nameController,
                                validator: (val) =>
                                    val!.isEmpty ? 'name required' : null,
                                decoration: constantInputDecoration('name')),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 20),
                            child: TextFormField(
                                controller: _phoneController,
                                validator: (val) =>
                                    val!.isEmpty ? 'phone required' : null,
                                decoration: constantInputDecoration('phone')),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                         Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 200,
                                  decoration: BoxDecoration(
                                      image: _imageFile == null
                                          ? null
                                          : DecorationImage(
                                              image: FileImage(
                                                  _imageFile ?? File('')),
                                              fit: BoxFit.contain)),
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.image,
                                      size: 50,
                                      color: Colors.black38,
                                    ),
                                    onPressed: () {
                                      getImage();
                                    },
                                  ),
                                ),
                          constantTextButton('submit', () {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                _loading = !_loading;
                              });
                              if (widget.teacher == null) {
                                _addTeacher();
                              } else {
                                _editTeacher(widget.teacher!.id ?? 0);
                              }
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return ViewTeacher();
                              }));
                            }
                          })
                        ],
                      ))
                ],
              ),
            ),
    );
  }
}
