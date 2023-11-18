import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  FirestoreService._();

  static final instance = FirestoreService._();

  static FirebaseFirestore get _baseFirestore => FirebaseFirestore.instance;

  static late final DocumentReference<Map<String, dynamic>> userDocument;

  static Future<void> init(User user) async {
    userDocument = _baseFirestore.collection('users').doc(user.uid);
  }
}
