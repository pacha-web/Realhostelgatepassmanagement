import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hostel_gpass/pages/services/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthService _authService = AuthService();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  String errorMsg = '';

  void _login() async {
    final user = await _authService.signIn(_email.text, _password.text);
    if (user != null) {
      GoRouter.of(context).go('/');
    } else {
      setState(() {
        errorMsg = 'Invalid email or password';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(controller: _email, decoration: const InputDecoration(labelText: "Email")),
            TextField(controller: _password, decoration: const InputDecoration(labelText: "Password"), obscureText: true),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _login, child: const Text("Login")),
            if (errorMsg.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(errorMsg, style: const TextStyle(color: Colors.red)),
              ),
          ],
        ),
      ),
    );
  }
}
