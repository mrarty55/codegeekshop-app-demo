import 'package:intl/intl.dart';

extension CurrencyFormat on double {
  String toKipString() {
    return NumberFormat("#,###").format(this);
  }
}
