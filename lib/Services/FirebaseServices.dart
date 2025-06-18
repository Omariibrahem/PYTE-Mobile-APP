import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

final String User_Collection = "user1";

class FirebaseService {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseStorage _storage = FirebaseStorage.instance;
  FirebaseFirestore _db = FirebaseFirestore.instance;
  Map? currentUser;

  FirebaseService();

  Future<bool> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential _userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      if (_userCredential.user != null) {
        currentUser = await getUserData(uid: _userCredential.user!.uid);
        print('Login successful: ${_userCredential.user!.uid}');
        return true;
      } else {
        print('Login failed: user is null');
        return false;
      }
    } catch (e) {
      print('Login failed: $e');
      return false;
    }
  }

  Future<Map> getUserData({required String uid}) async {
    try {
      DocumentSnapshot _doc = await _db.collection(User_Collection).doc(uid).get();
      return _doc.data() as Map;
    } catch (e) {
      print('Failed to get user data: $e');
      return {};
    }
  }
}
