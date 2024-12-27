import 'dart:convert';
import 'dart:developer';
import 'package:healer_user/model/therapistmodel/therapist_model.dart';
import 'package:healer_user/services/api_helper.dart';
import 'package:healer_user/services/endpoints.dart';

Future<List<TherapistModel>> fetchTherapist() async {
  final response = await makeRequest(listTherapistUrl, 'GET');
  if (response == null || response.statusCode != 200) return [];

  try {
    log(response.body);
    final data = jsonDecode(response.body) as Map<String, dynamic>;
    final list = data['therapists'] as List;
    return list
        .map((item) => TherapistModel.fromJson(item as Map<String, dynamic>))
        .toList();
  } catch (e) {
    log('Error parsing therapist list: $e');
    return [];
  }
}

Future<int> requestSent(String clientId, String therapistId) async {
  log('client : $clientId therapist : $therapistId');
  final response = await makeRequest(requestSentUrl, 'POST',
      body: jsonEncode({"clientId": clientId, "therapistId": therapistId}));
  log(response!.statusCode.toString());

  return response.statusCode;
}

Future<List<TherapistModel>> requestStatus(String status) async {
  log('$requestSentUrl$status');
  final response = await makeRequest('$requestStatusUrl$status', 'GET');
  // log(response!.body.toString());
  if (response == null || response.statusCode != 200) return [];

  try {
    log(response.body);
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
    log('Error parsing therapist list: $e');
    return [];
  }
}
