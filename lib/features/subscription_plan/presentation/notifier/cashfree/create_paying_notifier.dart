


import 'package:flutter/material.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfcard/cfcardwidget.dart';
import 'package:flutter_cashfree_pg_sdk/api/cferrorresponse/cferrorresponse.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpayment/cfwebcheckoutpayment.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfpaymentgateway/cfpaymentgatewayservice.dart';
import 'package:flutter_cashfree_pg_sdk/api/cfsession/cfsession.dart';
import 'package:flutter_cashfree_pg_sdk/utils/cfenums.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stream4videos/features/profile/presentation/notifier/profile_notifier.dart';
import 'package:stream4videos/features/share_pref/user_provider.dart';
import 'package:stream4videos/features/subscription_plan/data/repo_impl/create_paying_repo_impl.dart';
enum PaymentStatus { idle, loading, success, failed }

class PaymentState {
  final PaymentStatus status;
  final String? message;

  const PaymentState({
    this.status = PaymentStatus.idle,
    this.message,
  });

  PaymentState copyWith({
    PaymentStatus? status,
    String? message,
  }) {
    return PaymentState(
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }
}
final paymentProvider =
StateNotifierProvider<CreatePayingNotifier, PaymentState>((ref) {
  return CreatePayingNotifier(ref);
});

class CreatePayingNotifier extends StateNotifier<PaymentState>{
  final Ref ref;
  CreatePayingNotifier(this.ref) : super(const PaymentState());


  final cfPaymentGatewayService = CFPaymentGatewayService();
  final CFPaymentGatewayService _cfService = CFPaymentGatewayService();
  final CFEnvironment environment = CFEnvironment.SANDBOX;

  CFCardWidget? cfCardWidget;


  Future<void> startPayment({
    required double amount,
    required String planId,
     String? addOnId
  }) async {
    try {
      state = state.copyWith(status: PaymentStatus.loading);

      final user = ref.read(userProvider);
      if (user == null || user.isGuest) {
        throw Exception("User not logged in");
      }

      final userId = user.id;
      final mobile = ref.read(profileNotifierProvider.notifier).mobileNumber;

      if (userId == null  || mobile.isEmpty) {
        throw Exception("User info missing");
      }
      final repo = ref.read(createPayingRepoProvider);

      final body = {
        "user_id": userId,
        "mobile": mobile,
        "amount": amount,
        "plan_id": planId,
      };
      if (addOnId != null && addOnId.isNotEmpty) {
        body["addon_id"] = addOnId;
      }

      debugPrint("🟡 Create payment body: $body");

      final res = await repo.createPayingSession(body);

      debugPrint("🟢 Create payment response: $res");

      if (res == null || res["status"] != true) {
        throw Exception(res?["message"] ?? "Payment init failed");
      }

      final data = res["data"];
      final orderId = data["order_id"].toString();
      final sessionId = data["payment_session_id"].toString();
    _openCashfree(sessionId, orderId);
      state = state.copyWith(
        status: PaymentStatus.idle,
        // orderId: orderId,
        // paymentSessionId: sessionId,
      );

    } catch (e, st) {
      debugPrint("❌ startPayment error: $e\n$st");
      state = state.copyWith(
        status: PaymentStatus.failed,
        message: e.toString(),
      );
    }
  }

  void _openCashfree(String sessionId, String orderId) {
    try {
      _cfService.setCallback(_onPaymentSuccess, _onPaymentError);

      final session = CFSessionBuilder()
          .setEnvironment(environment)
          .setOrderId(orderId)
          .setPaymentSessionId(sessionId)
          .build();

      final payment = CFWebCheckoutPaymentBuilder()
          .setSession(session)
          .build();

      _cfService.doPayment(payment);

    } catch (e) {
      debugPrint("❌ Cashfree init failed: $e");
      state = state.copyWith(
        status: PaymentStatus.failed,
        message: "Payment gateway error",
      );
    }
  }
  Future<void> _onPaymentSuccess(String orderId) async {
    debugPrint("✅ Payment success: $orderId");

    try {
      /// 🔥 VERIFY PAYMENT WITH BACKEND
      final profileNotifier = ref.read(profileNotifierProvider.notifier);

      await profileNotifier.getProfile();

      // final hasPlan =
      //     ref.read(profileNotifierProvider).profile?.hasActivePlan ?? false;
      //
      // ref.read(userProvider.notifier)
      //     .updatePlanStatus(hasPlan);

      state = state.copyWith(
        status: PaymentStatus.success,
        message: "Payment successful",
      );

    } catch (e) {
      debugPrint("❌ verify payment error: $e");
      state = state.copyWith(
        status: PaymentStatus.failed,
        message: "Payment verification failed",
      );
    }
  }

  /// ❌ PAYMENT FAILED
  void _onPaymentError(CFErrorResponse error, String orderId) {
    debugPrint("❌ Payment failed: ${error.getMessage()}");

    state = state.copyWith(
      status: PaymentStatus.failed,
      message: error.getMessage(),
    );
  }






}