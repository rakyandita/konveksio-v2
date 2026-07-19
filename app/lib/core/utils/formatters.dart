import 'package:intl/intl.dart';

class AppFormatters {
  /// Memformat angka nominal menjadi mata uang Rupiah
  /// Contoh: 1000000 -> Rp 1.000.000
  static String formatCurrency(num amount) {
    final formatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    return formatter.format(amount);
  }

  /// Memformat tanggal menjadi format ringkas (dd-MM-yyyy)
  /// Contoh: 2026-07-19 -> 19-07-2026
  static String formatDate(DateTime date) {
    final formatter = DateFormat('dd-MM-yyyy');
    return formatter.format(date);
  }

  /// Memformat tanggal menjadi format panjang (dd MMM yyyy)
  /// Contoh: 2026-07-19 -> 19 Jul 2026
  static String formatDateLong(DateTime date) {
    final formatter = DateFormat('dd MMM yyyy');
    return formatter.format(date);
  }
}
