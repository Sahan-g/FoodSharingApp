import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: (MaterialApp(
        home: Scaffold(
          backgroundColor: Colors.blue[900],
          body: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Hello, Welcome back",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              const Text(
                "Login to Continue",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: "Username",
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.5),
                ),
              ),
              const TextField(
                decoration: InputDecoration(hintText: "Password"),
              ),
              TextButton(
                onPressed: () => {},
                child: const Text("Forgot Password?"),
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text("Login"),
              ),
              const Text("Or Login With"),
              ElevatedButton(
                onPressed: () {},
                child: Row(
                  children: [
                    Image.asset(
                      'assests/images/search.png',
                      width: 22,
                      height: 22,
                    ),
                    const Text("Login With Google"),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                child: Row(
                  children: [
                    Image.asset(
                      'assests/images/facebook.png',
                      width: 22,
                      height: 22,
                    ),
                    const Text("Login With Facebook"),
                  ],
                ),
              ),
              Row(
                children: [
                  const Text("Don't have an Account"),
                  TextButton(onPressed: () {}, child: const Text("Sign Up"))
                ],
              )
            ],
          ),
        ),
      )),
    );
  }
}
