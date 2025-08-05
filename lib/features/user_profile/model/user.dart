import 'package:equatable/equatable.dart';

class User extends Equatable {
  //eq
  final String imagePath;
  final String name;
  final String email;

  const User({
    required this.imagePath,
    required this.name,
    required this.email,
  });

  User copyWith({
    String? imagePath,
    String? name,
    String? email,
  }) {
    return User(
      imagePath: imagePath ?? this.imagePath,
      name: name ?? this.name,
      email: email ?? this.email,
    );
  }

  factory User.empty() {
    return const User(
      imagePath: '',
      name: '',
      email: '',
    );
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      imagePath: 'assets/${json['image']}',
      name: json['name'],
      email: json['email'],
    );
  }

  @override
  List<Object?> get props => [imagePath, name, email];
}
