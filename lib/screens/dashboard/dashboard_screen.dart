import 'package:expense_track/providerss/auth_provider.dart';
import 'package:expense_track/screens/login/login_screen.dart';
import 'package:expense_track/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'add_expense.dart';
import 'navigation_drawer.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: primaryThemeColor,
        iconTheme: const IconThemeData(color: Colors.white),
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
        actions: [
          Consumer<AuthProvider>(
            builder: (context, authProvider, child) {
              return IconButton(
                  onPressed: () {
                    authProvider.logout(
                      onSuccess: () {
                        Navigator.pushAndRemoveUntil(context,
                            MaterialPageRoute(builder: (context) => LoginScreen()),
                                (Route<dynamic> route) => false
                        );
                      }
                    );
                  },
                  icon: Icon(Icons.logout));
            },
          ),
        ],
      ),
      drawer: const NavigationDrawerDesign(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet<dynamic>(
            context: context,
            backgroundColor: backgroundColor,
            builder: (context) => AddExpense(),
            isScrollControlled: true,
            barrierLabel: 'Add Expense',
            isDismissible: false,
            showDragHandle: true
          );
        },
        backgroundColor: primaryThemeColor,
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 30,
        ),
      ),
      body: SafeArea(
          child: Column(
            children: [
              Center(
                child: Text('Hello'),
              )
            ],
          )
      ),
    );
  }
}
