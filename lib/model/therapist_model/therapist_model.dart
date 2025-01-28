class TherapistModel {
  final String id;
  final String email;
  final String? role;
  final String? image;
  final String name;
  final String password;
  final String status;
  final String profileId;
  final String qualification;
  final String specialization;
  final int? experience;
  final String bio;

  TherapistModel({
    required this.password,
    required this.id,
    required this.profileId,
    required this.email,
    this.role,
    this.status = '',
    this.image,
    required this.name,
    required this.qualification,
    required this.specialization,
    this.experience,
    this.bio = '',
  });

  factory TherapistModel.fromJson(Map<String, dynamic> json) {
    final profile = json['profile'] ?? {};
    return TherapistModel(
      password: json['password'] ?? '',
      profileId: profile['_id'] ?? '',
      id: json['_id'] ?? '',
      email: json['email'] ?? '',
      role: json['role'] ?? '',
      image: json['image'] ?? '',
      name: profile['name'] ?? '',
      qualification: profile['qualification'] ?? '',
      specialization: profile['specialization'] ?? '',
      experience: profile['experience'] ?? 0,
      bio: profile['bio'] ?? '',
    );
  }
}
