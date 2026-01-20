import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stream4videos/core/utils/routes/routes_name.dart';
import 'package:stream4videos/core/widget/common_help_option_tile.dart';
import 'package:stream4videos/core/widget/common_screen_container.dart';
import 'package:stream4videos/features/home/presentation/notifier/help_support_notifer.dart';
import 'package:stream4videos/l10n/app_localizations.dart';

class HelpCenterScreen extends HookConsumerWidget {
  const HelpCenterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final helpState = ref.watch(helpSupportNotifierProvider);
    final notifier = ref.read(helpSupportNotifierProvider.notifier);

    useEffect(() {
      Future.microtask(() {
        if (ref.read(helpSupportNotifierProvider).data == null) {
          notifier.helpSupportApi();
        }
      });
      return null;
    }, []);
    final list = helpState.data?.data ?? [];
final t=AppLocalizations.of(context)!;
    return SafeArea(
      top: false,
      child: Scaffold(
        body: CommonScreenContainer(
          title: t.help_title,
          scrollable: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // AppSizes.spaceH(10),

              // CommonHelpOptionTile(
              //   icon: Icons.chat_bubble_outline,
              //   title: "Chat with us",
              //   onTap: () {
              //     // TODO: Open chat screen
              //   },
              // ),

              helpState.isLoading?Center(child: CircularProgressIndicator(),):
                  helpState.data?.data==null?SizedBox.shrink():
                   ListView.builder(
                       itemCount: list.length,
                       padding: EdgeInsets.zero,
                       shrinkWrap: true,
                       physics: NeverScrollableScrollPhysics(),
                       itemBuilder: (context,index){
                         final item = list[index];


                         return CommonHelpOptionTile(
                             icon: getIconBySlug(item.slug),
                             title: item.title ?? "",
                             onTap: (){
                               context.push(
                                 RoutesName.helpDetailScreen,
                                 extra: {
                                   "title": item.title ?? "",
                                   "content": item.content ?? "",
                                 },                               );
                             }
                         );


                       })

              // CommonHelpOptionTile(
              //   icon: Icons.privacy_tip_outlined,
              //   title: "Privacy Policy",
              //   onTap: () {
              //     // context.push(RoutesName.privacyPolicyScreen);
              //   },
              // ),
              //
              // CommonHelpOptionTile(
              //   icon: Icons.description_outlined,
              //   title: "Terms & Conditions",
              //   onTap: () {
              //     // context.push(RoutesName.termsConditionScreen);
              //   },
              // ),
              //
              // CommonHelpOptionTile(
              //   icon: Icons.help_outline,
              //   title: "FAQ",
              //   onTap: () {
              //     // context.push(RoutesName.faqScreen);
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }

  IconData getIconBySlug(String? slug) {
    final key = slug?.toLowerCase().trim() ?? "";
    switch (key) {
      case "about-us":
        return Icons.info_outline;

      case "help-support":
        return Icons.headset_mic_outlined;

      case "privacy-policy":
        return Icons.privacy_tip_outlined;

      case "terms-conditions":
        return Icons.description_outlined;

      case "contact-us":
      case "contact us":
        return Icons.call_outlined;

      default:
        return Icons.help_outline;
    }
  }

}

