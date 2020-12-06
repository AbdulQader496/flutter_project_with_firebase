import 'package:flutter_project_with_firebase/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_project_with_firebase/services/database.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj based on firebase user
  // ignore: deprecated_member_use
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  //auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged
           .map( _userFromFirebaseUser);
  }

  // sign in anon
  Future signInAnon() async {
    try {
      var result = await _auth.signInAnonymously();
      // ignor
      //
      // e: deprecated_member_use
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

// sign in with email and password
  Future signInWithEmailAndPassword( String email, String password) async {
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }


// register with email and password

  Future registerWithEmailAndPassword( String email, String password) async {
    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;

      //creTE A new document for the user with the uid
      await DatabaseService(uid: user.uid).updateUserData('Qader', '0', 100);

      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

// sign out

Future signOut() async {
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
}
}