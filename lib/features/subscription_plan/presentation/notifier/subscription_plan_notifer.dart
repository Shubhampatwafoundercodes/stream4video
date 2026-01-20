import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/legacy.dart' show StateNotifierProvider, StateNotifier;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stream4videos/core/helper/network/network_api_service_dio.dart';
import 'package:stream4videos/features/share_pref/user_provider.dart';
import 'package:stream4videos/features/subscription_plan/data/model/plan_add_on_model.dart';
import 'package:stream4videos/features/subscription_plan/data/model/subcription_plans_model.dart' show SubscriptionPlanModel;
import 'package:stream4videos/features/subscription_plan/data/model/user_plan_history_model.dart';
import 'package:stream4videos/features/subscription_plan/data/repo_impl/subscription_repo_impl.dart';
import 'package:stream4videos/features/subscription_plan/domain/repo/subscription_repo.dart';


class SubscriptionState {
  final bool isLoading;
  final SubscriptionPlanModel? plans;
  final PlanAddOnModel? plansAddOnModel;
  final UserPlanHistoryModel? userPlanHistory;


  SubscriptionState({
    this.isLoading = false,
    this.plans,
    this.plansAddOnModel,
    this.userPlanHistory
  });

  SubscriptionState copyWith({
    bool? isLoading,
    SubscriptionPlanModel? plans,
    PlanAddOnModel? plansAddOnModel,
    UserPlanHistoryModel? userPlanHistory,
  }) {
    return SubscriptionState(
      isLoading: isLoading ?? this.isLoading,
      plans: plans ?? this.plans,
      plansAddOnModel: plansAddOnModel ?? this.plansAddOnModel,
      userPlanHistory: userPlanHistory ?? this.userPlanHistory,
    );
  }
}

final subscriptionNotifierProvider =
StateNotifierProvider<SubscriptionNotifier, SubscriptionState>((ref) {
  final api = SubscriptionRepoImpl(NetworkApiServicesDio(ref));
  return SubscriptionNotifier(api,ref);
});


class SubscriptionNotifier extends StateNotifier<SubscriptionState> {
  final SubscriptionRepo _repo;
  final Ref _ref;

  SubscriptionNotifier(this._repo,this._ref) : super(SubscriptionState());

  Future<void> getSubscriptionPlans() async {
    state = state.copyWith(isLoading: true);
    try {
      final res = await _repo.getSubscriptionPlansAPi();
      state = state.copyWith(
        isLoading: false,
        plans: res,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false);
      debugPrint("❌ getSubscriptionPlans error: $e");
    }
  }

  Future<void> getSubscriptionAddOnPlanApi(String planId) async {
    state = state.copyWith(isLoading: true);
    try {
      final res = await _repo.getSubscriptionAddOnPlanApi(planId);
      state = state.copyWith(
        isLoading: false,
        plansAddOnModel: res,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false);
      debugPrint("❌ getSubscriptionPlans error: $e");
    }
  }


  Future<void> getUserPlanHistory() async {
    state = state.copyWith(isLoading: true);
    try {

      final userId=_ref.read(userProvider.notifier).userId;

      final res = await _repo.getUserPlanHistoryApi(userId.toString());
      state = state.copyWith(
        isLoading: false,
        userPlanHistory: res,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false);
      debugPrint("❌ User plan history error: $e");
    }
  }


}
