class Teacher {
  int? id;
  String? name; 
  String? phone;
  String? image;

  Teacher({this.id, this.name,  this.phone,this.image});

  // function to convert json data to user model
  factory Teacher.fromJson(Map<String, dynamic> json) {
    return Teacher(
        id: json['id'],
        name: json['name'],
        phone: json['phone'],
        image: json['image'],
        );
  }
}
