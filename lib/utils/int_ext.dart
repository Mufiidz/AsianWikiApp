import 'package:intl/intl.dart';

import 'export_utils.dart';

extension IntExt on int? {
  String toIdr({bool withSymbol = true}) {
    NumberFormat currencyFormatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: withSymbol ? 'Rp ' : '',
      decimalDigits: 0,
    );
    return currencyFormatter.format(this ?? 0);
  }

  /// Convert int to double.degreesToRadia
  double get degreesToRadian => (this ?? 0).roundToDouble().degreesToRadian;
}
