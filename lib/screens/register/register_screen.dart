import 'package:expense_track/providerss/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utils/constants.dart';
import '../../utils/widget/loading_button.dart';
import '../../utils/widget/text_input.dart';
import '../dashboard/dashboard_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  bool isLoading = false;
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: primaryThemeColor,
        title: Text(
          'Register',
          style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold
          ),
        ),
        leading: IconButton(
            onPressed: () {
              if(isLoading) return;
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )
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
                    'Enter Username, Email Address and Password to Register.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 15,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.normal
                    ),
                  ),
                ),
                SizedBox(height: 25),
                TextInput(
                  textEditingController: userNameController,
                  hintText: 'User Name',
                  icon: Icons.person,
                  imeAction: TextInputAction.next,
                  isEnabled: !isLoading,
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
                SizedBox(height: 25),
                Consumer<AuthProvider>(
                  builder: (context, authProvider, child) {
                    return LoadingButton(
                      title: 'Register',
                      isLoading: isLoading,
                      onTap: () {
                        if (isLoading) return;
            
                        setState(() {
                          isLoading = true;
                        });
                        authProvider.register(
                            userName: userNameController.text.trim(),
                            email: emailController.text.trim(),
                            password: passwordController.text.trim(),
                            onSuccess: () {
                              setState(() {
                                isLoading = false;
                              });
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => DashboardScreen()),
                                    (Route<dynamic> route) => false,
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
                          'Already have an account? ',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.normal
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            if(isLoading) return;
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Sign In!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: primaryThemeColor,
                              fontSize: 14,
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
}
