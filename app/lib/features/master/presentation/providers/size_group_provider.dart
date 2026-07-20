import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/size_group_model.dart';
import '../../data/size_group_repository.dart';

final sizeGroupListProvider = AsyncNotifierProvider<SizeGroupListNotifier, List<SizeGroupModel>>(() {
  return SizeGroupListNotifier();
});

class SizeGroupListNotifier extends AsyncNotifier<List<SizeGroupModel>> {
  @override
  Future<List<SizeGroupModel>> build() async {
    return ref.watch(sizeGroupRepositoryProvider).getSizeGroups();
  }

  Future<void> addSizeGroup(SizeGroupModel sizeGroup) async {
    state = const AsyncValue.loading();
    try {
      await ref.read(sizeGroupRepositoryProvider).createSizeGroup(sizeGroup);
      ref.invalidateSelf();
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> updateSizeGroup(SizeGroupModel sizeGroup) async {
    state = const AsyncValue.loading();
    try {
      await ref.read(sizeGroupRepositoryProvider).updateSizeGroup(sizeGroup);
      ref.invalidateSelf();
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> deleteSizeGroup(String id) async {
    state = const AsyncValue.loading();
    try {
      await ref.read(sizeGroupRepositoryProvider).deleteSizeGroup(id);
      ref.invalidateSelf();
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
