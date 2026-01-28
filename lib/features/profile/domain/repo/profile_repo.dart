
import 'package:stream4videos/features/profile/data/model/profile_model.dart';

abstract class ProfileRepo{

  Future<ProfileModel> getProfileApi(String userId,String deviceId,String?token);
  Future<dynamic> editProfileApi({
    required String userId,
    String? name,
    String? email,
  });


}