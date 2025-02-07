import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healer_user/bloc/appointment/appointment_bloc.dart';
import 'package:healer_user/constants/space.dart';
import 'package:healer_user/constants/textstyle.dart';
import 'package:healer_user/view/appointment/widgets/field.dart';
import 'package:healer_user/view/appointment/widgets/payment_completed_dialog.dart';
import 'package:healer_user/view/widgets/dialog_button.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

void showPaymentSlotDialog(String id, int amount, BuildContext context) {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  showDialog(
      context: context,
      builder: (context) {
        return BlocListener<AppointmentBloc, AppointmentState>(
          listener: (context, state) {
            if (state is PaymentInitiated && state.paymentResponse != null) {
              log('initiated');
              _initiateRazorpayPayment(
                context,
                state.paymentResponse.amount,
                state.paymentResponse.orderId,
              );
            }
          },
          child: AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              title: const Text(
                "Pay with RazorPay",
                style: smallBold,
                textAlign: TextAlign.center,
              ),
              content: SizedBox(
                  width: 700,
                  child: Form(
                      key: formkey,
                      child: SingleChildScrollView(
                          child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                            buildField(
                                label: "Amount",
                                initialValue: amount.toString()),
                            space,
                            Row(
                              children: [
                                InkWell(
                                    onTap: () {
                                      context.read<AppointmentBloc>().add(
                                          InitiatePaymentEvent(
                                              amount: amount.toString(),
                                              appointmentId: id));
                                    },
                                    child: buildButton(text: 'Confirm')),
                                hSpace,
                                InkWell(
                                    onTap: () => Navigator.of(context).pop(),
                                    child: buildButton(text: 'Cancel')),
                              ],
                            )
                          ]))))),
        );
      });
}

void _initiateRazorpayPayment(
    BuildContext context, int amount, String orderId) {
  try {
    Razorpay razorpay = Razorpay();
    var options = {
      'key': 'rzp_test_ZbZoAjOgS6FA5C',
      'amount': amount,
      'order_id': orderId,
      'name': 'Healer',
      'description': 'Payment for Appointment',
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {
        'contact': '8888888888',
        'email': 'healer.therapyapp@gmail.com'
      },
      'external': {
        'wallets': ['paytm']
      }
    };

    razorpay.on(
        Razorpay.EVENT_PAYMENT_ERROR,
        (PaymentFailureResponse response) =>
            handlePaymentErrorResponse(context, response));

    razorpay.on(
        Razorpay.EVENT_PAYMENT_SUCCESS,
        (PaymentSuccessResponse response) =>
            handlePaymentSuccessResponse(context, response));

    razorpay.on(
        Razorpay.EVENT_EXTERNAL_WALLET,
        (ExternalWalletResponse response) =>
            handleExternalWalletSelected(context, response));

    razorpay.open(options);
  } catch (e) {
    log('Payment initialization failed: $e');
  }
}

void handlePaymentErrorResponse(
    BuildContext context, PaymentFailureResponse response) {
  showLottieDialog(context, "Payment Failed",
      "Code: ${response.code}\nDescription: ${response.message}\nMetadata: ${response.error.toString()}"
      'asset/failed.json');
}

void handlePaymentSuccessResponse(
    BuildContext context, PaymentSuccessResponse response) {
  context.read<AppointmentBloc>().add(VerifyPaymentEvent(
      paymentId: response.paymentId!,
      orderId: response.orderId!,
      signature: response.signature!));
  showLottieDialog(context, "Payment Successful",
      "Payment ID: ${response.paymentId}\nOrder ID: ${response.orderId}\nSignature: ${response.signature}"
      'asset/success.json');
}

void handleExternalWalletSelected(
    BuildContext context, ExternalWalletResponse response) {
  showLottieDialog(
      context, "External Wallet Selected", "${response.walletName}");
}


