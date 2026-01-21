import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stream4videos/core/res/constant/const_text.dart';
import 'package:stream4videos/core/widget/common_screen_container.dart';
import 'package:stream4videos/features/home/presentation/notifier/cat_notifier.dart';
import 'package:stream4videos/features/home/presentation/ui/section/home_category/widget/ranked_section_widget.dart';
import 'package:stream4videos/l10n/app_localizations.dart';

class WatchlistScreen extends HookConsumerWidget {
  const WatchlistScreen({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final t=AppLocalizations.of(context)!;

    final state = ref.watch(categoryNotifierProvider);
    final notifier = ref.read(categoryNotifierProvider.notifier);


    final watchlist = state.myWatchListModelData ?? [];

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_){
        if(watchlist.isEmpty){
          notifier.getMyWatchListApi();
        }

      });
      return null;
    }, []);



    return SafeArea(
      top: false,
      child: Scaffold(
        body: CommonScreenContainer(
          title:t.watchlist_title,
          scrollable: false,
          child:watchlist.isEmpty?
          Center(child: ConstText(text:t.watchlist_empty)):
          GridView.builder(
            padding: EdgeInsets.zero,
            // padding: const EdgeInsets.symmetric(horizontal: 14),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 0.65,
            ),
            itemCount: watchlist.length,
            itemBuilder: (context, index) {
              return PosterCard(item: watchlist[index]);
            },
          ),
        ),
      ),
    );
  }
}
