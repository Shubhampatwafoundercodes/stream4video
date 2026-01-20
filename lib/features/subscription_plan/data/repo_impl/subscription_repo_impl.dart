  import 'package:stream4videos/core/helper/api_url/api_urls.dart';
  import 'package:stream4videos/core/helper/network/base_api_service.dart';
  import 'package:stream4videos/features/subscription_plan/data/model/plan_add_on_model.dart';
  import 'package:stream4videos/features/subscription_plan/data/model/user_plan_history_model.dart';
  import 'package:stream4videos/features/subscription_plan/domain/repo/subscription_repo.dart';

  import '../model/subcription_plans_model.dart' show SubscriptionPlanModel;


  class SubscriptionRepoImpl implements SubscriptionRepo {
    final BaseApiServices api;
    SubscriptionRepoImpl(this.api);


    @override
    Future<SubscriptionPlanModel> getSubscriptionPlansAPi()async {
      final url = ApiUrls.subscriptionPlansUrl;
      final data = await api.getGetApiResponse(url);
      return SubscriptionPlanModel.fromJson(data);
    }

    @override
    Future<PlanAddOnModel> getSubscriptionAddOnPlanApi(String planId) async{
      final url = "${ApiUrls.addOnSubscriptionPlansUrl}$planId/addons";
      final data = await api.getGetApiResponse(url);
      return PlanAddOnModel.fromJson(data);
    }

    @override
    Future<UserPlanHistoryModel> getUserPlanHistoryApi(String userId) async{
      final url = "${ApiUrls.plansHistoryUrl}$userId";
      final data = await api.getGetApiResponse(url);
      return UserPlanHistoryModel.fromJson(data);
    }

    }
