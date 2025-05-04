import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_track/utils/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

class FireStoreProvider extends ChangeNotifier {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> userExpenses = [];

  Future<void> getFireStoreData(String uid) async {
    final snapshot = await _firestore
        .collection('expenses')
        .doc(uid)
        .collection('records')
        .get();

    userExpenses = snapshot.docs.map((doc) => doc.data()).toList();

    notifyListeners();
  }

  Future<void> addFireStoreData({
    required String uid,
    required String id,
    required String amount,
    required String notes,
    required String date,
    required VoidCallback onSuccess,
    required VoidCallback onError,
  }) async {
    if(amount.isEmpty) {
      showErrorToast(msg: "Please enter your Amount");
      onError();
      return;
    }

    if(notes.isEmpty) {
      showErrorToast(msg: "Please enter your Note");
      onError();
      return;
    }

    try {
      final record = {
        'id': id,
        'amount': amount,
        'notes': notes,
        'date': date,
      };

      await FirebaseFirestore.instance
          .collection('expenses')
          .doc(uid)
          .collection('records')
          .doc(id)
          .set(record);

      onSuccess();
      notifyListeners();
    } on FirebaseException catch (e) {
      final message = e.message ?? 'Unknown error occurred';
      showErrorToast(msg: message);
      debugPrint('Error adding expense: $message');
      onError();
    } finally {
      notifyListeners();
    }
  }
}