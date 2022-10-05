import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:share_stuff/models/user.dart';

class AuthService {
  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;

  //create user obj base on FirebaseUser
  MyUser? _userFromFirebaseUser(auth.User user) {
    return user !=null? MyUser(uid: user.uid) : null;
  }

  //auth change user stream
  Stream<MyUser?> get user{
    return _auth.authStateChanges()
    .map((auth.User? user) => _userFromFirebaseUser(user!));
  }

// sign in anon
  Future signInAnon() async {
    try {
      auth.UserCredential result = await _auth.signInAnonymously();
      auth.User? user = result.user;
      return _userFromFirebaseUser(user!);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

// sign email and password
Future signWithEmailAndPasswod(String email, String password) async{
  try{
  auth.UserCredential result = 
  await _auth.signInWithEmailAndPassword(email: email, password: password);
  auth.User? user = result.user;
  // print(user!.email);
  return _userFromFirebaseUser(user!);
  }catch(e){
    print('error: ${e.toString()}');
    return null;
  }
}

// register email and pasword
Future registerWithEmailAndPasswod(String email, String password) async{
  try{
  auth.UserCredential result = 
  await _auth.createUserWithEmailAndPassword(email: email, password: password);
  auth.User? user = result.user;
  return _userFromFirebaseUser(user!);
  }catch(e){
    print(e.toString());
    return null;
  }
}

//sign out
 Future signOut() async {
   try{
     return await _auth.signOut();
   }catch(e){
     print(e.toString());
     return Null;
   }
 }


}
