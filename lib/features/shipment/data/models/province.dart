
import 'package:equatable/equatable.dart';

class Province extends Equatable {
  final String name;
  final String slug;
  final String type;
  final String nameWithType;
  final String code;

  const Province({
    required this.name,
    required this.slug,
    required this.type,
    required this.nameWithType,
    required this.code
  });

  factory Province.fromJson(Map<String, dynamic> json) {
    return Province(
        name: json['name'],
        slug: json['slug'],
        type: json['type'],
        nameWithType: json['name_with_type'],
        code: json['code']
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'slug': slug,
    'type': type,
    'name_with_type': nameWithType,
    'code': code
  };

  @override
  String toString() {
    return 'name: $name - code: $code';
  }

  @override
  List<Object?> get props => [
    name,
    slug,
    type,
    nameWithType,
    code
  ];
}