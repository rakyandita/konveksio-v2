import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../domain/branch_setting_model.dart';
import '../data/branch_repository.dart';

class SettingsBranchState {
  final bool isLoading;
  final String? error;
  final BranchSettingModel? setting;

  SettingsBranchState({
    this.isLoading = false,
    this.error,
    this.setting,
  });

  SettingsBranchState copyWith({
    bool? isLoading,
    String? error,
    BranchSettingModel? setting,
  }) {
    return SettingsBranchState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      setting: setting ?? this.setting,
    );
  }
}

class SettingsBranchController extends Notifier<SettingsBranchState> {
  @override
  SettingsBranchState build() {
    return SettingsBranchState();
  }

  Future<void> loadSetting(String branchId) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final setting = await ref.read(branchRepositoryProvider).getBranchSetting(branchId);
      state = state.copyWith(isLoading: false, setting: setting);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> updateSetting(BranchSettingModel newSetting) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await ref.read(branchRepositoryProvider).updateBranchSetting(newSetting);
      state = state.copyWith(isLoading: false, setting: newSetting);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}

final settingsBranchControllerProvider = NotifierProvider<SettingsBranchController, SettingsBranchState>(() {
  return SettingsBranchController();
});
