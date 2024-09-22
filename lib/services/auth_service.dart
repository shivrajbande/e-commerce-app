import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> signup(String? name, String? email, String? password) async {
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email!, password: password!);
    await _firestore
        .collection('users')
        .doc(userCredential.user!.uid)
        .set({'name': name, 'email': email});
  }

  Future<Map<String, dynamic>> login(String? email, String? password) async {
    UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email!, password: password!);
    DocumentSnapshot snapshot = await _firestore
        .collection('users')
        .doc(userCredential.user!.uid)
        .get();
    Map<String,dynamic> userData = {};
    if (snapshot.exists) {
      var data = snapshot.data() as Map<String, dynamic>;
      if (data['email'] == email) {
        userData = data;
      }
    }
    return userData;
  }
}
