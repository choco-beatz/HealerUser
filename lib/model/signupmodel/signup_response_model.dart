class SignupResponseModel {
  String userId;
  String? token;
  String role;
 
  bool isVerified;

  SignupResponseModel(
      {required this.userId,
      this.token,
      
      required this.role,
      required this.isVerified});

  factory SignupResponseModel.fromJson(Map<String, dynamic> json) {
    return SignupResponseModel(
        userId: json["userId"] ?? '',
        token: json["token"],
        
        role: json["role"] ?? '',
        isVerified: json["isVerified"] ?? false);
  }
}
