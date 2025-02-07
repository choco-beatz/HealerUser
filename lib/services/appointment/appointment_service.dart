import 'dart:convert';
import 'dart:developer';

import 'package:healer_user/model/appointment_model/appointment_model.dart';
import 'package:healer_user/model/appointment_model/payment_response_model.dart';
import 'package:healer_user/model/appointment_model/slot_model.dart';
import 'package:healer_user/model/appointment_model/cofirmslot_model.dart';
import 'package:healer_user/services/api_helper.dart';
import 'package:healer_user/services/endpoints.dart';

Future<List<SlotModel>> fetchSlots(String therapistid, String date) async {
  final response = await makeRequest('$getSlotsUrl$therapistid/$date', 'GET');
  if (response == null || response.statusCode != 200) return [];

  try {
    log(response.body);
    final data = jsonDecode(response.body) as Map<String, dynamic>;
    log(date);
    final list = data['availableSlots'] as List;
    return list
        .map((item) => SlotModel.fromJson(item as Map<String, dynamic>))
        .toList();
  } catch (e) {
    log('Error parsing slots data: $e');
    return [];
  }
}

Future<bool> confirmSlots(String therapistid, ConfirmSlotModel slot) async {
  final response = await makeRequest('$confirmSlotsUrl$therapistid', 'POST',
      body: jsonEncode({
        "startTime": slot.startTime,
        "endTime": slot.endTime,
        "amount": slot.amount,
        "date": slot.date
      }));
  if (response == null || response.statusCode != 200) return false;

  try {
    log(response.body);

    return true;
  } catch (e) {
    log('Error parsing slots data: $e');
    return false;
  }
}

Future<List<AppointmentModel>> slotStatus(String status) async {
  final response = await makeRequest('$slotStatusUrl$status', 'GET');
  
  if (response == null || response.statusCode != 200) return [];

  try {
    log(response.body);
    final dynamic decodedData = jsonDecode(response.body);

    if (decodedData is! List) return [];

    return decodedData
        .whereType<Map<String, dynamic>>()
        .map((item) => AppointmentModel.fromJson(item))
        .toList();
  } catch (e) {
    log('Error parsing slots data: $e');
    return [];
  }
}

Future<PaymentResponseModel> initiatePayment(
    String amount, String appointmentId) async {
  final response = await makeRequest(initiatePaymentUrl, 'POST',
      body: jsonEncode({"amount": amount, "appointmentId": appointmentId}));

  if (response == null || response.statusCode != 200) {
    throw Exception('Payment initiation failed');
  }

  try {
    log('body:${response.body}');
    final data = jsonDecode(response.body) as Map<String, dynamic>;
    return PaymentResponseModel.fromJson(data);
  } catch (e) {
    log('Error parsing payment data: $e');
    throw Exception('Payment data parsing failed');
  }
}

Future<bool> verifyPayment(
    String paymentId, String orderId, String signature) async {
  try {
    final response = await makeRequest(verifyPaymentUrl, 'POST',
        body: jsonEncode({
          "paymentId": paymentId,
          "orderId": orderId,
          "signature": signature
        }));

    if (response == null || response.statusCode != 200) {
      log('body:${response!.body}');
      return false;
    }

    log('body:${response.body}');
    return true;
  } catch (e) {
    log('Error parsing payment data: $e');
    return false;
  }
}
