import 'package:equatable/equatable.dart';

/// Service entity represents a service offered in the application.
/// This class is immutable and implements value equality using Equatable.
class Service extends Equatable {
  /// The display label of the service
  final String label;
  
  /// The path to the service's image asset
  final String imagePath;
  
  /// The badge text displayed on the service
  final String badge;

  const Service({
    required this.label,
    required this.imagePath,
    required this.badge,
  });

  @override
  List<Object?> get props => [label, imagePath, badge];

  /// Creates a copy of this Service with the given fields replaced with the new values.
  /// Returns a new instance of Service with the updated fields.
  Service copyWith({
    String? label,
    String? imagePath,
    String? badge,
  }) {
    return Service(
      label: label ?? this.label,
      imagePath: imagePath ?? this.imagePath,
      badge: badge ?? this.badge,
    );
  }
}