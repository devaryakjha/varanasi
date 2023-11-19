import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  FirestoreService._();

  static final instance = FirestoreService._();

  static FirebaseFirestore get _baseFirestore => FirebaseFirestore.instance;

  static DocumentReference<Map<String, dynamic>>? userDocument;

  static bool initialised = false;

  static DocumentReference<Map<String, dynamic>> getUserDocument() =>
      _baseFirestore
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid);

  static Future<void> init() async {
    if (initialised) return;
    initialised = true;
    final user = FirebaseAuth.instance.currentUser!;
    userDocument = _baseFirestore.collection('users').doc(user.uid);
    userDocument?.get().then((value) {
      if (!value.exists) {
        userDocument?.set({
          'name': user.displayName,
          'email': user.email,
          'photoUrl': user.photoURL,
          'createdAt': FieldValue.serverTimestamp(),
        });
      }
    });
  }

  static Future<void> update(Map<String, dynamic> data) async {
    await userDocument?.update(data);
  }

  static Future<void> delete() async {
    await userDocument?.delete();
  }

  static Future<void> dispose() async {
    initialised = false;
  }
}
