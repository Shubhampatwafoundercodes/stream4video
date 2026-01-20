import 'package:hooks_riverpod/legacy.dart';

class HomeState {
  final bool isSticky;
  final int selectedCategory;

  const HomeState({
    this.isSticky = false,
    this.selectedCategory = 0,
  });

  HomeState copyWith({bool? isSticky, int? selectedCategory}) {
    return HomeState(
      isSticky: isSticky ?? this.isSticky,
      selectedCategory: selectedCategory ?? this.selectedCategory,
    );
  }
}

class HomeStateNotifier extends StateNotifier<HomeState> {
  HomeStateNotifier() : super(const HomeState());

  void updateSticky(bool v) {
    if (state.isSticky != v) {
      state = state.copyWith(isSticky: v);
    }
  }

  void updateCategory(int index) {
    state = state.copyWith(selectedCategory: index);
  }
}

final homeProvider =
StateNotifierProvider<HomeStateNotifier, HomeState>((ref) {
  return HomeStateNotifier();
});
