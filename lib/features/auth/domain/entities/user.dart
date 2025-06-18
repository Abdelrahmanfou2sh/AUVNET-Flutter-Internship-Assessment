import 'package:equatable/equatable.dart';

/// UserEntity represents a user in the application.
/// This class is immutable and implements value equality using Equatable.
class UserEntity extends Equatable {
  /// The unique identifier of the user
  final String id;
  
  /// The email address of the user
  final String email;

  const UserEntity({
    required this.id,
    required this.email,
  });

  @override
  List<Object?> get props => [id, email];

  /// Creates a copy of this UserEntity with the given fields replaced with the new values.
  /// Returns a new instance of UserEntity with the updated fields.
  UserEntity copyWith({
    String? id,
    String? email,
  }) {
    return UserEntity(
      id: id ?? this.id,
      email: email ?? this.email,
    );
  }
}