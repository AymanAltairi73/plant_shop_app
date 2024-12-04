import 'package:flutter/material.dart';
import '/models/payment_method.dart';

class PaymentMethodItem extends StatelessWidget {
  final PaymentMethod method;
  final bool isSelected;
  final VoidCallback onTap;

  const PaymentMethodItem({
    super.key,
    required this.method,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Radio<bool>(
        value: true,
        groupValue: isSelected,
        onChanged: (_) => onTap(),
        activeColor: Colors.teal,
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            method.name,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          Image.asset(
            method.iconPath,
            width: 40,
            height: 40,
          ),
        ],
      ),
      subtitle: Text(
        '•••• •••• 4833 7893 /12-2024',
        style: TextStyle(
          color: Colors.grey[600],
        ),
      ),
      onTap: onTap,
    );
  }
}