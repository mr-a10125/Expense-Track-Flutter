import 'package:expense_track/providerss/auth_provider.dart';
import 'package:expense_track/providerss/firestore_provider.dart';
import 'package:expense_track/screens/dashboard/delete_dialog.dart';
import 'package:expense_track/screens/login/login_screen.dart';
import 'package:expense_track/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'add_expense.dart';
import 'expense_item.dart';
import 'navigation_drawer.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    callFireStoreData();
  }

  void callFireStoreData() async {
    if(!mounted) return;
    setState(() {
      isLoading = true;
    });
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final fireStoreProvider = Provider.of<FireStoreProvider>(context, listen: false);

      final uid = authProvider.currentUser?.uid ?? "";
      await fireStoreProvider.getFireStoreData(uid);
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var userExpenses = Provider.of<FireStoreProvider>(context).userExpenses;
    debugPrint('$userExpenses');

    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: true,
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: userExpenses.length < 2?primaryThemeColor:userExpenses[0]['type'] == 'Overspending'?Colors.red:Colors.green,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          'Dashboard',
          style: TextStyle(
              color: Colors.white,
              fontSize: 20,
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
        onPressed: () async {
          await showModalBottomSheet<dynamic>(
            context: context,
            backgroundColor: backgroundColor,
            builder: (context) => PopScope(
                canPop: false,
                child: AddExpense(id: Uuid().v4())
            ),
            isScrollControlled: true,
            barrierLabel: 'Add Expense',
            isDismissible: true,
            showDragHandle: true,
            enableDrag: false
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
          child: isLoading?Center(
            child: Container(
              padding: EdgeInsets.only(bottom: 80),
              width: 80,
              height: 160,
              child: LoadingIndicator(
                  indicatorType: Indicator.lineScalePulseOut,
                  colors: [primaryThemeColor],
                  strokeWidth: 2,
                  backgroundColor: backgroundColor,
                  pathBackgroundColor: Colors.black
              ),
            ),
          ):userExpenses.length > 1?ListView.builder(
            itemCount: userExpenses.length,
            itemBuilder: (BuildContext context, int index) {
              final record = userExpenses[index];
              return index == 0?Container(
                width: double.infinity,
                height: 150,
                color: userExpenses.length < 2?primaryThemeColor:userExpenses[0]['type'] == 'Overspending'?Colors.red:Colors.green,
                child: Stack(
                  children: [
                    Center(
                      child: Icon(
                        Icons.show_chart,
                        size: 150,
                        color: Colors.white30,
                      ),
                    ),

                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            userExpenses[index]['type'],
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold
                            ),
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.currency_rupee, size: 20, color: Colors.white,),
                              Text(
                                '${userExpenses.length < 2?'':userExpenses[0]['type'] == 'Overspending'?'-':'+'}${userExpenses[index]['amount']}  ',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ],
                          )
                        ],
                      )
                    ),
                  ],
                ),
              )
                  : ExpenseItem(
                      id: record['id'],
                      type: record['type'],
                      amount: record['amount'],
                      date: record['date'],
                      note: record['notes'],
                      dividerIsVisible: index != userExpenses.length - 1,
                      onEditPress: (String str) {
                        showModalBottomSheet<dynamic>(
                            context: context,
                            backgroundColor: backgroundColor,
                            builder: (context) =>
                                PopScope(
                                  canPop: false,
                                  child: AddExpense(
                                    id: record['id'],
                                    type: record['type'],
                                    amount: record['amount'],
                                    date: record['date'],
                                    note: record['notes'],
                                  ),
                                ),
                            isScrollControlled: true,
                            barrierLabel: 'Add Expense',
                            isDismissible: false,
                            showDragHandle: true,
                            enableDrag: false
                        );
                      },
                      onDeletePress: (String str) {
                        debugPrint(str);
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return DeleteDialog(id: str);
                            },
                          barrierDismissible: false
                        ).then((value){
                          if(value) {
                            // callFireStoreData();
                          }
                        });
                      },
              );
            },
          )
              :SizedBox(
                height: height,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 60),
                  child: Center(child: Text('No Data Available.'))),
          )
      ),
    );
  }
}
