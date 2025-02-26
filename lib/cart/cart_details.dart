import 'package:flutter/material.dart';

class cart_details extends StatelessWidget {
  final String text;
  final String price;
  const cart_details({super.key, required this.price, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom:10 ),
      child: Expanded(
        child: Row(
          children: [
            Text(
              text,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
            Spacer(),
            Text(
              price,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            )
          ],
        ),
      ),
    );
  }
}
