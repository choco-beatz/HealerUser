import 'dart:convert';
import 'package:healer_user/model/therapist_model/therapist_model.dart';
import 'package:healer_user/services/api_helper.dart';
import 'package:healer_user/services/endpoints.dart';

Future<List<TherapistModel>> fetchTherapist() async {
  final response = await makeRequest(listTherapistUrl, 'GET');
  if (response == null || response.statusCode != 200) return [];

  try {
    
    final data = jsonDecode(response.body) as Map<String, dynamic>;
    final list = data['therapists'] as List;
    return list
        .map((item) => TherapistModel.fromJson(item as Map<String, dynamic>))
        .toList();
  } catch (e) {
    return [];
  }
}

Future<int> requestSent(String clientId, String therapistId) async {
  final response = await makeRequest(requestSentUrl, 'POST',
      body: jsonEncode({"clientId": clientId, "therapistId": therapistId}));

  return response!.statusCode;
}

Future<List<TherapistModel>> requestStatus(String status) async {
  final response = await makeRequest('$requestStatusUrl$status', 'GET');
  if (response == null || response.statusCode != 200) return [];

  try {
    final data = jsonDecode(response.body) as Map<String, dynamic>;
    final requests = data['requests'] as List;

    return requests
        .map((item) {
          final therapistData = item['therapist'];
          return therapistData != null
              ? TherapistModel.fromJson(therapistData)
              : null;
        })
        .whereType<TherapistModel>()
        .toList();
  } catch (e) {
    return [];
  }
}
