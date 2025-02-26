import 'package:flutter/material.dart';

class account_cards extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  const account_cards(
      {super.key,
      required this.icon,
      required this.title,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){},
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 64,
        child: Row(
          children: [
            Icon(
              icon,
              size: 24,
              color: color,
            ),
            const SizedBox(
              width: 25,
            ),
            Text(
              title,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color.fromRGBO(26, 26, 26, 1)),
            ),
            Spacer(),
            Icon(
              Icons.arrow_right_outlined,
              color: Colors.grey,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
}
