import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../settings/data/branch_repository.dart';

class OwnerCabangState {
  final bool isLoading;
  final String? error;
  final List<Map<String, dynamic>> branches;

  OwnerCabangState({
    this.isLoading = false,
    this.error,
    this.branches = const [],
  });

  OwnerCabangState copyWith({
    bool? isLoading,
    String? error,
    List<Map<String, dynamic>>? branches,
  }) {
    return OwnerCabangState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      branches: branches ?? this.branches,
    );
  }
}

class OwnerCabangController extends Notifier<OwnerCabangState> {
  @override
  OwnerCabangState build() {
    Future.microtask(() => loadBranches());
    return OwnerCabangState();
  }

  Future<void> loadBranches() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final branches = await ref.read(branchRepositoryProvider).getBranches();
      state = state.copyWith(isLoading: false, branches: branches);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> addBranch(String name, String address, String phone) async {
    try {
      await ref.read(branchRepositoryProvider).createBranch(name, address, phone);
      await loadBranches(); // Refresh list
    } catch (e) {
      state = state.copyWith(error: e.toString());
      rethrow;
    }
  }
}

final ownerCabangControllerProvider = NotifierProvider<OwnerCabangController, OwnerCabangState>(() {
  return OwnerCabangController();
});
