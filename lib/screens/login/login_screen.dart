import 'package:expense_track/providerss/auth_provider.dart';
import 'package:expense_track/utils/widget/loading_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utils/constants.dart';
import '../../utils/widget/text_input.dart';
import '../dashboard/dashboard_screen.dart';
import '../forgotpassword/forgot_password_screen.dart';
import '../register/register_screen.dart';

class LoginScreen extends StatefulWidget {

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool isLoading = false;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: primaryThemeColor,
        title: Text(
          'Login',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 16),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Enter Email Address and Password to Login.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.normal
                    ),
                  ),
                ),
                SizedBox(height: 16),
                TextInput(
                  textEditingController: emailController,
                  hintText: 'Email Address',
                  icon: Icons.email,
                  imeAction: TextInputAction.next,
                  isEnabled: !isLoading,
                ),
                SizedBox(height: 16),
                TextInput(
                  textEditingController: passwordController,
                  hintText: 'Password',
                  icon: Icons.password,
                  isPasswordField: true,
                  isEnabled: !isLoading,
                ),
                SizedBox(height: 2),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      onPressed: () {
                        if(isLoading) return;
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => ForgotPasswordScreen())
                        );
                      },
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: primaryThemeColor,
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.normal
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Consumer<AuthProvider>(
                  builder: (context, authProvider, child) {
                    return LoadingButton(
                      title: 'Login',
                      isLoading: isLoading,
                      onTap: () {
                        if(isLoading) return;
            
                        setState(() {
                          isLoading = true;
                        });
                        authProvider.login(
                          email: emailController.text.trim(),
                          password: passwordController.text.trim(),
                          onSuccess: () {
                            setState(() {
                              isLoading = false;
                            });
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (_) => DashboardScreen())
                            );
                          },
                          onError: () {
                            setState(() {
                              isLoading = false;
                            });
                          }
                        );
                      },
                    );
                  },
                ),
                SizedBox(height: 16),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Text(
                        'Don\'t have an account? ',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.normal
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if(isLoading) return;
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => RegisterScreen())
                          );
                        },
                        child: Text(
                          'Sign Up!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: primaryThemeColor,
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.normal
                          ),
                        ),
                      ),
                    ]
                  ),
                ),
                SizedBox(height: 16),
              ],
            ),
          )
      ),
    );
  }

  void login() {

  }
}
