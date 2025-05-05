import 'package:expense_track/utils/widget/loading_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providerss/auth_provider.dart';
import '../../providerss/firestore_provider.dart';
import '../../utils/constants.dart';

class DeleteDialog extends StatefulWidget {
  final String id;

  const DeleteDialog({super.key, required this.id});

  @override
  State<DeleteDialog> createState() => _DeleteDialogState();
}

class _DeleteDialogState extends State<DeleteDialog> {

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: Text(
          'Delete Expense',
          style: TextStyle(
              color: primaryThemeColor,
              fontSize: 20,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold
          ),
        ),
      ),
      content: Text(
        'Are you sure you want to delete this item?',
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.black,
            fontSize: 15,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.normal
        ),
      ),
      backgroundColor: backgroundColor,
      actions: [
        Row(
          children: [
            Expanded(
                child: TextButton(
                  onPressed: () {
                    if(isLoading) return;
                    Navigator.of(context).pop(false);
                  },
                  child: Text(
                    'Close',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 17,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.normal
                    ),
                  ),
                )
            ),
            Expanded(
                child: Consumer<FireStoreProvider>(
                  builder: (context, fireStoreProvider, child) {
                    return LoadingButton(
                        title: "Delete",
                        isLoading: isLoading,
                        onTap: () {
                          if(isLoading) return;
                          setState(() {
                            isLoading = true;
                          });
                          final authProvider = Provider.of<AuthProvider>(context, listen: false);

                          fireStoreProvider.deleteFireStoreData(
                              uid: authProvider.currentUser?.uid??"",
                              recordId: widget.id,
                              onSuccess: () {
                                Navigator.of(context).pop(true);
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
                        });
                  }
                )
            )
          ],
        )
      ],
    );
  }
}
