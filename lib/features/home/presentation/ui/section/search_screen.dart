import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stream4videos/core/res/app_color.dart';
import 'package:stream4videos/core/res/app_constant.dart';
import 'package:stream4videos/core/res/app_size.dart';
import 'package:stream4videos/core/res/app_text_field.dart';
import 'package:stream4videos/core/res/constant/const_text.dart';
import 'package:stream4videos/core/widget/common_no_data_found.dart';
import 'package:stream4videos/core/widget/common_screen_container.dart';
import 'package:stream4videos/core/widget/shimmer/home_screen_shimmer.dart'
    show SearchScreenShimmer;
import 'package:stream4videos/features/home/data/model/common_model/content_poster_item_model.dart';
import 'package:stream4videos/features/home/presentation/notifier/cat_notifier.dart';
import 'package:stream4videos/features/home/presentation/ui/section/home_category/widget/ranked_section_widget.dart'
    show PosterCard;
import 'package:stream4videos/l10n/app_localizations.dart';

class SearchScreen extends HookConsumerWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = AppLocalizations.of(context)!;
    final categoryState = ref.watch(categoryNotifierProvider);
    final catNot = ref.read(categoryNotifierProvider.notifier);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (categoryState.allSearchItems.isEmpty) {
          catNot.getSubCategories("1", isSearchListDataAdd: true);
        }
      });
      return null;
    }, const []);

    final List<ContentPosterItemModel> listToShow =
        categoryState.searchedItems ?? categoryState.allSearchItems;

    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: AppColors.blackPrimary,
        body: CommonScreenContainer(
          padding: EdgeInsets.zero,
          showBack: false,
          scrollable: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppSizes.spaceH(30),
              AppTextField(
                prefixIcon: Icon(Icons.search, color: Colors.white60, size: 22),
                hintText: t.search_hint,
                showClearButton: false,
                margin: EdgeInsets.all(16.r),
                onChanged: (value) {
                  catNot.searchByTitle(value);
                },
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: ConstText(
                  text: t.search_trending_title,
                  fontSize: AppConstant.fontSizeThree,
                  fontWeight: AppConstant.semiBold,
                ),
              ),
              Expanded(
                child: RefreshIndicator(
                  color: AppColors.textPrimary,
                  backgroundColor: AppColors.blackPrimary,
                  onRefresh: () async {
                    await catNot.getSubCategories(
                      "1",
                      isSearchListDataAdd: true,
                    );
                  },
                  child: categoryState.isSubCatLoading
                      ? ListView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          children: const [
                            // SizedBox(height: 300),
                            SearchScreenShimmer(),
                          ],
                        )
                      : listToShow.isEmpty
                      ? ListView(
                          children: [
                            Center(
                              child: CommonNoDataFound(
                                title: t.search_no_results,
                              ),
                            ),
                          ],
                        )
                      : GridView.builder(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                mainAxisSpacing: 12,
                                crossAxisSpacing: 12,
                                childAspectRatio: 0.65,
                              ),
                          itemCount: listToShow.length,
                          itemBuilder: (context, index) {
                            final item = listToShow[index];

                            return PosterCard(item: item);
                          },
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
