import 'package:flutter_masked_text/flutter_masked_text.dart';

class PriceUtils {
  static String _formatPriceHelper(String viewPriceFormat) =>
      viewPriceFormat.replaceAll(',', '');

  // used when need math operations.
  static double formatPriceToDouble(String viewPriceFormat) {
    double value = .0;
    try {
      value = double.parse(_formatPriceHelper(viewPriceFormat));
      return value;
    }

    catch (ex) {
      print(ex);
    }

    return .0;
  }

  // used just in view components
  static String formatPriceToString(double moneyValue) {
    if (moneyValue == null)
      return '';

    final MoneyMaskedTextController converter = MoneyMaskedTextController(
      thousandSeparator: ',',
      decimalSeparator: '.',
      initialValue: moneyValue ?? .0,
    );

    return converter.text;
  }
}
