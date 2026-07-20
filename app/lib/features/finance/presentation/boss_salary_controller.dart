import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../auth/presentation/auth_controller.dart';
import '../domain/salary_record_model.dart';
import '../data/finance_repository.dart';

class BossSalaryState {
  final bool isLoading;
  final String? error;
  final List<SalaryRecordModel> history;

  BossSalaryState({
    this.isLoading = false,
    this.error,
    this.history = const [],
  });

  BossSalaryState copyWith({
    bool? isLoading,
    String? error,
    List<SalaryRecordModel>? history,
  }) {
    return BossSalaryState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      history: history ?? this.history,
    );
  }
}

class BossSalaryController extends Notifier<BossSalaryState> {
  @override
  BossSalaryState build() {
    Future.microtask(() => loadHistory());
    return BossSalaryState();
  }

  Future<void> loadHistory() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final supabase = Supabase.instance.client;
      if (supabase.auth.currentUser == null) {
        state = state.copyWith(isLoading: false, history: []);
        return;
      }
      
      final records = await ref.read(financeRepositoryProvider).getAllSalaryRecords();
      state = state.copyWith(isLoading: false, history: records);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> generateSalary() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final supabase = Supabase.instance.client;
      if (supabase.auth.currentUser == null) {
        state = state.copyWith(isLoading: false, error: 'Sesi tidak valid');
        return;
      }
      
      final authState = ref.read(authControllerProvider);
      if (authState.branchId == null) {
        state = state.copyWith(isLoading: false, error: 'Branch ID tidak ditemukan');
        return;
      }

      // Hitung periode minggu lalu (Senin - Minggu)
      final now = DateTime.now();
      final currentWeekday = now.weekday; // 1 = Monday, 7 = Sunday
      // Menghitung end date ke Minggu sebelumnya
      final end = now.subtract(Duration(days: currentWeekday));
      // Menghitung start date ke Senin pada minggu sebelumnya
      final start = end.subtract(const Duration(days: 6));

      await ref.read(financeRepositoryProvider).generateWeeklySalary(
            authState.branchId!,
            start,
            end,
          );
      
      // Muat ulang history setelah generate
      await loadHistory();
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}

final bossSalaryControllerProvider = NotifierProvider<BossSalaryController, BossSalaryState>(() {
  return BossSalaryController();
});
