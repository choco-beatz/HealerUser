class PaymentResponseModel {
  String orderId;
 int amount;

  PaymentResponseModel({
    required this.orderId,
    required this.amount,
  });

  factory PaymentResponseModel.fromJson(Map<String, dynamic> json) {
    return PaymentResponseModel(
      orderId: json["orderId"], 
      amount: json["amount"]);
  }
}
