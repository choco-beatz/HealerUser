class TherapistModel {
  String id;
  String email;
  String role;
  String profileModel;
  String image;
  bool isVerified;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  TherapistProfile profile;

  TherapistModel({
    required this.id,
    required this.email,
    required this.role,
    required this.profileModel,
    required this.image,
    required this.isVerified,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.profile,
  });

  factory TherapistModel.fromJson(Map<String, dynamic> json) {
    return TherapistModel(
      id: json["_id"],
      email: json["email"],
      role: json["role"],
      profileModel: json["profileModel"],
      image: json["image"],
      isVerified: json["isVerified"],
      createdAt: DateTime.parse(json["createdAt"]),
      updatedAt: DateTime.parse(json["updatedAt"]),
      v: json["__v"],
      profile: TherapistProfile.fromJson(json["profile"]),
    );
  }
}

class TherapistProfile {
  String id;
  String name;
  String qualification;
  String specialization;
  int experience;
  String bio;
  int v;

  TherapistProfile({
    required this.id,
    required this.name,
    required this.qualification,
    required this.specialization,
    required this.experience,
    required this.bio,
    required this.v,
  });

  factory TherapistProfile.fromJson(Map<String, dynamic> json) {
    return TherapistProfile(
      id: json["_id"],
      name: json["name"],
      qualification: json["qualification"],
      specialization: json["specialization"],
      experience: json["experience"],
      bio: json["bio"],
      v: json["__v"],
    );
  }
}