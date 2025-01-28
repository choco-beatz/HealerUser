class SlotModel {
  final String startTime;
  final String endTime;
  final int amount;
  final String id;

  SlotModel({
    required this.startTime,
    required this.endTime,
    required this.amount,
    required this.id,
  });

  factory SlotModel.fromJson(Map<String, dynamic> json) {
    return SlotModel(
      startTime: json['startTime'] ?? '',
      endTime: json['endTime'] ?? '',
      amount: json['amount'] ?? 0,
      id: json['_id'] ?? '',
    );
  }
}
