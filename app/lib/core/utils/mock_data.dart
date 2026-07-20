import '../../features/finance/domain/cash_advance_model.dart';

/// Tempat penyimpanan data sementara (in-memory) untuk pengujian UI tanpa koneksi Supabase.
class MockData {
  static final List<SizeGroupModel> sizeGroups = [
    const SizeGroupModel(id: 'sg-1', branchId: 'branch-1', name: 'Dewasa Standar', sizes: ['S', 'M', 'L', 'XL', 'XXL']),
    const SizeGroupModel(id: 'sg-2', branchId: 'branch-1', name: 'Anak-anak', sizes: ['4', '6', '8', '10', '12']),
  ];

  static final List<ProductModel> products = [
    ProductModel(
      id: 'prod-1',
      branchId: 'branch-1',
      name: 'Kemeja PDH',
      category: ProductCategory.non_setelan,
      sizeGroupId: 'sg-1',
      priceMin: 150000,
      priceMax: 200000,
      isActive: true,
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
    ),
    ProductModel(
      id: 'prod-2',
      branchId: 'branch-1',
      name: 'Kaos Oblong',
      category: ProductCategory.non_setelan,
      sizeGroupId: 'sg-1',
      priceMin: 50000,
      priceMax: 80000,
      isActive: true,
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
    ),
  ];

  static final List<CashAdvanceModel> cashAdvances = [
    CashAdvanceModel(
      id: 'ca-1',
      branchId: 'branch-1',
      userId: 'Siti Aminah', // Mocking user name for UI
      amountRequested: 500000,
      reason: 'Bayar kos',
      status: ApprovalStatus.pending,
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    CashAdvanceModel(
      id: 'ca-2',
      branchId: 'branch-1',
      userId: 'Budi Santoso', // Mocking user name for UI
      amountRequested: 200000,
      amountApproved: 200000,
      reason: 'Beli bensin',
      status: ApprovalStatus.approved,
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      approvedAt: DateTime.now().subtract(const Duration(hours: 20)),
    ),
    CashAdvanceModel(
      id: 'ca-3',
      branchId: 'branch-1',
      userId: 'Agus Salim', // Mocking user name for UI
      amountRequested: 1000000,
      reason: 'Biaya sekolah anak',
      status: ApprovalStatus.rejected,
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
      rejectionReason: 'Limit kasbon bulan ini sudah habis',
    ),
  ];
}
