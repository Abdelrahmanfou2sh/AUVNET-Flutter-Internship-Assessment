import 'package:hive/hive.dart';
import '../../domain/entities/user.dart';
import '../models/user_model.dart';

abstract class AuthLocalDataSource {
  Future<void> cacheUser(UserEntity user);
  Future<void> clearUser();
  Future<UserEntity?> getLastUser();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final Box<UserModel> _userBox;
  static const String userKey = 'current_user';

  AuthLocalDataSourceImpl({required Box<UserModel> userBox}) : _userBox = userBox;

  @override
  Future<void> cacheUser(UserEntity user) async {
    final userModel = UserModel.fromEntity(user);
    await _userBox.put(userKey, userModel);
  }

  @override
  Future<void> clearUser() async {
    await _userBox.delete(userKey);
  }

  @override
  Future<UserEntity?> getLastUser() async {
    final userModel = _userBox.get(userKey);
    return userModel;
  }
}