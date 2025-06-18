import 'package:equatable/equatable.dart';

class Shortcut extends Equatable {
  final String label;
  final String imagePath;

  const Shortcut({required this.label, required this.imagePath});

  @override
  List<Object?> get props => [label, imagePath];

  Shortcut copyWith({String? label, String? imagePath}) {
    return Shortcut(
      label: label ?? this.label,
      imagePath: imagePath ?? this.imagePath,
    );
  }
}
