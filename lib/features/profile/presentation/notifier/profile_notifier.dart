import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hooks_riverpod/legacy.dart';
import 'package:stream4videos/core/helper/network/network_api_service_dio.dart';
import 'package:stream4videos/features/profile/data/model/profile_model.dart';
import 'package:stream4videos/features/profile/data/repo_impl/pofile_repo_impl.dart';
import 'package:stream4videos/features/profile/domain/repo/profile_repo.dart';
import 'package:stream4videos/features/share_pref/user_provider.dart';

class ProfileState {
  final bool isLoading;
  final ProfileModel? profile;

  const ProfileState({this.isLoading = false, this.profile});

  ProfileState copyWith({bool? isLoading, ProfileModel? profile}) {
    return ProfileState(
      isLoading: isLoading ?? this.isLoading,
      profile: profile ?? this.profile,
    );
  }
}

final profileNotifierProvider =
    StateNotifierProvider<ProfileNotifier, ProfileState>((ref) {
      return ProfileNotifier(ProfileRepoImpl(NetworkApiServicesDio(ref)), ref);
    });

class ProfileNotifier extends StateNotifier<ProfileState> {
  final ProfileRepo repo;
  final Ref ref;

  ProfileNotifier(this.repo, this.ref) : super(const ProfileState());

  Future<void> getProfile() async {
    try {
      state = state.copyWith(isLoading: true);
      final userState = ref.read(userProvider.notifier);

      final userid = userState.userId;
      final deviceId = userState.deviceId;
      final isGuest = userState.isGuest;
      final token = userState.token;
      if (isGuest == true || userid == null || userid.isEmpty) {
        state = state.copyWith(isLoading: false, profile: null);
        return;
      }

      final profile = await repo.getProfileApi(
        userid.toString(),
        deviceId.toString(),
        token.toString(),
      );

      if (profile.success == true) {
        state = state.copyWith(isLoading: false, profile: profile);
        final hasPlan =
            profile.profile?.subscription.toString().toLowerCase() == "yes" &&
            profile.profile?.subscriptionData != null;

        await userState.updatePlanStatus(hasPlan);
      } else {
        state = state.copyWith(isLoading: false, profile: null);
      }
    } catch (e) {
      state = state.copyWith(isLoading: false);
      // rethrow;
    }
  }

  void clearProfile() {
    state = const ProfileState();
  }

  Future<void> updateProfile({String? name, String? email}) async {
    try {
      state = state.copyWith(isLoading: true);

      final userId = ref.read(userProvider.notifier).userId;

      final updatedProfile = await repo.editProfileApi(
        userId: userId.toString(),
        name: name,
        email: email,
      );
      if (updatedProfile["success"] == true) {
        getProfile();
        state = state.copyWith(isLoading: false);
      } else {
        state = state.copyWith(isLoading: false);
      }
    } catch (e) {
      state = state.copyWith(isLoading: false);
      rethrow;
    }
  }

  String get deviceId => state.profile?.profile?.deviceId ?? "";
  String get mobileNumber => state.profile?.profile?.mobile ?? "";
  String get userSubscription => state.profile?.profile?.subscription ?? "";
}
