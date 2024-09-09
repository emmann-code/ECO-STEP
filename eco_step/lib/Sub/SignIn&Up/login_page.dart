import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart'; // Import Spinkit
import '../Components/google_component.dart';
import '../Components/my_button.dart';
import '../Components/my_textfield.dart';
import '../Pages/MainScreen.dart';
import '../Services/auth/auth_service.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key, this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isLoading = false; // Track loading state

  // login method
  Future<void> _login() async {
    final _authService = AuthService();
    setState(() {
      _isLoading = true;
    });

    try {
      await _authService.signInWithEmailPassword(emailController.text, passwordController.text);
      if (context.mounted) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen()));
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.background,
          title: Text(e.toString()),
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 100),
                Image.asset("assets/recylce.png", scale: 2),
                const SizedBox(height: 25),
                Text(
                  "Welcome Back",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 26,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  "Sign in to work with the application",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 25),
                MyTextfield(
                  controller: emailController,
                  hintText: "Email",
                  obscureText: false,
                ),
                const SizedBox(height: 25),
                MyTextfield(
                  controller: passwordController,
                  hintText: "Password",
                  obscureText: true,
                ),
                const SizedBox(height: 25),
                MyButton(
                  text: 'Sign In',
                  onTap: _login,
                  isLoading: _isLoading, // Pass loading state
                ),
                const SizedBox(height: 25),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: 2,
                        width: 100,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'or sign in with',
                        style: TextStyle(
                          fontSize: 17,
                          fontFamily: 'Nunito-Medium',
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        height: 2,
                        width: 100,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                GoogleComponent(),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account yet?",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const SizedBox(width: 5),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 25),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
