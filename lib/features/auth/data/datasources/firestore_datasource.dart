import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/user.dart';
import '../models/user_model.dart';

abstract class FirestoreDataSource {
  Future<void> saveUser(UserEntity user);
  Future<UserEntity?> getUser(String userId);
  Future<void> updateUser(UserEntity user);
  Future<void> deleteUser(String userId);
}

class FirestoreDataSourceImpl implements FirestoreDataSource {
  final FirebaseFirestore _firestore;
  final String _usersCollection = 'users';

  FirestoreDataSourceImpl({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Future<void> saveUser(UserEntity user) async {
    final userModel = UserModel.fromEntity(user);
    await _firestore
        .collection(_usersCollection)
        .doc(user.id)
        .set(userModel.toMap());
  }

  @override
  Future<UserEntity?> getUser(String userId) async {
    final doc = await _firestore.collection(_usersCollection).doc(userId).get();
    if (!doc.exists || doc.data() == null) return null;
    return UserModel.fromMap(doc.data()!);
  }

  @override
  Future<void> updateUser(UserEntity user) async {
    final userModel = UserModel.fromEntity(user);
    await _firestore
        .collection(_usersCollection)
        .doc(user.id)
        .update(userModel.toMap());
  }

  @override
  Future<void> deleteUser(String userId) async {
    await _firestore.collection(_usersCollection).doc(userId).delete();
  }
}
