import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stream4videos/core/res/app_btn.dart';
import 'package:stream4videos/core/res/app_color.dart';
import 'package:stream4videos/core/res/app_constant.dart';
import 'package:stream4videos/core/res/app_size.dart';
import 'package:stream4videos/core/res/app_text_field.dart';
import 'package:stream4videos/core/res/constant/const_text.dart';
import 'package:stream4videos/core/utils/global_loader/global_loader.dart';
import 'package:stream4videos/core/utils/routes/routes_name.dart';
import 'package:stream4videos/core/widget/common_screen_container.dart';
import 'package:stream4videos/features/profile/presentation/notifier/profile_notifier.dart';
import 'package:stream4videos/generated/assets.dart';
import 'package:stream4videos/l10n/app_localizations.dart';

class EditProfileScreen extends HookConsumerWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final t=AppLocalizations.of(context)!;
    final profileState = ref.watch(profileNotifierProvider);
    final profile = profileState.profile?.profile;
    final nameController = useTextEditingController(
      text: profile?.name ?? "",
    );

    final emailController = useTextEditingController(
      text: profile?.email ?? "",
    );

    return SafeArea(
      top: false,
      child:Scaffold(
        resizeToAvoidBottomInset: false,
        body:CommonScreenContainer(
          title: t.profile_edit_title,
          scrollable: false,

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppSizes.spaceH(20),
              Center(
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Container(
                      width: 110.w,
                      height: 110.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.textHint,
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.textPrimary.withAlpha(30),
                            blurRadius: 12,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child:ClipOval(
                        child: profile?.image != null && profile!.image!.isNotEmpty
                            ? Image.network(
                          profile.image!,
                          fit: BoxFit.cover,
                          width: 80.w,
                          height: 80.h,
                          errorBuilder: (_, __, ___) {
                            return Image.asset(
                              Assets.imageNoCustomerImage,
                              fit: BoxFit.cover,
                            );
                          },
                        )
                            : Image.asset(
                          Assets.imageNoCustomerImage,
                          fit: BoxFit.cover,
                        ),
                      ),

                    ),

                    /// ✏️ EDIT ICON
                    // GestureDetector(
                    //   onTap: () {
                    //     // TODO: image picker
                    //   },
                    //   child: Container(
                    //     width: 34,
                    //     height: 34,
                    //     decoration: BoxDecoration(
                    //       color: AppColors.primaryBackground,
                    //       shape: BoxShape.circle,
                    //       border: Border.all(
                    //         color: AppColors.textHint,
                    //       ),
                    //     ),
                    //     child: const Icon(
                    //       Icons.camera_alt,
                    //       size: 18,
                    //       color: Colors.white,
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),

              AppSizes.spaceH(35),
              ConstText(
                text:t.profile_registered_mobile,
                color: AppColors.textTertiary,

              ),
              AppSizes.spaceH(02),
              ConstText(
                text: (profile?.mobile != null && profile!.mobile!.isNotEmpty)
                    ? "+91-${profile.mobile}"
                    : t.profile_guest_message,
                color: AppColors.textPrimary,
                fontSize: AppConstant.fontSizeThree,
                fontWeight: FontWeight.w400,
              ),

              AppSizes.spaceH(15),




              /// 📝 NAME FIELD
              AppTextField(
                labelText: t.profile_full_name_label,
                hintText: t.profile_full_name_hint,
                textInputAction: TextInputAction.next,
                controller:nameController ,
                showClearButton: false,
              ),

              AppSizes.spaceH(20),

              /// 📱 MOBILE / EMAIL FIELD
              AppTextField(
                labelText: t.profile_email_label,
                hintText: t.profile_email_hint,
                controller: emailController,
                // initialValue: profile?.email ?? "",
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.done,
                showClearButton: false,
              ),

              // AppSizes.spaceH(40),
               Spacer(),
              AppBtn(
                title: (profile?.mobile == null ||
                    profile!.mobile!.isEmpty)
                    ?t.profile_login_continue
                    : t.profile_save_changes,
                onTap: () async{
                  if (profile?.mobile == null ||
                      profile!.mobile!.isEmpty) {
                    context.pushNamed(RoutesName.loginScreen);
                    return;
                  }
                  final updatedName = nameController.text.trim();
                  final updatedEmail = emailController.text.trim();

                  if (updatedName == profile.name && updatedEmail == profile.email) {
                    context.pop();
                    return;
                  }
                  GlobalLoader.show(context,message: t.profile_updating);
                  await ref.read(profileNotifierProvider.notifier).updateProfile(
                    name: updatedName,
                    email: updatedEmail,
                  );
                  // ignore: use_build_context_synchronously
                  GlobalLoader.hide(context);
                },
              ),
              AppSizes.spaceH(40),

            ],
          ),
        ),
      )



    );
  }
}

