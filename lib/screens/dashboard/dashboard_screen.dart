import 'package:expense_track/providerss/auth_provider.dart';
import 'package:expense_track/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: Text(
          'Dashboard',
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
          child: Center(
            child: Consumer<AuthProvider>(
              builder: (context, authProvider, child) {
                return GestureDetector(
                    onTap: () {
                      authProvider.logout();
                    },
                    child: Text('Sign out ${authProvider.currentUser?.email}')
                );
              },
            ),
          )
      ),
    );
  }
}
