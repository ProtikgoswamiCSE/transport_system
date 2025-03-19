import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:transport_system/login/driver.dart';

void main() => runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
          children: <Widget>[
            const SizedBox(height: 80),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FadeInUp(
                    duration: const Duration(milliseconds: 1000),
                    child: const Text(
                      "Login",
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
                decoration: BoxDecoration(
                  // Use Opacity widget with 50% opacity
                  image: DecorationImage(
                    opacity: 0.4,
                    image: AssetImage(
                      'assets/images/oo2.png',
                    ), // Correct image path
                    fit: BoxFit.cover,
                    alignment: Alignment.topRight,
                  ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60),
                  ),
                ),
                child: Opacity(
                  opacity: 0.9, // 50% opacity
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(52, 90, 1,
                          102), // Apply dark overlay to make text stand out
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60),
                      ),
                    ),
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(30),
                      child: Column(
                        children: [
                          const SizedBox(height: 60),
                          FadeInUp(
                            duration: const Duration(milliseconds: 1400),
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.pink
                                    .shade100, // Light pink for inner container
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color.fromRGBO(225, 95, 27, .3),
                                    blurRadius: 20,
                                    offset: Offset(0, 10),
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
                              style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0)),
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
                              style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0)),
                            ),
                          ),
                          const SizedBox(height: 30),
                          Row(
                            children: [
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.train, color: Colors.white),
                                        SizedBox(width: 8),
                                        Text(
                                          "Driver",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 20),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.people, color: Colors.white),
                                        SizedBox(width: 8),
                                        Text(
                                          "User",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
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
                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
