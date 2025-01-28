class TherapistProfile {
  final String id;
  final String name;
  final String qualification;
  final String specialization;
  final int experience;
  final String bio;

  TherapistProfile({
    required this.id,
    required this.name,
    required this.qualification,
    required this.specialization,
    required this.experience,
    this.bio = '',
  });

  factory TherapistProfile.fromJson(Map<String, dynamic> json) {
    return TherapistProfile(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      qualification: json['qualification'] ?? '',
      specialization: json['specialization'] ?? '',
      experience: json['experience'] ?? 0,
      bio: json['bio'] ?? '',
    );
  }
}

class TherapistData {
  final String id;
  final String email;
  final String image;
  final TherapistProfile profile;

  TherapistData({
    required this.id,
    required this.email,
    required this.image,
    required this.profile,
  });

  factory TherapistData.fromJson(Map<String, dynamic> json) {
    return TherapistData(
      id: json['_id'] ?? '',
      email: json['email'] ?? '',
      image: json['image'] ?? '',
      profile: TherapistProfile.fromJson(json['profile'] ?? {}),
    );
  }
}

class AppointmentModel {
  final String id;
  final TherapistData therapist;
  final String startTime;
  final String endTime;
  final int amount;
  final String status;
  final String date;

  AppointmentModel({
    required this.id,
    required this.therapist,
    required this.startTime,
    required this.endTime,
    required this.amount,
    required this.status,
    required this.date,
  });

  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel(
      id: json['_id'] ?? '',
      therapist: TherapistData.fromJson(json['therapist'] ?? {}),
      startTime: json['startTime'] ?? '',
      endTime: json['endTime'] ?? '',
      amount: json['amount'] ?? 0,
      status: json['status'] ?? '',
      date: json['date'] ?? '',
    );
  }
}