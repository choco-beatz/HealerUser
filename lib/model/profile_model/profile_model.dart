class UserModel {
  final String id;
  final String email;
  final String role;
  final UserProfile profile;
  final String? profileModel; // Made nullable
  final String image; // Made nullable
  final bool isVerified;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  UserModel({
    required this.id,
    required this.email,
    required this.role,
    required this.profile,
    this.profileModel, // No longer required
    required this.image, // No longer required
    required this.isVerified,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["_id"] ?? '',
      email: json["email"] ?? '',
      role: json["role"] ?? '',
      profile: UserProfile.fromJson(json["profile"] ?? {}),
      profileModel: json["profileModel"], // Can be null
      image: json["image"], // Can be null
      isVerified: json["isVerified"] ?? false,
      createdAt:
          DateTime.parse(json["createdAt"] ?? DateTime.now().toIso8601String()),
      updatedAt:
          DateTime.parse(json["updatedAt"] ?? DateTime.now().toIso8601String()),
      v: json["__v"] ?? 0,
    );
  }
}

class UserProfile {
  final String id;
  final String name;
  final String gender; // Made nullable
  final int age;
  final int v;

  UserProfile({
    required this.id,
    required this.name,
    required this.gender, // No longer required
    required this.age,
    required this.v,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json["_id"] ?? '',
      name: json["name"] ?? '',
      gender: json["gender"] ?? '', // Can be null
      age: json["age"] ?? 0,
      v: json["__v"] ?? 0,
    );
  }
}
