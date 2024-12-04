import 'package:flutter/material.dart';
import 'package:plant_shop_app/constants.dart';
import 'package:plant_shop_app/models/plants.dart';
import './widgets/payment_method_item.dart';
import './widgets/price_summary.dart';
import '/utils/constants.dart';

class PaymentScreen extends StatefulWidget {
  final List<Plant> cartItems;
  final double totalPrice;

  const PaymentScreen({
    super.key,
    required this.cartItems,
    required this.totalPrice,
  });

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final double shippingFee = 10.00;
  int selectedMethodIndex = 2;

  void _showSuccessMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Icons.check_circle, color: Color.fromARGB(255, 255, 255, 255)),
            SizedBox(width: 8),
            Text(
              'Payment completed successfully!',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
        backgroundColor: Constants.primaryColor,
        duration: const Duration(seconds: 5),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  void _handlePaymentConfirmation() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.teal),
          ),
        );
      },
    );

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pop(context);
      _showSuccessMessage();
    });
  }

  PriceSummary _buildPriceSummary() {
    double subtotal = widget.cartItems.fold(0.0, (sum, item) => sum + (item.price * item.quantity));
    double totalShipping = shippingFee * widget.cartItems.length;
    double total = subtotal + totalShipping;

    return PriceSummary(
      subtotal: subtotal,
      shipping: totalShipping,
      total: total,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Constants.primaryColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.home_outlined, color: Colors.white),
        //     onPressed: () {
        //       Navigator.push(context,
        //           MaterialPageRoute(builder: (builder) => const HomePage()));
        //     },
        //   ),
        // ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                const Text(
                  'Hadhramaut - Yemen',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.location_on, color: Color.fromARGB(255, 31, 117, 70)),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          const Text(
            'Payment Method',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 13, 14, 13),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: paymentMethods.length,
              itemBuilder: (context, index) {
                return PaymentMethodItem(
                  method: paymentMethods[index],
                  isSelected: selectedMethodIndex == index,
                  onTap: () {
                    setState(() {
                      selectedMethodIndex = index;
                    });
                  },
                );
              },
            ),
          ),
          // Call the method to build the PriceSummary
          _buildPriceSummary(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: _handlePaymentConfirmation,
              style: ElevatedButton.styleFrom(
                backgroundColor: Constants.primaryColor,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: const Text(
                'Confirm Payment',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
