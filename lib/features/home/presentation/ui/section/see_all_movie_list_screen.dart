

import 'package:flutter/material.dart';
import 'package:stream4videos/core/widget/common_screen_container.dart';
import 'package:stream4videos/features/home/data/model/common_model/content_poster_item_model.dart';
import 'package:stream4videos/features/home/presentation/ui/section/home_category/widget/ranked_section_widget.dart';
import 'package:stream4videos/l10n/app_localizations.dart';

class SeeAllMovieListScreen extends StatelessWidget {
  final String title;
  final List<ContentPosterItemModel>? items;

  const SeeAllMovieListScreen({
    super.key,
    required this.title,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    final t=AppLocalizations.of(context)!;
    final safeItems = items ?? [];

    return SafeArea(
      top: false,
      child: Scaffold(
        body: CommonScreenContainer(
          title: title,
          scrollable: false,
          child: safeItems.isEmpty?Text(t.search_no_results)
              :
          GridView.builder(
            padding: EdgeInsets.zero,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 2 / 3,
            ),
            itemCount: safeItems.length,
            itemBuilder: (context, index) {
              return PosterCard(item: safeItems[index]);
            },
          ),
        ),
      ),
    );
  }
}
