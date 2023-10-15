import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csse_app/models/user_model.dart';
import 'package:csse_app/services/auth_service.dart';
import 'package:csse_app/utils/collection_names.dart';

class UserService {
  final _firestore = FirebaseFirestore.instance;
  final _authService = AuthService();

  Future<void> addUser(UserModel user, String password) async {
    try {
      await _authService.signupUser(user.email, password).then((value) async {
        await _firestore.collection(usersCollection).doc(value).set(
              user.toMap(),
            );
      });
    } catch (e) {
      throw Error.safeToString(e);
    }
  }
}
