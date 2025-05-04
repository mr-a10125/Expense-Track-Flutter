import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_track/utils/toast.dart';
import 'package:flutter/cupertino.dart';

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
    userExpenses = userExpenses.reversed.toList();

    userExpenses.insert(0, {
      'type': 'Overspending',
      'amount': '0',
      'notes': 'Overspending or Normal Spending'
    });

    calculateSpending();

    notifyListeners();
  }

  void calculateSpending() {
    int totalIncome = 0;
    int totalExpenses = 0;

    for (var expense in userExpenses) {
      if (expense.containsKey('dummy')) continue;

      int amount = int.tryParse(expense['amount']?.toString() ?? '') ?? 0;
      String type = expense['type']?.toString() ?? '';

      if (type == 'Income') {
        totalIncome += amount;
      } else if (type == 'Expense') {
        totalExpenses += amount;
      }
    }

    String overspendingType = 'Surplus';
    String overspendingMessage = 'Normal Spending';
    int spendingDifference = totalExpenses - totalIncome;

    if (spendingDifference > 0) {
      overspendingType = 'Overspending';
      overspendingMessage = 'Overspending: \$$spendingDifference';
    }

    userExpenses[0]['type'] = overspendingType;
    userExpenses[0]['notes'] = overspendingMessage;
    userExpenses[0]['amount'] = spendingDifference.abs().toString();
  }


  Future<void> addFireStoreData({
    required String uid,
    required String id,
    required String type,
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
        'type': type,
        'amount': amount,
        'notes': notes,
        'date': date,
      };

      await _firestore
          .collection('expenses')
          .doc(uid)
          .collection('records')
          .doc(id)
          .set(record);

      onSuccess();

      final index = userExpenses.indexWhere((item) => item['id'] == id);
      index != -1? userExpenses[index] = record: userExpenses.insert(1, record);
      calculateSpending();
    } on FirebaseException catch (e) {
      final message = e.message ?? 'Unknown error occurred';
      showErrorToast(msg: message);
      debugPrint('Error adding expense: $message');
      onError();
    } finally {
      notifyListeners();
    }
  }

  Future<void> deleteFireStoreData({
    required String uid,
    required String recordId,
    required VoidCallback onSuccess,
    required VoidCallback onError,
  }) async {
    try {
      await _firestore
          .collection('expenses')
          .doc(uid)
          .collection('records')
          .doc(recordId)
          .delete();

      await getFireStoreData(uid);
      onSuccess();
      removeExpenseById(recordId);
    } catch (e) {
      debugPrint("Error deleting document: $e");
      onError();
    }
  }

  void removeExpenseById(String id) {
    userExpenses.removeWhere((item) => item['id'] == id);
    notifyListeners();
  }
}