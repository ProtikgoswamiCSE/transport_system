import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

void main() => runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
      ),
    );

class Driverlogin extends StatelessWidget {
  const Driverlogin({super.key});

  @override
  Widget build(BuildContext context) {
    var children = <Widget>[
      const SizedBox(height: 10),
      Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FadeInUp(
              duration: const Duration(milliseconds: 1000),
              child: const Text(
                "Driver Login",
                style: TextStyle(color: Colors.white, fontSize: 40),
              ),
            ),
            const SizedBox(height: 10),
            FadeInUp(
              duration: const Duration(milliseconds: 1300),
              child: const Text(
                "Welcome Back",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 20),
      Expanded(
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(60),
              topRight: Radius.circular(60),
            ),
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(50),
            child: Column(
              children: <Widget>[
                const SizedBox(height: 60),
                FadeInUp(
                  duration: const Duration(milliseconds: 1400),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromRGBO(225, 95, 27, .3),
                          blurRadius: 20,
                          offset: Offset(0, 10),
                        )
                      ],
                    ),
                    child: Column(
                      children: <Widget>[
                        // Email
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.grey.shade200,
                              ),
                            ),
                          ),
                          child: const TextField(
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              hintText: "                 ......Name......",
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        // Password
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.grey.shade200,
                              ),
                            ),
                          ),
                          child: const TextField(
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              hintText: "                 ......Email......",
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        // Confirm Password
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.grey.shade200,
                              ),
                            ),
                          ),
                          child: const TextField(
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              hintText: "                 ......Bus ID......",
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.grey.shade200,
                              ),
                            ),
                          ),
                          child: const TextField(
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              hintText: "             ......Transport ID......",
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.grey.shade200,
                              ),
                            ),
                          ),
                          child: const TextField(
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              hintText: "                 ......Phone......",
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          child: const TextField(
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              hintText: "             ......Blood group......",
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                FadeInUp(
                  duration: const Duration(milliseconds: 1500),
                  child: const Text(
                    "Forgot Password?",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                const SizedBox(height: 40),
                FadeInUp(
                  duration: const Duration(milliseconds: 1600),
                  child: MaterialButton(
                    onPressed: () {},
                    height: 50,
                    color: Colors.green[900],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: const Center(
                      child: Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                FadeInUp(
                  duration: const Duration(milliseconds: 1700),
                  child: const Text(
                    "Continue with social media",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: FadeInUp(
                        duration: const Duration(milliseconds: 1800),
                        child: MaterialButton(
                          onPressed: () {},
                          height: 50,
                          color: Colors.lightGreen,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.train, color: Colors.white, size: 30),
                              SizedBox(width: 8),
                              Text(
                                "Driver",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 30),
                    Expanded(
                      child: FadeInUp(
                        duration: const Duration(milliseconds: 1900),
                        child: MaterialButton(
                          onPressed: () {},
                          height: 50,
                          color: Colors.lightGreen,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.people, color: Colors.white, size: 30),
                              SizedBox(width: 8),
                              Text(
                                "User",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30), // Extra padding for scroll
              ],
            ),
          ),
        ),
      ),
    ];
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              Colors.green,
              Colors.lightGreen,
              Colors.lightGreenAccent,
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        ),
      ),
    );
  }
}
