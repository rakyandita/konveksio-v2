import '../../features/finance/domain/cash_advance.dart';

/// Tempat penyimpanan data sementara (in-memory) untuk pengujian UI tanpa koneksi Supabase.
class MockData {
  static final List<CashAdvance> cashAdvances = [
    // Pre-populate dengan satu data dummy agar Boss Kasbon punya data awal untuk di-review
    CashAdvance(
      id: 'mock-1',
      branchId: 'branch-1',
      userId: 'Budi (Mock)',
      amountRequested: 500000,
      reason: 'Biaya darurat keluarga',
      status: ApprovalStatus.pending,
      createdAt: DateTime.now().subtract(const Duration(hours: 1)),
    )
  ];
}
