import 'package:equatable/equatable.dart';

class Service extends Equatable {
  final String label;
  final String imagePath;
  final String badge;

  const Service({
    required this.label,
    required this.imagePath,
    required this.badge,
  });

  @override
  List<Object?> get props => [label, imagePath, badge];

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