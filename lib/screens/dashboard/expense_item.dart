import 'package:expense_track/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ExpenseItem extends StatelessWidget {

  final String id;
  final String type;
  final String amount;
  final String date;
  final String note;
  final Function(String str) onEditPress;
  final Function(String str) onDeletePress;
  final bool dividerIsVisible;

  const ExpenseItem({
    super.key,
    required this.id,
    required this.type,
    required this.amount,
    required this.date,
    required this.note,
    required this.onEditPress,
    required this.onDeletePress,
    required this.dividerIsVisible
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
                      onEditPress(id);
                    },
                    backgroundColor: primaryThemeColor,
                    foregroundColor: Colors.white,
                    icon: Icons.edit,
                    label: 'Edit',
                  ),
                  SlidableAction(
                    onPressed: (context) {
                      onDeletePress(id);
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
                            type,
                            style: TextStyle(
                                color: type=='Income'?primaryThemeColor:Colors.red,
                                fontSize: 16,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),

                      Text(
                        '₹$amount',
                        style: TextStyle(
                            color: Colors.black87,
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
                      note,
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
                      date,
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
          child: Container(color: dividerIsVisible?Colors.black12:Colors.transparent, height: 1, width: width,)
        ),
      ]
    );
  }
}
