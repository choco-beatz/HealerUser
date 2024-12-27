// ignore_for_file: public_member_api_docs, sort_constructors_first
class ConfirmSlotModel {
  String startTime;
  String endTime;
  int amount;
  String date;

  ConfirmSlotModel({
    required this.startTime,
    required this.endTime,
    required this.amount,
    required this.date,
  });

  factory ConfirmSlotModel.fromJson(Map<String, dynamic> json) {
    return ConfirmSlotModel(startTime: json["startTime"], endTime: json["endTime"],date: json["date"], amount: json["amount"]);
  }
}
