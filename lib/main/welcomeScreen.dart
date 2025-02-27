import 'package:flutter/material.dart';
import 'package:marketawi/cart/cart.dart';
import 'package:marketawi/main/home.dart';
import 'package:marketawi/main/profile.dart';

class WelcomeScreen extends StatefulWidget {
  final String name;
  const WelcomeScreen({super.key, required this.name});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  var pageIndex = 0;

  List<Widget> _screens = [Cart(), profile()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading:    Hero(
            tag: "markat",
            child: Image.asset(
              'assets/logo.png',
              width: 25,
              height:25,
            ),
          ),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black54,
          elevation: 0,
          centerTitle: false,
          title: Text(
            "Welcome " + widget.name,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        body: pageIndex == 0
            ? home()
            : pageIndex == 1
                ? Cart()
                : profile(),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: pageIndex,
          onTap: (findex) {
            setState(() {
              pageIndex = findex; // Update the current index
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home, size: 30, color: Colors.black),
              label: "home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_basket_sharp,
                  size: 30, color: Colors.black),
              label: "cart",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search_rounded, size: 30, color: Colors.black),
              label: "profile",
            ),
          ],
        ));
  }
}
