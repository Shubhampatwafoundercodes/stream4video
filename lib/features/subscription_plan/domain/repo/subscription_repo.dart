
import 'package:stream4videos/features/subscription_plan/data/model/plan_add_on_model.dart';
import 'package:stream4videos/features/subscription_plan/data/model/subcription_plans_model.dart';
import 'package:stream4videos/features/subscription_plan/data/model/user_plan_history_model.dart';

abstract class SubscriptionRepo {
  Future<SubscriptionPlanModel> getSubscriptionPlansAPi();

  Future<PlanAddOnModel> getSubscriptionAddOnPlanApi(String planId);
  Future<UserPlanHistoryModel> getUserPlanHistoryApi(String userId);
}