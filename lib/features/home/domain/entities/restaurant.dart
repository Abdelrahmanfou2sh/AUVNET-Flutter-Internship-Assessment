import 'package:equatable/equatable.dart';

/// Restaurant entity represents a restaurant in the application.
/// This class is immutable and implements value equality using Equatable.
class Restaurant extends Equatable {
  /// The name of the restaurant
  final String name;
  
  /// The URL of the restaurant's image
  final String imageUrl;
  
  /// The operating hours of the restaurant
  final String time;

  const Restaurant({
    required this.name,
    required this.imageUrl,
    required this.time,
  });

  @override
  List<Object?> get props => [name, imageUrl, time];

  /// Creates a copy of this Restaurant with the given fields replaced with the new values.
  /// Returns a new instance of Restaurant with the updated fields.
  Restaurant copyWith({String? name, String? imageUrl, String? time}) {
    return Restaurant(
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      time: time ?? this.time,
    );
  }
}
