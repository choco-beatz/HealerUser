import 'package:healer_user/constants/constant.dart';

const registerationUrl = '${baseUrl}auth/register';
const otpUrl = '${baseUrl}auth/verify-otp';
const loginUrl = '${baseUrl}auth/login';
const resentOtpUrl = '${baseUrl}auth/resend-otp';
const listTherapistUrl = '${baseUrl}user/therapists';
const requestSentUrl = '${baseUrl}requests';
const requestStatusUrl = '${baseUrl}requests/client?status=';
const getSlotsUrl = '${baseUrl}slots/';
const confirmSlotsUrl = '${baseUrl}appointment/book/';
const slotStatusUrl = '${baseUrl}appointment/client?status=';
const initiatePaymentUrl = '${baseUrl}payment/initiate';
const verifyPaymentUrl = '${baseUrl}payment/verify';
const inboxUrl = '${baseUrl}chats';