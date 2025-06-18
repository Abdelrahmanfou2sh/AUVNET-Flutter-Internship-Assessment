import 'package:equatable/equatable.dart';

class Restaurant extends Equatable {
  final String name;
  final String imageUrl;
  final String time;

  const Restaurant({
    required this.name,
    required this.imageUrl,
    required this.time,
  });

  @override
  List<Object?> get props => [name, imageUrl, time];

  Restaurant copyWith({String? name, String? imageUrl, String? time}) {
    return Restaurant(
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      time: time ?? this.time,
    );
  }
}
