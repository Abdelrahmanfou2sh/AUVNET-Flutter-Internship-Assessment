import 'package:hive/hive.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import '../../domain/entities/user.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel extends UserEntity {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String email;

  const UserModel({required this.id, required this.email})
    : super(id: id, email: email);

  factory UserModel.fromFirebaseUser(firebase_auth.User user) {
    return UserModel(id: user.uid, email: user.email ?? '');
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'email': email};
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(id: map['id'] ?? '', email: map['email'] ?? '');
  }

  UserEntity toEntity() {
    return UserEntity(id: id, email: email);
  }

  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(id: entity.id, email: entity.email);
  }
}
