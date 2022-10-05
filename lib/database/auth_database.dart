import 'package:firebase_database/firebase_database.dart';

class AuthDatabase {
  final FirebaseDatabase _authFirebaseDatabase = FirebaseDatabase.instance;

//insert data from database
  void insertData(String name, String phone) {
    var user = {'name': name, 'phone': phone};
   _authFirebaseDatabase.ref().child('userinfo').set(user).then((user) {
      print('Thanh cong');
    }).catchError((error) {
      print(error.toString());
    });
  }

// Update data

// delete data

}
