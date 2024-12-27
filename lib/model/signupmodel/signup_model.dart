class SignupModel {
  String email;
  String password;
  String name;

  SignupModel({
    required this.email,
    required this.password,
    required this.name
  });

  factory SignupModel.fromJson(Map<String, dynamic> json) {
    return SignupModel(email: json["email"], password: json["password"], name: json["name"]);
  }
}
