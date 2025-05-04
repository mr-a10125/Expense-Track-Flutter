import 'package:expense_track/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ExpenseItem extends StatelessWidget {

  final Function(String str) onEditPress;
  final Function(String str) onDeletePress;

  const ExpenseItem({
    super.key,
    required this.onEditPress,
    required this.onDeletePress
  });

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Slidable(
            endActionPane: ActionPane(
                motion: DrawerMotion(),
                children: [
                  SlidableAction(
                    onPressed: (context) {
                      onEditPress('OnEdit');
                    },
                    backgroundColor: primaryThemeColor,
                    foregroundColor: Colors.white,
                    icon: Icons.edit,
                    label: 'Edit',
                  ),
                  SlidableAction(
                    onPressed: (context) {
                      onDeletePress('OnDelete');
                    },
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    icon: Icons.delete,
                    label: 'Delete',
                  ),
                ]
            ),
            child: Container(
              width: width,
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Income',
                            style: TextStyle(
                                color: primaryThemeColor,
                                fontSize: 16,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),

                      Text(
                        '₹100',
                        style: TextStyle(
                            color: primaryThemeColor,
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Received money from the salary. Received money from the salary.',
                      style: TextStyle(
                          color: hintTextColor,
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.normal
                      ),
                    ),
                  ),

                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      '2025-05-04',
                      style: TextStyle(
                          color: hintTextColor,
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.normal
                      ),
                    ),
                  ),
                ],
              ),
            )
        ),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Container(color: Colors.grey, height: 1, width: width,)
        ),
      ]
    );
  }
}
