import 'package:equatable/equatable.dart';

/// Shortcut entity represents a shortcut item in the application.
/// This class is immutable and implements value equality using Equatable.
class Shortcut extends Equatable {
  /// The display label of the shortcut
  final String label;
  
  /// The path to the shortcut's image asset
  final String imagePath;

  const Shortcut({required this.label, required this.imagePath});

  @override
  List<Object?> get props => [label, imagePath];

  /// Creates a copy of this Shortcut with the given fields replaced with the new values.
  /// Returns a new instance of Shortcut with the updated fields.
  Shortcut copyWith({String? label, String? imagePath}) {
    return Shortcut(
      label: label ?? this.label,
      imagePath: imagePath ?? this.imagePath,
    );
  }
}
