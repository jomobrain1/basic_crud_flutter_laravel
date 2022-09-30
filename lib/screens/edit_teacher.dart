import 'package:flutter/material.dart';
import 'package:teachers/constants/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:teachers/constants/widgets.dart';
import 'package:teachers/models/teacher.dart';
import 'package:teachers/screens/view_teacher.dart';
import 'dart:io';

import 'package:teachers/services/api_response.dart';
import 'package:teachers/services/teacher_service.dart';

class EditTeacher extends StatefulWidget {
  // final Teacher? teacher;
  int? id;
  final String? title;
  final String? name;
  final String? phone;

  EditTeacher({this.id, this.title, this.name, this.phone});

  @override
  State<EditTeacher> createState() => _EditTeacherState();
}

class _EditTeacherState extends State<EditTeacher> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
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

  void _editTeacher(int postId) async {
    String? image_save = _imageFile == null ? null : getStringImage(_imageFile);
    ApiResponse response = await editTeacher(
        postId, _nameController.text, _phoneController.text, image_save);

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

  //Delete
  void _handleDeletePost(int postId) async {
    ApiResponse response = await deleteTeacher(postId);
    if (response.error == null) {
      // retrievePosts();
      print('No error');
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

  @override
  void initState() {
    setState(() {
      _nameController.text = "${widget.name}";
      _phoneController.text = "${widget.phone}";
      _idController.text = "${widget.id}";
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: constantAppBar("${widget.title}", true, Colors.black, 10),
      body: Container(
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
                    //tobeRemoved
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 20),
                      child: TextFormField(
                          controller: _idController,
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
                                  image: FileImage(_imageFile ?? File('')),
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
                        // setState(() {
                        //   _loading = !_loading;
                        // });
                        _editTeacher(widget.id!);
                      }
                    }),
                    SizedBox(
                      height: 20,
                    ),
                    constantTextButton("Delete", () {
                      _handleDeletePost(widget.id!);
                    })
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
