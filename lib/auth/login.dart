import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marketawi/provider/Product_provider.dart';
import 'package:marketawi/auth/register.dart';
import 'package:marketawi/main/welcomeScreen.dart';
import 'package:provider/provider.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  bool _obscurePassword = true;
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductProvider>(context);

    return Scaffold(
      body: provider.loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: SafeArea(
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 12.0, right: 12, top: 11),
                  child: Column(
                    children: [
                      Hero(
                        tag: "markat",
                        child: Image.asset(
                          'assets/logo.png',
                          width: 272,
                          height: 232,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 21,
                      ),
                      TextField(
                        controller: _email,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email, color: Colors.grey),
                          hintText: 'Username or Email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                BorderSide(color: Colors.blue, width: 2),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                BorderSide(color: Colors.blue, width: 2),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      TextField(
                        controller: _password,
                        obscureText: _obscurePassword,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock, color: Colors.grey),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.grey,
                            ),
                          ),
                          hintText: 'Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                BorderSide(color: Colors.blue, width: 2),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                BorderSide(color: Colors.blue, width: 2),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      InkWell(
                        onTap: () async {
                          await provider.login(_email.text, _password.text);

                          if (provider.login_message == "SUCCESS") {
                            //NAVIGATE
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Registration Successful! Redirecting..."),
                                  backgroundColor: Colors.green,
                                  duration: Duration(seconds: 3), // Show message for 3 seconds
                                ),
                            );
                            Future.delayed(Duration(seconds: 3), () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => WelcomeScreen(name: provider.userName.toString(),)));
                            });
                          }
                          else {
                            print("main " + provider.login_message.toString());
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Error Email Or Password Is Incorrect..."),
                                backgroundColor: Colors.red,
                                duration: Duration(seconds: 3), // Show message for 3 seconds
                              ),
                            );
                          }

                          },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 48, // Adjusted height
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color.fromRGBO(54, 105, 201, 1),
                          ),
                          child: Center(
                            child: Text(
                              "Log In",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Center(
                              child: Text(
                            "Are you new in Marketi ",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w400),
                          )),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => register())
                              );
                            },
                            child: Text("register?",
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400)),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 12,
                      ),

                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
