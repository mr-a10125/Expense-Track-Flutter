import 'package:expense_track/providerss/auth_provider.dart';
import 'package:expense_track/utils/widget/loading_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utils/constants.dart';
import '../../utils/widget/text_input.dart';

class ForgotPasswordScreen extends StatefulWidget {

  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {

  bool isLoading = false;
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: primaryThemeColor,
        title: Text(
          'Forgot Password',
          style: TextStyle(
              color: Colors.white,
              fontSize: 22,
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
          child: Column(
            children: [
              SizedBox(height: 16),
              Flexible(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Please enter your registered email address to receive a password reset link.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.normal
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextInput(
                textEditingController: emailController,
                hintText: 'Email Address',
                icon: Icons.email,
                imeAction: TextInputAction.done,
                isEnabled: !isLoading,
              ),
              SizedBox(height: 16),
              Consumer<AuthProvider>(
                builder: (context, authProvider, child) {
                  return LoadingButton(
                    title: 'Forgot Password',
                    isLoading: isLoading,
                    onTap: () {
                      if (isLoading) return;

                      setState(() {
                        isLoading = true;
                      });

                      authProvider.forgotPassword(
                          email: emailController.text.trim(),
                          onSuccess: (){
                            setState(() {
                              isLoading = false;
                            });

                            Navigator.pop(context);
                          },
                          onError: (){
                            setState(() {
                              isLoading = false;
                            });
                          }
                      );
                    },
                  );
                }
              ),
              SizedBox(height: 16)
            ],
          )
      ),
    );
  }
}
