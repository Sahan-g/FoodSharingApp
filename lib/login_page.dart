import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: (MaterialApp(
        home: Scaffold(
          backgroundColor: Colors.green[100],
          body: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              const Text(
                "hello Welcome back",
                style: TextStyle(
                  color: Colors.black26,
                ),
              ),
              const Text("Login to Continue"),
              const TextField(
                decoration: InputDecoration(hintText: "Username"),
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
