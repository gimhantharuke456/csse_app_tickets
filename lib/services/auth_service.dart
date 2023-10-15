import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csse_app/models/user_model.dart';
import 'package:csse_app/services/local_prefs.dart';
import 'package:csse_app/utils/collection_names.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;
  final _localPrefs = LocalPreferences.instance;
  final _firebase = FirebaseFirestore.instance;
  Future<void> signinWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      _localPrefs.setToken(_auth.currentUser!.uid);
      _localPrefs.setEmail(email);
      _localPrefs.setPassword(password);
    } on FirebaseAuthException catch (e) {
      throw Error.safeToString(e.message);
    } catch (e) {
      throw Error.safeToString(e);
    }
  }

  Future<UserModel?> getCurrentUser() async {
    try {
      String? uid = _auth.currentUser!.uid;

      DocumentSnapshot snap =
          await _firebase.collection(usersCollection).doc(uid).get();
      if (snap.exists) {
        return UserModel.fromDocumentSnapshot(snap);
      } else {
        throw Error.safeToString('User not found');
      }
    } on FirebaseException catch (e) {
      throw Error.safeToString(e.message);
    } catch (e) {
      throw Error.safeToString(e);
    }
  }

  Future<void> signOutUser() async {
    try {
      await _auth.signOut();
      _localPrefs.clearePrefs();
    } on FirebaseException catch (e) {
      throw Error.safeToString(e.message);
    } catch (e) {
      throw Error.safeToString(e);
    }
  }

  Future<String?> signupUser(String email, String password) async {
    try {
      return await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        await _auth.signOut();
        await signinWithEmailAndPassword(email, password);
        return value.user?.uid;
      });
    } on FirebaseException catch (e) {
      throw Error.safeToString(e.message);
    } catch (e) {
      throw Error.safeToString(e);
    }
  }
}
