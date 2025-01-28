class SignupModel {
 final String email;
  final String password;
  final String name;
  final String gender;
  final String? image;
  final int age;

  SignupModel({required this.age, this.image, required this.gender, 
      required this.email, required this.password, required this.name});

  factory SignupModel.fromJson(Map<String, dynamic> json) {
    return SignupModel(
        email: json["email"], 
        age: json["age"], 
        gender: json["gender"], 
        image: json['image'] ?? '',
        password: json["password"], 
        name: json["name"]);
  }
}
