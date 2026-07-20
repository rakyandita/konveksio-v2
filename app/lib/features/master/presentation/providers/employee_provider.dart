import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../auth/domain/user_model.dart';
import '../../domain/employee_rate_model.dart';
import '../../data/employee_repository.dart';

final employeeListProvider = AsyncNotifierProvider<EmployeeListNotifier, List<UserModel>>(() {
  return EmployeeListNotifier();
});

class EmployeeListNotifier extends AsyncNotifier<List<UserModel>> {
  @override
  Future<List<UserModel>> build() async {
    return ref.watch(employeeRepositoryProvider).getEmployees();
  }
}

final adminListProvider = AsyncNotifierProvider<AdminListNotifier, List<UserModel>>(() {
  return AdminListNotifier();
});

class AdminListNotifier extends AsyncNotifier<List<UserModel>> {
  @override
  Future<List<UserModel>> build() async {
    return ref.watch(employeeRepositoryProvider).getAdmins();
  }
}

final employeeRateListProvider = FutureProvider.family<List<EmployeeRateModel>, String>((ref, userId) async {
  return ref.watch(employeeRepositoryProvider).getEmployeeRates(userId);
});
