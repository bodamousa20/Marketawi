import 'package:flutter/material.dart';
import 'package:marketawi/widgets/account_cards.dart';

class profile extends StatelessWidget {
  const profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding: EdgeInsets.only(left: 24, right: 24, top: 29),
        child: Column(children: [
          const account_cards(
              icon: Icons.add_box, title: "My Order", color: Colors.black),
          const Divider(
            thickness: 1.4,
          ),
          const account_cards(
              icon: Icons.person_pin, title: "My Details", color: Colors.black),
          const Divider(
            thickness: 1.4,
          ),
          const account_cards(
            icon: Icons.home,
            title: "Address Book",
            color: Colors.black,
          ),
          const Divider(
            thickness: 1.4,
          ),
          const account_cards(
            icon: Icons.question_mark_outlined,
            title: "FAQs",
            color: Colors.black,
          ),
          const Divider(
            thickness: 1.4,
          ),
          const account_cards(
              icon: Icons.headphones,
              title: "Help Center",
              color: Colors.black),
          const Divider(thickness: 1.4),
          const SizedBox(
            height: 140,
          ),
          InkWell(
            onTap: () {},
            child: const Row(
              children: [
                Icon(
                  Icons.logout,
                  color: Colors.red,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Logout",
                  style: TextStyle(fontSize: 16, color: Colors.red),
                )
              ],
            ),
          )
        ]),
      ),
    );
  }
}
