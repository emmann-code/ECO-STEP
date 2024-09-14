import 'package:flutter/material.dart';
import '../Components/google_component.dart';
import '../Components/my_button.dart';
import '../Components/my_textfield.dart';
import '../Services/auth/auth_service.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmpasswordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController(); // New field for username
  bool _isLoading = false;

  // register method
  void register() async {
    // get auth service
    final _authService = AuthService();
    setState(() {
      _isLoading = true;
    });

    // check if passwords match => create user
    if (passwordController.text == confirmpasswordController.text) {
      // try to create user
      try {
        await _authService.signUpWithEmailPassword(
          emailController.text,
          passwordController.text,
          usernameController.text, // Pass the username
        );
        // After successful registration, navigate to the desired page or show success message
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(' Error: ${e.toString()} '),
          ),
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Passwords don't match"),
        ),
      );
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 100), // Adjust the height as needed
            Image.asset("assets/recylce.png", scale: 2),
            const SizedBox(height: 25),
            Text(
              "Welcome!",
              style: TextStyle(
                color: Colors.black,
                fontSize: 26,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              "To work with the application \nyou need to create an account",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 25),
            // username textfield
            MyTextfield(
              controller: usernameController,
              hintText: "Username",
              obscureText: false,
            ),
            const SizedBox(height: 25),
            // email textfield
            MyTextfield(
              controller: emailController,
              hintText: "Email",
              obscureText: false,
            ),
            const SizedBox(height: 25),
            // password textfield
            MyTextfield(
              controller: passwordController,
              hintText: "Password",
              obscureText: true,
            ),
            const SizedBox(height: 25),
            // confirm password textfield
            MyTextfield(
              controller: confirmpasswordController,
              hintText: "Confirm Password",
              obscureText: true,
            ),
            const SizedBox(height: 25),
            // sign up button
            MyButton(
              text: 'Sign Up',
              onTap: register,
              isLoading: _isLoading,
            ),
            SizedBox(height: 30),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 2,
                    width: 120,
                    color: Colors.grey,
                  ),
                  SizedBox(width: 12),
                  Text(
                    'or sign in with',
                    style: TextStyle(
                      fontSize: 17,
                      fontFamily: 'Nunito-Medium',
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(width: 12),
                  Container(
                    height: 2,
                    width: 120,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
            GoogleComponent(),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account?",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                SizedBox(width: 5),
                GestureDetector(
                  onTap: widget.onTap,
                  child: Text(
                    "Log in",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
