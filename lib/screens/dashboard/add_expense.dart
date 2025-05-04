import 'package:expense_track/providerss/firestore_provider.dart';
import 'package:expense_track/utils/constants.dart';
import 'package:expense_track/utils/widget/loading_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../providerss/auth_provider.dart';
import '../../utils/widget/text_input.dart';

class AddExpense extends StatefulWidget {
  final String id;

  const AddExpense({
    super.key,
    required this.id
  });

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {

  bool isLoading = false;
  final TextEditingController amountController = TextEditingController();
  final TextEditingController notesController = TextEditingController();
  int selectedType = 0;
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Text(
                'Add Expense',
                style: TextStyle(
                    color: primaryThemeColor,
                    fontSize: 22,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold
                ),
              ),
            ),

            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Select Type: ',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedType = 0;
                    });
                  },
                  child: Row(
                    children: [
                      Icon(
                        selectedType==0?Icons.check_circle_sharp:Icons.radio_button_unchecked_sharp,
                        color: selectedType==0?primaryThemeColor:hintTextColor,
                      ),
                      SizedBox(width: 10,),
                      Text(
                        'Income',
                        style: TextStyle(
                            color: selectedType==0?primaryThemeColor:hintTextColor,
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 80),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedType = 1;
                    });
                  },
                  child: Row(
                    children: [
                      Icon(
                        selectedType==1?Icons.check_circle_sharp:Icons.radio_button_unchecked_sharp,
                        color: selectedType==1?primaryThemeColor:hintTextColor,
                      ),
                      SizedBox(width: 10,),
                      Text(
                        'Expense',
                        style: TextStyle(
                            color: selectedType==1?primaryThemeColor:hintTextColor,
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),

            SizedBox(height: 20),

            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Enter Amount: ',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            TextInput(
              textEditingController: amountController,
              hintText: 'Amount',
              icon: Icons.currency_rupee,
              imeAction: TextInputAction.done,
              isEnabled: !isLoading,
              isNumberOnly: true,
              maxLength: 10,
            ),
            SizedBox(height: 20),

            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Select Date: ',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: GestureDetector(
                onTap: () {
                  _selectDate(context);
                },
                child: Container(
                  width: double.infinity,
                  height: 56.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey, width: 1),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            DateFormat('yyyy-MM-dd').format(selectedDate),
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),
                      
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Icon(
                          Icons.arrow_drop_down_circle,
                          color: Colors.black87,
                        ),
                      )
                    ]
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),

            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Enter Note: ',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            TextInput(
              textEditingController: notesController,
              hintText: 'Notes',
              icon: Icons.notes,
              imeAction: TextInputAction.done,
              isEnabled: !isLoading,
            ),
            SizedBox(height: 25),

            Consumer<FireStoreProvider>(
              builder: (context, fireStoreProvider, child) {
                return LoadingButton(
                    title: 'Add Expense',
                    isLoading: isLoading,
                    onTap: () {
                      if(isLoading) return;
                      setState(() {
                        isLoading = true;
                      });

                      final authProvider = Provider.of<AuthProvider>(context, listen: false);

                      fireStoreProvider.addFireStoreData(
                          uid: authProvider.currentUser?.uid??"",
                          id: widget.id,
                          amount: amountController.text.trim(),
                          notes: notesController.text.trim(),
                          date: DateFormat('yyyy-MM-dd').format(selectedDate),
                          onSuccess: () {
                            Navigator.of(context).pop();
                            setState(() {
                              isLoading = false;
                            });
                          },
                          onError: (){
                            setState(() {
                              isLoading = false;
                            });
                          }
                      );
                    }
                );
              }
            )
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // default selected date
      firstDate: DateTime(2000),   // earliest date user can pick
      lastDate: DateTime(2100),    // latest date user can pick
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }
}