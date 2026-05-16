import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ─── Auth State Stream
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // ─── Get Current User
  User? get currentUser => _auth.currentUser;

  // ─── Get User Role from Firestore
  Future<String?> getUserRole(String uid) async {
    try {
      final doc = await _firestore.collection('users').doc(uid).get();
      return doc.data()?['role'];
    } catch (e) {
      return null;
    }
  }

  // ─── PASSENGER REGISTER ──────────────────────────────────────────
  Future<String?> registerPassenger(String email, String password) async {
    try {
      final cred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await _firestore.collection('users').doc(cred.user!.uid).set({
        'email': email,
        'role': 'passenger',
        'createdAt': FieldValue.serverTimestamp(),
      });
      return null; // null = success
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  // ─── DRIVER REGISTER
  Future<String?> registerDriver(String email, String password) async {
    try {
      final cred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await _firestore.collection('users').doc(cred.user!.uid).set({
        'email': email,
        'role': 'driver',
        'createdAt': FieldValue.serverTimestamp(),
      });
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  // ─── PASSENGER LOGIN ─────────────────────────────────────────────
  Future<String?> loginPassenger(String email, String password) async {
    try {
      final cred = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final role = await getUserRole(cred.user!.uid);
      if (role != 'passenger') {
        await _auth.signOut();
        return 'This account is not a passenger account.';
      }
      return null; // success
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  // ─── DRIVER LOGIN ────────────────────────────────────────────────
  Future<String?> loginDriver(String email, String password) async {
    try {
      final cred = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final role = await getUserRole(cred.user!.uid);
      if (role != 'driver') {
        await _auth.signOut();
        return 'This account is not a driver account.';
      }
      return null; // success
    } on FirebaseAuthException catch (e) {
      return e.message;
    }}
  // ─── ADMIN LOGIN ─────────────────────────────────────────────────
  Future<String?> loginAdmin(String email, String password) async {
    try {
      final cred = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final role = await getUserRole(cred.user!.uid);
      if (role != 'admin') {
        await _auth.signOut();
        return 'This account is not an admin account.';
      }
      return null; // success
    } on FirebaseAuthException catch (e) {
      return e.message;
    }}
  Future<String?> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  // ─── SIGN OUT ────────────────────────────────────────────────────
  Future<void> signOut() async {
    await _auth.signOut();
  }
}

