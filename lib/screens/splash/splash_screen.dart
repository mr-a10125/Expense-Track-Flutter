import 'package:expense_track/providerss/auth_provider.dart';
import 'package:expense_track/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../dashboard/dashboard_screen.dart';
import '../login/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final isLoggedIn = authProvider.currentUser != null;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => isLoggedIn ? const DashboardScreen() : const LoginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        debugPrint("Pop attempted. didPop: $didPop, result: $result");
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Image.asset(
                  'assets/images/appstore.png',
                  width: 200,
                  height: 200,
                  fit: BoxFit.fill,
                ),
              ),

              Text(
                'ExpenseTrack',
                style: TextStyle(
                  color: primaryThemeColor,
                  fontSize: 30,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold
                ),
              ),

              SizedBox(height: 50)
            ]
          ),
        ),
      ),
    );
  }
}
