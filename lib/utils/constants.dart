/// This Dart code snippet is defining a list of `PaymentMethod` objects. Each `PaymentMethod` object
/// represents a payment method and contains a name and an icon path. The list `paymentMethods` is
/// initialized with four `PaymentMethod` objects, each created using the `const` constructor with
/// specific name and icon path values. The `PaymentMethod` class is likely defined in the
/// `payment_method.dart` file located in the `models` directory relative to the current file.
library;
import '../models/payment_method.dart';

final List<PaymentMethod> paymentMethods = [
  const PaymentMethod(
    name: 'Google Pay',
    iconPath: 'assets/images/google_pay.png',
  ),
  const PaymentMethod(
    name: 'Cash Wallet',
    iconPath: 'assets/images/cash_wallet.png',
  ),
  const PaymentMethod(
    name: 'Visa Card',
    iconPath: 'assets/images/visa.png',
  ),
  const PaymentMethod(
    name: 'Master Card',
    iconPath: 'assets/images/mastercard.png',
  ),
];