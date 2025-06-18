import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/error/firebase_error_handler.dart';
import '../../domain/entities/user.dart';
import '../models/user_model.dart';
import 'auth_local_datasource.dart';
import 'firestore_datasource.dart';

abstract class AuthRemoteDataSource {
  Future<UserEntity> signInWithEmailAndPassword(String email, String password);
  Future<UserEntity> signUpWithEmailAndPassword(String email, String password);
  Future<void> signOut();
  Stream<UserEntity?> get authStateChanges;
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final AuthLocalDataSource _localDataSource;
  final FirestoreDataSource _firestoreDataSource;

  AuthRemoteDataSourceImpl({
    firebase_auth.FirebaseAuth? firebaseAuth,
    required AuthLocalDataSource localDataSource,
    required FirestoreDataSource firestoreDataSource,
  }) : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance,
       _localDataSource = localDataSource,
       _firestoreDataSource = firestoreDataSource;

  @override
  Future<UserEntity> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user == null) {
        throw Exception('User not found');
      }
      // Try to get user data from Firestore first
      try {
        final firestoreUser = await _firestoreDataSource.getUser(
          userCredential.user!.uid,
        );
        await _localDataSource.cacheUser(firestoreUser!);
        return firestoreUser;
      } catch (e) {
        // Fallback to Firebase user data if Firestore data is not available
        final user = UserModel.fromFirebaseUser(userCredential.user!);
        await _localDataSource.cacheUser(user);
        return user;
      }
    } on FirebaseAuthException catch (e) {
      throw FirebaseErrorHandler.handle(e);
    }
  }

  @override
  Future<UserEntity> signUpWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user == null) {
        throw Exception('Failed to create user');
      }
      final user = UserModel.fromFirebaseUser(userCredential.user!);
      await Future.wait([
        _localDataSource.cacheUser(user),
        _firestoreDataSource.saveUser(user),
      ]);
      return user;
    } on FirebaseAuthException catch (e) {
      throw FirebaseErrorHandler.handle(e);
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
      await _localDataSource.clearUser();
    } on FirebaseAuthException catch (e) {
      throw FirebaseErrorHandler.handle(e);
    }
  }

  @override
  Stream<UserEntity?> get authStateChanges {
    return _firebaseAuth.authStateChanges().map((user) {
      return user != null ? UserModel.fromFirebaseUser(user) : null;
    });
  }
}
