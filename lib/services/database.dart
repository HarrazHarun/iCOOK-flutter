import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

// database reference
  final CollectionReference icookCollection =
      Firestore.instance.collection('Users');

  Future updateUserData(
      {String emailToDb,
      String passwordToDb,
      String genderToDb,
      String nameToDb,
      DateTime dateToDb}) async {
    return await icookCollection.document(uid).setData({
      'email': emailToDb,
      'password': passwordToDb,
      'gender': genderToDb,
      'name': nameToDb,
      'Date': dateToDb,
    });
  }
}
