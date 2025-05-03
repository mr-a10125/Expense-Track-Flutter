import 'package:expense_track/utils/constants.dart';
import 'package:expense_track/utils/widget/loading_button.dart';
import 'package:flutter/material.dart';

import '../../utils/widget/text_input.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({super.key});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {

  bool isLoading = false;
  final TextEditingController amountController = TextEditingController();
  final TextEditingController notesController = TextEditingController();

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
                Row(
                  children: [
                    Icon(Icons.check_circle_sharp, color: primaryThemeColor,),
                    SizedBox(width: 10,),
                    Text(
                      'Income',
                      style: TextStyle(
                          color: primaryThemeColor,
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 80),
                Row(
                  children: [
                    Icon(Icons.radio_button_unchecked_sharp, color: hintTextColor,),
                    SizedBox(width: 10,),
                    Text(
                      'Expense',
                      style: TextStyle(
                          color: hintTextColor,
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
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
              textEditingController: notesController,
              hintText: 'Amount',
              icon: Icons.currency_rupee,
              imeAction: TextInputAction.done,
              isEnabled: !isLoading,
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
                onTap: () {},
                child: Container(
                  width: double.infinity,
                  height: 56.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: primaryThemeColor,
                  ),
                  child: Center(
                    child: Text(
                      'Select Date Picker',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold
                      ),
                    ),
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

            LoadingButton(
                title: 'Add Expense',
                isLoading: isLoading,
                onTap: () {

                }
            )
          ],
        ),
      ),
    );
  }
}