// Create post
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:teachers/models/teacher.dart';
import 'package:teachers/services/api_response.dart';

Future<ApiResponse> createTeacher(
    String name, String phone, String? image) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    final response =
        await http.post(Uri.parse("http://192.168.161.37:8000/api/teachers"),
            headers: {'Accept': 'application/json'},
            body: image != null
                ? {'name': name, 'phone': phone, 'image': image}
                : {
                    'name': name,
                    'phone': phone,
                  });

    // here if the image is null we just send the body, if not null we send the image too

    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body);
        break;
      case 422:
        final errors = jsonDecode(response.body)['errors'];
        apiResponse.error = errors[errors.keys.elementAt(0)][0];
        break;

      default:
        print(response.body);
        apiResponse.error = "somethingWentWrong";
        break;
    }
  } catch (e) {
    print(e);
    apiResponse.error = "serverError";
  }
  return apiResponse;
}

// get All Teachers
// get all students
Future<ApiResponse> getTeachers() async {
  ApiResponse apiResponse = ApiResponse();
  try {
    final response = await http
        .get(Uri.parse("http://192.168.161.37:8000/api/teachers"), headers: {
      'Accept': 'application/json',
    });

    switch (response.statusCode) {
      case 200:
        // print(jsonDecode(response.body));
        apiResponse.data =
            jsonDecode(response.body).map((p) => Teacher.fromJson(p)).toList();
        // apiResponse.data = jsonDecode(response.body)['posts'].map((p) => Student.fromJson(p)).toList();
        // we get list of posts, so we need to map each item to post model
        apiResponse.data as List<dynamic>;
        break;

      case 404:
        apiResponse.error = "unauthorized";
        break;
      default:
        apiResponse.error = "somethingWentWrong";
        break;
    }
  } catch (e) {
    print(e);
    apiResponse.error = "serverError";
  }
  return apiResponse;
}

// Edit Teacher ??
Future<ApiResponse> editTeacher(
    int postId, String name, String phone, String? image) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    final response = await http.put(
        Uri.parse("http://192.168.161.37:8000/api/teachers/${postId}"),
        headers: {
          'Accept': 'application/json',
        },
        body: {
          'name': name,
          'phone': phone,
          'image': image,
        });

    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body);
        break;
      case 422:
        final errors = jsonDecode(response.body)['errors'];
        apiResponse.error = errors[errors.keys.elementAt(0)][0];
        break;

      default:
        print(response.body);
        apiResponse.error = "somethingWentWrong";
        break;

    }
  } catch (e) {
    print(e);
    apiResponse.error = "serverError";
  }
  return apiResponse;
}

// Get base64 encoded image
String? getStringImage(File? file) {
  if (file == null) return null;
  return base64Encode(file.readAsBytesSync());
}

//Delete TeachEr

// Delete post
Future<ApiResponse> deleteTeacher(int postId) async {
  ApiResponse apiResponse = ApiResponse();
  try {
  
    final response = await http.delete(Uri.parse("http://192.168.161.37:8000/api/teachers/${postId}"),
    headers: {
      'Accept': 'application/json',
     
    });

    switch(response.statusCode){
       case 200:
        apiResponse.data = jsonDecode(response.body);
        break;
      case 422:
        final errors = jsonDecode(response.body)['errors'];
        apiResponse.error = errors[errors.keys.elementAt(0)][0];
        break;

      default:
        print(response.body);
        apiResponse.error = "somethingWentWrong";
        break;

    }
  }
  catch (e){
    apiResponse.error = "serverError";
  }
  return apiResponse;
}

