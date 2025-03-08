import 'package:flutter/material.dart';
import 'package:transport_system/main.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  // Separate controllers for each field
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController busIdController = TextEditingController();
  final TextEditingController transportIdController = TextEditingController();
  final TextEditingController bloodGroupController = TextEditingController();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Login Successful!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              "assets/images/oo2.png", // Ensure this image is in your assets folder
              fit: BoxFit.cover,
            ),
          ),

          // Scrollable Form
          Center(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.greenAccent
                      .withOpacity(0.8), // Slight transparency
                  borderRadius: BorderRadius.circular(15),
                ),
                margin: const EdgeInsets.symmetric(horizontal: 24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "Login Page",
                        style: TextStyle(
                          // Fixed background color
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: nameController,
                        decoration: const InputDecoration(labelText: "Name"),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: emailController,
                        decoration: const InputDecoration(labelText: "Email"),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          } else if (!RegExp(
                                  r"^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$")
                              .hasMatch(value)) {
                            return 'Enter a valid email';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: busIdController,
                        decoration: const InputDecoration(labelText: "Bus ID"),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your Bus ID';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: transportIdController,
                        decoration:
                            const InputDecoration(labelText: "Transport ID"),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your Transport ID';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: phoneController,
                        decoration:
                            const InputDecoration(labelText: "Phone No"),
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your Phone No';
                          } else if (!RegExp(r"^[0-9]{10}$").hasMatch(value)) {
                            return 'Enter a valid 10-digit phone number';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: bloodGroupController,
                        decoration:
                            const InputDecoration(labelText: "Blood Group"),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your Blood Group';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MyWidget(),
                              ));
                        },
                        child: const Text("Submit"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
