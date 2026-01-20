import 'package:flutter_riverpod/legacy.dart';
import 'package:stream4videos/core/helper/network/network_api_service_dio.dart';
import 'package:stream4videos/features/home/data/model/help_support_model.dart';
import 'package:stream4videos/features/home/data/repo_impl/help_support_repo_impl.dart';
import 'package:stream4videos/features/home/domain/repo/help_support_repo.dart';

class HelpSupportState {
  final bool isLoading;
  final HelpSupportModel? data;
  final String? error;

  const HelpSupportState({
    this.isLoading = false,
    this.data,
    this.error,
  });

  HelpSupportState copyWith({
    bool? isLoading,
    HelpSupportModel? data,
    String? error,
  }) {
    return HelpSupportState(
      isLoading: isLoading ?? this.isLoading,
      data: data ?? this.data,
      error: error,
    );
  }
}

final helpSupportNotifierProvider =
StateNotifierProvider<HelpSupportNotifier, HelpSupportState>((ref) {
  return HelpSupportNotifier(HelpSupportRepoImpl(NetworkApiServicesDio(ref)));
});


class HelpSupportNotifier extends StateNotifier<HelpSupportState> {
  final HelpSupportRepo repo;

  HelpSupportNotifier(this.repo) : super(const HelpSupportState());

  Future<void> helpSupportApi() async {
    try {
      state = state.copyWith(isLoading: true, error: null);

      final response = await repo.helpSupportApi();

      state = state.copyWith(
        isLoading: false,
        data: response,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }
}
